---
title: Query Optimization
summary: Gets you started with using and optimizing your queries with Splice Machine.
keywords: optimizing, explain plan, statistics, indexes, hints, query hints, select without table, index hint, join order hint, join strategy hint, pinned table hint, spark hint, usespark, delete hint, bulk delete, hfile delete, delete hfile, splice-properties, hints, hinting, --splice-properties, broadcast join, outer join, natural join, joinorder, fixed, joinstrategy, sortmerge, nestedloop, merge
toc: false
product: all
sidebar: home_sidebar
permalink: developers_tuning_queryoptimization.html
folder: DeveloperTopics/TuningAndDebugging
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Optimizing Splice Machine Queries

This topic introduces you to Splice Machine query optimization
techniques, including information about executing SQL expressions
without a table context, and using optimization hints.

## Introduction to Query Optimization

Here are a few mechanisms you can use to optimize your Splice Machine
queries:

<table summary="Query optimization mechanisms">
<thead>
<tr><th>Optimization Mechanism</th><th>Description</th></tr>
</thead>
<tbody>
<tr>
<td>Use Explain Plan</td>
<td>
<p>You can use the Splice Machine Explain Plan facility to display the execution plan for a statement without actually executing the statement. You can use Explain Plan to help determine options such as which join strategy to use or which index to select.</p>
<p>See the <a href="developers_tuning_explainplan.html">About Explain Plan</a> topic.</p>
</td>
</tr>
<tr>
<td>Use Statistics</td>
<td>Your database administrator can refine which statistics are collected on your database, which in turn enhances the operation of the query optimizer. See the <a href="developers_tuning_usingstats.html">Using Statistics</a> topic.</td>
</tr>
<tr>
<td>Use <code>WHERE</code> clauses</td>
<td>Use a <code>WHERE</code> clause in your queries to restrict how much data is scanned.</td>
</tr>
<tr>
<td>Use indexes</td>
<td>
<p class="noSpaceAbove">You can speed up a query by having an index on the criteria used in the <code>WHERE</code> clause, or if the <code>WHERE</code> clause is using a primary key.</p>
<p>Composite indexes work well for optimizing queries.</p>
</td>
</tr>
<tr>
<td>Use Splice Machine <em>query hints</em></td>
<td>The Splice Machine query optimizer allows you to <a href="#Using">provide hints</a> to help in the optimization process.</td>
</tr>
</tbody>
</table>
## Using Select Without a Table   {#Using}

Sometimes you want to execute SQL scalar expressions without having a
table context. For example, you might want to create a query that
evaluates an expression and returns a table with a single row and one
column. Or you might want to evaluate a list of comma-separated
expressions and return a table with a single row and multiple columns
one for each expression.

In Splice Machine, you can execute queries without a table by using the
`sysibm.sysdummy1` dummy table. Here's the syntax:

<div class="fcnWrapperWide" markdown="1">
    select expression FROM sysibm.sysdummy1
{: .FcnSyntax xml:space="preserve"}

</div>
And here's an example:

<div class="preWrapper" markdown="1">
    splice> select 1+ 1 from sysibm.sysdummy1;
{: .Example xml:space="preserve"}

</div>
## Using Splice Machine Query Hints {#queryhints}

You can use *hints* to help the Splice Machine query interface optimize
your database queries.

The Splice Machine optimizer is constantly being improved, and new hint
types sometimes get added. One recent addition is the ability to specify
that a query should be run on (or not on) Spark, if possible.
{: .noteNote}

### Types of Hints

