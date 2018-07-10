---
title: Backing Up Your Data
summary: Summary of options for configuring backups
keywords: importing
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_onprem_backups.html
folder: BestPractices/OnPrem
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Best Practices" %}
# Configuring Your Splice Machine Backups

This section contains best practice and troubleshooting information related to backing up your data with our *On-Premise Database* product, in these topics:

* [How Backup Jobs Run](#howjobsrun)
* [Configuring Backups When Copying with Spark Executors](#usingspark)
* [Configuring Backups When Copying with `distcp`](#usingdistcp)

## How Backup Jobs Run {#howjobsrun}

Splice Machine backups run as Spark jobs, submitting tasks to copy HFiles. In the past, Splice Machine backups used the Apache Hadoop `distcp` tool to copy the HFile; `distcp` uses MapReduce to copy, which can require significant resources. These requirements can limit file copying parallelism and reduce backup throughput. Splice Machine backups now can run (and do so by default) using a Spark executor to copy the HFiles, which significantly increases backup performance.

## Configuring Backups When Copying with Spark Executors {#usingspark}

The default way for backups to run is using Spark executors to perform the file copies, which results in a significant performance boost compared to the older method of using `distcp`. You can configure these backups using the following options:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Property</th>
            <th>Default value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">splice.backup.max.bandwidth.mb</td>
            <td class="CodeFont">100</td>
            <td>Sets the maximum throughput, in megabtyes, for one thread of file copying; if copying is faster than this value, I/O is throttled to avoid consuming too much network and disk bandwidth. The default value is 100MB per second. </td>
        </tr>
        <tr>
            <td class="CodeFont">splice.backup.io.buffer.size</td>
            <td class="CodeFont">64</td>
            <td>This is the size, in kilobytes, of the buffer used to read from and write to HDFS.Tuning this value has an impact of backup performance. The default value is 64KB.</td>
        </tr>
    </tbody>
</table>

## Resource Configuration When Using `distcp`  {#usingdistcp}

You can choose to have Splice Machine use `distcp` for copying HFiles when backing up your database. To do so, set the following configuration option:

````
splice.backup.use.distcp = true
````
{: .AppCommand}

The default value of `splice.backup.use.distcp` is `false`.

When using `distcp` for copying, Splice Machine backup jobs use a Map Reduce job to copy HFiles; this process may hang up if the resources required for the Map Reduce job are not available from Yarn. To make sure the resources are available, follow these three configuration steps:

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

</div>
</section>
