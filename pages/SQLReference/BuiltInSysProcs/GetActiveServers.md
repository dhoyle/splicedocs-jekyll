---
title: SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS built-in system procedure
summary: Built-in system procedure that displays the number of active servers in the Splice cluster.
keywords: active servers, get_active_servers
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getactiveservers.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS   {#BuiltInSysProcs.GetActiveServers}

The `SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS` system procedure displays the
active servers in the Splice cluster.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS`
include these values:

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
                        <td class="CodeFont">HOSTNAME
                    </td>
                        <td>The host on which the server is running.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">PORT
                    </td>
                        <td>
                            <p>The port on which the server is listening for requests.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>STARTCODE</code></td>
                        <td>The system identifier for the Region Server.</td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS();
    HOSTNAME |PORT  |STARTCODE
    -------------------------------------
    localhost |56412 |1447433590803
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

