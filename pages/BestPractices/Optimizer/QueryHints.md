---
title: Using Hints to Improve Performance
summary: Using Hints to Optimize Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_hints.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Hints to Improve Performance

Splice Machine offers a number of *hints* that you can add to a query. These hints provide the optimizer with guidance that help it create the best execution plan for a query. There are different type of hints you can supply, each of which is described in a section in this topic.

The remainder of this topic contains these sections:

* [Types of Hints](#hinttypes)
* [How to Specify Hints in Your Queries](#inclhints)
* [Using Hints](#usingHints)

## Types of Hints  {#hinttypes}

The following table summarizes the hint types available in Splice Machine:

<table>
    <col width="120px"/>
    <col width="45%"/>
    <col />
    <thead>
        <tr>
            <th>Hint Type</th>
            <th>Example</th>
            <th>Used to Specify</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="#Delete">Delete</a></td>
            <td class="CodeFont">--splice-properties bulkDeleteDirectory='/path'</td>
            <td>That you are deleting a large amount of data and want to bypass the normal write pipeline to speed up the deletion.</td>
        </tr>
        <tr>
            <td><a href="#Index">Index</a></td>
            <td class="CodeFont">--splice-properties index=my_index</td>
            <td>Which index to use or not use</td>
        </tr>
        <tr>
            <td><a href="#Insert">Insert</a></td>
            <td class="CodeFont">--splice-properties bulkImportDirectory='/path'</td>
            <td>That you want to bypass the normal write pipeline to speed up the insertion of a large amount of data by using our bulk import technology.</td>
        </tr>
        <tr>
            <td><a href="#JoinOrder">Join Order</a></td>
            <td class="CodeFont">--splice-properties joinOrder=fixed</td>
            <td>Which join order to use for two tables</td>
        </tr>
        <tr>
            <td><a href="#JoinStrategy">Join Strategy</a></td>
            <td class="CodeFont">--splice-properties joinStrategy=sortmerge</td>
            <td>How a join is processed (in conjunction with the Join Order hint)</td>
        </tr>
<!--
        <tr>
            <td><a href="#Pinned">Pinned Table</a></td>
            <td class="CodeFont">--splice-properties pin=true</td>
            <td>That you want the pinned (cached in memory) version of a table used in a query</td>
        </tr>
-->
        <tr>
            <td><a href="#Spark">Spark</a></td>
            <td class="CodeFont">--splice-properties useSpark=true</td>
            <td>That you want a query to run (or not run) on Spark</td>
        </tr>
        <tr>
            <td><a href="#SubQueryFlatten">Subquery Flatten</a></td>
            <td class="CodeFont">--splice-properties doNotFlatten=true</td>
            <td>Tells the optimizer to flatten (<code>=false</code>) or not flatten (<code>=true</code>) a subquery that could be flattened.</td>
        </tr>
    </tbody>
</table>

## How to Specify Hints in Your Queries  {#inclhints}

Specific hint types can be used in specific locations: after a table identifier, after a subquery, or after a
`FROM` clause, as shown in the following table:

<table>
    <thead>
        <tr><th>Hint after a:</th><th>Hint types</th><th>Example</th></tr>
    </thead>
    <tbody>
        <tr>
            <td>Table identifier</td>
            <td class="CodeFont">
                <p>index</p>
                <p>joinStrategy</p>
                <p>useSpark</p>
                <p>bulkDeleteDirectory</p>
            </td>
            <td><code><span class="Example">SELECT * FROM<br />    member_info m, rewards r,<br />   points p --SPLICE-PROPERTIES index=ie_point WHERE...</span></code></td>
        </tr>
        <tr>
            <td>A <code>FROM</code> clause</td>
            <td class="CodeFont">
                <p>joinOrder</p>
            </td>
            <td><code><span class="Example">SELECT * FROM --SPLICE-PROPERTIES joinOrder=fixed<br />   mytable1 e, mytable2 t<br />   WHERE e.id = t.parent_id;</span></code></td>
        </tr>
        <tr>
            <td>A subquery</td>
            <td class="CodeFont">
                <p>doNotFlatten</p>
            </td>
            <td><code><span class="Example">SELECT * FROM t1 WHERE b1=1<br />  AND c1 = (SELECT MAX(c2) FROM t2 WHERE a1=a2 AND b1=b2) --splice-properties doNotFlatten=false<br />   ;</span></code></td>
        </tr>
    </tbody>
</table>

### Hint at the End of a Line

Hints __MUST ALWAYS__ be at the end of a line, followed by a newline character; if the hint ends your command, you need to add the terminating `;` on the next line. For example:

```
splice> SELECT * FROM my_table --splice-properties index=my_index
> ;
```
{: .Example }

You can apply hints to multiple tables or `FROM` clauses in a command. Put each hint at the end of the line containing the table name or `FROM`, as shown here:

```
SELECT * FROM my_table_1 --splice-properties index=my_index
, my_table_2 --splice-properties index=my_index_2
WHERE my_table_1.id = my_table_2.parent_id;
```
{: .Example }

You *can* apply multiple hints to a table or `FROM` clause; when doing so, add the comma-separated hints at the end of a line, as shown here:

```
splice> INSERT INTO myUserTbl --splice-properties bulkImportDirectory='/tmp', useSpark=true, skipSampling=false
>SELECT * FROM licensedUserInfo;
```
{: .Example }

Many of the examples in this section show usage of hints on the `splice>` command line. Follow the same rules when using hints programmatically.
{: .noteIcon}

## Using Hints  {#usingHints}

This section provides specific information about how to use the different hint types:

* [Delete Hints](#Delete)
* [Index Hints](#Index)
* [Insert Hints](#Insert)
* [JoinOrder Hints](#JoinOrder)
* [JoinStrategy Hints](#JoinStrategy)
* [Spark Hints](#Spark)
* [Subquery Flatten Hints](#SubQueryFlatten)


### Delete Hints   {#Delete}

You can use the `bulkDeleteDirectory` hint to specify that you want to
use our bulk delete feature to optimize the deletion of a large amount
of data. Similar to our [bulk import
feature](bestpractices_ingest_bulkimport.html), bulk delete generates HFiles,
which allows us to bypass the Splice Machine write pipeline and HBase
write path when performing the deletion. This can significantly speed up
the deletion process.
{: .indentLevel1}

You need to specify the directory to which you want the temporary HFiles
written; you must have write permissions on this directory to use this
feature. If you're specifying a location on AWS or Azure, please
see the [Configuring an S3 Bucket](developers_cloudconnect_configures3.html) or [Using Azure Storage](developers_cloudconnect_configureazure.html) topics for information.</p>
{: .indentLevel1}

```
splice> DELETE FROM my_table --splice-properties bulkDeleteDirectory='/bulkFilesPath'
> ;
```
{: .Example }


We recommend performing a major compaction on your database after
deleting a large amount of data; you should also be aware of our new
[`SYSCS_UTIL.SET_PURGE_DELETED_ROWS`](sqlref_sysprocs_purgedeletedrows.html)
system procedure, which you can call before a compaction to specify that
you want the data physically (not just logically) deleted during
compaction.
{: .noteNote}



### Index Hints   {#Index}

Use *index hints* to tell the query interface how to use certain indexes
for an operation.

To force the use of a particular index, you can specify the index name;
for example:

```
splice> SELECT * FROM my_table --splice-properties index=my_index
> ;
```
{: .Example }

To tell the query interface to not use an index for an operation,
specify the null index. For example:

```
splice> SELECT * FROM my_table --splice-properties index=null
> ;
```
{: .Example }

And to tell the query interface to use specific indexes on specific
tables for an operation, you can add multiple hints. For example:

```
splice> SELECT * FROM my_table_1   --splice-properties index=my_index
> , my_table_2                --splice-properties index=my_index_2
> WHERE my_table_1.id = my_table_2.parent_id;
```
{: .Example }

#### Important Note About Placement of Index Hints

Each `index` hint in a query **MUST** be specified alongside the table
containing the index, or an error will occur.

For example, if we have a table named `points` with an index named
`ie_point` and another table named `rewards` with an index named
`ie_rewards`, then this hint works as expected:

```
SELECT * FROM   member_info m,
   rewards r,
   points p    --SPLICE-PROPERTIES index=ie_point
WHERE...
```
{: .Example }

But the following hint will generate an error because `ie_rewards` is
not an index on the points table.

```
SELECT * FROM
   member_info m,
   rewards r,
   points p    --SPLICE-PROPERTIES index=ie_rewards
WHERE...
```
{: .Example }

### Insert Hints  {#Insert}
You can add a set of hints to an `INSERT` statement that tell the database to use bulk import technology to insert a set of query results into a table.

To understand how bulk import works, please review the [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) topic in our *Best Practices Guide.*
{: .noteIcon}

You need to combine two hints together for bulk insertion, and can add a third hint in your `INSERT` statement:

* The `bulkImportDirectory` hint is used just as it is with the `BULK_HFILE_IMPORT` procedure: to specify where to store the temporary HFiles used for the bulk import.
* The `useSpark=true` hint tells Splice Machine to use the Spark engine for this insert. This is __required__ for bulk HFile inserts.
* The optional `skipSampling` hint is used just as it is with the `BULK_HFILE_IMPORT` procedure: to tell the bulk insert to compute the splits automatically or that the splits have been supplied manually.

Here's a simple example:

```
DROP TABLE IF EXISTS myUserTbl;
CREATE TABLE myUserTbl AS SELECT
    user_id,
    report_date,
    type,
    region,
    country,
    access,
    birth_year,
    gender,
    product,
    zipcode,
    licenseID
FROM licensedUserInfo
WITH NO DATA;

INSERT INTO myUserTbl --splice-properties bulkImportDirectory='/tmp', useSpark=true, skipSampling=false
SELECT * FROM licensedUserInfo;
```
{: .Example }


### JoinOrder Hints   {#JoinOrder}

Use `JoinOrder` hints to tell the query interface in which order to join
two tables. You can specify these values for a `JoinOrder` hint:

* Use `joinOrder=FIXED` to tell the query optimizer to order the table
  join according to how where they are named in the `FROM` clause.
* Use `joinOrder=UNFIXED` to specify that the query optimizer can
  rearrange the table order.

  `joinOrder=UNFIXED` is the default, which means that you don't need to
  specify this hint to allow the optimizer to rearrange the table order.
  {: .noteNote}

Here are examples:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Hint</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">joinOrder=FIXED</td>
            <td class="Example"><code>splice&gt; SELECT * FROM --SPLICE-PROPERTIES joinOrder=fixed<br />&gt;  mytable1 e, mytable2 t WHERE e.id = t.parent_id;</code></td>
        </tr>
        <tr>
            <td class="CodeFont">joinOrder=UNFIXED</td>
            <td class="Example"><code>splice&gt; SELECT * from --SPLICE-PROPERTIES joinOrder=unfixed<br />
              &gt; mytable1 e, mytable2 t WHERE e.id = t.parent_id;</code></td>
        </tr>
    </tbody>
</table>


### JoinStrategy Hints   {#JoinStrategy}

You can use a `JoinStrategy` hint in conjunction with a `joinOrder` hint
to tell the query interface how to process a join. For example, this
query specifies that the `SORTMERGE` join strategy should be used:

```
SELECT * FROM      --SPLICE-PROPERTIES joinOrder=fixed
   mytable1 e, mytable2 t --SPLICE-PROPERTIES joinStrategy=SORTMERGE
   WHERE e.id = t.parent_id;
```
{: .Example }

And this uses a `joinOrder` hint along with two `joinStrategy` hints:

```
SELECT *
  FROM --SPLICE-PROPERTIES joinOrder=fixed
  keyword k
  JOIN campaign c  --SPLICE-PROPERTIES joinStrategy=NESTEDLOOP
    ON k.campaignid = c.campaignid
  JOIN adgroup g  --SPLICE-PROPERTIES joinStrategy=NESTEDLOOP
    ON k.adgroupid = g.adgroupid
  WHERE adid LIKE '%us_gse%'
```
{: .Example }

You can specify these join strategies:

<table summary="Join strategy hint types">
    <tbody>
        <tr><th>JoinStrategy Value</th><th>Strategy Description</th></tr>
        <tr>
            <td><code>BROADCAST</code></td>
            <td>
                <p class="noSpaceAbove">Read the results of the Right Result Set (<em>RHS</em>) into memory, then for each row in the left result set (<em>LHS</em>), perform a local lookup to determine the right side of the join.</p>
                <p class="noSpaceAbove"><code>BROADCAST</code> will only work if at least one of the following is true:</p>
                <ul>
                   <li>There is at least one equijoin (<code>=</code>) predicate that does not include a function call.</li>
                   <li>There is at least one inequality join predicate, the RHS is a base table, and the join is evaluated in Spark.</li>
                </ul>
            </td>
        </tr>
        <tr>
        <td><code>CROSS</code></td>
            <td>
                <p class="noSpaceAbove">Combines each row from the first table with each row from the second table; this produces the Cartesian product of rows from tables in the join. </p>
            </td>
        </tr>
        <tr>
        <td><code>MERGE</code></td>
            <td>
                <p class="noSpaceAbove">Read the Right and Left result sets simultaneously in order and join them together as they are read.</p>
                <p class="noSpaceAbove"><code>MERGE</code> joins require that both the left and right result sets be sorted according to the join keys. <code>MERGE</code> requires an equijoin predicate that does not include a function call.</p>
            </td>
        </tr>
        <tr>
            <td><code>NESTEDLOOP</code></td>
            <td>
                <p>For each row on the left, fetch the values on the right that match the join.</p>
                <p><code>NESTEDLOOP</code> is the only join that can work with any join predicate of any type; however this type of join is generally very slow.</p>
            </td>
        </tr>
        <tr>
            <td><code>SORTMERGE</code></td>
            <td>
                <p class="noSpaceAbove">Re-sort both the left and right sides according to the join keys, then perform a <code>MERGE</code> join on the results.</p>
                <p class="noSpaceAbove"><code>SORTMERGE</code> requires an equijoin predicate with no function calls.</p>
            </td>
        </tr>
    </tbody>
</table>
<!--    Hidden by GRH 12/2018 via note from GDavis
### Pinned Table Hint   {#Pinned}

You can use the `pin` hint to specify to specify that you want a query
to run against a pinned version of a table.
{: .indentLevel1}

```
splice> PIN TABLE myTable;splice> SELECT COUNT(*) FROM my_table --splice-properties pin=true> ;
```
{: .Example }


You can read more about pinning tables in the
[`PIN TABLE`](sqlref_statements_pintable.html) statement topic.
{: .indentLevel1}
-->
### Spark Hints   {#Spark}

You can use the `useSpark` hint to specify to the optimizer that you
want a query to run on (or not on) Spark. The Splice Machine query
optimizer automatically determines whether to run a query through our
Spark engine or our HBase engine, based on the type of query; you can
override this by using a hint.

Here is an example:

```
splice> SELECT COUNT(*) FROM my_table --splice-properties useSpark=true
> ;
```
{: .Example }

You can also specify that you want the query to run on HBase and not on
Spark. For example:

```
splice> SELECT COUNT(*) FROM your_table --splice-properties useSpark=false
> ;
```
{: .Example }

The Splice Machine optimizer uses its estimated cost for a query to
decide whether to use Spark. If your statistics are out of date, the
optimizer may end up choosing the wrong engine for the query.
{: .noteNote}

### Subquery Flatten Hints  {#SubQueryFlatten}


The Splice Machine optimizer uses a rule-based approach to optimizing subqueries. In some cases, the optimizer decides to flatten a subquery that could run faster without flattening. The `doNotFlatten` hint allows you to tell the optimizer to not consider flattening a specific subquery.

This is a Boolean hint with possible values `true` and `false`, which you include at the end of a line immediately after the subquery that you do not want flattened. For example, here we tell the optimizer to not flatten the `(SELECT MAX...)` subquery:

```
SELECT * FROM t1 WHERE b1=1
  AND c1 = (SELECT max(c2) FROM t2 WHERE a1=a2 AND b1=b2) --splice-properties doNotFlatten=true
;
```
{: .Example}

<p class="noteNote">The default value, <code>doNotFlatten=false</code>, is assumed when this hint is not present.</p>

#### When to Use This Hint

In certain cases, non-flattened subqueries perform better than flatten subqueries, because the correlating condition can be leveraged. Here's an example that will help you to understand when to consider using the `doNotFlatten` hint.

```
splice> CREATE TABLE t1 (a1 INT, b1 INT, c1 INT, PRIMARY KEY (a1));
splice> CREATE TABLE t2 (a2 INT, b2 INT, c2 INT, PRIMARY KEY (a2));
splice> INSERT INTO t1 VALUES (1,1,1), (2,2,2), (3,3,3), (4,4,4), (5,5,5);
splice> INSERT INTO t2 SELECT * FROM t1;
splice> ANALYZE TABLE t1;
splice> ANALYZE TABLE t2;
```
{: .Example}

Let's examine the execution plan with `doNotFlatten=true`:

```
splice> EXPLAIN SELECT * FROM t1 WHERE b1=1
  AND c1 = (SELECT MAX(c2) FROM t2 WHERE a1=a2 AND b1=b2) --splice-properties doNotFlatten=true
;

Plan
------------------------------------------------------------------------------------------------------------------
Cursor(n=10,rows=1,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=9,totalCost=8.016,outputRows=1,outputHeapSize=12 B,partitions=1)
    ->  ProjectRestrict(n=8,totalCost=4.006,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(C1[1:3] = subq=6)])
      ->  Subquery(n=7,totalCost=12.006,outputRows=1,outputHeapSize=0 B,partitions=1,correlated=true,expression=true,invariant=true)
        ->  ProjectRestrict(n=6,totalCost=8.002,outputRows=1,outputHeapSize=0 B,partitions=1)
          ->  GroupBy(n=5,totalCost=8.002,outputRows=1,outputHeapSize=0 B,partitions=1)
            ->  ProjectRestrict(n=4,totalCost=4.001,outputRows=1,outputHeapSize=5 B,partitions=1)
              ->  TableScan[T2(1600)](n=3,totalCost=4.001,scannedRows=1,outputRows=1,outputHeapSize=5 B,partitions=1,preds=[(B1[1:2] = B2[2:2]),(A1[1:1] = A2[2:1])])
      ->  ProjectRestrict(n=2,totalCost=4.006,outputRows=1,outputHeapSize=12 B,partitions=1)
        ->  TableScan[T1(1584)](n=1,totalCost=4.006,scannedRows=5,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(B1[0:2] = 1)])

10 rows selected
```
{: .Example}

You can see that a `Subquery` node is in the plan, so we know that the subquery is not being flattened.

If you set `doNotFlatten=false` or simply leave the hint out, you get the following plan, which has a higher cost:

```
splice> EXPLAIN SELECT * FROM t1 WHERE b1=1
  AND c1 = (SELECT MAX(c2) FROM t2 WHERE a1=a2 AND b1=b2) --splice-properties doNotFlatten=false
;

Plan
------------------------------------------------------------------------------------------------------------------
Cursor(n=9,rows=1,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=8,totalCost=18.518,outputRows=1,outputHeapSize=19 B,partitions=1)
    ->  ProjectRestrict(n=7,totalCost=12.022,outputRows=1,outputHeapSize=19 B,partitions=1)
      ->  BroadcastJoin(n=6,totalCost=12.022,outputRows=1,outputHeapSize=19 B,partitions=1,preds=[(A1[8:1] = AggFlatSub-0-1.A2[8:5]),(C1[8:3] = AggFlatSub-0-1.SQLCol1[8:4])])
        ->  ProjectRestrict(n=5,totalCost=8.011,outputRows=1,outputHeapSize=12 B,partitions=1)
          ->  GroupBy(n=4,totalCost=8.011,outputRows=1,outputHeapSize=12 B,partitions=1)
            ->  ProjectRestrict(n=3,totalCost=4.006,outputRows=1,outputHeapSize=12 B,partitions=1)
              ->  TableScan[T2(1600)](n=2,totalCost=4.006,scannedRows=5,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(AggFlatSub-0-1.B2[2:2] = 1)])
        ->  TableScan[T1(1584)](n=1,totalCost=4.006,scannedRows=5,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(B1[0:2] = 1)])

9 rows selected
```
{: .Example}

</div>
</section>
