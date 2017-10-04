---
title: Using Splice Machine Statistics
summary: How to use our statistics collection tools to enhance query optimization.
keywords: statistics, collect statistics
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_tuning_usingstats.html
folder: Developers/TuningAndDebugging
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Statistics with Splice Machine

This topic introduces how to use database statistics with Splice
Machine. Database statistics are a form of metadata (data about data)
that assists the Splice Machine query optimizer; the statistics help the
optimizer select the most efficient approach to running a query, based
on information that has been gathered about the tables involved in the
query.

This topic describes how to:

* [Collecting statistics](#Collecti) for a schema or table in your
  database
* [Dropping statistics](#Dropping) for a schema
* [Enable and disable collection of statistics](#Enabling) on specific
  columns in tables in your database
* [View collected statistics](#Viewing)

Statistics are inexact; in fact, some statistics like table cardinality
are estimated using advanced algorithms, due to the resources required
to compute these values. It's important to keep this in mind when basing
design decisions on values in database statistics tables.

It's also important to note that the statistics for your database are
not automatically refreshed when the data in your database changes,
which means that when you query a statistical table or view, the results
you see may not exactly match the data in the actual tables.
{: .noteImportant}

## Collecting Statistics   {#Collecti}

You can collect statistics on a schema or table using the [<span
class="AppFontCustCode">splice&gt; Analyze</span>](cmdlineref_analyze.html)
command.

You can also use the
[`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
procedure to collect statistics on an entire schema, including every
table in the schema. For example:

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS( 'SPLICEBBALL', false );
{: .Example xml:space="preserve"}

</div>
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

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.DISABLE_COLUMN_STATISTICS( schema, table, column);
{: .FcnSyntax style="text-indent: 0.5in;"}

</div>
Splice Machine strongly recommends that you *always* collect statistics
on small tables, such as a table that has hundreds of rows on each
region server.

### How to Determine if You Should Collect or Drop Statistics

You can use [Explain Plan](developers_tuning_explainplan.html) in your
development or test environment to determine how dropping or collecting
statistics changes the execution plan for a query.

## Dropping Statistics   {#Dropping}

If you subsequently wish to drop statistics for a schema, you can use
the
[`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
procedure to drop statistics for an entire schema. For example:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.DROP_SCHEMA_STATISTICS('SPLICEBBALL');
{: .Example xml:space="preserve"}

</div>
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

<div class="preWrapperWide" markdown="1">

    CALL SYSCS_UTIL.ENABLE_COLUMN_STATISTICS('SPLICEBBALL', 'Players', 'Birthdate');
{: .Example xml:space="preserve"}

</div>
#### Disabling Statistics Collection on a Column

If you subsequently wish to disable collection of statistics on a
specific column in a table, use the
[`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
procedure:
{: .spaceAbove}

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.DISABLE_COLUMN_STATISTICS('SPLICEBBALL', 'Players', 'Birthdate');
{: .Example xml:space="preserve"}

</div>
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

## Viewing Collected Statistics   {#Viewing}

Splice Machine provides two system tables you can query to view the
statistics that have been collected for your database:

* Query the &nbsp;[`SYSTABLESTATISTICS System
  Table`](sqlref_systables_systablestats.html) to view statistics for
  specific tables
* Query the &nbsp;[`SYSCOLUMNSTATISTICS System
  Table`](sqlref_systables_syscolumnstats.html) to view statistics for
  specific table columns

## See Also

* [Splice Machine Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html)
* [`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
* [`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
* [`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
* [`SYSCS_UTIL.ENABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
* [`SYSCOLUMNSTATISTICS System Table`](sqlref_systables_syscolumnstats.html)
* [`SYSTABLESTATISTICS System Table`](sqlref_systables_systablestats.html)

</div>
</section>
