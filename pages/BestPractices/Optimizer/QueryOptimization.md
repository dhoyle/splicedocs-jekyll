---
title: Splice Machine Query Optimizer
summary: Overview of the Splice Machine Query Optimizer
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_intro.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# The Splice Machine Query Optimizer

{% comment %}
NOTE: Captured this info from Xi Yia's slides for Clearsense (https://docs.google.com/presentation/d/1FiUMR8zG8hWMsPCrVL6Qun45xfJv_euKduHm-wVMsvI/edit?usp=sharing) on May 30, 2019 via DB-8359
{% endcomment %}

With a perfect optimizer, you don't need to worry about the efficiency of your SQL statements; the optimizer’s responsibility is to convert your SQL into a semantically equivalent and more performant execution plan. However, there's no such thing as a perfect optimizer, so there are times when we need to apply some manual tuning and rewriting to queries. That's because:

* The optimizer’s heuristic rewrite functionalities has limitations with regard to what it can do
* The optimizer can only explore a limited portion of the search space
* Statistics and cost estimation are not 100% accurate
* The optimizer must not use excessive time parsing query paths

It is organized into these subsections:

* [Using Explain](#explain) introduces the tools you can use to determine if/when manual tuning is required for a query.
* [Using the Statistics Views](#stats) introduces the system views you can query for statistical information about the tables in a query.
* [Addressing Common Performance Problems](#problems) shows you how to apply those tools to several common performance problems.
* [Guiding the Optimizer with Hints](#hints) provides information and example of using the optimizer hints that Splice Machine offers.


## Using Explain  {#explain}

Learning to use the `explain` plan feature is essential for determining how to boost query performance.

***** BRING IN DISCUSSION OF EXPLAIN FROM ZEPPELIN OR DOCS ************

Here's a sample plan:

```
EXPLAIN
SELECT COUNT(*) FROM tpch100.lineitem
WHERE l_shipdate <= DATE({fn TIMESTAMPADD(SQL_TSI_DAY, -90, CAST('1998-12-01 00:00:00' as TIMESTAMP))});

Plan
----
Cursor(n=6,rows=1,updateMode=,engine=Spark)
  ->  ScrollInsensitive(n=5,totalCost=2010896.134,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=20131.62,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  GroupBy(n=3,totalCost=20131.62,outputRows=1,outputHeapSize=0 B,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=241579.259,outputRows=198012508,outputHeapSize=1.014 GB,partitions=12)
          ->  IndexScan[L_SHIPDATE_IDX(21345)](n=1,totalCost=241579.259,scannedRows=198012508,outputRows=198012508,outputHeapSize=1.014 GB,partitions=12,baseTable=LINEITEM(21184),preds=[(L_SHIPDATE[0:1] <= date(TIMESTAMPADD(1998-12-01 00:00:00.0, 4, -90) ))])

6 rows selected
```
{: .Example}

Here are several notes about reading a plan

* The order in which the plan is executed is from the bottom up.
* For a binary join, the left table comes first, then the right table.

And here are some key facts to examine in the explain plan:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Query Execution Phase</th>
            <th>Key Fact</th>
            <th>Comments</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowSpan="3" colSpan="3"><em>Scan step</em></td>
        </tr>
        <tr>
            <td><code>scannedRows</code> vs. <code>outputRows</code></td>
            <td>XXX</td>
        </tr>
        <tr>
            <td><code>predicates</code></td>
            <td>XXX</td>
        </tr>
        <tr>
            <td rowSpan="3" colSpan="3"><em>Join step</em></td>
        </tr>
        <tr>
            <td>Nested loop join</td>
            <td>This is the most general join strategy, but may only be efficient for a special scenario.</td>
        </tr>
        <tr>
            <td>Broadcast join</td>
            <td>Is the right table small enough to fit in memory?</td>
        </tr>
        <tr>
            <td>Sortmerge join</td>
            <td>Is there any skewness on the join columns?</td>
        </tr>
        <tr>
            <td><em>Execution Path</em></td>
            <td>Spark or Control?</td>
            <td>The threshold for Spark execution is 20K scanned rows.</td>
        </tr>
    </tbody>
</table>

## Using the Statistics Views  {#stats}

You can query these two system views for key metrics about tables that will help you to understand the characteristics of the tables in your queries.

The `SYS.SYSTABLESTATISTICS` table contains row count and total size information for each table:

  ```
  splice> SELECT total_row_count, total_size, stats_type, sample_fraction FROM SYS.SYSTABLESTATISTICS WHERE schemaname='TPCH100' AND tablename='LINEITEM';
  TOTAL_ROW_COUNT       |TOTAL_SIZE          |STATS_TYPE |SAMPLE_FRACTION
  -----------------------------------------------------------------------
  600037902             |52803335376         |2          |0.0

  1 row selected
  ```
  {: .Example}

The `SYS.SYSCOLUMNSTATISTICS` table contains statistical information about each column in each table:

  ```
  SELECT columnname, cardinality, null_count, min_value, max_value
  FROM SYS.SYSCOLUMNSTATISTICS
  WHERE schemaname='TPCH100' AND tablename='LINEITEM' AND columnname='L_SHIPDATE';
  ;
  COLUMNNAME     |CARDINALITY         |NULL_COUNT  |MIN_VALUE   |MAX_VALUE
  ---------------------------------------------------------------------------
  L_SHIPDATE     |2291                |0           |1992-01-02  |1998-12-01

  1 row selected

  ```
  {: .Example}

## Addressing Common Performance Problems  {#problems}

### Skewness Issue
* In the presence of skewness, a few tasks have to do significantly more work than other tasks, and defeat the purpose of parallelism, and it could also lead to OOM.
* Skewness could exists in the base table on certain columns, it could also happen after certain joins
* Skewness usually causes trouble in the sortmerge join steps or grouped aggregate operations
* How to detect skewness
  * If execution goes through the spark path, we can look at the tasks on the Spark WebUI

  ```
  select count(*) from --SPLICE-PROPERTIES joinOrder=FIXED
  xiayi.lineitem_with_skew --splice-properties index=null
  , tpch100.orders --splice-properties joinStrategy=sortmerge, index=null
   where o_orderkey = l_orderkey;

  Plan
  ------------------------------------------------------------------------------------------------------Cursor(n=8,rows=1,updateMode=,engine=Spark)
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

  <img src="images/OptimizerSkew1.png" class="indentedMedium" />

* Alternative SQL to check skewness on join columns or group by columns:

  ```
  select count(*), min(CC), max(CC), avg(CC)
  from
  (select l_orderkey, count(*) as CC
   from xiayi.lineitem_with_skew
   group by 1) dt;

  1                   |2                   |3                   |4
  -----------------------------------------------------------------------
  150000000           |1                   |20971526            |4

  1 row selected
  ```
  {: .Example}

### Skewness Solutions
* Some solutions to avoid/alleviate skewness
  * Broadcast join: if one table is small enough to broadcast to all executors, we can void shuffling the large table on skewed join columns.
  * Split the skewed table into one portion with only the skewed value and one with non-skewed value only, join with the other table separately, finally union-all the result.
  * Salt the skewed value with random number to even the skewness (SPLICE-2357)
  * Push aggregation done below the join (SPLICE-1522)
  * Delay the skewed join, sometimes other joins can reduce the skewness or simply reduce the total rows.

### Skewness Example

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

#### Skewness Attempt 1: Hint with Broadcast Join

<div class="PreWrapper" markdown="1"><pre class="Example">
SELECT  DISTINCT  /* here no column is projected from the inner tables of the left joins */
          stc.TREE_NUMBER, df.FLU_ID,  df.FLU_HANDLE
FROM CC_GE_CPM_CENTRICITYCPM.DOC_FLUIDS df -- 602K rows with skewed values(330k, 100k)
inner join  CC_GE_CPM_CENTRICITYCPM.SYS_TREE stc  ON stc.TREE_ID = df.FLU_TREEID

            LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_DRAIN dd <span class="HighlightedCode">--splice-properties joinStrategy=broadcast</span>
ON df.FLU_FLUIDID =  dd.DRN_FLUIDID
            LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_CATHETER dc <span class="HighlightedCode">--splice-properties joinStrategy=broadcast</span>
ON df.FLU_FLUIDID = dc.CAT_FLUIDID
            LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_INVASIVE di <span class="HighlightedCode">--splice-properties joinStrategy=broadcast</span>
ON df.FLU_FLUIDID = di.INV_FLUIDID

where (dd.DRN_HANDLE = stc.TREE_HANDLE or   dc.CAT_HANDLE=stc.TREE_HANDLE  or di.INV_HANDLE=stc.TREE_HANDLE );</pre>
</div>

#### Skewness Attempt 2: Pull Skewed Values Out and Handle Them Separately

<div class="PreWrapper" markdown="1"><pre class="Example">
           Select distinct …
           From
            CC_GE_CPM_CENTRICITYCPM.DOC_FLUIDS df
            LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_DRAIN dd ON df.FLU_FLUIDID =  dd.DRN_FLUIDID
<span class="HighlightedCode">Rewrite to:</span>
           Select …
           From
           CC_GE_CPM_CENTRICITYCPM.DOC_FLUIDS df
            LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_DRAIN dd  --splice-properties joinStrategy=broadcast
            ON df.FLU_FLUIDID =  dd.DRN_FLUIDID AND dd.FLU_FLUIDID = /*the skewed value*/
           WHERE df.FLU_FLUIDID = /*the skewed value*/
           UNION
           Select …
           From
           CC_GE_CPM_CENTRICITYCPM.DOC_FLUIDS df
           LEFT OUTER JOIN CC_GE_CPM_CENTRICITYCPM.DOC_DRAIN dd
           ON df.FLU_FLUIDID =  dd.DRN_FLUIDID
           WHERE (df.FLU_FLUIDID <> /*the skewed value*/ or df.FLU_FLUIDID is null)</pre>
</div>

#### Skewness Attempt 3: Rewrite by Introducing Non-skewed Join Columns

<div class="PreWrapper" markdown="1"><pre class="Example">
WITH dt AS (
SELECT
 stc.TREE_NUMBER, df.FLU_ID,  df.FLU_HANDLE, df.FLU_FLUIDID, stc.TREE_HANDLE
FROM CC_GE_CPM_CENTRICITYCPM.DOC_FLUIDS df inner join  CC_GE_CPM_CENTRICITYCPM.SYS_TREE stc
ON stc.TREE_ID = df.FLU_TREEID)

SELECT stc.TREE_NUMBER, df.FLU_ID,  df.FLU_HANDLE
FROM dt where exists (select 1 from CC_GE_CPM_CENTRICITYCPM.DOC_DRAIN dd where dt.FLU_FLUIDID =  dd.DRN_FLUIDID and dd.DRN_HANDLE = dt.TREE_HANDLE)
      UNION
      select * from dt where exists (select 1 from CC_GE_CPM_CENTRICITYCPM.DOC_CATHETER dc where dt.FLU_FLUIDID = dc.CAT_FLUIDID and dc.CAT_HANDLE = dt.TREE_HANDLE)
      UNION
      select * from dt where exists (select 1 from CC_GE_CPM_CENTRICITYCPM.DOC_INVASIVE di where dt.FLU_FLUIDID = di.INV_FLUIDID and di.INV_HANDLE=dt.TREE_HANDLE);</pre>
</div>

### Choice of Access Path

The choice of access path: covering index, non-covering index, or table scan
* Full table scan
  * This will display as a TableScan operation in the explain.
* Primary key access
  * When query has predicate on leading PK columns, optimizer can derive start or stop key to restrict the scan, avoid looping over all rows in the table.
  * This will still display as a TableScan operation in the explain but the number of rows scanned would be smaller than the total rows in the table.

#### Example of Full Table Scan vs. Scan with Pk Constraint

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


### Nested Loop Join Performance

* Nestedloop join works for all kinds of join conditions (equality or non-equality).
* When equality join condition is present, nestedloop join’s performance usually is not as good as the other 3 join strategies (broadcast, sortmerge and merge join)
* The exception is when the left table has a small amount of rows to read and the join with the right table is on the right tables leading pk/index column with low selectivity.(A very good plan for OLTP queries)

#### Example of a Good Nested Loop Join

```
select count(*) from
lineitem, supplier
where l_suppkey= s_suppkey and l_partkey = 1 and  L_orderkey = 5120486;

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

#### Problematic Example

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

## Guiding the Optimizer with Hints  {#hints}


</div>
</section>
