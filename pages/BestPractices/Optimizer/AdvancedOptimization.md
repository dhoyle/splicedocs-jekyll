---
title: Advanced Query Optimization Techniques
summary: Advanced Query Optimization Techniques
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_advanced.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Advanced Query Optimization Techniques

This topic shows you how to work with improving query performance related to several common query execution issues:

* [Issue 1: Skewness](#skewness)
* [Issue 2: Choosing the Access Path](#accesspath)
* [Issue 3: Nested Loop Join Performance](#nestedloop)
* [Issue 4: Influencing Join Order](#joinorder)

## Issue 1: Skewness  {#skewness}

When the data in a table is skewed, the optimizer is limited in what sort of transformations it can use to improve query optimization. Some observations about skewness:

* In the presence of skewness, a few tasks have to do significantly more work than other tasks; this can dilute parallelism and can ultimately lead to running out of memory.
* Skewness might exist in the base table on certain columns.
* Skewness can also happen after certain joins are performed.
* Skewness usually causes trouble in: 1) sortmerge join steps, 2) grouped aggregate operations

### Detecting Skewness in the Spark UI
If the query is running in Spark, we can detect skewness by looking at the tasks in the Spark Web UI. For example, given this query:

```
SELECT COUNT(*) FROM --SPLICE-PROPERTIES JOINORDER=FIXED
xiayi.lineitem_with_skew --SPLICE-PROPERTIES INDEX=null
, tpch100.orders --SPLICE-PROPERTIES JOINSTRATEGY=sortmerge, index=null
 WHERE o_orderkey = l_orderkey;
```
{: .Example}

Here's the query execution plan:

```
Plan
--------------------------------------------------------------------------------
Cursor(n=8,rows=1,updateMode=,engine=Spark)
  ->  ScrollInsensitive(n=7,totalCost=13280613.55,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  ProjectRestrict(n=6,totalCost=324646.049,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  GroupBy(n=5,totalCost=324646.049,outputRows=1,outputHeapSize=0 B,partitions=1)
        ->  ProjectRestrict(n=4,totalCost=1429666.424,outputRows=642585370,outputHeapSize=4.844 GB,partitions=8)
          ->  MergeSortJoin(n=3,totalCost=1429666.424,outputRows=642585370,outputHeapSize=4.844 GB,partitions=8,preds=[(O_ORDERKEY[4:2] = L_ORDERKEY[4:1])])
            ->  TableScan[ORDERS(21584)](n=2,totalCost=300004,scannedRows=150000000,outputRows=150000000,outputHeapSize=4.844 GB,partitions=8)
            ->  TableScan[LINEITEM_WITH_SKEW(21952)](n=1,totalCost=1167501.713,scannedRows=621009422,outputRows=621009422,outputHeapSize=3.181 GB,partitions=8)

8 rows selected
```
{: .Example}

And here's a screenshot from the Spark Web UI:
<img src="images/OptimizerSkew1.png" class="indentedMedium" />


### Detecting Skewness with Alternative SQL

The following example query shows how to use SQL to check skewness on `join` or `group by` columns:

```
SELECT COUNT(*), MIN(CC), max(CC), avg(CC)
FROM
(SELECT l_orderkey, COUNT(*) AS CC
 FROM xiayi.lineitem_with_skew
 GROUP BY 1) dt;

1                   |2                   |3                   |4
--------------------------------------------------------------------------------
150000000           |1                   |20971526            |4

1 row selected
```
{: .Example}

### Skewness Solutions

We'll apply a number of solutions to the following example of skewness:

<div class="PreWrapper" markdown="1"><pre class="Example">
SELECT  DISTINCT  /* here no column is projected from the inner tables of the left joins */
        stc.TREE_NUMBER, df.FLU_ID,  df.FLU_HANDLE
FROM CC_GE_CPM_CENTRICITYCPM.DOC_FLUIDS df -- 602K rows with skewed values(330k, 100k)
inner join  CC_GE_CPM_CENTRICITYCPM.SYS_TREE stc  ON stc.TREE_ID = df.FLU_TREEID

                      LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_DRAIN dd ON <span class="HighlightedCode">df.FLU_FLUIDID =  dd.DRN_FLUIDID</span>
                      LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_CATHETER dc ON <span class="HighlightedCode">df.FLU_FLUIDID = dc.CAT_FLUIDID</span>
                      LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_INVASIVE di ON <span class="HighlightedCode">df.FLU_FLUIDID = di.INV_FLUIDID</span>

where (dd.DRN_HANDLE = stc.TREE_HANDLE or   dc.CAT_HANDLE=stc.TREE_HANDLE  or di.INV_HANDLE=stc.TREE_HANDLE );</pre>
</div>

<div class="noteNote" markdown="1">
Among the 602K rows of the left table df, one value of `FLU_FLUIDID` has around 330k rows.
What is worse, the right table of the left joins `dd`, `dc` are also skewed on the join column `DRN_FLUIDID` and `CAT_FLUIDID` respectively.

Among the 106K rows of `dc`, there are less than 20 unique rows on `CAT_FLUIDID`, and one of the value has around 80k rows. As a result, the left join results are inflated a lot with duplicate rows(after there first left join, the number of rows is inscreased from 602K to 776M) and the skewness become even worse.
</div>


We'll show you these solutions, which you can apply to avoid or alleviate skewness:

* [1. Hinting with Broadcast Join](#broadcastHint)
* [2. Splitting the Skewed Table](#splittable)
* [3. Rewriting with Non-Skewed Join Columns](#rewrite)
* [4. Salting the Skewed Value](#saltskew)
* [5. Pushing Aggregation Down](#pushaggr)
* [6. Delaying the Skewed Join](#delayjoin)


#### Skewness Solution 1: Hinting with Broadcast Join  {#broadcastHint}

One solution for skewed join columns works if one table is small; you can broadcast the small table to all executors, which can avoid shuffling the large table. In the following example, we supply the `JOINSTRATEGY=BROADCAST` hint in this manner. Note that, in this example, no column is projected from the inner tables of the left joins:

<div class="PreWrapper" markdown="1"><pre class="Example">
SELECT  DISTINCT
  stc.tree_number, df.flu_id,  df.flu_handle
FROM cc_ge_cpm_centricitycpm.doc_fluids df      -- 602K rows with skewed values(330k, 100k)
INNER JOIN  cc_ge_cpm_centricitycpm.sys_tree stc  ON stc.tree_id = df.flu_treeid

    LEFT OUTER JOIN cc_ge_cpm_centricitycpm.doc_drain dd <span class="HighlightedCode">--SPLICE-PROPERTIES JOINSTRATEGY=BROADCAST</span>
ON df.FLU_FLUIDID =  dd.DRN_FLUIDID
    LEFT OUTER JOIN cc_ge_cpm_centricitycpm.doc_catheter dc <span class="HighlightedCode">--SPLICE-PROPERTIES JOINSTRATEGY=BROADCAST</span>
ON df.FLU_FLUIDID = dc.CAT_FLUIDID
    LEFT OUTER JOIN cc_ge_cpm_centricitycpm.doc_invasive di <span class="HighlightedCode">--SPLICE-PROPERTIES JOINSTRATEGY=BROADCAST</span>
ON df.FLU_FLUIDID = di.INV_FLUIDID

WHERE (dd.drn_handle = stc.tree_handle  OR  dc.cat_handle=stc.tree_handle  OR  di.inv_handle=stc.tree_handle );</pre>
</div>

#### Skewness Solution 2: Splitting the Table  {#splittable}

Another skew solution that is worth considering is to split the skewed table in two portions:
* one portion with only the skewed value
* one portion with non-skewed value only

And then join each portion with the other table separately, followed by a union-all. Here's an example:

```
SELECT DISTINCT …
FROM
  cc_ge_cpm_centricitycpm.doc_fluids df
  LEFT OUTER JOIN cc_ge_cpm_centricitycpm.doc_drain dd ON df.FLU_FLUIDID =  dd.DRN_FLUIDID
```
{: .Example}

We can rewrite this query as follows:
```
SELECT …
FROM
  cc_ge_cpm_centricitycpm.doc_fluids df
  LEFT OUTER JOIN cc_ge_cpm_centricitycpm.doc_drain dd  --SPLICE-PROPERTIES JOINSTRATEGY=broadcast
  ON df.flu_fluidid =  dd.drn_fluidid AND dd.flu_fluidid = /*the skewed value*/
WHERE df.flu_fluidid = /*the skewed value*/
UNION
SELECT …
FROM
  cc_ge_cpm_centricitycpm.doc_fluids df
  LEFT OUTER JOIN cc_ge_cpm_centricitycpm.doc_drain dd
  ON df.flu_fluidid =  dd.drn_fluidid
  WHERE (df.flu_fluidid <> /*the skewed value*/ OR df.flu_fluidid is null)
```

#### Skewness Solution 3: Rewriting with Non-Skewed Join Columns

Another possible solution for skewness is to rewite the query by introducing non-skewed join columns. For example:

```
WITH dt AS (
SELECT
  stc.tree_number, df.flu_id,  df.flu_handle, df.flu_fluidid, stc.tree_handle
FROM cc_ge_cpm_centricitycpm.doc_fluids df INNER JOIN  cc_ge_cpm_centricitycpm.sys_tree stc
ON stc.tree_id = df.flu_treeid);
```
{: .Example}

Here's the rewrite:

```
SELECT stc.tree_number, df.flu_id,  df.flu_handle
FROM dt WHERE EXISTS (SELECT 1 FROM cc_ge_cpm_centricitycpm.doc_drain dd WHERE dt.flu_fluidid =  dd.drn_fluidid AND dd.drn_handle = dt.tree_handle)
    UNION
    SELECT * FROM dt WHERE EXISTS (SELECT 1 FROM cc_ge_cpm_centricitycpm.doc_catheter dc WHERE dt.flu_fluidid = dc.cat_fluidid AND dc.cat_handle = dt.tree_handle)
    UNION
    SELECT * FROM dt WHERE EXISTS (SELECT 1 FROM cc_ge_cpm_centricitycpm.doc_invasive di WHERE dt.flu_fluidid = di.inv_fluidid and di.inv_handle=dt.tree_handle);
```
{: .Example}

We applied these rewrites:
* The `OR` term was separated and consumed in 3 branches of `UNION`.
* The `OUTER JOIN` was replaced with a correlated `EXISTS`, since no column is projected from the inner tables of the outer joins, and the `SELECT` clause uses `DISTINCT` to remove duplicates.
* The join of `dt` with each correlated `EXISTS` is on two join conditions; for example, here the column `dt.tree_handle` is not skewed:
  ```
  dt.flu_fluidid = dc.cat_fluidid AND dc.cat_handle = dt.tree_handle
  ```

#### Skewness Solution 4: Salting the Skewed Value  {#saltskew}
Salt the skewed value with random number to even the skewness (SPLICE-2357)

#### Skewness Solution 5: Pushing Aggregation Down Below the Join  {#pushaggr}
Push aggregation done below the join (SPLICE-1522)

#### Skewness Solution 6: Delaying the Skewed Join  {#delayjoin}
Delay the skewed join, sometimes other joins can reduce the skewness or simply reduce the total rows.


## Issue 2: Choosing the Access Path  {#accesspath}

How a query is written determines the choice of access path, which may be one of the following:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Access Path</th>
            <th>Comments</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">Full Table Scan</td>
            <td>This displays as a `TableScan` operation in the explain plan output.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Primary Key Access</td>
            <td><p>When a query has a predicate on leading Primary Key columns, the optimizer can derive the start or stop key to restrict the scan, which avoids looping over all rows in the table.</p>
                <p>This displays as a `TableScan` operation, but will have a smaller number of rows scanned than the total number of rows in the table.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Covering Index Access</td>
            <td><p>If all of the fields referenced in the query that belong to a particular table are covered by an index defined on that table, that index is called a *covering index* for this query.</p>
                <p>When the number of rows accessed is the same, scanning a covering index is usually more favorable than scanning the base table, as index usually has smaller row size.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Non-Covering Index Access</td>
            <td><p>If not all of the fields referenced in the query that belong to a particular table are covered by an index defined on that table, that index is called a *non-covering index*.</p>
                <p>The use of non-covering index incurs the extra cost of looking up the values of column not covered by the index in the base table for each qualified row; this means that it may or may not be a better choice than scanning the base table.</p>
            </td>
        </tr>
    </tbody>
</table>

* Full table scan, which displays as a `TableScan` operation in the explain plan.
* Primary key access, which also displays as a `TableScan` operation, but will have a smaller number of rows scanned than the total number of rows in the table.
* Covering index access
* Non-covering index access


The choice of access path: covering index, non-covering index, or table scan
* Full table scan
* This will display as a TableScan operation in the explain.
* Primary key access
* When query has predicate on leading PK columns, optimizer can derive start or stop key to restrict the scan, avoid looping over all rows in the table.
* This will still display as a TableScan operation in the explain but the number of rows scanned would be smaller than the total rows in the table.

### Example of Full Table Scan vs. Scan with Pk Constraint

```
create table t1 (a1 int, b1 int, c1 int, primary key (a1, b1)); /* total of 640 rows have been  populated */
 /* full table scan */
splice> explain select * from t1;
Plan
----------------------------------------------------------------------------------
Cursor(n=3,rows=640,updateMode=READ_ONLY (1),engine=control)
->  ScrollInsensitive(n=2,totalCost=15.192,outputRows=640,outputHeapSize=7.5 KB,partitions=1)
  ->  TableScan[T1(1792)](n=1,totalCost=4.717,scannedRows=640,outputRows=640,outputHeapSize=7.5 KB,partitions=1)

/* table scan with PK constraint */
splice> explain select * from t1 where a1=10;
Plan
----------------------------------------------------------------------------------
Cursor(n=3,rows=1,updateMode=READ_ONLY (1),engine=control)
->  ScrollInsensitive(n=2,totalCost=8,outputRows=1,outputHeapSize=0 B,partitions=1)
  ->  TableScan[T1(1792)](n=1,totalCost=4,scannedRows=1,outputRows=1,outputHeapSize=0 B,partitions=1,preds=[(A1[0:1] = 10)])
```
{: .Example}

### More on Choice of Access Path
* Covering index access
* If all fields referenced in the query belonging to a particular table are covered by an index defined on that table, that index is called a covering index for this query. When the number of rows accessed is the same, scanning a covering index is usually more favorable than scanning the base table, as index usually has smaller row size.
* Non-covering index access
* If not all fields referenced in the query belonging to a particular table are covered by an index defined on that table, that index is called a non-covering index.
* The use of non-covering index incurs the extra cost to lookup the values of column not covered by the index in the base table for each qualified row, so it may or may not be a better choice than the scan of  base table.

#### Example of Covering Index vs. Non-covering Index

```
create index idx_t1 on t1 (b1, c1);
 /* covering index */
splice> explain select b1, c1 from t1 where b1=3;
-----------------------------------------------------------------------------------------------------------------------
Cursor(n=3,rows=64,updateMode=READ_ONLY (1),engine=control)
->  ScrollInsensitive(n=2,totalCost=8.714,outputRows=64,outputHeapSize=512 B,partitions=1)
  ->  IndexScan[IDX_T1(1825)](n=1,totalCost=4.069,scannedRows=64,outputRows=64,outputHeapSize=512 B,partitions=1,baseTable=T1(1792),preds=[(B1[0:1] = 3)])


/* non-covering index */
splice> explain select a1, b1 from t1 --splice-properties index=idx_t1
> where b1=3;
-----------------------------------------------------------------------------------------------------------------------
Cursor(n=4,rows=64,updateMode=READ_ONLY (1),engine=control)
->  ScrollInsensitive(n=3,totalCost=264.714,outputRows=64,outputHeapSize=512 B,partitions=1)
  ->  IndexLookup(n=2,totalCost=260.069,outputRows=64,outputHeapSize=512 B,partitions=1)
    ->  IndexScan[IDX_T1(1825)](n=1,totalCost=4.069,scannedRows=64,outputRows=64,outputHeapSize=512 B,partitions=1,baseTable=T1(1792),preds=[(B1[1:2] = 3)])
```
{: .Example}

<div class="noteNote" markdown="1">
In the above query, column `a1` is not defined in the index `idx_t1`, so to use the index `idx_t1`, an `IndexLookup` operation is needed.

This makes the index plan not so attractive compared to the base table scan. Here optimizer does not pick index scan, we hint the query to force index scan for demonstration purpose.

Only when the ratio of the number of rows accessed using base table scan over that using index scan is huge, would optimizer picks non-covering index scan over base table scan.
</div>


## Issue 3: Nested Loop Join Performance  {#nestedloop}

You can use nested loop joins for both equality and non-equality join conditions; however, nested loop performance tends to lag behind other join strategies when using an equality join.

One important exception is when the left table has a small number of rows to read, and the join with the right table uses that table's leading primary-key/index column with low selectively. This, in fact, is a very good plan for OLTP queries.

Here's an example of a good nested loop join:

```
SELECT COUNT(*) FROM
lineitem, supplier
WHERE l_suppkey= s_suppkey AND l_partkey = 1 AND  L_orderkey = 5120486;

Plan
----------------------------------------------------------------------------------------------------------------------
Cursor(n=9,rows=1,updateMode=,engine=control)
->  ScrollInsensitive(n=8,totalCost=72.468,outputRows=1,outputHeapSize=0 B,partitions=1)
  ->  ProjectRestrict(n=7,totalCost=64.458,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  GroupBy(n=6,totalCost=64.458,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  ProjectRestrict(n=5,totalCost=1.334,outputRows=1,outputHeapSize=19 B,partitions=12)
        ->  NestedLoopJoin(n=4,totalCost=1.334,outputRows=1,outputHeapSize=19 B,partitions=12)
          ->  TableScan[SUPPLIER(21248)](n=3,totalCost=4.002,scannedRows=1,outputRows=1,outputHeapSize=19 B,partitions=12,preds=[(L_SUPPKEY[1:3] = S_SUPPKEY[2:1])])
          ->  ProjectRestrict(n=2,totalCost=4,outputRows=1,outputHeapSize=0 B,partitions=12)
            ->  IndexScan[L_PART_IDX(21361)](n=1,totalCost=4,scannedRows=1,outputRows=1,outputHeapSize=0 B,partitions=12,baseTable=LINEITEM(21184),preds=[(L_PARTKEY[0:1] = 1),(L_ORDERKEY[0:2] = 5120486)])
```
{: .Example}

### Problematic Example

```
SELECT  ...
FROM
 cc_ge_cpm_centricitycpm.SYS_TREE stce,
 cc_ge_cpm_centricitycpm.HISTORY hst,
 cc_ge_cpm_centricitycpm.CEMAS ce,
 cc_ge_cpm_centricitycpm.GEN_NODE gna,
 cc_ge_cpm_centricitycpm.SYS_TYPE sty,
 cc_ge_cpm_centricitycpm.EMPMAS emp,
 cc_ge_cpm_centricitycpm.CASES c
WHERE
 stce.TREE_ID = hst.HIST_TREEID AND
 stce.TREE_NODEID = ce.CE_ID AND
 hst.HIST_ACTION = gna.GNODE_ID AND
 hst.HIST_TYPE = sty.TYPE_ID AND
 hst.HIST_USERID = emp.EMP_EMPNUM AND
 HIST_TYPE = 2001 AND
 (gna.GNODE_DESCRP = 'Closed' OR gna.GNODE_DESCRP = 'Signed') and
c.cass_id=hst.hist_handle
and  cass_code in ('352928','272626','271706','237193','273830','311042');

```
{: .Example}

<div class="PreWrapper" markdown="1"><pre class="Example">
Cursor(n=19,rows=416,updateMode=,engine=Spark)
->  ScrollInsensitive(n=18,totalCost=311341.97,outputRows=416,outputHeapSize=73.746 KB,partitions=1)
  ->  ProjectRestrict(n=17,totalCost=307112.573,outputRows=416,outputHeapSize=73.746 KB,partitions=1)
    ->  BroadcastJoin(n=16,totalCost=307112.573,outputRows=416,outputHeapSize=73.746 KB,partitions=1,preds=[(HST.HIST_USERID[25:13] = EMP.EMP_EMPNUM[25:26])])
      ->  TableScan[EMPMAS(2228016)](n=15,totalCost=10.037,scannedRows=2261,outputRows=2261,outputHeapSize=73.746 KB,partitions=1)
      ->  BroadcastJoin(n=14,totalCost=307075.681,outputRows=75,outputHeapSize=8.894 KB,partitions=1,preds=[(STCE.TREE_NODEID[21:21] = CE.CE_ID[21:23])])
        ->  TableScan[CEMAS(2229584)](n=13,totalCost=4.109,scannedRows=70,outputRows=70,outputHeapSize=8.894 KB,partitions=1)
        ->  NestedLoopJoin(n=12,totalCost=307066.854,outputRows=75,outputHeapSize=7.014 KB,partitions=1)
          ->  IndexLookup(n=11,totalCost=8.001,outputRows=1,outputHeapSize=7.014 KB,partitions=1)
            ->  IndexScan[IDX_SYSTREE_TREEID_TREEPARENT_TREEHANDLE(2686913)](n=10,totalCost=4.001,scannedRows=1,outputRows=1,outputHeapSize=7.014 KB,partitions=1,baseTable=SYS_TREE(2231536),preds=[(STCE.TREE_ID[15:1] = HST.HIST_TREEID[13:8])])
          ->  BroadcastJoin(n=9,totalCost=249380.216,outputRows=75,outputHeapSize=5.839 KB,partitions=1,preds=[(HST.HIST_ACTION[12:12] = GNA.GNODE_ID[12:18])])
            ->  ProjectRestrict(n=8,totalCost=29.389,outputRows=2,outputHeapSize=5.839 KB,partitions=1,preds=[(GNA.GNODE_DESCRP[10:2] IN (Closed,Signed))])
              ->  TableScan[GEN_NODE(2228656)](n=7,totalCost=29.075,scannedRows=14087,outputRows=14087,outputHeapSize=5.839 KB,partitions=1)
            ->  NestedLoopJoin(n=6,totalCost=249346.807,outputRows=376,outputHeapSize=28.981 KB,partitions=1)
              <span class="HighlightedCode">->  TableScan[HISTORY(2234640)](n=5,totalCost=245795.978,scannedRows=154586150,outputRows=376,outputHeapSize=28.981 KB,partitions=1,preds=[(C.CASS_ID[5:3] = HST.HIST_HANDLE[6:2]),(HIST_TYPE[6:3] = 2001)])</span>
              ->  NestedLoopJoin(n=4,totalCost=531.096,outputRows=1,outputHeapSize=20 B,partitions=1)
                ->  ProjectRestrict(n=3,totalCost=518.958,outputRows=1,outputHeapSize=20 B,partitions=1,preds=[(CASS_CODE[2:2] IN (237193,271706,272626,273830,311042,352928))])
                  ->  TableScan[CASES(2231088)](n=2,totalCost=517.012,scannedRows=221126,outputRows=221126,outputHeapSize=20 B,partitions=1)
                ->  TableScan[SYS_TYPE(2230320)](n=1,totalCost=4.128,scannedRows=80,outputRows=1,outputHeapSize=20 B,partitions=1,preds=[(STY.TYPE_ID[0:1] = 2001)])
</pre></div>

Here's the rewritten query:

```
Rewritten query:

SELECT  ...
FROM --splice-properties joinOrder=fixed
cc_ge_cpm_centricitycpm.HISTORY hst,
cc_ge_cpm_centricitycpm.CASES c,
cc_ge_cpm_centricitycpm.SYS_TYPE sty --splice-properties joinStrategy=broadcast
, cc_ge_cpm_centricitycpm.GEN_NODE gna,
cc_ge_cpm_centricitycpm.EMPMAS emp,
cc_ge_cpm_centricitycpm.SYS_TREE stce
,cc_ge_cpm_centricitycpm.CEMAS ce
WHERE
stce.TREE_ID = hst.HIST_TREEID AND
stce.TREE_NODEID = ce.CE_ID AND
hst.HIST_ACTION = gna.GNODE_ID AND
hst.HIST_TYPE = sty.TYPE_ID AND
hst.HIST_USERID = emp.EMP_EMPNUM AND
HIST_TYPE = 2001 AND
(gna.GNODE_DESCRP = 'Closed' OR gna.GNODE_DESCRP = 'Signed') and
c.cass_id=hst.hist_handle
and  cass_code in ('352928','272626','271706','237193','273830','311042');

Cursor(n=19,rows=3,updateMode=,engine=Spark)
->  ScrollInsensitive(n=18,totalCost=246722.677,outputRows=3,outputHeapSize=2.199 KB,partitions=1)
	->  ProjectRestrict(n=17,totalCost=246681.667,outputRows=3,outputHeapSize=2.199 KB,partitions=1)
	->  BroadcastJoin(n=16,totalCost=246681.667,outputRows=3,outputHeapSize=2.199 KB,partitions=1,preds=[(STCE.TREE_NODEID[25:25] = CE.CE_ID[25:27])])
  	->  TableScan[CEMAS(2229584)](n=15,totalCost=4.109,scannedRows=70,outputRows=70,outputHeapSize=2.199 KB,partitions=1)
  	->  NestedLoopJoin(n=14,totalCost=246672.84,outputRows=3,outputHeapSize=327 B,partitions=1)
    	->  IndexLookup(n=13,totalCost=8.001,outputRows=1,outputHeapSize=327 B,partitions=1)
      	->  IndexScan[IDX_SYSTREE_TREEID_TREEPARENT_TREEHANDLE(2686913)](n=12,totalCost=4.001,scannedRows=1,outputRows=1,outputHeapSize=327 B,partitions=1,baseTable=SYS_TREE(2231536),preds=[(STCE.TREE_ID[19:1] = HST.HIST_TREEID[17:4])])
    	->  NestedLoopJoin(n=11,totalCost=246513.437,outputRows=3,outputHeapSize=275 B,partitions=1)
      	->  TableScan[EMPMAS(2228016)](n=10,totalCost=10.037,scannedRows=2261,outputRows=1,outputHeapSize=275 B,partitions=1,preds=[(HST.HIST_USERID[13:9] = EMP.EMP_EMPNUM[14:1])])
      	->  BroadcastJoin(n=9,totalCost=246360.484,outputRows=3,outputHeapSize=240 B,partitions=1,preds=[(HST.HIST_ACTION[12:8] = GNA.GNODE_ID[12:18])])
        	->  ProjectRestrict(n=8,totalCost=29.389,outputRows=2,outputHeapSize=240 B,partitions=1,preds=[(GNA.GNODE_DESCRP[10:2] IN (Closed,Signed))])
          	->  TableScan[GEN_NODE(2228656)](n=7,totalCost=29.075,scannedRows=14087,outputRows=14087,outputHeapSize=240 B,partitions=1)
        	->  BroadcastJoin(n=6,totalCost=246327.075,outputRows=16,outputHeapSize=983 B,partitions=1,preds=[(HST.HIST_TYPE[8:3] = STY.TYPE_ID[8:16])])
          	->  TableScan[SYS_TYPE(2230320)](n=5,totalCost=4.128,scannedRows=80,outputRows=1,outputHeapSize=983 B,partitions=1,preds=[(STY.TYPE_ID[6:1] = 2001)])
          	->  BroadcastJoin(n=4,totalCost=246318.937,outputRows=196,outputHeapSize=11.294 KB,partitions=1,preds=[(C.CASS_ID[4:14] = HST.HIST_HANDLE[4:2])])
            	->  ProjectRestrict(n=3,totalCost=518.958,outputRows=1,outputHeapSize=11.294 KB,partitions=1,preds=[(CASS_CODE[2:2] IN (237193,271706,272626,273830,311042,352928))])
              	->  TableScan[CASES(2231088)](n=2,totalCost=517.012,scannedRows=221126,outputRows=221126,outputHeapSize=11.294 KB,partitions=1)
            	->  TableScan[HISTORY(2234640)](n=1,totalCost=245795.978,scannedRows=154586150,outputRows=41314052,outputHeapSize=2.27 GB,partitions=1,preds=[(HIST_TYPE[0:3] = 2001)])
```
{: .Example}

## Issue 4: Influencing Join Order  {#joinorder}
xxxx

### Join Order - Use of Derived Table to Influence the Join Order

```
explain select a1, a2, a3, a4 from (select * from t1, t4 where a1=a4) as dt1, (select * from t2, t3 where a2=a3)as dt2 where a1=a2;
-----------------------------------------------------------------------------------------------------------------------------------------
Cursor(n=10,rows=15,updateMode=READ_ONLY (1),engine=control)
->  ScrollInsensitive(n=9,totalCost=36.16,outputRows=15,outputHeapSize=68 B,partitions=1)
  ->  ProjectRestrict(n=8,totalCost=23.913,outputRows=15,outputHeapSize=68 B,partitions=1)
    ->  BroadcastJoin(n=7,totalCost=23.913,outputRows=15,outputHeapSize=68 B,partitions=1,preds=[(A1[16:1] = A2[16:3])])
      ->  BroadcastJoin(n=6,totalCost=12.298,outputRows=18,outputHeapSize=38 B,partitions=1,preds=[(A2[12:1] = A3[12:2])])
        ->  TableScan[T3(1664)](n=5,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=38 B,partitions=1)
        ->  TableScan[T2(1648)](n=4,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=20 B,partitions=1)
      ->  BroadcastJoin(n=3,totalCost=12.298,outputRows=18,outputHeapSize=38 B,partitions=1,preds=[(A1[4:1] = A4[4:2])])
        ->  TableScan[T4(1680)](n=2,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=38 B,partitions=1)
        ->  TableScan[T1(1584)](n=1,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=20 B,partitions=1)
```
{: .Example}


### Join Order - Use of Derived Table to Force the Join of a Subset of Tables

```
splice> explain select a1 from t1 left join t2 on a1=a2 where exists (select 1 from t3 where a1=a3);
Plan
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Cursor(n=9,rows=16,updateMode=READ_ONLY (1),engine=control)
->  ScrollInsensitive(n=8,totalCost=30.922,outputRows=16,outputHeapSize=96 B,partitions=1)
  ->  ProjectRestrict(n=7,totalCost=20.716,outputRows=16,outputHeapSize=96 B,partitions=1)
    ->  BroadcastJoin(n=6,totalCost=20.716,outputRows=16,outputHeapSize=96 B,partitions=1,preds=[(A1[10:2] = ExistsFlatSubquery-0-1.A3[10:1])])
      ->  MergeLeftOuterJoin(n=5,totalCost=12.3,outputRows=20,outputHeapSize=80 B,partitions=1,preds=[(A1[8:1] = A2[8:2])])
        ->  TableScan[T2(1648)](n=4,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=80 B,partitions=1)
        ->  ProjectRestrict(n=3,totalCost=4.04,outputRows=20,outputHeapSize=20 B,partitions=1)
          ->  TableScan[T1(1584)](n=2,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=20 B,partitions=1)
      ->  DistinctTableScan[T3(1664)](n=1,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=20 B,partitions=1)
```
{: .Example}


</div>
</section>
