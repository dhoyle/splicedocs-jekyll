---
title: Fine-tuning performance options
summary: Summary of options for configuring database performance
keywords: importing
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_onprem_configperf.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring Performance of Your Splice Machine Database

This section contains best practice and troubleshooting information related to modifying configuration options to fine-tune database performance with our *On-Premise Database* product, in these topics:

* [Resolving Periodic Spikes in HBase Read Times](#HbaseSpikes)
* [Increasing Parallelism for Spark Shuffles](#SparkShuffles)
* [Increasing Memory Settings for Heavy Analytical Work Loads](#OLAPMemSettings)
* [Force Compaction to Run Locally](#LocalCompaction)
* [MVCC Purge](#MVCCPurge)

{% include splice_snippets/onpremonlytopic.md %}

## Resolving Periodic Spikes in HBase Read Times  {#HbaseSpikes}

If you're using Cloudera and you closely monitor your read request queues as a way to stay on top of your cluster load, you might observe a spike in reads every 30 minutes. Cloudera Manager enables an `Hbase Region Health Canary` that pings every server once every 30 minutes. As long as you are not experiencing any throughput problems, these spikes are harmless. If you want to get rid of the spikes, you can disable this monitoring, as follows:

1. In Cloudera Manager, navigate to `HBase service -> Configuration -> Monitoring`.
2. Deselect (uncheck) `HBase Region Health Canary`.

## Increasing Parallelism for Spark Shuffles {#SparkShuffles}

You can adjust the minimum parallelism for Spark shuffles by adjusting the value of the `splice.olap.shuffle.partitions` configuration option.

This option is similar to the `spark.sql.shuffle.partitions` option, which configures the number of partitions to use when shuffling data for joins or aggregations; however, the `spark.sql.shuffle.partitions` option is set to allow a lower number of partitions than is optimal for certain operations.

Specifically, increasing the number of shuffle partitions with the `splice.olap.shuffle.partitions` option is useful when performing operations on small tables that generate large, intermediate datasets; additional, but smaller sized partitions allows us to operate with better parallelism.

The default value of `splice.olap.shuffle.partitions` is `200`.

## Increasing Memory Settings for Heavy Analytical Work Loads  {#OLAPMemSettings}

If you are running heavy analytical loads or running OLAP jobs on very large tables, you may want to increase these property settings in your `hbase-site.xml` file:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Property</th>
            <th>Default Value (MB)</th>
            <th>Recommendations for Heavy Analytical Loads</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">splice.olap_server.memory</td>
            <td>1024</td>
            <td>Set to the same value as HMaster heap size</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.olap_server.memoryOverhead</td>
            <td>512</td>
            <td>Set to 10% of <span class="CodeFont">splice.olap_server.memory</span></td>
        </tr>
        <tr>
            <td class="CodeFont">splice.olap_server.virtualCores</td>
            <td>1 vCore</td>
            <td>4 vCores</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.olap_server.external</td>
            <td>true</td>
            <td>true</td>
        </tr>
    </tbody>
</table>


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

## MVCC Purge  {#MVCCPurge}

Multi-Version Concurrency Control (MVCC) purge enables you to control the way data is purged during memstore flush, minor compaction, and major compaction.


MVCC purge is controlled using the following configuration parameters:

* `splice.olap.compaction.automaticallyPurgeDeletedRows` -- enabled (`true`) by default.

* `splice.olap.compaction.automaticallyPurgeOldUpdates` -- disabled (`false`) by default.


When a row in a table is deleted, the data is not physically removed from HBase -- instead, a tombstone cell is placed on top of the row. Similarly, when a row in a table is updated, a new entry is added in HBase, shadowing (but not removing) the older value.

* If `automaticallyPurgeDeletedRows` is enabled, the deleted rows are purged as much as possible during memstore flush, minor compaction, and major compaction.

* Similarly, if `automaticallyPurgeOldUpdates` is enabled, shadowed entries are purged as much as possible during memstore flush, minor compaction, and major compaction.


</div>
</section>
