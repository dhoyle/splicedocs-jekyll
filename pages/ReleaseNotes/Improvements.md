---
title: Improvements in the Current Release of Splice Machine
summary: Improvements in the current release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_improvements.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Improvements in Release {{splvar_basic_SpliceReleaseVersion}} of the Splice Machine Database

{% include splice_snippets/onpremonlytopic.md %}
This topic describes significant improvements in the Splice Machine Database, which is used in both our Database-as-Service and On-Premise Database products.

Here's a summary of the new features in this release:

<table summary="Summary of Improvements in this release">
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-398</td>
            <td>Support 'drop view if exists'</td>
        </tr>
        <tr>
            <td>SPLICE-949</td>
            <td>Built-in function ROUND added</td>
        </tr>
        <tr>
            <td>SPLICE-1222</td>
            <td>Implement in-memory subtransactions</td>
        </tr>
        <tr>
            <td>SPLICE-1351</td>
            <td>Upgrade Sketching Library from 0.8.1 - 0.8.4</td>
        </tr>
        <tr>
            <td>SPLICE-1372</td>
            <td>Control-side query control</td>
        </tr>
        <tr>
            <td>SPLICE-1479</td>
            <td>Iterator based stats collection</td>
        </tr>
        <tr>
            <td>SPLICE-1497</td>
            <td>Add flag for inserts to skip conflict detection</td>
        </tr>
        <tr>
            <td>SPLICE-1500</td>
            <td>Skip WAL for unsafe imports</td>
        </tr>
        <tr>
            <td>SPLICE-1513</td>
            <td>Create Spark Adapter that supports both 1.6.x and 2.1.0 versions of Spark</td>
        </tr>
        <tr>
            <td>SPLICE-1516</td>
            <td>Enable compression for WritePipeline</td>
        </tr>
        <tr>
            <td>SPLICE-1517</td>
            <td>Orc Reader Additions</td>
        </tr>
        <tr>
            <td>SPLICE-1555</td>
            <td>Enable optimizer trace info for costing</td>
        </tr>
        <tr>
            <td>SPLICE-1568</td>
            <td>Core Spark Adapter Functionality With Maven Build</td>
        </tr>
        <tr>
            <td>SPLICE-1619</td>
            <td>Update the Spark Adapter to 2.1.1</td>
        </tr>
        <tr>
            <td>SPLICE-1681</td>
            <td>Introduce query hint "skipStats" after a table identifier to bypass fetching real stats from dictionary tables</td>
        </tr>
        <tr>
            <td>SPLICE-1702</td>
            <td>Removed LocatedRow construct from the execution tree</td>
        </tr>
        <tr>
            <td>SPLICE-1703</td>
            <td>Changed "size==0" to isEmpty()</td>
        </tr>
        <tr>
            <td>SPLICE-1714</td>
            <td>Ignore "should not give a splitkey that equates to startkey" exception</td>
        </tr>
        <tr>
            <td>SPLICE-1725</td>
            <td>External table documentation updated</td>
        </tr>
        <tr>
            <td>SPLICE-1729</td>
            <td>Handle 'drop table table_name if exists'</td>
        </tr>
        <tr>
            <td>SPLICE-1733</td>
            <td>Support type conversion Varchar to INT</td>
        </tr>
        <tr>
            <td>SPLICE-1739</td>
            <td>Added CREATE SCHEMA IF NOT EXISTS functionality</td>
        </tr>
        <tr>
            <td>SPLICE-1752</td>
            <td>Support inserting int types to char types</td>
        </tr>
        <tr>
            <td>SPLICE-1756</td>
            <td>Introduce database property collectIndexStatsOnly to specify the collect stats behavior</td>
        </tr>
        <tr>
            <td>SPLICE-1760</td>
            <td>Enhancement to provide corresponding Spark JobID when Splice jobs or queries are submitted through Spark</td>
        </tr>
        <tr>
            <td>SPLICE-1785</td>
            <td>Too many tasks are launched in the last stage of bulk import</td>
        </tr>
        <tr>
            <td>SPLICE-1834</td>
            <td>Remove EFS FileSystem</td>
        </tr>
        <tr>
            <td>SPLICE-1835</td>
            <td>Remove MBeanResultSet</td>
        </tr>
        <tr>
            <td>SPLICE-1836</td>
            <td>Remove SpliceCsvTokenizer</td>
        </tr>
        <tr>
            <td>SPLICE-1837</td>
            <td>Remove Old Cost Estimate Implementation...</td>
        </tr>
        <tr>
            <td>SPLICE-1838</td>
            <td>Remove Left Over Aggregate Plumbing</td>
        </tr>
        <tr>
            <td>SPLICE-1839</td>
            <td>Remove Serial Encoding Package</td>
        </tr>
        <tr>
            <td>SPLICE-1840</td>
            <td>Remove Dead PhysicalStatsStore</td>
        </tr>
        <tr>
            <td>SPLICE-1841</td>
            <td>Remove ScanInfo class and Interfaces</td>
        </tr>
        <tr>
            <td>SPLICE-1842</td>
            <td>Derby Utils Dead Code Cleanup</td>
        </tr>
        <tr>
            <td>SPLICE-1845</td>
            <td>Tweak Kryo Serde for Missing Elements</td>
        </tr>
        <tr>
            <td>SPLICE-1851</td>
            <td>Remove concurrent.traffic package</td>
        </tr>
        <tr>
            <td>SPLICE-1873</td>
            <td>Added documentation for GET_SESSION_INFO</td>
        </tr>
        <tr>
            <td>SPLICE-1875</td>
            <td>Added documentation for GET_RUNNING_OPERATIONS and KILL_OPERATION</td>
        </tr>
        <tr>
            <td>SPLICE-1879</td>
            <td>KeyBy Function on Control is a multimap index vs. a map function</td>
        </tr>
        <tr>
            <td>SPLICE-1880</td>
            <td>Modify ReduceByKey to execute lazily and not use Multimaps.</td>
        </tr>
        <tr>
            <td>N/A</td>
            <td>Added SplicemachineContext.g</td>
        </tr>
        <tr>
            <td>N/A</td>
            <td>Bcast implementation dataset vs rddetConnection() to enable commit/rollback in Scala</td>
        </tr>
        <tr>
            <td>N/A</td>
            <td>Bcast implementation dataset vs rdd</td>
        </tr>
        <tr>
            <td>N/A</td>
            <td>Add logging to Vacuum process</td>
        </tr>
    </tbody>
</table>

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>

</div>
</section>
