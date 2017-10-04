---
title: SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS built-in system procedure
summary: Built-in system procedure that displays information about each Splice Machine operations running on a server.
keywords: operations, server ops, kill operation
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getrunningops.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS

The `SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS` system procedure displays
a list of the operations running on the server to which you are
currently connected.

You can use this procedure to find the UUID for an operation, which you
can then use for purposes such as terminating an operation with the
[`SYSCS_UTIL.SYSCS_KILL_OPERATION`](sqlref_sysprocs_killoperation.html)
system procedure.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS();
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling
`SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS` include these values:

<table summary=" summary=&quot;Columns in Get_Active_Servers results display&quot;">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont">UUID
                    </td>
                        <td>The operation identifier. This is the same identifier that is shown in the Spark console.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">USER
                    </td>
                        <td>The name of the database user.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">HOSTNAME
                    </td>
                        <td>The host on which the server is running.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">SESSION
                    </td>
                        <td>The session ID.</td>
                    </tr>
                    <tr>
                        <td><code>SQL</code></td>
                        <td>The SQL statement that is running.</td>
                    </tr>
                </tbody>
            </table>
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

