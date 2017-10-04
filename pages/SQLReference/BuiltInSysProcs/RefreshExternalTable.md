---
title: SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE built-in system procedure
summary: Built-in system procedure that refreshes the schema of an external table that has been modified outside of Splice Machine.
keywords: refresh_external_table, refreshing external table, external tables, orc, parquet, textfile
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_refreshexttable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE

You call the `SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE` system procedure
to manually refresh the schema of an external table in Splice Machine
that has been modified outside of Spark. When you use the external
table, Spark caches its schema in memory to improve performance; as long
as you are using Spark to modify the table, it is smart enough to
refresh the cached schema. However, if the table schema is modified
outside of Spark, you need to call
`SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE`.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE(
                String schemaName,
                String tableName )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema of the table. Passing a `null` or non-existent
schema name generates an error.
{: .paramDefnFirst}

table Name
{: .paramName}

The table name.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Example

This refreshes the schema of the external table named `myTable`:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE('APP', 'myTable');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [CREATE EXTERNAL TABLE](sqlref_statements_createexternaltable.html)
{: .codeList}

</div>
</section>
