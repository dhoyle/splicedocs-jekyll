---
title: Fine-tuning performance options
summary: Summary of options for configuring database performance
keywords: importing
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_onprem_configperf.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Best Practices" %}
# Configuring Performance of Your Splice Machine Database


This section contains best practice and troubleshooting information related to modifying configuration options to fine-tune database performance with our *On-Premise Database* product, in these topics:

* [Increasing Parallelism for Spark Shuffles](#SparkShuffles)
* [Increasing Memory Settings for Heavy Analytical Work Loads](#OLAPMemSettings)
* [Force Compaction to Run Locally](#LocalCompaction)


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

</div>
</section>
