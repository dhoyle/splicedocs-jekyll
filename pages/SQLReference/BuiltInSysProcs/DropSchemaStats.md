---
title: SYSCS_UTIL.DROP_SCHEMA_STATISTICS built-in system procedure
summary: Built-in system procedure that drops statistics for a schema.
keywords: drop statistics, drop_schema_statistics
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_dropschemastats.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.DROP_SCHEMA_STATISTICS

The `SYSCS_UTIL.DROP_SCHEMA_STATISTICS`  system procedure drops
statistics for a specific schema in your database.

This procedure drops statistics for every table in the schema. It also
drops statistics for the index associated with every table in the
schema. For example, if you have :

* a schema named `mySchema`
* `mySchema` contains two tables: `myTable1` and `myTable2`
* `myTable1` has two indices: `myTable1Index1` and `myTable1Index2`

Then `SYSCS_UTIL.DROP_SCHEMA_STATISTICS` will drop statistics for
`myTable1`, `myTable2`, `myTable1Index1`, and `myTable1Index2`.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.DROP_SCHEMA_STATISTICS( VARCHAR(128) schema );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema for which you want to drop statistics. Passing a
`null` or non-existent schema name generates an error.
{: .paramDefnFirst}

</div>
## Results

This procedure does not produce a result.

## SQL Examples

<div class="preWrapperWide" markdown="1">
    
    splice> CALL SYSCS_UTIL.DROP_SCHEMA_STATISTICS('MYSCHEMA');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [Data Assignments and
  Comparisons](sqlref_datatypes_compatability.html)
* [`SYSCS_UTIL.ENABLE_COLUMN_STATISTICS`](sqlref_sysprocs_enablecolumnstats.html)
* [`SYSCS_UTIL.DISABLE_COLUMN_STATISTICS`](sqlref_sysprocs_disablecolumnstats.html)
* [`SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS`](sqlref_sysprocs_collectschemastats.html)
* [Using Statistics](developers_tuning_usingstats.html) in the
  *Administrator's Guide*

</div>
</section>

