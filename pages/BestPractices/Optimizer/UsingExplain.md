---
title: Using Explain Plan to Tune Queries
summary: Using Explain Plan to Tune Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_explain.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Explain Plan to Tune Queries

If you have a query that is not performing as expected, you can run the `explain` command to display the execution plan for the query. You can then examine the plan to determine where it looks like too much time is being spent in the query's execution flow

To generate an explain plan, simply put `explain` in front of a query. You'll note that you need to read the plan from the bottom up: the first step is at the bottom. For example:


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

When you use `explain` in front of a query, the query itself does not run.
{: .noteNote}


## Examining an Explain Plan

To see the execution flow of a query, look at the generated plan from the *bottom up.*  The very first steps of the query are at the bottom, then each step follows above.

Each row includes the action being performed (a Scan, Join, grouping, etc.) followed by:

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td class="CodeFont">n count</td>
            <td>The step of the plan (and again you can see as we go from the bottom up the count starts from 1 and goes up from there)</td>
        </tr>
        <tr>
            <td class="CodeFont">totalCost</td>
            <td>The estimated cost for this step (and any substeps below it)</td>
        </tr>
        <tr>
            <td class="CodeFont">scannedRows (for Table or Index Scan steps)</td>
            <td>The estimated count of how many rows need to be scanned in this step</td>
        </tr>
        <tr>
            <td class="CodeFont">outputRows</td>
            <td>The estimated count of how many rows are passed to the next step in the plan</td>
        </tr>
        <tr>
            <td class="CodeFont">outputHeapSize</td>
            <td>The estimated count of how much data is passed to the next step in the plan</td>
        </tr>
        <tr>
            <td class="CodeFont">partitions</td>
            <td>The estimated number of (HBase) regions are involved in that step of the plan</td>
        </tr>
        <tr>
            <td class="CodeFont">preds</td>
            <td>Which filtering predicates are applied in that step of the plan</td>
        </tr>
        <tr>
            <td class="CodeFont">engine</td>
            <td>Which execution path the query will take: <code>Spark</code> for OLAP queries, and <code>Control</code> for OLTP queries.</td>
        </tr>
    </tbody>
</table>

We will see that the `scannedRows` and `outputRows` are key numbers to monitor as we tune query performance.


### Joins

Here are a few key notes about reviewing joins in a plan:

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td class="ItalicFont">Nested loop join</td>
            <td>This is the most general join strategy, but may only be efficient for a special scenario.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Broadcast join</td>
            <td>Is the right table small enough to fit in memory?</td>
        </tr>
        <tr>
            <td class="ItalicFont">Sortmerge join</td>
            <td>Is there any skewness on the join columns?</td>
        </tr>
    </tbody>
</table>


### Which Execution Path (Which Engine)?
The final steps, `Scroll Insensitive` and `Cursor` are typical end steps to the query execution.  There is one __very important__ piece of information shown on the `Cursor` line at the end:

```
Cursor(n=5,rows=360,updateMode=, engine=control)
```
{: .Example}
<br />

This line shows you which *engine* Splice Machine plans to use for the query.

<div class="noteIcon">
<p>As you may know, Splice Machine is a dual-engine database:</p>
<ul style="margin-bottom:0; padding-bottom:0">
<li>Fast-running queries (e.g. those only processing a few rows) typically get executed on the <code>control</code> side, directly in HBase.</li>
<li>Longer-running queries or queries that process a lot of data go through <code>Spark</code>.</li>
</ul>
</div>


## Explain Plan Examples

The remainder of this topic contains the following examples of using the `explain` command to display the execution plan for a statement:

