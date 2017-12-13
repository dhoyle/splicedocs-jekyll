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

* [Restarting Splice Machine after an HMaster Failure](*HMasterRestart)
* [Updating Stored Query Plans after a Splice Machine Update](*SpliceUpdate)
* [Increasing Parallelism for Spark Shuffles](#SparkShuffles)
* [Force Compaction to Run Locally](#LocalCompaction)
* [Kerberos Configuration Option](#KerberosConfig)

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
* Set the value of `splice.spark.dynamicAllocation.maxExecutors` to twice that number. Adjust these setting in the `Java Config Options` section of your HBase Master configuration.

The default option settings are:

    -Dsplice.spark.dynamicAllocation.minExecutors=0
    -Dsplice.spark.dynamicAllocation.maxExecutors=12
{: .ShellCommand}

For a cluster with 20 Region Servers, you would set these to:

    -Dsplice.spark.dynamicAllocation.minExecutors=20
    -Dsplice.spark.dynamicAllocation.maxExecutors=40
{: .ShellCommand}

## Kerberos Configuration Option  {#KerberosConfig}
If you're using Kerberos, you need to add this option to your HBase Master Java Configuration Options:

<div class="preWrapper" markdown="1">
    -Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
{:.ShellCommand}
</div>


</div>
</section>
