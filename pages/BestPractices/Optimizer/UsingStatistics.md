---
title: Using Statistics to Tune Queries
summary: Using Statistics to Tune Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_statistics.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Statistics to Tune Queries

Collecting statistics dramatically improves the estimation of costs that the optimizer relies on to find the best plan. Database statistics are a form of metadata (data about data) that assists the Splice Machine query optimizer to select the most efficient approach to running a query, based on information that has been gathered about the tables involved in the query.

Splice Machine recommends collecting statistics after initial loading of data into a table, and recollecting them by using the `analyze` command if you've made significant changes to a table. Running the `analyze` command can take a bit of time, depending on the size of your database; however, collecting statistics dramatically improves the estimation of costs that the optimizer relies on to find the best plan.


This topic describes:

* [Collecting statistics](#Collecti) for a schema or table in your
  database
* [Viewing collected statistics](#Viewing)
* [Dropping statistics](#Dropping) for a schema
* [Enabling and disabling collection of statistics](#Enabling) on specific
  columns in tables in your database

## About Database Statistics

Statistics are inexact; in fact, some statistics like table cardinality are estimated using advanced algorithms, due to the resources required to compute these values. It's important to keep this in mind when basing design decisions on values in database statistics tables. Collecting or dropping statistics will typically change the execution plan that the optimizer generates for a query; please review the [Using Explain Plan to Tune Queries](#bestpractices_optimizer_explain.html) topic for information about reviewing explain plans.

The statistics for your database are not automatically refreshed when the data in your database changes, which means that when you query a statistical table or view, the results you see may not exactly match the data in the actual tables.
{: .noteImportant}

## Collecting Statistics   {#Collecti}

Splice Machine offers two variations of the [`ANALYZE`](cmdlineref_analyze.html) statistics collection command, which you can use from the `splice>` command line interpreter:

*  `ANALYZE TABLE` collects statistics for a specific table.
*  `ANALYZE SCHEMA` collects statistics for all tables in a schema.


You can also call the
[`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html) system
procedure to collect statistics on an entire schema.

### Analyzing a Table

The `ANALYZE TABLE` command has two forms; here are examples:

```
splice> ANALYZE TABLE myTable;

splice> ANALYZE TABLE myTable ESTIMATE STATISTICS SAMPLE 5 PERCENT;
```
{: .Example}

In both cases, you can optionally qualify the table name with its schema name, e.g. `mySchema.myTable`.

You can use the `ESTIMATE STATISTICS` form of this command to reduce analysis time; you specify the percentage of the table that should be sampled when generating statistics for the table, instead of using the default, which is to randomly sample the entire table.

The `ANALYZE TABLE` command also collects statistics for any indexes associated with the table.


## Analyzing a Schema

The `ANALYZE SCHEMA` command collects statistics for every table (and every index defined on those tables) in the specified schema; for example:

```
splice> ANALYZE SCHEMA mySchema;
```
{: .Example}

The output of `ANALYZE SCHEMA` is effectively the cumulative output that you would see from running `ANALYZE TABLE` on each table in the schema, as shown in the next section.

## Analyze Output

Here's some sample output from `ANALYZE` commands:

```
splice> analyze table test.t2;
schemaName |tableName |partition |rowsCollec&|partitionSize |partitionCount  |statsType  |sampleFraction
-----------------------------------------------------------------------------------------------------------------
TEST       |T2        |-All-     |39226      |235356        |1               |2          |0

1 rows selected
splice>splice> analyze table test.t2 estimate statistics sample 50 percent;
schemaName |tableName |partition |rowsCollec&|partitionSize |partitionCount  |statsType  |sampleFraction
-----------------------------------------------------------------------------------------------------------------
TEST       |T2        |-All-     |19613      |235356        |1               |3          |0.5

1 rows selected
splice>splice> analyze schema test;
schemaName |tableName |partition |rowsCollec&|partitionSize |partitionCount  |statsType  |sampleFraction
-----------------------------------------------------------------------------------------------------------------
TEST       |T2        |-All-     |39226      |235356        |1               |2          |0
TEST       |T5        |-All-     |39226      |235356        |1               |2          |0
2 rows selected
```
{: .Example}

The following table summarizes the information displayed by `ANALYZE`:

<table summary="List of columns in the output of the analyze table command.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>schemaName</code></td>
            <td>The name of the schema.</td>
        </tr>
        <tr>
            <td><code>tableName</code></td>
            <td>The name of the table.</td>
        </tr>
        <tr>
            <td><code>partition</code></td>
            <td>The Splice Machine partition. We merge the statistics for all table partitions, so the partition will show as <code>-All-</code> when you specify one of the non-merged type values for the <code>statsType</code> parameter.</td>
        </tr>
        <tr>
            <td><code>rowsCollected</code></td>
            <td>The total number of rows collected for the table.</td>
        </tr>
        <tr>
            <td><code>partitionSize</code></td>
            <td>The combined size of the table's partitions.</td>
        </tr>
        <tr>
            <td><code>statsType</code></td>
            <td><p>The type of statistics, which is one of these values:</p>
                <table>
 <col />
 <col />
 <tbody>
     <tr>
         <td>0</td>
         <td>Full table (not sampled) statistics that reflect the unmerged partition values.</td>
     </tr>
     <tr>
         <td>1</td>
         <td>Sampled statistics that reflect the unmerged partition values.</td>
     </tr>
     <tr>
         <td>2</td>
         <td>Full table (not sampled) statistics that reflect the table values after all partitions have been merged.</td>
     </tr>
     <tr>
         <td>3</td>
         <td>Sampled statistics that reflect the table values after all partitions have been merged.</td>
     </tr>
 </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>sampleFraction</code></td>
            <td>
                <p>The sampling percentage, expressed as <code>0.0</code> to <code>1.0</code>, </p>
                <ul>
 <li>If <code>statsType=0</code> or <code>statsType=1</code> (full statistics), this value is not used, and is shown as <code>0</code>.</li>
 <li>If <code>statsType=2</code> or <code>statsType=3</code>, this value is the percentage or rows to be sampled. A value of <code>0</code> means no rows, and a value of <code>1</code> means all rows (same as full statistics).</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>


## Viewing Statistics  {#Viewing}

After statistics have been collected, you can query two system views for key metrics about the tables in your database. This information can provide you with insights into how to best structure certain queries:

* The [Table Statistics View](#tableStats) contains statistical information for tables in your database.
* The [Column Statistics View](#columnStats) contains statistical information about each column in a table.

You can see the columns available in these views using the `DESCRIBE` command, e.g.

```
splice> describe sys.systablestatistics;
COLUMN_NAME          |TYPE_NAME|DEC&|NUM&|COLUM&|COLUMN_DEF|CHAR_OCTE&|IS_NULL&
--------------------------------------------------------------------------------------------------
SCHEMANAME           |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
TABLENAME            |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
CONGLOMERATENAME     |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
TOTAL_ROW_COUNT      |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
AVG_ROW_COUNT        |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
TOTAL_SIZE           |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
NUM_PARTITIONS       |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
AVG_PARTITION_SIZE   |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
ROW_WIDTH            |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
STATS_TYPE           |INTEGER  |0   |10  |10    |NULL      |NULL      |YES
SAMPLE_FRACTION      |DOUBLE   |NULL|2   |52    |NULL      |NULL      |YES

11 rows selected
```
{: .Example}

Here's an example of summarizing some interesting statistics for a table:

```
splice> SELECT total_row_count, total_size, stats_type, sample_fraction
> FROM SYS.SYSTABLESTATISTICS
> WHERE schemaname='TPCH100' AND tablename='LINEITEM';
TOTAL_ROW_COUNT       |TOTAL_SIZE          |STATS_TYPE |SAMPLE_FRACTION
-----------------------------------------------------------------------
600037902             |52803335376         |2          |0.0

1 row selected
```
{: .Example}


Here's a similar example using the `SYS.SYSCOLUMNSTATISTICS` view:

```
splice> describe sys.syscolumnstatistics;
COLUMN_NAME          |TYPE_NAME|DEC&|NUM&|COLUM&|COLUMN_DEF|CHAR_OCTE&|IS_NULL&
--------------------------------------------------------------------------------------------------
SCHEMANAME           |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
TABLENAME            |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
COLUMNNAME           |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
CARDINALITY          |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
NULL_COUNT           |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
NULL_FRACTION        |REAL     |NULL|2   |23    |NULL      |NULL      |YES
MIN_VALUE            |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
MAX_VALUE            |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
QUANTILES            |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
FREQUENCIES          |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES
THETA                |VARCHAR  |NULL|NULL|32672 |NULL      |65344     |YES

11 rows selected

splice> SELECT columnname, cardinality, null_count, min_value, max_value
> FROM SYS.SYSCOLUMNSTATISTICS
> WHERE schemaname='TPCH100' AND tablename='LINEITEM' AND columnname='L_SHIPDATE';
COLUMNNAME     |CARDINALITY         |NULL_COUNT  |MIN_VALUE   |MAX_VALUE
---------------------------------------------------------------------------
L_SHIPDATE     |2291                |0           |1992-01-02  |1998-12-01

1 row selected
```
{: .Example}


## When Should You Collect Statistics?

We advise that you collect statistics after you have:

* Created an index on a table.
* Modified a significant number of rows in a table with update, insert,
  or delete operations.
* Enabled or disable statistics collection on specific columns.

A general rule-of-thumb is that you should collect statistics after
modifying more than 10% of data.
{: .noteNote}

Once collection of statistics has completed, the Splice Machine query
optimizer will automatically begin using the updated statistics to
optimize query execution plans.

## Enabling and Disabling Statistics on Specific Columns   {#Enabling}

You can selectively enable or disable statistics collection on specific columns in a table. You can only collect statistics on columns containing data that can be ordered. This includes all numeric types, Boolean values, some `CHAR` and `BIT` data types, and date and timestamp values.

After enabling or disabling statistics collection on columns in a table, you should use `ANALYZE TABLE` to re-collect statistics for that table.
{: .noteIcon}

### On Which Columns Should You Collect Statistics?

During statistical collection:

* Statistics are automatically collected on columns in a primary key,
  and on columns that are indexed. These are called *keyed columns*.
* Statistics are also collected on columns for which you have enabled
  statistics collection.

By default, Splice Machine collects statistics on all columns in a
table. To reduce the operational cost of analyzing large tables (such as fact
tables), you can selectively enable/disable statistics collection on a per-column basis.

When selecting which columns to collect statistics on, keep these factors in mind:

* The process of collecting statistics requires both memory and compute
  time to complete; the more statistics you collect, the longer it takes
  and the more of your computing resources that it uses.
* You *should collect statistics* for any column that is used as a
  predicate in a query.
* You *should collect statistics* for any column that is used in a
  `select distinct`, `Group by`, `order by`, or `join` clause.
* You *do not need to enable statistics* for columns that are merely
  carried through the computation; however, doing so may improve heap
  size estimations, which in turn can make broadcast joins more likely
  to be chosen.

As you can see, selecting columns for statistics is a tradeoff between
the resources required to collect the statistics, and the improvements
in optimization that result from having the statistics collected.

### How to Disable/Enable Column Statistics

You can explicitly disable statistics collection on a specific column
in a table using the [`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
procedure. For example, the following call disables statistics on the `Birthdate` column in the `Players` table:

```
CALL SYSCS_UTIL.DISABLE_COLUMN_STATISTICS('mySchema', 'Players', 'Birthdate');
```
{: .Example }

To enable statistics collection on the same column, use the
[`SYSCS_UTIL.ENSABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
procedure; for example:

```
CALL SYSCS_UTIL.ENABLE_COLUMN_STATISTICS('mySchema', 'Players', 'Birthdate');
```
{: .Example }

</div>
</section>
