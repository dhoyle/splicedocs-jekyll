---
title: SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS built-in system procedure
summary: Built-in system procedure that displays information about each Splice Machine operations running on a server.
keywords: operations, server ops, kill operation
toc: false
product: all
sidebar: home_sidebar
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
## Security Note
This procedure runs another, internal (undocumented) system procedure named `SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS_LOCAL`. This means that when you change permissions for `SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS`, you must also make the same permission changes to `SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS_LOCAL`.

This will be handled automatically in a future release.
{: .noteNote}

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
                    <tr>
                        <td><code>SUBMITTED</code></td>
                        <td>The date and time that the operation was submitted.</td>
                    </tr>
                    <tr>
                        <td><code>ELAPSED</code></td>
                        <td>Elapsed time since the operation began running.</td>
                    </tr>
                    <tr>
                        <td><code>ENGINE</code></td>
                        <td>Which engine (SPARK or CONTROL) is running the operation.</td>
                    </tr>
                    <tr>
                        <td><code>JOBTYPE</code></td>
                        <td>The operation type.</td>
                    </tr>
                </tbody>
            </table>
## Example

<code>splice> call SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS();</code>

|UUID                                    |USER                              |HOSTNAME                                                                                                                |SESSION    |SQL                                                                                                                                                                                                                     |SUBMITTED     |ELAPSED                        |ENGINE      |JOBTYPE                                  |
|34b0f479-be9a-4933-9b4d-900af218a19c    |SPLICE                                  |MacBook-Pro.local:1527                                                                                          |264        |select * from sysvw.systablesview --splice-properties useSpark=true                                                                                                                                                                                                   |2018-02-02 17:39:05               | 26 sec(s)|SPARK     |Produce Result Set |
|4099f016-3c9d-4c62-8059-ff18d3b38a19     |SPLICE                                  |MacBook-Pro.local:1527                                                                                          |4          |call syscs_util.syscs_get_running_operations()                                                                                                                                                                                                                  |2018-02-02 17:39:31               |0 sec(s) |CONTROL   |Call Procedure |

```
2 rows selected

splice> call SYSCS_UTIL.SYSCS_KILL_OPERATION('4099f016-3c9d-4c62-8059-ff18d3b38a19');
Statement executed.
```

</div>
</section>
