---
title: SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO built-in system procedure
summary: Built-in system procedure that displays input and output statistics about the cluster.
keywords:  get_region_server_stats_info, region server statistics
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getregionserverstats.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO

The `SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO` system procedure
displays input and output statistics about the cluster.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling
`SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO` include these values:

<table summary=" summary=&quot;Columns in Get_Region_Server_Stats_Info results display&quot;">
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
                        <td><code>HOST</code></td>
                        <td>The host name (or IP address).</td>
                    </tr>
                    <tr>
                        <td><code>REGIONCOUNT</code></td>
                        <td>The number of regions.</td>
                    </tr>
                    <tr>
                        <td><code>STOREFILECOUNT</code></td>
                        <td>The number of files stored.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">WRITEREQUESTCOUNT</td>
                        <td>The number of write requests.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">READREQUESTCOUNT</td>
                        <td>The number of read requests.</td>
                    </tr>
                    <tr>
                        <td><code>TOTALREQUESTCOUNT	</code></td>
                        <td>The total number of requests.</td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO();
    Host          |regionCount         |storeFileCount      |writeRequestCount   |readRequestCount    |totalRequestCount
    --------------------------------------------------------------------------------------------------------------------
    111.222.3.4   |58                  |0                   |5956                |99697               |20517
    555.666.7.8   |59                  |0                   |1723                |57022               |6253
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>
