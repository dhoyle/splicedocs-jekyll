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

* [Resource Allocation for Backup Jobs](#BackupResources)
* [Bulk Import of Very Large Datasets with Spark 2.2](#BulkImportSparkSep)


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

</div>
</section>
