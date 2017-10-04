---
title: Release Notes for the Current Release of Splice Machine
summary: Release notes for the current release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar:  onprem_sidebar
permalink: onprem_info_release2.5.html
folder: OnPrem/Info
---
# Release Notes for Splice Machine On-Premise Database v2.5.0.1735 (Sept, 2017)

{% include splice_snippets/onpremonlytopic.md %}

Welcome to 2.5 update release (2.5.0.1735) of Splice Machine! The product is available to build from open source (see <https://github.com/splicemachine/spliceengine>), as well as prebuilt packages for use on a cluster or cloud.

Version 2.5 (2.5.0.1707) was originally released in March, 2017. You'll find the original release notes at the bottom of this page.

This topic contains the following sections pertaining to the new patch release:

* [Supported Platforms](#supported-platforms)
* [Enterprise-only Features](#enterprise-only-features)
* [Running the Standalone Version](#running-the-standalone-version)
* [New Features](#new-features)
* [Improvements](#improvements)
* [Bug Fixes](#bug-fixes)
* [Known Issues and Workarounds](#known-issues-and-workarounds)


## Supported Platforms
The supported platforms with 2.5 are:

* Cloudera 5.8.0, 5.8.3
* MapR 5.2.0
* HortonWorks HDP 2.5.5

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

* HBase Bulk Import    (SPLICE-1482)
* Allow Physical Deletes in a Table    (SPLICE-1591)
* Support sample statistics collection (via Analyze)    (SPLICE-1603)
* Bulk delete by loading HFiles    (SPLICE-1669)
* Enable snapshot with bulk load procedure    (SPLICE-1671)

* Add a system procedure MERGE_DATA_FROM_FILE to achieve a limited fashion of merge-into
* Implement Kerberos JDBC support

<div class="noteIcon">For additional information about new features in this release, see <a href="onprem_info_newfeatures.html">our new features information page</a>.</div>


## Improvements
Here are major improvements we've included in this version:

* Support 'drop view if exists' for 2.5    (SPLICE-398)
* Support upgrade from K2 (2.5)            (SPLICE-774)
* Iterator based stats collection (2.5)    (SPLICE-1479)
* Skip WAL for unsafe imports (2.5)        (SPLICE-1500)
* Enable compression for WritePipeline     (SPLICE-1516)
* Enable optimizer trace info for costing  (SPLICE-1555)
* Introduce query hint "skipStats"         (SPLICE-1681)
* JXM mbean server for cache and enginedriver exec service   (SPLICE-1701)
* Support 'drop table t_name if exists' for 2.5              (SPLICE-1729)
* Improve distributed boot process         (SPLICE-1769)
* Introduce database property collectIndexStatsOnly to specify the collect stats behavior   (SPLICE-1756)

* Bcast implementation dataset vs rdd
* Prune query blocks based on unsatisfiable conditions
* Add logging to Vacuum process
* Restore breaks transaction semantics (2.5)



## Bug fixes
These bug fixes have been incorporated into this version:

* Order by column in subquery not projected should not be resolved    (SPLICE-77)
* Generate correct insert statement to import char for bit column    (SPLICE-79)
* Fix wrong result in right outer join with expression in join condition    (SPLICE-612)
* Reset statistics during upgrade    (SPLICE-774)
* Wait for master to clear upgrade znode    (SPLICE-774)
* Add more info in the message for data import error    (SPLICE-1023)
* Prevent nonnull selectivity from being 0    (SPLICE-1098)
* Poor Costing when first part of PK is not =    (SPLICE-1294)
* Add a generic error message for import failure from S3    (SPLICE-1395)
* Clean up import error messages for bad file    (SPLICE-1423)
* Fix the explain plan issues    (SPLICE-1438)
* Skip cutpoint that create empty partitions    (SPLICE-1443)
* Correct cardinality estimation when there is missing partition stats    (SPLICE-1452)
* Wrap exception parsing against errors    (SPLICE-1461)
* Set hbase.rowlock.wait.duration to 0 to avoid deadlock    (SPLICE-1469)
* Make sure user transaction rollbacks on Spark failure    (SPLICE-1470)
* Allow user code to load com.splicemachine.db.iapi.error    (SPLICE-1473)
* Fixing Statement Limits    (SPLICE-1478)
* Add flag for inserts to skip conflict detection    (SPLICE-1497)
* Handle CodecPool manually to avoid leaking memory    (SPLICE-1526)
* Eliminate duplicates in the IN list    (SPLICE-1533)
* Fix IN-list issues with dynamic bindings and char column    (SPLICE-1541,SPLICE-1543)
* BulkImportDirectory is case sensitive    (SPLICE-1559)
* Apply memory limit on consecutive broadcast joins    (SPLICE-1582)
* Fix IndexOutOfBound exception when not all column stats are collected and we try to access column stats for estimation.    (SPLICE-1584)
* Prevent NPE when Spark job fails    (SPLICE-1586)
* All transactions are processed by pre-created region 0    (SPLICE-1589)
* Fix wrong result for min/max/sum on empty table without groupby    (SPLICE-1601)
* Normalize row source for split_table_or_index procedure    (SPLICE-1609)
* Return only latest version for sequences    (SPLICE-1622)
* Load pipeline driver at RS startup    (SPLICE-1624)
* HFile bulk load is slow to copy/move HFile to regions    (SPLICE-1628)
* Enable compression for HFile gen in bulk loader    (SPLICE-1637)
* Fix NPE due to Spark static initialization missing    (SPLICE-1639)
* Apply memory limit check for consecutive outer broadcast join and derived tables    (SPLICE-1640)
* Delete Not Using Index Scan due to index columns being required for the scan.    (SPLICE-1660)
* Merge partition stats at the stats collection time    (SPLICE-1675)
* Perform accumulator check before txn resolution (2.5)    (SPLICE-1682)
* Fix stats collection logic for ArrayIndexOutOfBoundsException in the presence of empty partition and some column stats disabled    (SPLICE-1684)
* Merge statistics on Spark (2.5)    (SPLICE-1690)
* Perform (anti)tombstone txn resolution only when needed    (SPLICE-1692)
* Add ScanOperation and SplcieBaseOperation to Kryo    (SPLICE-1696)
* Refresh/resolve changes with latest master branch    (SPLICE-1702)
* Fix value outside the range of the data type INTEGER error for analyze table statement.    (SPLICE-1737)
* Fix delete over nestedloop join    (SPLICE-1749)
* HBase Master generates 1.1GB/s of network bandwidth even when cluster is idle    (SPLICE-1759)
* Fixing Object Creation on IndexTransformFunction    (SPLICE-1781)
* Code Cleanup on BulkInsertRowIndex    (SPLICE-1782)
* Fixing Serial Cutpoint Generation    (SPLICE-1784)
* Make username's more specific to resolve concurrent conflicts    (SPLICE-1791)
* BroadcastJoinMemoryLimitIT must be executed serially    (SPLICE-1792)
* Fix NullPointerExeption for update with expression, and uncomment test case in HdfsImport related to this bug    (SPLICE-1795)
* Parallel Queries can fail on SPS Descriptor Update...    (SPLICE-1798)
* Null checking for REGEXP_LIKE
* Resubmit to Spark if we consume too many resouces in control
* Fix a couple issues that cause backup to hang
* Backups block flushes forever if not stopped cleanly
* Bind select statement only once in insert into select
* Boncatenate all iterables at once to avoid stack overflow error
* Fix hash join column ordering
* Throw BR014 for concurrent backup
* Fix incremental backup hang
* Continue processing tables when one doesn't have a namespace
* Correct postSplit
* Disable dictionary cache for hbase master and spark executor
* Making sure schema is ejected from the cache correctly
* Disable Spark block cache and fix broadcast costing
* Fixing ClosedConnectionException handling
* Clean up backup endpoint to avoid hang
* Update error message when partial record is found (2.5)
* Suppress false constraint violation during retry
* Avoid deleting a nonexist snapshot
* Cleanup failed backup from old build
* Correct a query to find indexes of a table
* Spark job has problems renewing a kerberos ticket
* Support ColumnPosition in GroupBy list
* Fix wrong result for broadcast with implicit cast from int to numeric type
* Fix limit on multiple partitions on Spark


## Known Issues and Workarounds
[Known issues and workarounds in release 2.5.0.1727 are described here](onprem_info_workarounds.html).

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>

# New Features in 2.5 GA Release (2.5.0.1707) - Mar. 1 2017
* Performance enhancement on TPCC, TPCH, backup/restore
* Privileges at Schema level
* Incremental Backup/Restore
* Non-native Database dump/load
* ORC/Parquet implemented as External Tables
* SQL WITH clause
* Window Function enhancements
* Caching RDD's (PINNING)
* Statistics Enhancements (including Histograms)


Critical issues fixed in 2.5 Release
* Export to S3 gives  java.lang.IllegalArgumentExceptionWrong FS    (SPLICE-1353:)
* Memory leak in SpliceObserverInstructions    (SPLICE-1329:)
* NLJoinFunction creates too many threads    (SPLICE-1325:)
* TPCH100g : Import fails with " java.util.concurrent.ExecutionException " in /bad record file.    (SPLICE-1062:)
* Regression: create table using text data type gives syntax error.    (SPLICE-1059:)
* TPCC test fails on CDH.5.7.2 platform    (SPLICE-995:)
* Reading from Spark sometimes returns deleted rows    (SPLICE-1463:)
* The number of threads in the HBase priority executor is inadequately low    (SPLICE-1379:)
* S3: import fails  when S3 file source is specified as /BAD file source, with error: java.lang.IllegalArgumentException    (SPLICE-1374:)
* S3: Import fails in case of BAD directory parameter is set to null    (SPLICE-1366:)
* Kerberos keytab not picked up by Spark on Splice Machine 2.5    (SPLICE-1361:)
* Context manager leaks in OlapServer    (SPLICE-961:)
* 2.0.x Class Not Found creating custom VTI
* Restore DB brokes database for creation tables in case new table creates after backup.
* Regression: backup_database()  is giving communication error
* Class Not Found creating custom VTI
* database owner can be changed with improper connection string
* Restore from S3 fails with SQL exception Failed to start database 'splicedb'
* [ODBC] unable to get output of EXPLAIN statement
* [Backup/Restore][Incremental Backup] Unable to select from table after restoring from incremental backup.
* Inconsistent results from a query
* Running SpliceFileVTI not working
