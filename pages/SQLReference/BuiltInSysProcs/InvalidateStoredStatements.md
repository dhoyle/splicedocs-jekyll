---
title: SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS built-in system procedure
summary: Built-in system procedure that invalidates all system prepared statements and forces the query optimizer to create new execution plans.
keywords: invalidating stored statements, invalidate_stored_statements
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_invalidatestoredstmts.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS

The `SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS` system procedure
invalidates all system prepared statements, and forces the query
optimizer to create new execution plans. You can use this to speed up
query execution by the data dictionary when performance has become
sub-optimal.

If you notice that `ij show `commands have slowed down, you can call
`SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS `to refresh the execution
plans.

Splice Machine uses prepared statements known as system procedures to
access data in the system tables. These procedures are cached, along
with their execution plans, in the data dictionary. The cached execution
plans can become sub-optimal after you issue a large number of
schema-modifying DLL statements, such as defining and/or modifying a
number of tables.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS();
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE`](sqlref_sysprocs_emptycache.html)
* [`SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE`](sqlref_sysprocs_emptycache.html)

</div>
</section>

