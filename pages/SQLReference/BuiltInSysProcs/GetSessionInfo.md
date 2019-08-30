---
title: SYSCS_UTIL.SYSCS_GET_SESSION_INFO built-in system procedure
summary: Built-in system procedure that displays session information, including the hostname and session IDs.
keywords: session information, get_session_info
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_getsessioninfo.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_SESSION_INFO

The `SYSCS_UTIL.SYSCS_GET_SESSION_INFO` system procedure displays the
hostname and session ID for your current session. You can use this
information to correlate your Splice Machine query with a Spark job: the
same information is displayed in the `Job Id (Job Group)` in the Spark
console.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_SESSION_INFO()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_SESSION` include
these values:

<table summary=" summary=&quot;Columns in Get_Session_Info results display&quot;">
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
            <td><code>HOSTNAME</code></td>
            <td>The identity of your Splice Machine connection.</td>
        </tr>
        <tr>
            <td class="CodeFont">SESSION
		</td>
            <td>The ID of your database connection session.</td>
        </tr>
    </tbody>
</table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_SESSION_INFO();
    HOSTNAME                       |SESSION  |
    ----------------------------------------------------------------------
    localhost:1527                 |4

    1 row selected
{: .Example xml:space="preserve"}

</div>
For this session, you could find your Spark job ID by correlating the
displayed host and session IDs with the Job Group information displayed
in the Spark console. For example:

<table>
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Job Id<br />(Job Group)</th>
            <th>Description</th>
			<th>Submitted</th>
			<th>Duration</th>
			<th>Stages:<br />Succeeded/Total</th>
			<th>Tasks (for all stages):<br />Succeeded/Total</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>0 (SPLICE &lt;<span class="Highlighted">localhost:1527,4</span>,e5ff1a51-4ac1-4202-a74c-a2d54ab3525a,36096&gt;)</td>
            <td>select * from sysvw.systablesview --splice-properties useSpark=true (kill) Produce Result Set	</td>
            <td>2017/08/25 14:03:07	</td>
            <td>8s</td>
            <td>0/1</td>
            <td>0/1</td>
        </tr>
    </tbody>
</table>
</div>
</section>
