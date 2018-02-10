---
title: Bug Fixes in the Current Release of Splice Machine
summary: Bug fixes in the current release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_bugfixes.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Bug Fixes in Release {{splvar_basic_SpliceReleaseVersion}} of the Splice Machine Database

{% include splice_snippets/onpremonlytopic.md %}
This topic describes bug fixes in the Splice Machine Database, which is used in both our Database-as-Service and On-Premise Database products, with notes for each patch release since the initial release of version 2.5, in these sections:

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
            <td>SPLICE-1995</td>
            <td>Correct imported rows</td>
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
            <td>SPLICE-1900</td>
            <td>Incorrect error message while reading data from Empty external table of AVRO file format.</td>
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
            <td>SPLICE-1870</td>
            <td>Fix update through index lookup path</td>
        </tr>
        <tr>
            <td>SPLICE-1927</td>
            <td>Amend pattern string for detecting splice machine ready to accept connections</td>
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
            <td>SPLICE-1983</td>
            <td>OOM in Spark executors while running TPCH1 repeatedly</td>
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
            <td>SPLICE-865</td>
            <td> Check if enterprise version is activated and if the user try to use column privileges.</td>
        </tr>
        <tr>
            <td>SPLICE-1784</td>
            <td>Query does not scale on 4000 regions (2.5)</td>
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
            <td>SPLICE-1784</td>
            <td>Trying to do cutpoints again</td>
        </tr>
        <tr>
            <td>SPLICE-1887</td>
            <td>Fix memory leak for merge join</td>
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
            <td>SPLICE-1928</td>
            <td>Decode region start/end key by fetching actual rowkey</td>
        </tr>
        <tr>
            <td>SPLICE-1934</td>
            <td>WordUtils.wrap() from commons-lang3 3.5 is broken</td>
        </tr>
    </tbody>
</table>

