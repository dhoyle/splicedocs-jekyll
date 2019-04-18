---
title: SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS built-in system procedure
summary: Built-in system procedure that collects statistics on a schema.
keywords: collect schema stats, collect_schema_stats, collect statistics
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_collectschemastats.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS

The `SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`  system procedure collects
statistics on a specific schema in your database.

Once statistics have been collected for a schema, they are automatically
used by the query optimizer.
{: .noteNote}

This procedure collects statistics for every table in the schema. It
also collects statistics for the index associated with every table in
the schema. For example, if you have :

* a schema named `mySchema`
* `mySchema` contains two tables: `myTable1` and `myTable2`
* `myTable1` has two indices: `myTable1Index1` and `myTable1Index2`

Then `SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS` will collect statistics for
`myTable1`, `myTable2`, `myTable1Index1`, and `myTable1Index2`.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS( VARCHAR(128) schema,
                                          BOOLEAN staleOnly)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema for which you want to collect statistics. Passing a
`null` or non-existent schema name generates an error.
{: .paramDefnFirst}

staleOnly
{: .paramName}

A `BOOLEAN` value that specifies:
{: .paramDefnFirst}

* If this is `true`, data is only re-collected for partitions that are
  known to have out of date statistics.
* If this is `false`, data is collected on all partitions. <span
  class="Highlighted">Note</span> that this can significantly increase
  the time required to collect statistics, and is typically used only
  when you are not sure about the current quality of statistics in the
  entire schema.
{: .nested}

The <span class="CodeItalicFont">staleOnly</span> parameter value is
currently ignored, but must be specified in your call to this procedure.
Its value is always set to `false` in the system code.
{: .noteIcon}

</div>
## Results

This procedure returns a results table that contains:

* one row for each table
* one row per index for every table and its associated index in the
  schema

Each row contains the following columns:

<table summary="Columns in Collect_Schema_Statistics results display">
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Column Name</th>
                        <th>Type</th>
                        <th>Contents</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>schemaName</code></td>
                        <td><code>VARCHAR</code></td>
                        <td>The name of the schema.</td>
                    </tr>
                    <tr>
                        <td><code>tableName</code></td>
                        <td><code>VARCHAR</code></td>
                        <td>The name of the table.</td>
                    </tr>
                    <tr>
                        <td><code>partition</code></td>
                        <td><code>VARCHAR</code></td>
                        <td>The name of the region on which statistics were collected.</td>
                    </tr>
                    <tr>
                        <td><code>rowsCollected</code></td>
                        <td><code>INTEGER</code></td>
                        <td>The number of rows of statistics that were collected..</td>
                    </tr>
                    <tr>
                        <td><code>partitionSize</code></td>
                        <td><code>BIGINT</code></td>
                        <td>The size of the partition in bytes.</td>
                    </tr>
                </tbody>
            </table>
## Usage Notes

Collecting statistics on a schema can take some time.

## SQL Examples

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS( 'SPLICE', false );
    schemaName |tableName  |partition                               |rowsCollec&|partitionSize
    ------------------------------------------------------------------------------------------
    SPLICE     |PLAYERS    |splice:1440,,1467393447889.cbc33f4635ade|76         |3515       
    SPLICE     |SALARIES   |splice:1456,,1467393749257.7724e0cb12af3|76         |1420
    SPLICE     |BATTING    |splice:1472,,1467393754889.b34f5da64c36e|44         |22571        
    SPLICE     |PITCHING   |splice:1488,,1467393760434.35ee9880e5090|32         |21212
    SPLICE     |FIELDING   |splice:1504,,1467393775949.674b34acdb182|44         |9876

    5 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html)
* [`SYSCS_UTIL.ENABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
* [`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
* [`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
* [Using Statistics](developers_tuning_usingstats.html) in the
  *Developer's Guide*

</div>
</section>
