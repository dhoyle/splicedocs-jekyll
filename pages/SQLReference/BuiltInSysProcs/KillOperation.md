---
title: SYSCS_UTIL.SYSCS_KILL_OPERATION built-in system procedure
summary: Built-in system procedure that terminates an operation that is currently running on a server.
keywords: operations, server ops, kill operation
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_killoperation.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_KILL_OPERATION   {#BuiltInSysProcs.GetActiveServers}

The `SYSCS_UTIL.SYSCS_KILL_OPERATION` system procedure terminates an
operation that is running on the server to which you are currently
connected.

You can use the
[`SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS`](sqlref_sysprocs_getrunningops.html)
system procedure. to find the UUID for an operation you want to kill.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.KILL_OPERATION(operationId)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
operationId
{: .paramName}

The UUID of the operation that you want to terminate.
{: .paramDefnFirst}

This is the same UUID that is shown in the Spark console. You can use
the
[`SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS`](sqlref_sysprocs_getrunningops.html)
system procedure to discover the UUID for the operation.
{: .paramDefn}

</div>
## Results

This procedure does not return a result.

## Example

<div class="preWrapper" markdown="1">
    splice> call SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS();
    UUID                                    |USER     |HOSTNAME         |SESSION    |SQL
    -------------------------------------------------------------------------------------------------------------------------------
    bf610dea-d33e-4304-bf2e-4f10e667aa98    |SPLICE   |localhost:1528   |2          |call SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS()
    33567e3c-ef33-46dc-8d10-5ceb79348c2e    |SPLICE   |localhost:1528   |20         |insert into a select * from a
    
    2 rows selected
    
    splice> call SYSCS_UTIL.SYSCS_KILL_OPERATION('33567e3c-ef33-46dc-8d10-5ceb79348c2e');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
</section>

