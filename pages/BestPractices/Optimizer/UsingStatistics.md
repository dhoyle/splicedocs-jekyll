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

This topic introduces you to statistics in Splice Machine; database statistics are a form of metadata (data about data)
that assists the Splice Machine query optimizer; the statistics help the optimizer select the most efficient approach to running a query, based on information that has been gathered about the tables involved in the query.

This topic describes:

* [Collecting statistics](#Collecti) for a schema or table in your
  database
* [Viewing collected statistics](#Viewing)
* [Dropping statistics](#Dropping) for a schema
* [Enabling and disabling collection of statistics](#Enabling) on specific
  columns in tables in your database

Statistics are inexact; in fact, some statistics like table cardinality are estimated using advanced algorithms, due to the resources required to compute these values. It's important to keep this in mind when basing design decisions on values in database statistics tables. Collecting or dropping statistics will typically change the execution plan that the optimizer generates for a query; please review the [Using Explain Plan to Tune Queries](#bestpractices_optimizer_explain.html) topic in this chapter for information about reviewing explain plans.

The statistics for your database are not automatically refreshed when the data in your database changes, which means that when you query a statistical table or view, the results you see may not exactly match the data in the actual tables.
{: .noteImportant}

## Collecting Statistics   {#Collecti}

You can collect statistics on a schema or table using the [<span
class="AppFontCustCode">splice&gt; Analyze</span>](cmdlineref_analyze.html)
command.

You can also use the
[`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
procedure to collect statistics on an entire schema, including every
table in the schema. For example:

```
splice> CALL SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS( 'SPLICEBBALL', false );
```
{: .Example }

During statistical collection:
{: .spaceAbove}

* Statistics are automatically collected on columns in a primary key,
  and on columns that are indexed. These are called *keyed columns*.
* Statistics are also collected on columns for which you have enabled
  statistics collection, as described in the next section, [Enabling and
  Disabling Statistics.](#Enabling)

Once collection of statistics has completed, the Splice Machine query
optimizer will automatically begin using the updated statistics to
optimize query execution plans.

### When Should You Collect Statistics?

We advise that you collect statistics after you have:

* Created an index on a table.
* Modified a significant number of rows in a table with update, insert,
  or delete operations.

A general rule-of-thumb is that you should collect statistics after
modifying more than 10% of data.
{: .noteIndent}

### On Which Columns Should You Collect Statistics?

By default, Splice Machine collects statistics on all columns in a
table.

To reduce the operational cost of analyzing large tables (such as fact
tables), you can tell Splice Machine to not collect statistics on
certain columns by running the
[`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html) built-in
system procedure:

```
SYSCS_UTIL.DISABLE_COLUMN_STATISTICS( schema, table, column);
```
{: .FcnSyntax}

Splice Machine strongly recommends that you *always* collect statistics
on small tables, such as a table that has hundreds of rows on each
region server.

## Viewing Statistics  {#Viewing}

After statistics have been collected, you can query two system views for key metrics about the tables in your database. This information can provide you with insights into how to best structure certain queries:

* The [Table Statistics View](#tableStats) contains statistical information for tables in your database.
* The [Column Statistics View](#columnStats) contains statistical information about each column in a table.

### Table Statistics View  {#tableStats}

The `SYS.SYSTABLESTATISTICS` table contains row count and total size information for each table:

```
splice> SELECT total_row_count, total_size, stats_type, sample_fraction FROM SYS.SYSTABLESTATISTICS WHERE schemaname='TPCH100' AND tablename='LINEITEM';
TOTAL_ROW_COUNT       |TOTAL_SIZE          |STATS_TYPE |SAMPLE_FRACTION
-----------------------------------------------------------------------
600037902             |52803335376         |2          |0.0

1 row selected
```
{: .Example}

### Column Statistics View  {#columnStats}

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


## Dropping Statistics   {#Dropping}

If you wish to drop statistics for a schema, you can use
the
[`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
procedure to drop statistics for an entire schema. For example:

```
splice> CALL SYSCS_UTIL.DROP_SCHEMA_STATISTICS('SPLICEBBALL');
```
{: .Example }

## Enabling and Disabling Statistics on Specific Columns   {#Enabling}

When you collect statistics, Splice Machine automatically collects
statistics on keyed columns, which are columns in a primary key and
columns that are indexed.

Please review the recommendations and restrictions regarding which
columns should or should not have statistics collection enabled, as
noted below in the [Selecting Columns for Statistics
Collection](#Selectin) subsection.
{: .noteTip}

You can also explicitly enable statistics collection on specific columns
in tables using the
[`SYSCS_UTIL.ENABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
procedure. For example:

```
CALL SYSCS_UTIL.ENABLE_COLUMN_STATISTICS('SPLICEBBALL', 'Players', 'Birthdate');
```
{: .Example }

#### Disabling Statistics Collection on a Column

If you subsequently wish to disable collection of statistics on a
specific column in a table, use the
[`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
procedure:
{: .spaceAbove}

```
splice> CALL SYSCS_UTIL.DISABLE_COLUMN_STATISTICS('SPLICEBBALL', 'Players', 'Birthdate');
```
{: .Example }

Once you've enabled or disabled statistics collection for one or more
table columns, you should update the query optimizer by [collecting
statistics](#Collecti) on the table or schema.

### Selecting Columns for Statistics Collection   {#Selectin}

You can only collect statistics on columns containing data that can be
ordered. This includes all numeric types, Boolean values, some
`CHAR` and `BIT` data types, and date and timestamp values.

When selecting columns on which statistics should be collected, keep
these ideas in mind:

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

</div>
</section>
