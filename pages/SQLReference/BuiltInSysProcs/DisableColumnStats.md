---
title: SYSCS_UTIL.DISABLE_COLUMN_STATISTICS built-in system procedure
summary: Built-in system procedure that disables collection of statistics on a specific column in a specific table.
keywords: disable_column_statistics
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_disablecolumnstats.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.DISABLE_COLUMN_STATISTICS

The `SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`  system procedure disables
collection of statistics on a specific table column in your database.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.DISABLE_COLUMN_STATISTICS(
                           VARCHAR(128) schema,
                           VARCHAR(128) table,
                           VARCHAR(128) columnName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema of the table. Passing a `null` or non-existent
schema name generates an error.
{: .paramDefnFirst}

tableName
{: .paramName}

Specifies the table name of the table. The string must exactly match the
case of the table name, and the argument of `"Fred"` will be passed to
SQL as the delimited identifier `'Fred'`. Passing a `null` or
non-existent table name generates an error.
{: .paramDefnFirst}

columnName
{: .paramName}

Specifies the name of the column for which you want statistics disabled.
Passing a `null` or non-existent column name generates an error.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Usage Notes

Statistics are automatically collected on all columns by default.
Attempting to disable statistics collection on a keyed column generates
an error.

## SQL Examples

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.DISABLE_COLUMN_STATISTICS('SPLICE', 'Salaries', 'Salary');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html)
* [`SYSCS_UTIL.ENABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
* [`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
* [`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
* [Using Statistics](bestpractices_optimizer_statistics.html)

</div>
</section>