There are different kinds of hints you can supply, each of which is
described in a section below; here's a summary:


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
            <td><a href="#Index">Index</a></td>
            <td class="CodeFont">--splice-properties index=my_index</td>
            <td>Which index to use or not use</td>
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
            <td><a href="#Insert">Insert</a></td>
            <td class="CodeFont">--splice-properties bulkImportDirectory='/path'</td>
            <td>That you want to bypass the normal write pipeline to speed up the insertion of a large amount of data by using our bulk import technology.</td>
        </tr>
        <tr>
            <td><a href="#Delete">Delete</a></td>
            <td class="CodeFont">--splice-properties bulkDeleteDirectory='/path'</td>
            <td>That you are deleting a large amount of data and want to bypass the normal write pipeline to speed up the deletion.</td>
        </tr>
    </tbody>
</table>

### Including Hints in Your Queries

Hints MUST ALWAYS be at the end of a line, meaning that you must always
terminate hints with a newline character.

You cannot add the semicolon that terminates the command immediately
after a hint; the semicolon must go on the next line, as shown in the
examples in this topic.

Many of the examples in this section show usage of hints on the
`splice>` command line. Follow the same rules when using hints
programmatically.
{: .noteIcon}

Hints can be used in two locations: after a table identifier or after a
`FROM` clause. Some hint types can be use after a table identifier, and
some can be used after a `FROM` clause:

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
<p>pin</p>
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
</tbody>
</table>
This example shows proper placement of the hint and semicolon when the
hint is at the end of statement:

<div class="preWrapperWide" markdown="1">
    SELECT * FROM my_table --splice-properties index=my_index;
{: .Example xml:space="preserve"}

</div>
If your command is broken into multiple lines, you still must add the
hints at the end of the line, and you can add hints at the ends of
multiple lines; for example:

<div class="preWrapperWide" markdown="1">
    SELECT * FROM my_table_1 --splice-properties index=my_index
    , my_table_2 --splice-properties index=my_index_2
    WHERE my_table_1.id = my_table_2.parent_id;
{: .Example xml:space="preserve"}

</div>
In the above query, the first command line ends with the first index
hint, because hints must always be the last thing on a command line.
That's why the comma separating the table specifications appears at the
beginning of the next line.
{: .noteNote}

### Index Hints   {#Index}

Use *index hints* to tell the query interface how to use certain indexes
for an operation.

To force the use of a particular index, you can specify the index name;
for example:

<div class="preWrapperWide" markdown="1">
    splice> SELECT * FROM my_table --splice-properties index=my_index
    > ;
{: .Example xml:space="preserve"}

</div>
To tell the query interface to not use an index for an operation,
specify the null index. For example:

<div class="preWrapperWide" markdown="1">
    splice> SELECT * FROM my_table --splice-properties index=null
    > ;
{: .Example xml:space="preserve"}

</div>
And to tell the query interface to use specific indexes on specific
tables for an operation, you can add multiple hints. For example:

<div class="preWrapperWide" markdown="1">
    splice> SELECT * FROM my_table_1   --splice-properties index=my_index
    > , my_table_2                --splice-properties index=my_index_2
    > WHERE my_table_1.id = my_table_2.parent_id;
{: .Example xml:space="preserve"}

</div>
#### Important Note About Placement of Index Hints

Each `index` hint in a query **MUST** be specified alongside the table
containing the index, or an error will occur.

For example, if we have a table named `points` with an index named
`ie_point` and another table named `rewards` with an index named
`ie_rewards`, then this hint works as expected:

<div class="preWrapper" markdown="1">
    SELECT * FROM   member_info m,
       rewards r,
       points p    --SPLICE-PROPERTIES index=ie_point
    WHERE...
{: .Example xml:space="preserve"}

</div>
But the following hint will generate an error because `ie_rewards` is
not an index on the points table.

<div class="preWrapper" markdown="1">
    SELECT * FROM
       member_info m,
       rewards r,
       points p    --SPLICE-PROPERTIES index=ie_rewards
    WHERE...
{: .Example xml:space="preserve"}

</div>
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

