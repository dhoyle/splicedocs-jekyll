---
title: SYSCS_UTIL.SYSCS_GET_REQUESTS built-in system procedure
summary: Built-in system procedure that displays information about the number of RPC requests that are coming into Splice Machine.
keywords: get_requests, RPC requests
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getrequests.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_REQUESTS

The `SYSCS_UTIL.SYSCS_GET_REQUESTS` system procedure displays
information about the number of RPC requests that are coming into Splice
Machine.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_REQUESTS()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_REQUESTS` include
these values:

<table summary=" summary=&quot;Columns in Get_Requests results display&quot;">
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
                        <td class="CodeFont">PORT
					</td>
                        <td>
                            <p>The port receiving requests.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont">TOTALREQUESTS
					</td>
                        <td>The total number of RPC requests on that port.</td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_REQUESTS();
    HOSTNAME  |PORT  |TOTALREQUE&
    -----------------------------------
    localhost  |55709 |7296
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

