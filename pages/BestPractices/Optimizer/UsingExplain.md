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

If you have a query that is not performing as expected, you can run the `explain` command to display the Explain plan (also referred to as *execution plan*) for the query. You can then examine the plan to determine where it looks like too much time is being spent in the query's execution flow.  This topic shows you how to generate and examine and interpret explain plans, in these sections:

* [Generating an Explain Plan](#generating)
* [Examining an Explain Plan](#examining)
* [Explain Plan Examples](#examples)

## Generating an Explain Plan  {#generating}

To generate an explain plan, simply put `explain` in front of a query. You'll note that you need to read the plan from the bottom up: the first step is at the bottom. For example:

```
EXPLAIN
SELECT COUNT(*) FROM tpch100.lineitem
WHERE l_shipdate <= DATE({fn TIMESTAMPADD(SQL_TSI_DAY, -90, CAST('1998-12-01 00:00:00' as TIMESTAMP))});

Plan
--------------------------------------------------------------------------------
Cursor(n=6,rows=1,updateMode=,engine=OLAP)
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


## Examining an Explain Plan  {#examining}

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
            <td>Which execution path the query will take: <code>OLAP</code> for OLAP queries, and <code>OLTP</code> for OLTP queries.</td>
        </tr>
    </tbody>
</table>

We will see that the `scannedRows` and `outputRows` are key numbers to monitor as we tune query performance.

<p class="noteIcon">The term <em>cost</em> in a Splice Machine explain plan is a measurement of the combined resources needed to execute an operation or a plan (which is a set of operations). The resources taken into account include CPU time, input/output, and network utilization; these are input to a cost model that produces a single number. The optimizer then selects the plan with the lowest number.</p>

### Explaining DDL Statements

SQL Data Definition Language (DDL) statements have no known cost, and
thus do not require optimization. Because of this, the `explain` command
does not work with DDL statements; attempting to `explain` a DDL
statement such as `CREATE TABLE` will generate a syntax error.

You **cannot** use `explain` with any of the following SQL statements:

* `ALTER`
* `CREATE ...` (any statement that starts with `CREATE`)
* `DROP ...`   (any statement that starts with `DROP`)
* `GRANT`
* `RENAME ...` (any statement that starts with `RENAME`)
* `REVOKE`
* `TRUNCATE TABLE`

### Reviewing Join Plans

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
Cursor(n=5,rows=360,updateMode=, engine=OLTP)
```
{: .Example}

This line shows you which *engine* Splice Machine plans to use for the query.

<div class="noteIcon">
<p>Splice Machine is a dual-engine database:</p>
<ul style="margin-bottom:0; padding-bottom:0">
<li>Fast-running queries (e.g. those only processing a few rows) are typically executed on the <code>OLTP</code> side, directly in HBase.</li>
<li>Longer-running queries or queries that process a lot of data are executed on the <code>OLAP</code> side using Spark.</li>
</ul>
</div>


## Explain Plan Examples  {#examples}

The remainder of this topic contains the following examples of using the `explain` command to display the execution plan for a statement. We use two TPCH data tables for these examples:

* [TableScan Examples](#TableSca)
* [IndexScan Examples](#IndexSca)
* [Projection and Restriction Examples](#Projecti)
* [Index Lookup](#Index)
* [Join Example](#Join)
* [Union Example](#Union)
* [Order By Example](#Order)
* [Aggregation Operation Examples](#Aggregat)
* [Subquery Example](#Subquery)

### Creating the Example Tables

We use these tables for the EXPLAIN plan examples in this section:

```
CREATE TABLE tpch1.orders (
    o_orderkey BIGINT NOT NULL PRIMARY KEY,
    o_custkey INTEGER,
    o_orderstatus VARCHAR(1),
    o_totalprice DECIMAL(15,2),
    o_orderdate DATE,
    o_orderpriority VARCHAR(15),
    o_clerk VARCHAR(15),
    o_shippriority INTEGER ,
    o_comment VARCHAR(79)
);

CREATE INDEX o_cust_idx ON tpch1.orders( o_custkey, o_orderkey);

CREATE TABLE tpch1.customer (
    c_custkey INTEGER NOT NULL PRIMARY KEY,
    c_name VARCHAR(25),
    c_address VARCHAR(40),
    c_nationkey INTEGER,
    c_phone VARCHAR(15),
    c_acctbal DECIMAL(15,2),
    c_mktsegment VARCHAR(10),
    c_comment VARCHAR(117)
);
```
{: .Example}


### TableScan Examples   {#TableSca}

This example show a plan for a `TableScan` operation that has no qualifiers, known as a *raw scan*:

```
splice> EXPLAIN SELECT * FROM tpch1.orders;
Plan
--------------------------------------------------------------------------------
Cursor(n=3,rows=1500000,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=2,totalCost=19472.843,outputRows=1500000,outputHeapSize=143.051 MB,partitions=1)
    ->  TableScan[ORDERS(2256)](n=1,totalCost=3004,scannedRows=1500000,outputRows=1500000,outputHeapSize=143.051 MB,partitions=1)

3 rows selected
```
{: .Example}


This example show a plan for a `TableScan` operation that does have
qualifiers:

```
EXPLAIN SELECT * FROM tpch1.orders --SPLICE-PROPERTIES INDEX=NULL
where o_custkey=1;
Plan
--------------------------------------------------------------------------------
Cursor(n=3,rows=15,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=2,totalCost=3008.164,outputRows=15,outputHeapSize=1.465 KB,partitions=1)
    ->  TableScan[ORDERS(2256)](n=1,totalCost=3004,scannedRows=1500000,outputRows=15,outputHeapSize=1.465 KB,partitions=1,preds=[(O_CUSTKEY[0:2] = 1)])

3 rows selected
```
{: .Example}

#### Notes About This Plan

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
EXPLAIN SELECT o_custkey, o_orderkey FROM tpch1.orders; --covering index
Plan
--------------------------------------------------------------------------------
Cursor(n=5,rows=1500000,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=4,totalCost=17163.52,outputRows=1500000,outputHeapSize=31.789 MB,partitions=1)
    ->  ProjectRestrict(n=3,totalCost=1834,outputRows=1500000,outputHeapSize=31.789 MB,partitions=1)
      ->  ProjectRestrict(n=2,totalCost=1834,outputRows=1500000,outputHeapSize=31.789 MB,partitions=1)
        ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=1834,scannedRows=1500000,outputRows=1500000,outputHeapSize=31.789 MB,partitions=1,baseTable=ORDERS(2256))

5 rows selected
```
{: .Example}


This example shows a plan for an `IndexScan` operation that contains
predicates:

```
EXPLAIN SELECT o_custkey, o_orderkey FROM tpch1.orders --splice-properties index=o_cust_idx
where o_custkey=1;
Plan
--------------------------------------------------------------------------------
Cursor(n=5,rows=15,updateMode=READ_ONLY (1),engine=OLTP)
  ->  ScrollInsensitive(n=4,totalCost=8.171,outputRows=15,outputHeapSize=333 B,partitions=1)
    ->  ProjectRestrict(n=3,totalCost=4.018,outputRows=15,outputHeapSize=333 B,partitions=1)
      ->  ProjectRestrict(n=2,totalCost=4.018,outputRows=15,outputHeapSize=333 B,partitions=1)
        ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=4.018,scannedRows=15,outputRows=15,outputHeapSize=333 B,partitions=1,baseTable=ORDERS(2256),preds=[(O_CUSTKEY[0:1] = 1)])

5 rows selected
```
{: .Example}

#### Notes About This Plan

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
EXPLAIN SELECT SUBSTR(o_comment, 1, 10) FROM tpch1.orders;
Plan
--------------------------------------------------------------------------------
Cursor(n=4,rows=1500000,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=3,totalCost=18170.76,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1)
    ->  ProjectRestrict(n=2,totalCost=3004,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1)
      ->  TableScan[ORDERS(2256)](n=1,totalCost=3004,scannedRows=1500000,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1)

4 rows selected
```
{: .Example}


This example shows a plan for a `Restriction` operation:

```
EXPLAIN SELECT o_custkey, o_orderkey FROM tpch1.orders WHERE CAST(o_custkey AS char(10)) LIKE '3%';
Plan
--------------------------------------------------------------------------------
Cursor(n=5,rows=750000,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=4,totalCost=9534.093,outputRows=750000,outputHeapSize=15.895 MB,partitions=1)
    ->  ProjectRestrict(n=3,totalCost=1867.333,outputRows=750000,outputHeapSize=15.895 MB,partitions=1)
      ->  ProjectRestrict(n=2,totalCost=1867.333,outputRows=750000,outputHeapSize=15.895 MB,partitions=1,preds=[like(O_CUSTKEY[0:1], 3%) ])
        ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=1834,scannedRows=1500000,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1,baseTable=ORDERS(2256))

5 rows selected
```
{: .Example}

#### Notes About This Plan

* The plan labels both projection and restriction operations as
  `ProjectRestrict`. which can contain both *projections* and
  *non-qualifier restrictions*. A *non-qualifier restriction* is a
  predicate that cannot be pushed to the underlying table scan.

### Index Lookup   {#Index}

This example shows a plan for an `IndexLookup` operation:

```
EXPLAIN SELECT * FROM tpch1.orders --SPLICE-PROPERTIES INDEX=o_cust_idx
WHERE o_custkey=1;
Plan
--------------------------------------------------------------------------------
Cursor(n=4,rows=15,updateMode=READ_ONLY (1),engine=OLTP)
  ->  ScrollInsensitive(n=3,totalCost=68.182,outputRows=15,outputHeapSize=1.465 KB,partitions=1)
    ->  IndexLookup(n=2,totalCost=64.018,outputRows=15,outputHeapSize=1.465 KB,partitions=1)
      ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=4.018,scannedRows=15,outputRows=15,outputHeapSize=1.465 KB,partitions=1,baseTable=ORDERS(2256),preds=[(O_CUSTKEY[1:2] = 1)])

4 rows selected
```
{: .Example}

#### Notes About This Plan

* The plan labels the operation as `IndexLookup`; you may see this
  labeled as an `IndexToBaseRow` operation elsewhere.
* Plans for `IndexLookup` operations do not contain any special fields.

## Join Example   {#Join}

This example shows a plan for a `Join` operation:

```
EXPLAIN SELECT * FROM tpch1.orders O, tpch1.customer C WHERE O.o_custkey = C.c_custkey;
Plan
--------------------------------------------------------------------------------
Cursor(n=6,rows=2369593,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=5,totalCost=113207.492,outputRows=2369593,outputHeapSize=488.804 MB,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=59891.557,outputRows=2369593,outputHeapSize=488.804 MB,partitions=1)
      ->  MergeSortJoin(n=3,totalCost=59891.557,outputRows=2369593,outputHeapSize=488.804 MB,partitions=1,preds=[(O.O_CUSTKEY[4:10] = C.C_CUSTKEY[4:1])])
        ->  TableScan[ORDERS(2256)](n=2,totalCost=3004,scannedRows=1500000,outputRows=1500000,outputHeapSize=488.804 MB,partitions=1)
        ->  TableScan[CUSTOMER(2272)](n=1,totalCost=383.5,scannedRows=150000,outputRows=150000,outputHeapSize=21.887 MB,partitions=1)

6 rows selected
```
{: .Example}

#### Notes About This Plan

* The plan labels the operation using the *join type* followed by
  `Join`; the possible values are:

  * `BroadcastJoin`
  * `MergeJoin`
  * `MergeSortJoin`
  * `NestedLoopJoin`
  * `OuterJoin`
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
example, if you are using a MergeSort join, and it's a left outer join,
then you'll see `MergeSortLeftOuterJoin`. Here's an example:

```
EXPLAIN SELECT * FROM tpch1.orders O LEFT JOIN tpch1.customer C ON O.o_custkey = C.c_custkey;

Plan
--------------------------------------------------------------------------------
Cursor(n=5,rows=1500000,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=4,totalCost=92772.017,outputRows=1500000,outputHeapSize=164.938 MB,partitions=1)
    ->  MergeSortLeftOuterJoin(n=3,totalCost=59021.964,outputRows=1500000,outputHeapSize=164.938 MB,partitions=1,preds=[(O.O_CUSTKEY[4:2] = C.C_CUSTKEY[4:10])])
      ->  TableScan[CUSTOMER(2272)](n=2,totalCost=383.5,scannedRows=150000,outputRows=150000,outputHeapSize=164.938 MB,partitions=1)
      ->  TableScan[ORDERS(2256)](n=1,totalCost=3004,scannedRows=1500000,outputRows=1500000,outputHeapSize=143.051 MB,partitions=1)

5 rows selected
```
{: .Example}


### Union Example   {#Union}

This example shows a plan for a `Union` operation:

```
EXPLAIN SELECT *
    FROM tpch1.orders WHERE o_orderkey=1
    UNION ALL
    SELECT * FROM tpch1.orders WHERE o_orderkey=100;
Plan
--------------------------------------------------------------------------------
Cursor(n=5,rows=2,updateMode=READ_ONLY (1),engine=OLTP)
  ->  ScrollInsensitive(n=4,totalCost=16.044,outputRows=2,outputHeapSize=100 B,partitions=1)
    ->  Union(n=3,totalCost=12.024,outputRows=2,outputHeapSize=100 B,partitions=1)
      ->  TableScan[ORDERS(2256)](n=2,totalCost=4.002,scannedRows=1,outputRows=1,outputHeapSize=100 B,partitions=1,preds=[(O_ORDERKEY[3:1] = 100)])
      ->  TableScan[ORDERS(2256)](n=1,totalCost=4.002,scannedRows=1,outputRows=1,outputHeapSize=100 B,partitions=1,preds=[(O_ORDERKEY[0:1] = 1)])

5 rows selected
```
{: .Example}

#### Notes About This Plan

* The right side of the `Union` is listed first, followed by the left
  side of the union,

### Order By Example   {#Order}

This example shows a plan for an order by operation:

```
EXPLAIN SELECT o_custkey FROM tpch1.orders ORDER BY o_custkey desc;
Plan
--------------------------------------------------------------------------------
Cursor(n=4,rows=1500000,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=3,totalCost=34001.52,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1)
    ->  OrderBy(n=2,totalCost=18834.76,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1)
      ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=1834,scannedRows=1500000,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1,baseTable=ORDERS(2256))

4 rows selected
```
{: .Example}

#### Notes About This Plan

* The plan labels this operation as `OrderBy`.

### Aggregation Operation Examples   {#Aggregat}

This example show a plan for a grouped aggregate operation:

```
EXPLAIN SELECT o_custkey, count(*) FROM tpch1.orders GROUP BY o_custkey;
Plan
--------------------------------------------------------------------------------
Cursor(n=6,rows=94953,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=5,totalCost=2910.182,outputRows=94953,outputHeapSize=1.006 MB,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=1950.096,outputRows=94953,outputHeapSize=1.006 MB,partitions=1)
      ->  GroupBy(n=3,totalCost=1950.096,outputRows=94953,outputHeapSize=1.006 MB,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=1834,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1)
          ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=1834,scannedRows=1500000,outputRows=1500000,outputHeapSize=15.895 MB,partitions=1,baseTable=ORDERS(2256))

6 rows selected
```
{: .Example}


This example shows a plan for a scalar aggregate operation:

```
EXPLAIN SELECT COUNT(*) FROM tpch1.orders;
Plan
--------------------------------------------------------------------------------
Cursor(n=6,rows=1,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=5,totalCost=16838.001,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=1834.001,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  GroupBy(n=3,totalCost=1834.001,outputRows=1,outputHeapSize=0 B,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=1834,outputRows=1500000,outputHeapSize=0 B,partitions=1)
          ->  IndexScan[O_CUST_IDX(2369)](n=1,totalCost=1834,scannedRows=1500000,outputRows=1500000,outputHeapSize=0 B,partitions=1,baseTable=ORDERS(2256))

6 rows selected
```
{: .Example}

#### Notes About This Plan

* The plan labels both grouped and scaled aggregate operations as
  `GroupBy`.

### Subquery Example   {#Subquery}

This example shows a plan for a `SubQuery` operation:

```
EXPLAIN SELECT * FROM tpch1.orders WHERE o_orderdate = (SELECT MAX(o_orderdate) FROM tpch1.orders);
Plan
--------------------------------------------------------------------------------
Cursor(n=9,rows=657,updateMode=READ_ONLY (1),engine=OLAP)
  ->  ScrollInsensitive(n=8,totalCost=3015.215,outputRows=657,outputHeapSize=64.19 KB,partitions=1)
    ->  ProjectRestrict(n=7,totalCost=3004,outputRows=657,outputHeapSize=64.19 KB,partitions=1)
      ->  TableScan[ORDERS(2256)](n=6,totalCost=3004,scannedRows=1500000,outputRows=657,outputHeapSize=64.19 KB,partitions=1,preds=[(O_ORDERDATE[5:5] = subq=4)])
        ->  Subquery(n=5,totalCost=12938856.093,outputRows=1,outputHeapSize=0 B,partitions=1,correlated=false,expression=true,invariant=true)
          ->  ProjectRestrict(n=4,totalCost=12923689.333,outputRows=1,outputHeapSize=0 B,partitions=1)
            ->  GroupBy(n=3,totalCost=12923689.333,outputRows=1,outputHeapSize=0 B,partitions=1)
              ->  ProjectRestrict(n=2,totalCost=12923689.32,outputRows=985500000,outputHeapSize=10.198 GB,partitions=1)
                ->  TableScan[ORDERS(2256)](n=1,totalCost=3004,scannedRows=1500000,outputRows=1500000,outputHeapSize=10.198 GB,partitions=1)

9 rows selected
```
{: .Example}

#### Notes About This Plan

* Subqueries are listed as a second query tree, whose starting
  indentation level is the same as the `ProjectRestrict` or `TableScan` operation that
  *owns* the subquery.
* Includes a *correlated* field, which specifies whether or not the
  query is treated as correlated or uncorrelated.
* Includes an *expression* field, which specifies whether or not the
  subquery is an expression.
* Includes an *invariant* field, which indicates whether the subquery is
  invariant.

</div>
</section>
