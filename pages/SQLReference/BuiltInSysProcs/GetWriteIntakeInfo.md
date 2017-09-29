---
title: SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO built-in system procedure
summary: Built-in system procedure that displays information about the number of writes coming into Splice Machine.
keywords: get write info, get_write_intake_info, get write intake info
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getwriteintakeinfo.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO

The `SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO` system procedure displays
information about the number of writes coming into Splice Machine.

You can use this information to know the number of bulk writes currently
active on a server. Each bulk write will contain up to 1000 rows; the
compaction and flush queue size, plus the reserved ipc thread setting
determine how many writes can execute concurrently.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling
`SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO` include these values:

<table summary=" summary=&quot;Columns in Get_Write_Intake_Info results display&quot;">
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
                        <td class="CodeFont">HOSTNAME
					</td>
                        <td>The host name.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">ACTIVEWRITETHREADS
					</td>
                        <td>The number of active write threads.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">COMPACTIONQUEUESIZELIMIT
					</td>
                        <td>The compaction queue limit at which writes will be blocked.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">FLUSHQUEUELIMIT
					</td>
                        <td>The flush queue limit at which writes will be blocked.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">IPCRESERVEDPOOL
					</td>
                        <td>
                            <p class="noSpaceAbove">The number of IPC threads reserved for reads. </p>
                            <p>The maximum number of bulk writes that are allowed currently is equal to the total number of IPC threads minus this value.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO();
    host               |depThreads |indThreads |depCount   |indCount   |avgThroughput         |oneMinAvgThroughput   |fiveMinAvgThroughput  |fifteenMinAvgThroughp&|totalRejected
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    localhost:55709    |0          |0          |0          |0          |0.011451093322589732  |5.472367185912236E-4  |0.007057900046373111  |0.0053884511108858845 |0
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

