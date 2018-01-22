---
summary: Troubleshooting your on-premise Splice Machine Database
title: Troubleshooting and Best Practices
keywords: troubleshooting, best practices
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_info_troubleshoot.html
folder: OnPrem/Info
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}
# Splice Machine Troubleshooting and Best Practices
{% include splice_snippets/onpremonlytopic.md %}

This topic provides troubleshooting guidance for these issues that you may encounter with your Splice Machine database:

* [Restarting Splice Machine after an HMaster Failure](#HMasterRestart)
* [Updating Stored Query Plans after a Splice Machine Update](#SpliceUpdate)
* [Increasing Parallelism for Spark Shuffles](#SparkShuffles)
* [Force Compaction to Run Locally](#LocalCompaction)
* [Kerberos Configuration Option](#KerberosConfig)
* [Resource Allocation for Backup Jobs](#BackupResources)
* [Bulk Import of Very Large Datasets with Spark 2.2 as Separate Service](#BulkImportSparkSep)

## Restarting Splice Machine After HMaster Failure {#HMasterRestart}

If you run Splice Machine without redundant HMasters, and you lose your HMaster, follow these steps to restart Splice Machine:

1. Restart the HMaster node
2. Restart every HRegion Server node

## Updating Stored Query Plans after a Splice Machine Update {#SpliceUpdate}

When you install a new version of your Splice Machine software, you need to
make these two calls:

<div class="preWrapperWide"><pre class="Example">
CALL <a href="sqlref_sysprocs_updatemetastmts.html">SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS();</a>
CALL <a href="sqlref_sysprocs_emptycache.html">SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE();</a>
</pre></div>

These calls will update the stored metadata query plans and purge the statement cache, which is required because the query plan APIs have changed. This is true for both minor (patch) releases and major new releases.

## Increasing Parallelism for Spark Shuffles {#SparkShuffles}

You can adjust the minimum parallelism for Spark shuffles by adjusting the value of the `splice.olap.shuffle.partitions` configuration option.

This option is similar to the `spark.sql.shuffle.partitions` option, which configures the number of partitions to use when shuffling data for joins or aggregations; however, the `spark.sql.shuffle.partitions` option is set to allow a lower number of partitions than is optimal for certain operations.

Specifically, increasing the number of shuffle partitions with the `splice.olap.shuffle.partitions` option is useful when performing operations on small tables that generate large, intermediate datasets; additional, but smaller sized partitions allows us to operate with better parallelism.

The default value of `splice.olap.shuffle.partitions` is `200`.

## Force Compaction to Run on Local Region Server {#LocalCompaction}

Splice Machine attempts to run database compaction jobs on an executor that is co-located with the serving Region Server; if it cannot find a local executor after a period of time, Splice Machine uses whatever executor Spark executor it can get; to force use of a local executor, you can adjust the `splice.spark.dynamicAllocation.minExecutors` configuration option.

To do so:
* Set the value of `splice.spark.dynamicAllocation.minExecutors` to the number of Region Servers in your cluster
* Set the value of `splice.spark.dynamicAllocation.maxExecutors` to equal to or greater than that number. Adjust these setting in the `Java Config Options` section of your HBase Master configuration.

The default option settings are:

    -Dsplice.spark.dynamicAllocation.minExecutors=0
    -Dsplice.spark.dynamicAllocation.maxExecutors=12
{: .ShellCommand}

For a cluster with 20 Region Servers, you would set these to:

    -Dsplice.spark.dynamicAllocation.minExecutors=20
    -Dsplice.spark.dynamicAllocation.maxExecutors=20
{: .ShellCommand}

## Kerberos Configuration Option  {#KerberosConfig}
If you're using Kerberos, you need to add this option to your HBase Master Java Configuration Options:

<div class="preWrapper" markdown="1">
    -Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
{:.ShellCommand}
</div>

## Resource Management for Backup Jobs {#BackupResources}

Splice Machine backup jobs use a Map Reduce job to copy HFiles; this process may hang up if the resources required for the Map Reduce job are not available from Yarn. To make sure the resources are available, follow these three configuration steps:

1. [Configure minimum executors for Splice Spark](#ConfigMinExec)
2. [Verify that adequate vcores are available for Map Reduce tasks](#EnoughVcores)
3. [Verify that adequate memory is available for Map Reduce tasks](#EnoughMem)

#### Configure the minimum number of executors allocated to Splice Spark {#ConfigMinExec}

You need to make sure that both of the following configuration settings relationships hold true.

  <div class="preWrapperWide" markdown="1">
    (splice.spark.dynamicAllocation.minExecutors + 1) < (yarn.nodemanager.resource.cpu-vcores * number_of_nodes)
  {: .Example}
  </div>

  <div class="preWrapperWide" markdown="1">
    (splice.spark.dynamicAllocation.minExecutors * (splice.spark.yarn.executor.memoryOverhead+splice.spark.executor.memory) + splice.spark.yarn.am.memory) < (yarn.nodemanager.resource.memory-mb * number_of_nodes)
  {: .Example}
  </div>

The actual `minExecutors` allocated to Splice Spark may be less than specified in `splice.spark.dynamicAllocation.minExecutors` because of memory constraints in the container. Once Splice Spark is launched, Yarn will allocate the actual `minExecutor` value and memory to Splice Spark. You need to verify that enough vcores and memory remain available for Map Reduce tasks.

#### Verify that adequate vcores are available {#EnoughVcores}

The Map Reduce application master requires the following number of vcores:
  <div class="preWrapperWide" markdown="1">
    yarn.app.mapreduce.am.resource.cpu-vcores * splice.backup.parallesim
  {: .Example}
  </div>

There must be at least this many additional vcores available to execute Map Reduce tasks:
  <div class="preWrapperWide" markdown="1">
    max{mapreduce.map.cpu.vcores,mapreduce.reduce.cpu.vcores}
  {: .Example}
  </div>

Thus, the total number of vcores that must be available for Map Reduce jobs is:
  <div class="preWrapperWide" markdown="1">
    yarn.app.mapreduce.am.resource.cpu-vcores * splice.backup.parallesim + max{mapreduce.map.cpu.vcores,mapreduce.reduce.cpu.vcores}
  {: .Example}
  </div>

#### Verify that adequate memory is available {#EnoughMem}

The Map Reduce application master requires this much memory:
  <div class="preWrapperWide" markdown="1">
    yarn.scheduler.minimum-allocation-mb * splice.backup.parallesim
  {: .Example}
  </div>

There must be at least this much memory available to execute Map Reduce tasks:
  <div class="preWrapperWide" markdown="1">
    yarn.scheduler.minimum-allocation-mb
  {: .Example}
  </div>

Thus, the total number of memory that must be available for Map Reduce jobs is:
  <div class="preWrapperWide" markdown="1">
    yarn.scheduler.minimum-allocation-mb * (splice.backup.parallesim+1)
  {: .Example}
  </div>

## Bulk Import of Very Large Datasets with Spark 2.2 as Separate Service  {#BulkImportSparkSep}

When using Splice Machine with Spark 2.2 as a separate service with Cloudera, bulk import of very large datasets can fail due to direct memory usage. Use the following settings to resolve this issue:

#### Update Shuffle-to-Mem Setting

Modify the following setting in the Cloudera Manager's *Java Configuration Options for HBase Master*:

  <div class="preWrapperWide" markdown="1">
    -Dsplice.spark.reducer.maxReqSizeShuffleToMem=134217728
  {: .Example}
  </div>

#### Update the YARN User Classpath

Modify the following settings in the Cloudera Manager's *YARN (MR2 Included) Service Environment Advanced Configuration Snippet (Safety Valve)*:

  <div class="preWrapperWide" markdown="1">
    YARN_USER_CLASSPATH=/opt/cloudera/parcels/SPARK2/lib/spark2/yarn/spark-2.2.0.cloudera1-yarn-shuffle.jar:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/scala-library-2.11.8.jar
    YARN_USER_CLASSPATH_FIRST=true
  {: .Example}
  </div>

</div>
</section>