* [TableScan Examples](#TableSca)
* [IndexScan Examples](#IndexSca)
* [Projection and Restriction Examples](#Projecti)
* [Index Lookup](#Index)
* [Join Example](#Join)
* [Union Example](#Union)
* [Order By Example](#Order)
* [Aggregation Operation Examples](#Aggregat)
* [Subquery Example](#Subquery)

### TableScan Examples   {#TableSca}

This example show a plan for a `TableScan` operation that has no qualifiers, known as a *raw scan*:

```
splice> EXPLAIN SELECT * FROM SYS.SYSTABLES;
Plan
-------------------------------------------------------------------------------------------------
Cursor(n=3,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=2,totalCost=8.594,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
    ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)

3 rows selected
```
{: .Example }
<br />

This example show a plan for a `TableScan` operation that does have
qualifiers:

```
splice> EXPLAIN SELECT * FROM SYS.SYSTABLES --SPLICE-PROPERTIES INDEX=NULL
> WHERE tablename='SYSTABLES';
Plan
-------------------------------------------------------------------------------------------------Cursor(n=3,rows=18,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=2,totalCost=8.54,outputRows=18,outputHeapSize=2.988 KB,partitions=1)
    ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=18,outputHeapSize=2.988 KB,partitions=1,preds=[(TABLENAME[0:2] = SYSTABLES)])

3 rows selected
```
{: .Example}

#### Nodes

* The plan labels this operation as `TableScan[`*tableId*(*conglomerateId*)`]`:

  * *tableId* is the name of the table, in the form `schemaName '.'
    tableName`.
  * *conglomerateId* is an ID that is unique to every HBase table; this
    value is used internally, and can be used for certain administrative
    tasks
  {: .SecondLevel}

* The `preds` field includes qualifiers that were pushed down to the
  base table.

### IndexScan Examples   {#IndexSca}

This example show a plan for an `IndexScan` operation that has no
predicates:

```
splice> EXPLAIN SELECT tablename FROM SYS.SYSTABLES; --covering index

Plan
-------------------------------------------------------------------------------------------------Cursor(n=3,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=2,totalCost=8.31,outputRows=20,outputHeapSize=560 B,partitions=1)
    ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=560 B,partitions=1,baseTable=SYSTABLES(32))

3 rows selected
```
{: .Example }
<br />

This example shows a plan for an `IndexScan` operation that contains
predicates:

```
splice> EXPLAIN SELECT tablename FROM SYS.SYSTABLES --SPLICE-PROPERTIES index=SYSTABLES_INDEX1
> WHERE tablename = 'SYSTABLES';

Plan
-------------------------------------------------------------------------------------------------Cursor(n=3,rows=18,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=2,totalCost=8.272,outputRows=18,outputHeapSize=432 B,partitions=1)
    ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.049,outputRows=18,outputHeapSize=432 B,partitions=1,baseTable=SYSTABLES(48),preds=[(TABLENAME[0:1] = SYSTABLES)])

3 rows selected
```
{: .Example }

#### Nodes

* The plan labels this operation as
  `IndexScan[`*indexId(conglomerateId)*`]`:

  * *indexId* is the name of the index
  * *conglomerateId* is an ID that is unique to every HBase table; this
    value is used internally, and can be used for certain administrative
    tasks
  {: .SecondLevel}

* The `preds` field includes qualifiers that were pushed down to the
  base table.

### Projection and Restriction Examples   {#Projecti}

This example show a plan for a `Projection` operation:

```
splice> EXPLAIN SELECT tablename || 'hello' FROM SYS.SYSTABLES;

Plan
-------------------------------------------------------------------------------------------------Cursor(n=4,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=3,totalCost=8.302,outputRows=20,outputHeapSize=480 B,partitions=1)
    ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
      ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))

4 rows selected
```
{: .Example }
<br />

This example shows a plan for a `Restriction` operation:

```
splice> EXPLAIN SELECT tablename FROM SYS.SYSTABLES WHERE tablename LIKE '%SYS%';

Plan
-------------------------------------------------------------------------------------------------Cursor(n=4,rows=10,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=3,totalCost=8.178,outputRows=10,outputHeapSize=240 B,partitions=1)
    ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=10,outputHeapSize=240 B,partitions=1,preds=[like(TABLENAME[0:1], %SYS%)])
      ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=240 B,partitions=1,baseTable=SYSTABLES(48))

4 rows selected
```
{: .Example }

#### Nodes

* The plan labels both projection and restriction operations as
  `ProjectRestrict`. which can contain both *projections* and
  *non-qualifier restrictions*. A *non-qualifier restriction* is a
  predicate that cannot be pushed to the underlying table scan.

### Index Lookup   {#Index}

This example shows a plan for an `IndexLookup` operation:

```
splice> EXPLAIN SELECT * FROM SYS.SYSTABLES --SPLICE-PROPERTIES INDEX=SYSTABLES_INDEX1
> WHERE tablename = 'SYSTABLES';

Plan
-------------------------------------------------------------------------------------------------Cursor(n=4,rows=18,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=3,totalCost=177.265,outputRows=18,outputHeapSize=921.586 KB,partitions=1)
    ->  IndexLookup(n=2,totalCost=78.715,outputRows=18,outputHeapSize=921.586 KB,partitions=1)
      ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=6.715,outputRows=18,outputHeapSize=921.586 KB,partitions=1,baseTable=SYSTABLES(48),preds=[(TABLENAME[1:2] = SYSTABLES)])
```
{: .Example }

#### Nodes

* The plan labels the operation as `IndexLookup`; you may see this
  labeled as an `IndexToBaseRow` operation elsewhere.
* Plans for `IndexLookup` operations do not contain any special fields.

## Join Example   {#Join}

This example shows a plan for a `Join` operation:

```
splice> EXPLAIN SELECT * FROM SYS.SYSTABLES t, SYS.SYSSCHEMAS s WHERE t.schemaid =s.schemaid;

Plan
-------------------------------------------------------------------------------------------------Cursor(n=5,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=4,totalCost=21.728,outputRows=20,outputHeapSize=6.641 KB,partitions=1)
    ->  BroadcastJoin(n=3,totalCost=12.648,outputRows=20,outputHeapSize=6.641 KB,partitions=1,preds=[(T.SCHEMAID[4:4] = S.SCHEMAID[4:8])])
      ->  TableScan[SYSSCHEMAS(32)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=6.641 KB,partitions=1)
      ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)

5 rows selected
```
{: .Example }

#### Nodes

* The plan labels the operation using the *join type* followed by
  `Join`; the possible values are:

  * {: .CodeFont value="1"} BroadcastJoin
  * {: .CodeFont value="2"} MergeJoin
  * {: .CodeFont value="3"} MergeSortJoin
  * {: .CodeFont value="4"} NestedLoopJoin
  * {: .CodeFont value="5"} OuterJoin
  {: .SecondLevel}

* The plan may include a `preds` field, which lists the join predicates.
* `NestedLoopJoin` operations do not include a `preds` field; instead,
  the predicates are listed in either a `ProjectRestrict` or in the
  underlying scan.
* The right side of the *Join* operation is listed first, followed by
  the left side of the join.

#### Outer Joins

An *outer join* does not display it as a separate strategy in the plan;
instead, it is treated a *postfix* for the strategy that's used. For
example, if you are using a Broadcast join, and it's a left outer join,
then you'll see `BroadcastLeftOuterJoin`. Here's an example:

```
EXPLAIN SELECT s.schemaname,t.tablename FROM SYS.SYSSCHEMAS s LEFT OUTER JOIN SYS.SYSTABLES t
> ON s.schemaid = t.schemaid;
Plan
-------------------------------------------------------------------------------------------------
Cursor(n=6,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=5,totalCost=348.691,outputRows=20,outputHeapSize=2 MB,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=130.579,outputRows=20,outputHeapSize=2 MB,partitions=1)
      ->  BroadcastLeftOuterJoin(n=3,totalCost=130.579,outputRows=20,outputHeapSize=2 MB,partitions=1,preds=[(S.SCHEMAID[4:1] = T.SCHEMAID[4:4])])
        ->  IndexScan[SYSTABLES_INDEX1(145)](n=2,totalCost=7.017,outputRows=20,outputHeapSize=2 MB,partitions=1,baseTable=SYSTABLES(48))
        ->  TableScan[SYSSCHEMAS(32)](n=1,totalCost=7.516,outputRows=20,outputHeapSize=1023.984 KB,partitions=1)
```
{: .Example }
<br />

### Union Example   {#Union}

This example shows a plan for a `Union` operation:

```
splice> EXPLAIN SELECT tablename FROM SYS.SYSTABLES t UNION ALL SELECT schemaname FROM sys.sysschemas;

Plan
-------------------------------------------------------------------------------------------------
Cursor(n=5,rows=40,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=4,totalCost=16.668,outputRows=40,outputHeapSize=1.094 KB,partitions=1)
    ->  Union(n=3,totalCost=12.356,outputRows=40,outputHeapSize=1.094 KB,partitions=1)
      ->  IndexScan[SYSSCHEMAS_INDEX1(209)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=1.094 KB,partitions=1,baseTable=SYSSCHEMAS(32))
      ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))

5 rows selected
```
{: .Example }

#### Nodes

* The right side of the `Union` is listed first, followed by the left
  side of the union,

### Order By Example   {#Order}

This example shows a plan for an order by operation:

```
splice> EXPLAIN SELECT tablename FROM SYS.SYSTABLES ORDER BY tablename DESC;

Plan
-------------------------------------------------------------------------------------------------Cursor(n=4,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=3,totalCost=16.604,outputRows=20,outputHeapSize=480 B,partitions=1)
    ->  OrderBy(n=2,totalCost=12.356,outputRows=20,outputHeapSize=480 B,partitions=1)
      ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))

4 rows selected
```
{: .Example }

#### Nodes

* The plan labels this operation as `OrderBy`.

### Aggregation Operation Examples   {#Aggregat}

This example show a plan for a grouped aggregate operation:

```
splice> EXPLAIN SELECT tablename, COUNT(*) FROM SYS.SYSTABLES GROUP BY tablename;

Plan
-------------------------------------------------------------------------------------------------Cursor(n=6,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=5,totalCost=12.568,outputRows=20,outputHeapSize=480 B,partitions=16)
    ->  ProjectRestrict(n=4,totalCost=8.32,outputRows=20,outputHeapSize=480 B,partitions=16)
      ->  GroupBy(n=3,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))

6 rows selected)
```
{: .Example }
<br />

This example shows a plan for a scalar aggregate operation:

```
splice> EXPLAIN SELECT COUNT(*) FROM SYS.SYSTABLES;

Plan
-------------------------------------------------------------------------------------------------Cursor(n=6,rows=1,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=5,totalCost=8.797,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=4.257,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  GroupBy(n=3,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1,baseTable=SYSTABLES(48))

6 rows selected
```
{: .Example }

#### Nodes

* The plan labels both grouped and scaled aggregate operations as
  `GroupBy`.

### Subquery Example   {#Subquery}

This example shows a plan for a `SubQuery` operation:

```
splice> EXPLAIN SELECT tablename, (SELECT tablename FROM SYS.SYSTABLES t2 WHERE t2.tablename = t.tablename)FROM SYS.SYSTABLES t;

Plan
-------------------------------------------------------------------------------------------------Cursor(n=6,rows=20,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=5,totalCost=8.302,outputRows=20,outputHeapSize=480 B,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
      ->  Subquery(n=3,totalCost=12.55,outputRows=20,outputHeapSize=480 B,partitions=1,correlated=true,expression=true,invariant=true)
        ->  IndexScan[SYSTABLES_INDEX1(145)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48),preds=[(T2.TABLENAME[0:1] = T.TABLENAME[4:1])])
      ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))

6 rows selected
```
{: .Example }

#### Nodes

* Subqueries are listed as a second query tree, whose starting
  indentation level is the same as the `ProjectRestrict` operation that
  *owns* the subquery.
* Includes a *correlated* field, which specifies whether or not the
  query is treated as correlated or uncorrelated.
* Includes an *expression* field, which specifies whether or not the
  subquery is an expression.
* Includes an *invariant* field, which indicates whether the subquery is
  invariant.

</div>
</section>
