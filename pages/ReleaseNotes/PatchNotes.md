---
title: Bug Fixes in the Current Release of Splice Machine
summary: Bug fixes in the current release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_patchnotes.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Notes for Patch Releases to Version 2.5

{% include splice_snippets/onpremonlytopic.md %}
This topic describes changes made in patch releases since the initial release of Splice Machine Version 2.5.

* [Patch Release 2.5.0.1805](#Patch1805)
* [Patch Release 2.5.0.1804](#Patch1804)
* [Patch Release 2.5.0.1803](#Patch1803)
* [Patch Release 2.5.0.1802](#Patch1802)
* [Patch Release 2.5.0.1749](#Patch1749)
* [Patch Release 2.5.0.1748](#Patch1748)
* [Patch Release 2.5.0.1747](#Patch1747)
* [Patch Release 2.5.0.1745](#Patch1745)

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
            <td>Internal</td>
            <td>Improve export performance</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix illegal merge join</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Prevent incremental backup from losing changes</td>
        </tr>
        <tr>
            <td>SPLICE-1995</td>
            <td>Correct imported rows</td>
        </tr>
        <tr>
            <td>SPLICE-2022</td>
            <td>Improve spark job description for compaction</td>
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
            <td>Internal</td>
            <td>Add hint <code>useDefaultRowCount</code> and <code>defaultSelectivityFactor</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix upsert index</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Vacuum disabled tables</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Cache more database properties</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix database restore from s3</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Retry write workload on host unreachable exceptions</td>
        </tr>
        <tr>
            <td>SPLICE-1717</td>
            <td>Asynchronous transaction resolution in compactions</td>
        </tr>
        <tr>
            <td>SPLICE-2012</td>
            <td>HMaster doesn't exit after shutdown</td>
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
            <td>Internal</td>
            <td>Add system procedure to enable/disable all column statistics</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Close <code>FutureIterator</code> to avoid race condition</td>
        </tr>
        <tr>
            <td>SPLICE-1900</td>
            <td>Incorrect error message while reading data from Empty external table of AVRO file format.</td>
        </tr>
        <tr>
            <td>SPLICE-1987</td>
            <td>Add fully qualified table name into HBASE <code>TableDisplayName</code> Attribute</td>
        </tr>
        <tr>
            <td>SPLICE-2004</td>
            <td>Fix inconsistency between plan logged in log and that in the explain</td>
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
            <td>Internal</td>
            <td>Clean up incremental changes from offline regions that were offline before full backup</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add ignore txn cache</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Handle CannotCommit exception correctly</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Reduce lengthy lineage of transformation for <code>MultiProbeTableScan</code> operation</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add JDBC timeout support</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Get keytab file name correctly</td>
        </tr>
        <tr>
            <td>SPLICE-1870</td>
            <td>Fix update through index lookup path</td>
        </tr>
        <tr>
            <td>SPLICE-1927</td>
            <td>Amend pattern string for detecting splice machine ready to accept connections</td>
        </tr>
        <tr>
            <td>SPLICE-1975</td>
            <td>Allow JavaRDD&lt;Row&gt; to be passed for CRUD operations in SplicemachineContext</td>
        </tr>
        <tr>
            <td>SPLICE-1991</td>
            <td>Add info to Spark UI for Compaction jobs to indicate presence of Reference Files</td>
        </tr>
        <tr>
            <td>SPLICE-1998</td>
            <td>Modify splice 2.5 log file's time stamp format to ISO8601</td>
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
            <td>Internal</td>
            <td>Exclude metrics jar for cdh platforms</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add missing <code>getEncodedName()</code> method</td>
        </tr>
        <tr>
            <td>SPLICE-1973</td>
            <td>Exclude Kafka jars from splice-uber.jar for all platforms</td>
        </tr>
        <tr>
            <td>SPLICE-1983</td>
            <td>OOM in Spark executors while running TPCH1 repeatedly</td>
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
            <td>Internal</td>
            <td>Fix inconsistent selectivity with predicate order change</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Delete data by region without scanning</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Adjust selectivity estimation by excluding skewed default values</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Propagate SORT elimination to outer joins</td>
        </tr>
        <tr>
            <td>SPLICE-1920</td>
            <td>Tooling to fix data dictionary corruption</td>
        </tr>
        <tr>
            <td>SPLICE-1970</td>
            <td>Exclude metrics jars from splice-uber.jar to avoid class loader issues when using Spark Adapter</td>
        </tr>
        <tr>
            <td>SPLICE-1978</td>
            <td>Add null check to <code>GET_RUNNING_OPERATIONS</code></td>
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
            <td>Internal</td>
            <td>Terminate backup timely if it has been cancelled</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Prepend schemaname to columns in PK conditions in update statement generated by <code>MERGE_DATA_FROM_FILE</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix column misalignment for join update through mergesort join</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Bound the outer join row count by the left outer table's row count</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Parameter sanity check for region operations</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Populate default value for column of DATE type in defaultRow with the right type (regression fix for SPLICE-1700)</td>
        </tr>
        <tr>
            <td>SPLICE-865</td>
            <td> Check if enterprise version is activated and if the user try to use column privileges.</td>
        </tr>
        <tr>
            <td>SPLICE-1784</td>
            <td>Query does not scale on 4000 regions (2.5)</td>
        </tr>
        <tr>
            <td>SPLICE-1351</td>
            <td>Upgrade Sketching Library from 0.8.1 - 0.8.4</td>
        </tr>
        <tr>
            <td>SPLICE-1700</td>
            <td>Avoid updating existing physical rows when adding not-null</td>
        </tr>
        <tr>
            <td>SPLICE-1802</td>
            <td>Create index by HFile loading(2.5)</td>
        </tr>
        <tr>
            <td>SPLICE-1895</td>
            <td>Wait for wrap up before closing remote query client (2.5)</td>
        </tr>
        <tr>
            <td>SPLICE-1906</td>
            <td>Make coprocessors throw only <code>IOExceptions</code></td>
        </tr>
        <tr>
            <td>SPLICE-1908</td>
            <td>Add check for actionAllowed</td>
        </tr>
        <tr>
            <td>SPLICE-1921</td>
            <td>Fix wrong result with sort merge inclusion join for spark path</td>
        </tr>
        <tr>
            <td>SPLICE-1928</td>
            <td>Decode region start/end key by fetching actual rowkey</td>
        </tr>
        <tr>
            <td>SPLICE-1930</td>
            <td>Fixes an issue where maven uses platform installed protobuf</td>
        </tr>
        <tr>
            <td>SPLICE-1934</td>
            <td>WordUtils.wrap() from commons-lang3 3.5 is broken</td>
        </tr>
        <tr>
            <td>SPLICE-1937</td>
            <td>Add cdh5.12 platform (2.5)</td>
        </tr>
        <tr>
            <td>SPLICE-1948</td>
            <td>Increase test timeout</td>
        </tr>
        <tr>
            <td>SPLICE-1948</td>
            <td>Initialize Splice Spark context with user context (2.5)</td>
        </tr>
        <tr>
            <td>SPLICE-1951</td>
            <td>Remove protobuf installation instructions</td>
        </tr>
        <tr>
            <td>SPLICE-1961</td>
            <td>Missing splice_spark module in <code>pom.xml</code></td>
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
            <td>Internal</td>
            <td>Add region name and id to compaction job description</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add more logging</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Enhance <code>MultiProbeIndexScan</code> to apply for cases where inlist is not the leading index/PK column</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add logs around task failure in Spark</td>
        </tr>
        <tr>
            <td>SPLICE-1784</td>
            <td>Trying to do cutpoints again</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Make table level select privileges to column level</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add back synchronous backup/restore</td>
        </tr>
        <tr>
            <td>SPLICE-1887</td>
            <td>Fix memory leak for merge join</td>
        </tr>
        <tr>
            <td>SPLICE-1302</td>
            <td>Add minimum parallelism for Spark shuffles</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add check for <code>actionAllowed</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Exclude flatten and restart scripts</td>
        </tr>
        <tr>
            <td>SPLICE-1906</td>
            <td>Make coprocessors throw only <code>IOExceptions</code></td>
        </tr>
        <tr>
            <td>SPLICE-1915</td>
            <td>Enable query logging by default</td>
        </tr>
        <tr>
            <td>SPLICE-1921</td>
            <td>Fix wrong result with sort merge inclusion join for spar</td>
        </tr>
        <tr>
            <td>SPLICE-1895</td>
            <td>Wait for wrap up before closing remote query client</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Move the bulkimport/bulkdelete test in DefaultIndexIT to a separate file under hbase_sql so it won't run for mem platform</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add parameter to ignore missing transactions from <code>SPLICE_TXN</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Keep alive backup</td>
        </tr>
        <tr>
            <td>SPLICE-1928</td>
            <td>Decode region start/end key by fetching actual rowkey</td>
        </tr>
        <tr>
            <td>SPLICE-1802</td>
            <td>Create index by HFile loading</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Synchronize access to shared <code>ArrayList</code></td>
        </tr>
        <tr>
            <td>SPLICE-1934</td>
            <td>WordUtils.wrap() from commons-lang3 3.5 is broken</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix automatic DROP of temp tables</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Enhance subquery processing logic to convert eligible where subqueries</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allow first connection on Kerberized cluster</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Large variance in simple select query execution time</td>
        </tr>
        <tr>
            <td>SPLICE-1700</td>
            <td>Avoid updating existing physical rows when adding not-null column with default value</td>
        </tr>
        <tr>
            <td>SPLICE-1951</td>
            <td>Remove protobuf installation instructions from</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allow distributed execution for splice client</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Avoid index creation timeout</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Flatten correlated Scalar Subquery in <code>Select</code> clause</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Null checking for region operations</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Avoid sort if some of the index columns are bound with constant</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Set rowlocation for index lookup</td>
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


For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>.

</div>
</section>
