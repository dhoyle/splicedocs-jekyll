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
This topic describes significant improvements in the Splice Machine Database, which is used in both our Database-as-Service and On-Premise Database products with notes for each patch release since the initial release of version 2.5, in these sections:

* [Patch Release 2.5.0.1805](#Patch1805)
* [Patch Release 2.5.0.1804](#Patch1804)
* [Patch Release 2.5.0.1803](#Patch1803)
* [Patch Release 2.5.0.1802](#Patch1802)
* [Patch Release 2.5.0.1749](#Patch1749)
* [Patch Release 2.5.0.1748](#Patch1748)
* [Patch Release 2.5.0.1747](#Patch1747)
* [Patch Release 2.5.0.1745](#Patch1745)
* [Release 2.5.0.1735](#Release1735)

## 2.5.0.1805 Patch Release  5-Feb-18  {#Patch1805}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-2022</td>
            <td> spark job description for compaction</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1804 Patch Release  28-Jan-18  {#Patch1804}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="2">No improvements in this patch release.</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1803 Patch Release  21-Jan-18  {#Patch1803}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-1987</td>
            <td>Add fully qualified table name into HBASE <code>TableDisplayName</code> Attribute</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1802 Patch Release  14-Jan-18  {#Patch1802}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-1975</td>
            <td>Allow JavaRDD&lt;Row&gt; to be passed for CRUD operations in SplicemachineContext</td>
        </tr>
        <tr>
            <td>SPLICE-1991</td>
            <td>Add info to Spark UI for Compaction jobs to indicate presence of Reference Files</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1749 Patch Release  26-Dec-17  {#Patch1749}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-1973</td>
            <td>Exclude Kafka jars from splice-uber.jar for all platforms</td>
        </tr>
        <tr>
            <td>SPLICE-1984</td>
            <td>Parallelize <code>MultiProbeTableScan</code> and Union Operations</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1748 Patch Release  18-Dec-17  {#Patch1748}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="2">No improvements in this patch release.</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1747 Patch Release  08-Dec-17  {#Patch1747}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-1351</td>
            <td>Upgrade Sketching Library from 0.8.1 - 0.8.4</td>
        </tr>
        <tr>
            <td>SPLICE-1948</td>
            <td>Increase test timeout</td>
        </tr>
        <tr>
            <td>SPLICE-1948</td>
            <td>Initialize Splice Spark context with user context</td>
        </tr>
        <tr>
            <td>SPLICE-1951</td>
            <td>Remove protobuf installation instructions</td>
        </tr>
    </tbody>
</table>

## 2.6.1.1745 Patch Release  08-Dec-17  {#Patch1745}

2.6 was an interim release that has been folded in to 2.5
{: .noteIcon}

<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-1302</td>
            <td>Add minimum parallelism for Spark shuffles</td>
        </tr>
        <tr>
            <td>SPLICE-1951</td>
            <td>Remove protobuf installation instructions from</td>
        </tr>
        <tr>
            <td>SPLICE-1948</td>
            <td>Initialize Splice Spark context with user context</td>
        </tr>
        <tr>
            <td>SPLICE-1948</td>
            <td>Increase test timeout</td>
        </tr>
    </tbody>
</table>

## Splice Release 2.5.0.1735] {#Release1735}

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
            <td>Support <code>drop view if exists</code></td>
        </tr>
        <tr>
            <td>SPLICE-949</td>
            <td>Built-in function <code>ROUND</code> added</td>
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
            <td>Changed <code>size==0</code> to <code>isEmpty()</code></td>
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
            <td>Support type conversion <code>Varchar</code> to <code>INT</code></td>
        </tr>
        <tr>
            <td>SPLICE-1739</td>
            <td>Added <code>CREATE SCHEMA IF NOT EXISTS</code> functionality</td>
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
            <td>Remove <code>SpliceCsvTokenizer</code></td>
        </tr>
        <tr>
            <td>SPLICE-1837</td>
            <td>Remove Old Cost Estimate Implementation.</td>
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
            <td>Added documentation for <code>GET_SESSION_INFO</code></td>
        </tr>
        <tr>
            <td>SPLICE-1875</td>
            <td>Added documentation for <code>GET_RUNNING_OPERATIONS</code> and <code>KILL_OPERATION</code></td>
        </tr>
        <tr>
            <td>SPLICE-1879</td>
            <td><code>KeyBy</code> Function on Control is a multimap index vs. a map function</td>
        </tr>
        <tr>
            <td>SPLICE-1880</td>
            <td>Modify <code>ReduceByKey</code> to execute lazily and not use Multimaps.</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Added <code>SplicemachineContext.g</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Bcast implementation dataset vs <code>rddetConnection()</code> to enable commit/rollback in Scala</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Bcast implementation dataset vs rdd</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add logging to <code>Vacuum</code> process</td>
        </tr>
    </tbody>
</table>

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>

</div>
</section>
