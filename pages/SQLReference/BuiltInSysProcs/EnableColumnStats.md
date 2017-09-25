---
title: SYSCS_UTIL.ENABLE_COLUMN_STATISTICS built-in system procedure
summary: Built-in system procedure that enables collection of statistics on a specific column in a specific table.
keywords: enable column statistics, enable_column_statistics
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_enablecolumnstats.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.ENABLE_COLUMN_STATISTICS

The `SYSCS_UTIL.ENABLE_COLUMN_STATISTICS` system procedure enables
collection of statistics on a specific table column in your database.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.ENABLE_COLUMN_STATISTICS(
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

Specifies the name of the column for which you want statistics enabled.
Passing a `null` or non-existent column name generates an error.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Usage Notes

Here are some <span class="Highlighted">important notes</span> about
collecting column statistics:

* Statistics can only be collected on columns with data types that can
  be ordered; numeric types, some `CHAR` types, some `BIT` types, and
  date/time types can be ordered.
  
  You can determine if a data type can be ordered by examining the
  Comparisons table in the [Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html) topic: any data type
  with a <span class="CodeBoldFont">Y</span> in any column in that table
  can be ordered, and thus can have statistics collected on it.

* Statistics are automatically collected on all columns by default.

## SQL Examples

<div class="preWrapperWide" markdown="1">
    
    splice> CALL SYSCS_UTIL.ENABLE_COLUMN_STATISTICS('SPLICE', 'Salaries', 'Salary');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html)
* [`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
* [`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
* [`SYSCS_UTIL.DROP_SCHEMA_STATISTICS`](sqlref_sysprocs_dropschemastats.html)
* [Using Statistics](developers_tuning_usingstats.html) in the
  *Developer's Guide*

</div>
</section>

