---
title: SYSCS_UTIL.DROP_TABLE_STATISTICS built-in system procedure
summary: Built-in system procedure that drops statistics for a table.
keywords: drop statistics, drop_table_statistics
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_droptablestats.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.DROP_TABLE_STATISTICS

The `SYSCS_UTIL.DROP_TABLE_STATISTICS`  system procedure drops
statistics for a specific table in your database.

This procedure drops statistics for indexes associated with the table.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.DROP_TABLE_STATISTICS( VARCHAR(128) schema,
                                      VARCHAR(1024) table );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema for which you want to drop statistics. Passing a
`null` or non-existent schema name generates an error.
{: .paramDefnFirst}

tableName
{: .paramName}

Specifies the name of the table for which you want to drop statistics. Passing a
`null` or non-existent table name generates an error.
{: .paramDefnFirst}

</div>
## Results

This procedure does not produce a result.

## SQL Examples

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.DROP_TABLE_STATISTICS( 'MYSCHEMA', 'MYTABLE' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html)
* [`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
* [`SYSCS_UTIL.ENABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
* [`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
* [`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
* [Using Statistics](bestpractices_optimizer_statistics.html)

</div>
</section>
