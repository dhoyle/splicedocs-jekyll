---
title: SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS built-in system procedure
summary: Built-in system procedure that updates updates the execution plan for stored procedures in a database.

keywords: update_system_procedure, update system procedure
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_updatemetastmts.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS

The `SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS` system procedure updates the execution plan for stored procedures in your  database.

## About System Procedures and Metadata

Splice Machine uses prepared statements known as system procedures to access data in the system tables. These procedures are cached, along with their execution plans, in the data dictionary. The cached execution plans can become sub-optimal after you issue a large number of schema-modifying DLL statements, such as defining and/or modifying a number of tables.

You typically need to call this procedure (along with the [`SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE`](sqlref_sysprocs_emptycache.html) procedure whenever you update your Splice Machine software installation.

If you have called the [`SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS`](sqlref_sysprocs_invalidatestoredstmts.html)  system procedure to improve query speed, and performance is still sub-optimal, it is probably because the query optimizer needs some manual hints to generate an optimal execution plan.

The manual hints are stored in the metadata.properties file, which is external to the database. Versions of this file are typically supplied by Splice Machine consultants or engineers.

Use this function to update the execution plans stored in the data dictionary.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS()
{: .FcnSyntax xml:space="preserve"}

</div>

## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS();
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE`](sqlref_sysprocs_emptycache.html)

</div>
</section>