## Splice Release 2.5.0.1735  {#Release1735}
<table summary="Summary of Bug Fixes in this release">
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA ID</th>
            <th>Issue Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-8</td>
            <td>Make CTAS work with case sensitive names</td>
        </tr>
        <tr>
            <td>SPLICE-57</td>
            <td>Drop backing index and write handler when dropping a unique constraint</td>
        </tr>
        <tr>
            <td>SPLICE-77</td>
            <td>Order by column in subquery not projected should not be resolved</td>
        </tr>
        <tr>
            <td>SPLICE-79</td>
            <td>Generate correct insert statement to import char for bit column</td>
        </tr>
        <tr>
            <td>SPLICE-612</td>
            <td>Fix wrong result in right outer join with expression in join condition</td>
        </tr>
        <tr>
            <td>SPLICE-737</td>
            <td>GetTableNumber should return -1 if it cannot be determined</td>
        </tr>
        <tr>
            <td>SPLICE-835</td>
            <td>Mapping TEXT column creation to CLOB</td>
        </tr>
        <tr>
            <td>SPLICE-865</td>
            <td>Check if enterprise version is activated and if the user try to use column privileges.</td>
        </tr>
        <tr>
            <td>SPLICE-976</td>
            <td>Do not allow odbc and jdbc requests other than splice driver</td>
        </tr>
        <tr>
            <td>SPLICE-1023</td>
            <td>Add more info in the message for data import error</td>
        </tr>
        <tr>
            <td>SPLICE-1062</td>
            <td>Retry if region location cannot be found</td>
        </tr>
        <tr>
            <td>SPLICE-1098</td>
            <td>Prevent nonnull selectivity from being 0</td>
        </tr>
        <tr>
            <td>SPLICE-1116</td>
            <td>Fixing OrderBy Removal from set operations since they are now hashed based</td>
        </tr>
        <tr>
            <td>SPLICE-1122</td>
            <td>Deleting a table needs to remove the pin for the table.</td>
        </tr>
        <tr>
            <td>SPLICE-1160</td>
            <td>Report syntax error instead of throwing NPE for topN in set operation</td>
        </tr>
        <tr>
            <td>SPLICE-1208</td>
            <td>Fix mergeSortJoin overestimate by 3x</td>
        </tr>
        <tr>
            <td>SPLICE-1211</td>
            <td>Open and close latency calculated twice for NLJ</td>
        </tr>
        <tr>
            <td>SPLICE-1290</td>
            <td>Adding Batch Writes to the dictionary</td>
        </tr>
        <tr>
            <td>SPLICE-1294</td>
            <td>Poor Costing when first part of PK is not =</td>
        </tr>
        <tr>
            <td>SPLICE-1320</td>
            <td>Fix Assertion Placement and Comment Out test to get build out</td>
        </tr>
        <tr>
            <td>SPLICE-1323</td>
            <td>Add null check for probevalue</td>
        </tr>
        <tr>
            <td>SPLICE-1324</td>
            <td>Making Sure SQLTinyInt can SerDe</td>
        </tr>
        <tr>
            <td>SPLICE-1329</td>
            <td>Memory leak in SpliceObserverInstructions</td>
        </tr>
        <tr>
            <td>SPLICE-1349</td>
            <td>Serialize and initialize BatchOnceOperation correctly</td>
        </tr>
        <tr>
            <td>SPLICE-1353</td>
            <td>Export to S3</td>
        </tr>
        <tr>
            <td>SPLICE-1357</td>
            <td>Fix wrong result for right outer join that is performed through spark engine</td>
        </tr>
        <tr>
            <td>SPLICE-1358</td>
            <td>CREATE EXTERNAL TABLE can failed with some specific users in hdfs,</td>
        </tr>
        <tr>
            <td>SPLICE-1359</td>
            <td>SanityManager.DEBUG messages create a lot of noise in derby.log</td>
        </tr>
        <tr>
            <td>SPLICE-1360</td>
            <td>Adding SQL Array Data Type Basic Serde Functions</td>
        </tr>
        <tr>
            <td>SPLICE-1361</td>
            <td>Kerberos keytab not picked up by Spark on Splice Machine 2.5/2.7</td>
        </tr>
        <tr>
            <td>SPLICE-1362</td>
            <td>Synchronize access to internalConnection's contextManager</td>
        </tr>
        <tr>
            <td>SPLICE-1369</td>
            <td>Store external table on S3</td>
        </tr>
        <tr>
            <td>SPLICE-1370</td>
            <td>INSERT, UPDATE, DELETE error message for pin tables</td>
        </tr>
        <tr>
            <td>SPLICE-1374</td>
            <td>Bad file in S3</td>
        </tr>
        <tr>
            <td>SPLICE-1375</td>
            <td>Fix concurrency issues reporting failedRows</td>
        </tr>
        <tr>
            <td>SPLICE-1379</td>
            <td>The number of threads in the HBase priority executor is inadequately low</td>
        </tr>
        <tr>
            <td>SPLICE-1386</td>
            <td>Load jar file from S3</td>
        </tr>
        <tr>
            <td>SPLICE-1395</td>
            <td>Add a generic error message for import failure from S3</td>
        </tr>
        <tr>
            <td>SPLICE-1410</td>
            <td>Make the compilation of the pattern static</td>
        </tr>
        <tr>
            <td>SPLICE-1411</td>
            <td>Resolve over clause expr when alias from inner query is used in window fn</td>
        </tr>
        <tr>
            <td>SPLICE-1423</td>
            <td>Add null check for bad file directory</td>
        </tr>
        <tr>
            <td>SPLICE-1424</td>
            <td>Removing Unneeded Visitor from FromTable</td>
        </tr>
        <tr>
            <td>SPLICE-1425</td>
            <td>Fix data type inconsistencies with unary functions and external table based on TEXT data format</td>
        </tr>
        <tr>
            <td>SPLICE-1430</td>
            <td>Remove pin from dictionary and rely on spark cache to get the status of pins & Fix race condition on OlapNIOLayer</td>
        </tr>
        <tr>
            <td>SPLICE-1433</td>
            <td>Fix drop pinned table</td>
        </tr>
        <tr>
            <td>SPLICE-1438</td>
            <td>Fix the explain plan issues</td>
        </tr>
        <tr>
            <td>SPLICE-1443</td>
            <td>Add logging to debug "can't find subpartitions" exception</td>
        </tr>
        <tr>
            <td>SPLICE-1443</td>
            <td>Skip cutpoint that create empty partitions</td>
        </tr>
        <tr>
            <td>SPLICE-1446</td>
            <td>Check schema for ext table only if there's data</td>
        </tr>
        <tr>
            <td>SPLICE-1448</td>
            <td>Make sure SpliceSpark.getContext/Session isn't misused</td>
        </tr>
        <tr>
            <td>SPLICE-1452</td>
            <td>Correct cardinality estimation when there is missing partition stats</td>
        </tr>
        <tr>
            <td>SPLICE-1453</td>
            <td>Fixing Calculating Stats on Array Types</td>
        </tr>
        <tr>
            <td>SPLICE-1461</td>
            <td>Add null check on exception parsing</td>
        </tr>
        <tr>
            <td>SPLICE-1461</td>
            <td>Wrap exception parsing against errors</td>
        </tr>
        <tr>
            <td>SPLICE-1462</td>
            <td>Adding Mesos Scheduling Option to Splice Machine</td>
        </tr>
        <tr>
            <td>SPLICE-1463</td>
            <td>Sort results in MemStoreKVScanner when needed</td>
        </tr>
        <tr>
            <td>SPLICE-1464</td>
            <td>Bypass schema checking for csv file</td>
        </tr>
        <tr>
            <td>SPLICE-1469</td>
            <td>Set hbase.rowlock.wait.duration to 0 to avoid deadlock</td>
        </tr>
        <tr>
            <td>SPLICE-1470</td>
            <td>Make sure user transaction rollbacks on Spark failure</td>
        </tr>
        <tr>
            <td>SPLICE-1473</td>
            <td>Allow user code to load com.splicemachine.db.iapi.error</td>
        </tr>
        <tr>
            <td>SPLICE-1478</td>
            <td>Fixing Statement Limits</td>
        </tr>
        <tr>
            <td>SPLICE-1479</td>
            <td>iterator based stats collection</td>
        </tr>
        <tr>
            <td>SPLICE-1480</td>
            <td>Allow N Tree Logging</td>
        </tr>
        <tr>
            <td>SPLICE-1481</td>
            <td>Unnecessary Interface Modifier</td>
        </tr>
        <tr>
            <td>SPLICE-1489</td>
            <td>Make Predicate Pushdown defaulted for ORC</td>
        </tr>
        <tr>
            <td>SPLICE-1490</td>
            <td>Bringing Derby Style Forward</td>
        </tr>
        <tr>
            <td>SPLICE-1491</td>
            <td>Remove Array Copy for Key From Insert</td>
        </tr>
        <tr>
            <td>SPLICE-1526</td>
            <td>Handle CodecPool manually to avoid leaking memory</td>
        </tr>
        <tr>
            <td>SPLICE-1531</td>
            <td>Fixed ThreadLocal in AbstractTimeDescriptorSerializer</td>
        </tr>
        <tr>
            <td>SPLICE-1533</td>
            <td>Eliminate duplicates in the IN list</td>
        </tr>
        <tr>
            <td><p>SPLICE-1541</p><p>SPLICE-1543</p></td>
            <td>Fix IN-list issues with dynamic bindings and char column</td>
        </tr>
        <tr>
            <td>SPLICE-1550</td>
            <td>Recursive Init Calls</td>
        </tr>
        <tr>
            <td>SPLICE-1559</td>
            <td>bulkImportDirectory is case sensitive</td>
        </tr>
        <tr>
            <td>SPLICE-1561</td>
            <td>Allowing Clients to turn off cache and lazily execute</td>
        </tr>
        <tr>
            <td>SPLICE-1567</td>
            <td>Set remotecost for merge join</td>
        </tr>
        <tr>
            <td>SPLICE-1578</td>
            <td>Upgrade from 2.5 to 2.7</td>
        </tr>
        <tr>
            <td>SPLICE-1582</td>
            <td>Apply memory limit on consecutive broadcast joins</td>
        </tr>
        <tr>
            <td>SPLICE-1584</td>
            <td>Fix IndexOutOfBound exception when not all column stats are collected and we try to access column stats for estimation.</td>
        </tr>
        <tr>
            <td>SPLICE-1586</td>
            <td>Prevent NPE when Spark job fails</td>
        </tr>
        <tr>
            <td>SPLICE-1589</td>
            <td>All transactions are processed by pre-created region 0</td>
        </tr>
        <tr>
            <td>SPLICE-1597</td>
            <td>Fix issue with cache dictionary when  SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER is called .</td>
        </tr>
        <tr>
            <td>SPLICE-1601</td>
            <td>Fix wrong result for min/max/sum on empty table without groupby</td>
        </tr>
        <tr>
            <td>SPLICE-1609</td>
            <td>Normalize row source for split_table_or_index procedure</td>
        </tr>
        <tr>
            <td>SPLICE-1611</td>
            <td>TPC-C workload causes many prepared statement recompilations</td>
        </tr>
        <tr>
            <td>SPLICE-1613</td>
            <td>Ignore saveSourceCode IT for now</td>
        </tr>
        <tr>
            <td>SPLICE-1621</td>
            <td>Fix select from partitioned orc table error</td>
        </tr>
        <tr>
            <td>SPLICE-1622</td>
            <td>Return only latest version for sequences</td>
        </tr>
        <tr>
            <td>SPLICE-1624</td>
            <td>Load pipeline driver at RS startup</td>
        </tr>
        <tr>
            <td>SPLICE-1628</td>
            <td>Don't raise exception if path doesn't exist</td>
        </tr>
        <tr>
            <td>SPLICE-1628</td>
            <td>Parallelize hstore bulkLoad step in Spark</td>
        </tr>
        <tr>
            <td>SPLICE-1637</td>
            <td>Enable compression for HFile gen in bulk loader</td>
        </tr>
        <tr>
            <td>SPLICE-1639</td>
            <td>Fix NPE due to Spark static initialization missing</td>
        </tr>
        <tr>
            <td>SPLICE-1640</td>
            <td>Apply memory limit check for consecutive outer broadcast join and derived tables</td>
        </tr>
        <tr>
            <td>SPLICE-1660</td>
            <td>Delete Not Using Index Scan due to index columns being required for the scan.</td>
        </tr>
        <tr>
            <td>SPLICE-1675</td>
            <td>Merge partition stats at the stats collection time</td>
        </tr>
        <tr>
            <td>SPLICE-1682</td>
            <td>Perform accumulator check before txn resolution</td>
        </tr>
        <tr>
            <td>SPLICE-1684</td>
            <td>Fix stats collection logic for ArrayIndexOutOfBoundsException in the presence of empty partition and some column stats disabled</td>
        </tr>
        <tr>
            <td>SPLICE-1690</td>
            <td>Merge statistics on Spark</td>
        </tr>
        <tr>
            <td>SPLICE-1696</td>
            <td>Add ScanOperation and SplcieBaseOperation to Kryo</td>
        </tr>
        <tr>
            <td>SPLICE-1698</td>
            <td>StringBuffer to StringBuilder</td>
        </tr>
        <tr>
            <td>SPLICE-1699</td>
            <td>Removing Unused Imports</td>
        </tr>
        <tr>
            <td>SPLICE-1703</td>
            <td>Replace size() == 0 with isEmpty()</td>
        </tr>
        <tr>
            <td>SPLICE-1704</td>
            <td>Replace double quotes with isEmpty</td>
        </tr>
        <tr>
            <td>SPLICE-1707</td>
            <td>Fix Tail Recursion Issues</td>
        </tr>
        <tr>
            <td>SPLICE-1708</td>
            <td>Do not use KeySet where entryset will work</td>
        </tr>
        <tr>
            <td>SPLICE-1711</td>
            <td>Replace concat with +</td>
        </tr>
        <tr>
            <td>SPLICE-1712</td>
            <td>Remove Constant Array Creation Style</td>
        </tr>
        <tr>
            <td>SPLICE-1737</td>
            <td>Fix value outside the range of the data type INTEGER error for analyze table statement.</td>
        </tr>
        <tr>
            <td>SPLICE-1744</td>
            <td>Removing Dictionary Check</td>
        </tr>
        <tr>
            <td>SPLICE-1748</td>
            <td>Fixing Role Cache Usage</td>
        </tr>
        <tr>
            <td>SPLICE-1749</td>
            <td>Fix delete over nestedloop join</td>
        </tr>
        <tr>
            <td>SPLICE-1759</td>
            <td>HBase Master generates 1.1GB/s of network bandwidth even when cluster is idle</td>
        </tr>
        <tr>
            <td>SPLICE-1769</td>
            <td>Improve distributed boot process</td>
        </tr>
        <tr>
            <td>SPLICE-1773</td>
            <td>Unifying the thread pools</td>
        </tr>
        <tr>
            <td>SPLICE-1781</td>
            <td>Fixing Object Creation on IndexTransformFunction</td>
        </tr>
        <tr>
            <td>SPLICE-1784</td>
            <td>Fixing Serial Cutpoint Generation</td>
        </tr>
        <tr>
            <td>SPLICE-1784</td>
            <td>Query does not scale on 4000 regions</td>
        </tr>
        <tr>
            <td>SPLICE-1791</td>
            <td>Make username's more specific to resolve concurrent conflicts</td>
        </tr>
        <tr>
            <td>SPLICE-1792</td>
            <td>BroadcastJoinMemoryLimitIT must be executed serially</td>
        </tr>
        <tr>
            <td>SPLICE-1795</td>
            <td>Fix NullPointerExeption for update with expression, and uncomment test case in HdfsImport related to this bug</td>
        </tr>
        <tr>
            <td>SPLICE-1798</td>
            <td>Parallel Queries can fail on SPS Descriptor Update...</td>
        </tr>
        <tr>
            <td>SPLICE-1813</td>
            <td>Transaction are not popped from transaction stack when releasing savepoints</td>
        </tr>
        <tr>
            <td>SPLICE-1824</td>
            <td>NullPointer when collecting stats on ORC table</td>
        </tr>
        <tr>
            <td>SPLICE-1850</td>
            <td>Couldn't find subpartitions in range exception with external tables</td>
        </tr>
        <tr>
            <td>SPLICE-1853</td>
            <td>Wrong count(*) result for partitioned external table</td>
        </tr>
        <tr>
            <td>SPLICE-1854</td>
            <td>wrong result query orc table with predicate on date column</td>
        </tr>
        <tr>
            <td>SPLICE-1858</td>
            <td>Join result is wrong for a partitioned external table</td>
        </tr>
        <tr>
            <td>SPLICE-1860</td>
            <td>Error analyzing table when columns contains zero length data</td>
        </tr>
        <tr>
            <td>SPLICE-1865</td>
            <td>Boolean operator &lt;&gt; is broken with external tables</td>
        </tr>
        <tr>
            <td>SPLICE-1867</td>
            <td>SHOW TABLES is broken</td>
        </tr>
        <tr>
            <td>SPLICE-1874</td>
            <td>Large table scan runs on control with predicate of high selectivity</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allow more packages to be loaded from user code</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Drop and re-create foreign key write handler after truncating a table</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Name space null check</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix table number to allow predicate push down</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Remove check for collecting schema level stats for external table</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Explicitly unset ordering</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Redo nested connection on Spark fix</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Avoid bad file naming collision</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allow inner table of broadcast join to be any FromTable</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix stat collection on external table textfile</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Resubmit to Spark if we consume too many resouces in control</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix a couple issues that cause backup to hang</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Clean up timeout backup</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Bind select statement only once in insert into select</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Concatenate all iterables at once to avoid stack overflow error</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Prune query blocks based on unsatisfiable conditions</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix hash join column ordering</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Throw BR014 for concurrent backup</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix incremental backup hang</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Restore cleanup</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Continue processing tables when one doesn't have a namespace</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Restore a chain of backup(2.5)</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Correct postSplit</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fixing S3 File System Implementation</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allowing SpliceClient.isClient to allow distributed execution for inserts</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix Driver Loading in Zeppelin where it fails initially</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix a problem while reading orc byte stream</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Disable dictionary cache for hbase master and spark executor</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix Orc Partition Pruning</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Making sure schema is ejected from the cache correctly</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Disable Spark block cache and fix broadcast costing</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fixing ClosedConnectionException</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Clean up backup endpoint to avoid hang</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Update the error message when partial record is found</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Suppress false constraint violation during retry</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Avoid deleting a nonexist snapshot</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Keep the column indexes zero based for new orc stats collection job</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Correct a query to find indexes of a table</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Spark job has problems renewing a kerberos ticket</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Support ColumnPosition in GroupBy list</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix wrong result for broadcast with implicit cast from int to numeric type</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix limit on multiple partitions on Spark</td>
        </tr>
    </tbody>
</table>

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>

</div>
</section>
