---
title: Release Notes for the Current Release of Splice Machine
summary: Release notes for the current release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar:  onprem_sidebar
permalink: onprem_info_release.html
folder: OnPrem/Info
---
# Release Notes for Splice Machine On-Premise Database v2.6 (August 1, 2017)

{% include splice_snippets/onpremonlytopic.html %}

Welcome to 2.6 release of Splice Machine! The product is available to build from open source (see <https:github.com/splicemachine/spliceengine>), as well as prebuilt packages for use on a cluster or cloud.

This topic contains the following sections:

* [Supported Platforms](#supported-platforms)
* [Enterprise-only Features](#enterprise-only-features)
* [Running the Standalone Version](#running-the-standalone-version)
* [New Features](#new-features)
* [Improvements](#improvements)
* [Bug Fixes](#bug-fixes)
* [Known Issues and Workarounds](#known-issues-and-workarounds)


## Supported Platforms
The supported platforms with 2.6 are:

* Cloudera CDH 5.8.0, 5.8.3
* MapR 5.1.0 and 5.2.0
* HortonWorks HDP 2.5 and 2.5.5

## Enterprise-only Features
The following features will NOT work on the Community Edition of Splice Machine.  You will need to upgrade to the Enterprise version:

* Backup/Restore
* LDAP integration
* Column-level user privileges
* Kerberos enablement
* Encryption at rest


## Running the Standalone Version
Supported hardware for the STANDALONE release:

* Mac OS X (10.8 or greater)
* Centos (6.4 or equivalent)


## New Features
These are the significant new features in this release, along with their Splice Machine open source JIRA identifiers:

* VTI Support for Hive ORC Files    (SPLICE-879)
* Support For Array Data Type    (SPLICE-1320)
* HBase Bulk Import    (SPLICE-1482)
* Multiple Distinct Operations in Aggregates Support    (SPLICE-1512)
* Allow Physical Deletes in a Table    (SPLICE-1591)
* Support sample statistics collection (via Analyze)    (SPLICE-1603)
* Bulk delete by loading HFiles    (SPLICE-1669)
* Enable snapshot with bulk load procedure    (SPLICE-1671)
* Enable monitoring and reporting capability of memory usage for HBase's JVM via JMX    (SPLICE-1701)

* Add a system procedure MERGE_DATA_FROM_FILE to achieve a limited fashion of merge-into
* Implement Kerberos JDBC support
* Support BLOB/CLOB in ODBC
* HAProxy and connection load balancing solution

<div class="noteIcon">For additional information about new features in this release, see <a href="onprem_info_newfeatures.html">our new feature information page</a>.</div>


## Improvements
Here are major improvements we've included in this version:

* Support 'drop view if exists'    (SPLICE-398)
* Implement in-memory subtransactions    (SPLICE-1222)
* Upgrade Sketching Library from 0.8.1 - 0.8.4    (SPLICE-1351)
* Control-side query control    (SPLICE-1372)
* Iterator based stats collection    (SPLICE-1479)
* Add flag for inserts to skip conflict detection    (SPLICE-1497)
* Skip WAL for unsafe imports    (SPLICE-1500)
* Create Spark Adapter that supports both 1.6.x and 2.1.0 versions of Spark    (SPLICE-1513)
* Enable compression for WritePipeline    (SPLICE-1516)
* Orc Reader Additions    (SPLICE-1517)
* Enable optimizer trace info for costing    (SPLICE-1555)
* Core Spark Adapter Functionality With Maven Build    (SPLICE-1568)
* Update the Spark Adapter to 2.1.1    (SPLICE-1619)
* Introduce query hint "skipStats" after a table identifier to bypass fetching real stats from dictionary tables    (SPLICE-1681)
* Handle 'drop table table_name if exists'    (SPLICE-1729)
* Support type conversion Varchar to INT    (SPLICE-1733)
* Added CREATE SCHEMA IF NOT EXISTS functionality    (SPLICE-1739)
* Support inserting int types to char types    (SPLICE-1752)
* Introduce database property collectIndexStatsOnly to specify the collect stats behavior    (SPLICE-1756)

* Added SplicemachineContext.g
* DB-5872 Bcast implementation dataset vs rddetConnection() to enable commit/rollback in Scala
* Bcast implementation dataset vs rdd
* Add logging to Vacuum process



## Bug fixes
These bug fixes have been incorporated into this version:

* Make CTAS work with case sensitive names    (SPLICE-8)
* Drop backing index and write handler when dropping a unique constraint    (SPLICE-57)
* Order by column in subquery not projected should not be resolved    (SPLICE-77)
* Generate correct insert statement to import char for bit column    (SPLICE-79)
* Fix wrong result in right outer join with expression in join condition    (SPLICE-612)
* GetTableNumber should return -1 if it cannot be determined    (SPLICE-737)
* Mapping TEXT column creation to CLOB    (SPLICE-835)
* Check if enterprise version is activated and if the user try to use column privileges.    (SPLICE-865)
* Do not allow odbc and jdbc requests other than splice driver    (SPLICE-976)
* Add more info in the message for data import error    (SPLICE-1023)
* Retry if region location cannot be found    (SPLICE-1062)
* Prevent nonnull selectivity from being 0    (SPLICE-1098)
* Fixing OrderBy Removal from set operations since they are now hashed based    (SPLICE-1116)
* Deleting a table needs to remove the pin for the table.    (SPLICE-1122)
* Report syntax error instead of throwing NPE for topN in set operation    (SPLICE-1160)
* Fix mergeSortJoin overestimate by 3x    (SPLICE-1208)
* Open and close latency calculated twice for NLJ    (SPLICE-1211)
* Adding Batch Writes to the dictionary    (SPLICE-1290)
* Poor Costing when first part of PK is not =    (SPLICE-1294)
* Fix Assertion Placement and Comment Out test to get build out    (SPLICE-1320)
* Add null check for probevalue    (SPLICE-1323)
* Making Sure SQLTinyInt can SerDe    (SPLICE-1324)
* Memory leak in SpliceObserverInstructions    (SPLICE-1329)
* Serialize and initialize BatchOnceOperation correctly    (SPLICE-1349)
* Export to S3    (SPLICE-1353)
* Fix wrong result for right outer join that is performed through spark engine    (SPLICE-1357)
* CREATE EXTERNAL TABLE can failed with some specific users in hdfs,    (SPLICE-1358)
* SanityManager.DEBUG messages create a lot of noise in derby.log    (SPLICE-1359)
* Adding SQL Array Data Type Basic Serde Functions    (SPLICE-1360)
* Kerberos keytab not picked up by Spark on Splice Machine 2.5/2.6    (SPLICE-1361)
* Synchronize access to internalConnection's contextManager    (SPLICE-1362)
* Store external table on S3    (SPLICE-1369)
* INSERT, UPDATE, DELETE error message for pin tables    (SPLICE-1370)
* Bad file in S3    (SPLICE-1374)
* Fix concurrency issues reporting failedRows    (SPLICE-1375)
* The number of threads in the HBase priority executor is inadequately low    (SPLICE-1379)
* Load jar file from S3    (SPLICE-1386)
* Add a generic error message for import failure from S3    (SPLICE-1395)
* Make the compilation of the pattern static    (SPLICE-1410)
* Resolve over clause expr when alias from inner query is used in window fn    (SPLICE-1411)
* Add null check for bad file directory    (SPLICE-1423)
* Removing Unneeded Visitor from FromTable    (SPLICE-1424)
* Fix data type inconsistencies with unary functions and external table based on TEXT data format    (SPLICE-1425)
* Remove pin from dictionary and rely on spark cache to get the status of pins & Fix race condition on OlapNIOLayer    (SPLICE-1430)
* Fix drop pinned table    (SPLICE-1433)
* Fix the explain plan issues    (SPLICE-1438)
* Add logging to debug "can't find subpartitions" exception    (SPLICE-1443)
* Skip cutpoint that create empty partitions    (SPLICE-1443)
* Check schema for ext table only if there's data    (SPLICE-1446)
* Make sure SpliceSpark.getContext/Session isn't misused    (SPLICE-1448)
* Correct cardinality estimation when there is missing partition stats    (SPLICE-1452)
* Fixing Calculating Stats on Array Types    (SPLICE-1453)
* Add null check on exception parsing    (SPLICE-1461)
* Wrap exception parsing against errors    (SPLICE-1461)
* Adding Mesos Scheduling Option to Splice Machine    (SPLICE-1462)
* Sort results in MemStoreKVScanner when needed    (SPLICE-1463)
* Bypass schema checking for csv file    (SPLICE-1464)
* Set hbase.rowlock.wait.duration to 0 to avoid deadlock    (SPLICE-1469)
* Make sure user transaction rollbacks on Spark failure    (SPLICE-1470)
* Allow user code to load com.splicemachine.db.iapi.error    (SPLICE-1473)
* Fixing Statement Limits    (SPLICE-1478)
* iterator based stats collection    (SPLICE-1479)
* Allow N Tree Logging    (SPLICE-1480)
* Unnecessary Interface Modifier    (SPLICE-1481)
* Make Predicate Pushdown defaulted for ORC    (SPLICE-1489)
* Bringing Derby Style Forward    (SPLICE-1490)
* Remove Array Copy for Key From Insert    (SPLICE-1491)
* Handle CodecPool manually to avoid leaking memory    (SPLICE-1526)
* Fixed ThreadLocal in AbstractTimeDescriptorSerializer    (SPLICE-1531)
* Eliminate duplicates in the IN list    (SPLICE-1533)
* Fix IN-list issues with dynamic bindings and char column    (SPLICE-1541,1543)
* Recursive Init Calls    (SPLICE-1550)
* bulkImportDirectory is case sensitive    (SPLICE-1559)
* Allowing Clients to turn off cache and lazily execute    (SPLICE-1561)
* Set remotecost for merge join    (SPLICE-1567)
* Upgrade from 2.5 to 2.6    (SPLICE-1578)
* Apply memory limit on consecutive broadcast joins    (SPLICE-1582)
* Fix IndexOutOfBound exception when not all column stats are collected and we try to access column stats for estimation.    (SPLICE-1584)
* Prevent NPE when Spark job fails    (SPLICE-1586)
* All transactions are processed by pre-created region 0    (SPLICE-1589)
* Fix issue with cache dictionary when  SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER is called .    (SPLICE-1597)
* Fix wrong result for min/max/sum on empty table without groupby    (SPLICE-1601)
* Normalize row source for split_table_or_index procedure    (SPLICE-1609)
* TPC-C workload causes many prepared statement recompilations    (SPLICE-1611)
* Ignore saveSourceCode IT for now    (SPLICE-1613)
* Fix select from partitioned orc table error    (SPLICE-1621)
* Return only latest version for sequences    (SPLICE-1622)
* Load pipeline driver at RS startup    (SPLICE-1624)
* Don't raise exception if path doesn't exist    (SPLICE-1628)
* Parallelize hstore bulkLoad step in Spark    (SPLICE-1628)
* Enable compression for HFile gen in bulk loader    (SPLICE-1637)
* Fix NPE due to Spark static initialization missing    (SPLICE-1639)
* Apply memory limit check for consecutive outer broadcast join and derived tables    (SPLICE-1640)
* Delete Not Using Index Scan due to index columns being required for the scan.     (SPLICE-1660)
* Merge partition stats at the stats collection time    (SPLICE-1675)
* Perform accumulator check before txn resolution    (SPLICE-1682)
* Fix stats collection logic for ArrayIndexOutOfBoundsException in the presence of empty partition and some column stats disabled    (SPLICE-1684)
* Merge statistics on Spark    (SPLICE-1690)
* Add ScanOperation and SplcieBaseOperation to Kryo    (SPLICE-1696)
* StringBuffer to StringBuilder    (SPLICE-1698)
* Removing Unused Imports    (SPLICE-1699)
* Replace size() == 0 with isEmpty()    (SPLICE-1703)
* Replace double quotes with isEmpty    (SPLICE-1704)
* Fix Tail Recursion Issues    (SPLICE-1707)
* Do not use KeySet where entryset will work    (SPLICE-1708)
* Replace concat with +    (SPLICE-1711)
* Remove Constant Array Creation Style    (SPLICE-1712)
* Fix value outside the range of the data type INTEGER error for analyze table statement.    (SPLICE-1737)
* Removing Dictionary Check    (SPLICE-1744)
* Fixing Role Cache Usage    (SPLICE-1748)
* Fix delete over nestedloop join    (SPLICE-1749)
* HBase Master generates 1.1GB/s of network bandwidth even when cluster is idle    (SPLICE-1759)
* Improve distributed boot process    (SPLICE-1769)
* Unifying the thread pools    (SPLICE-1773)
* Fixing Object Creation on IndexTransformFunction    (SPLICE-1781)
* Fixing Serial Cutpoint Generation    (SPLICE-1784)
* Make username's more specific to resolve concurrent conflicts    (SPLICE-1791)
* BroadcastJoinMemoryLimitIT must be executed serially    (SPLICE-1792)
* Fix NullPointerExeption for update with expression, and uncomment test case in HdfsImport related to this bug    (SPLICE-1795)
* Parallel Queries can fail on SPS Descriptor Update...    (SPLICE-1798)
* NullPointer when collecting stats on ORC table    (SPLICE-1824)

* Allow more packages to be loaded from user code
* Drop and re-create foreign key write handler after truncating a table
* Name space null check
* Fix table number to allow predicate push down
* Remove check for collecting schema level stats for external table
* Explicitly unset ordering
* Redo nested connection on Spark fix
* Avoid bad file naming collision
* Allow inner table of broadcast join to be any FromTable
* Fix stat collection on external table textfile
* Resubmit to Spark if we consume too many resouces in control
* Fix a couple issues that cause backup to hang
* Clean up timeout backup
* Bind select statement only once in insert into select
* Concatenate all iterables at once to avoid stack overflow error
* Prune query blocks based on unsatisfiable conditions
* Fix hash join column ordering
* Throw BR014 for concurrent backup
* Fix incremental backup hang
* Restore cleanup
* Continue processing tables when one doesn't have a namespace
* Restore a chain of backup(2.5)
* Correct postSplit
* Fixing S3 File System Implementation
* Allowing SpliceClient.isClient to allow distributed execution for inserts
* Fix Driver Loading in Zeppelin where it fails initially
* Fix a problem while reading orc byte stream
* Disable dictionary cache for hbase master and spark executor
* Fix Orc Partition Pruning
* Making sure schema is ejected from the cache correctly
* Disable Spark block cache and fix broadcast costing
* Fixing ClosedConnectionException
* Clean up backup endpoint to avoid hang
* Update the error message when partial record is found
* Suppress false constraint violation during retry
* Avoid deleting a nonexist snapshot
* Keep the column indexes zero based for new orc stats collection job
* Correct a query to find indexes of a table
* Spark job has problems renewing a kerberos ticket
* Support ColumnPosition in GroupBy list
* Fix wrong result for broadcast with implicit cast from int to numeric type
* Fix limit on multiple partitions on Spark



## Known Issues and Workarounds
[Known issues and workarounds in this release are described here](onprem_info_workarounds.html).

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>