| Hint | Example |
|----------
| `joinOrder=FIXED` | `splice> SELECT * FROM --SPLICE-PROPERTIES joinOrder=fixed>  mytable1 e, mytable2 t> WHERE e.id = t.parent_id;` |
| `joinOrder=UNFIXED` | `splice> SELECT * from --SPLICE-PROPERTIES joinOrder=unfixed> mytable1 e, mytable2 t WHERE e.id = t.parent_id;` |
{: summary="Examples of joinOrder hints"}

### JoinStrategy Hints   {#JoinStrategy}

You can use a `JoinStrategy` hint in conjunction with a `joinOrder` hint
to tell the query interface how to process a join. For example, this
query specifies that the `SORTMERGE` join strategy should be used:

<div class="preWrapperWide" markdown="1">
    SELECT * FROM      --SPLICE-PROPERTIES joinOrder=fixed
       mytable1 e, mytable2 t --SPLICE-PROPERTIES joinStrategy=SORTMERGE
       WHERE e.id = t.parent_id;
{: .Example xml:space="preserve"}

</div>
And this uses a `joinOrder` hint along with two `joinStrategy` hints:

<div class="preWrapperWide" markdown="1">
    SELECT *
      FROM --SPLICE-PROPERTIES joinOrder=fixed
      keyword k
      JOIN campaign c  --SPLICE-PROPERTIES joinStrategy=NESTEDLOOP
        ON k.campaignid = c.campaignid
      JOIN adgroup g  --SPLICE-PROPERTIES joinStrategy=NESTEDLOOP
        ON k.adgroupid = g.adgroupid
      WHERE adid LIKE '%us_gse%'
{: .Example xml:space="preserve"}

</div>
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

<div class="preWrapperWide" markdown="1">
    splice> PIN TABLE myTable;splice> SELECT COUNT(*) FROM my_table --splice-properties pin=true> ;
{: .Example xml:space="preserve"}

</div>
You can read more about pinning tables in the
[`PIN TABLE`](sqlref_statements_pintable.html) statement topic.
{: .indentLevel1}
-->
### Spark Hints   {#Spark}

You can use the `useSpark` hint to specify to the optimizer that you
want a query to run on (or not on) Spark. The Splice Machine query
optimizer automatically determines whether to run a query through our
Spark engine or our HBase engine, based on the type of query; you can
override this by using a hint:
{: .indentLevel1}

The Splice Machine optimizer uses its estimated cost for a query to
decide whether to use spark. If your statistics are out of date, the
optimizer may end up choosing the wrong engine for the query.
{: .noteNote}

<div class="preWrapperWide" markdown="1">
    splice> SELECT COUNT(*) FROM my_table --splice-properties useSpark=true
    > ;
{: .Example xml:space="preserve"}

</div>
You can also specify that you want the query to run on HBase and not on
Spark. For example:
{: .indentLevel1}

<div class="preWrapperWide" markdown="1">
    splice> SELECT COUNT(*) FROM your_table --splice-properties useSpark=false
    > ;
{: .Example xml:space="preserve"}

</div>

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

INSERT INTO myUserTbl --splice-properties bulkImportDirectory='/tmp',
useSpark=true,
skipSampling=false
SELECT * FROM licensedUserInfo;
```
{: .Example}
<br />

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
feature. If you're specifying an S3 bucket on AWS, please review our
[Configuring an S3 Bucket for Splice Machine
Access](developers_cloudconnect_configures3.html) tutorial before proceeding.
{: .indentLevel1}

<div class="preWrapperWide" markdown="1">
    splice> DELETE FROM my_table --splice-properties bulkDeleteDirectory='/bulkFilesPath'
    > ;
{: .Example xml:space="preserve"}

</div>
We recommend performing a major compaction on your database after
deleting a large amount of data; you should also be aware of our new
[`SYSCS_UTIL.SET_PURGE_DELETED_ROWS`](sqlref_sysprocs_purgedeletedrows.html)
system procedure, which you can call before a compaction to specify that
you want the data physically (not just logically) deleted during
compaction.
{: .noteNote}

</div>
</section>
