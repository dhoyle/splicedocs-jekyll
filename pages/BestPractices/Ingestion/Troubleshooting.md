---
title: Ingestion Troubleshooting
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_ingest_troubleshooting.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Troubleshooting On-Premise Bulk Import

This section contains the following tips for troubleshooting ingestion of  data into our *On-Premise Database* product:

* [Using Bulk Import on a KMS-Enabled Cluster](#BulkImportKMS)
* [Bulk Import: Out of Heap Memory](#heapmem)
* [Bulk Import: Out of Direct Memory (Cloudera)](#directmem)
* [Bulk Import: Network Timeout](#networktimeout)

There are currently no troubleshooting issues to address if you're using the *Splice Machine Database-as-Service* product.
{: .noteIcon}

## Using Bulk Import on a KMS-Enabled Cluster {#BulkImportKMS}

If you are a Splice Machine On-Premise Database customer and want to use bulk import on a cluster with Cloudera Key Management Service (KMS) enabled, you must complete these extra configuration steps:

1.  Make sure that the `bulkImportDirectory` is in the same encryption zone as is HBase.
2.  Add these properties to `hbase-site.xml` to load secure Apache BulkLoad and to put its staging directory in the same encryption zone as HBase:

    ```
    <property>
      <name>hbase.bulkload.staging.dir</name>
      <value><YourStagingDirectory></value>
    </property>
    <property>
      <name>hbase.coprocessor.region.classes</name>
      <value>org.apache.hadoop.hbase.security.access.SecureBulkLoadEndpoint</value>
    </property></pre>
    ```
    {: .Example}

    Replace ```<YourStagingDirectory>``` with the path to your staging directory, and make sure that directory is in the same encryption zone as HBase; for example:
    {: .spaceAbove}

    ```
       <value>/hbase/load/staging</value>
    ```
    {: .Example}

For more information about KMS, see <a href="https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_sg_kms.html" target="_blank">https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_sg_kms.html</a>.

## Bulk Import: Out of Heap Memory  {#heapmem}
If you run out of heap memory while bulk importing an extremely large amount of data with our *On-Premise* product, you can resolve the issue by setting the hbase client's `hfile.block.cache.size` property value to a very small number. We recommend this setting:

```
hfile.block.cache.size=0.01
```
{: .Example}

This setting should be applied only to the HBase client.
{: .noteNote}

## Bulk Import: Network Timeout  {#networktimeout}

If you enounter a network timeout during bulk ingestion with our *On-Premise* product, you can resolve it by adjusting the value of the `shuffle.io.connectionTimout` property as follows:

```
-Dsplice.spark.shuffle.io.connectionTimeout=480s
```
{: .Example}


## Bulk Import: Out of Direct Memory (Cloudera)  {#directmem}

When using the *On-Premise* version of Splice Machine with Spark with Cloudera, bulk import of very large datasets can fail due to direct memory usage. Use the following settings to resolve this issue:

1.  Update the Shuffle-to-Mem Setting

    Modify the following setting in the Cloudera Manager's *Java Configuration Options for HBase Master*:

    ```
    -Dsplice.spark.reducer.maxReqSizeShuffleToMem=134217728
    ```
    {: .Example}

2.  Update the YARN User Classpath

    Modify the following settings in the Cloudera Manager's *YARN (MR2 Included) Service Environment Advanced Configuration Snippet (Safety Valve)*:

    ```
    YARN_USER_CLASSPATH=/opt/cloudera/parcels/SPARK2/lib/spark2/yarn/spark-2.2.0.cloudera1-yarn-shuffle.jar:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/scala-library-2.11.8.jar
    YARN_USER_CLASSPATH_FIRST=true
    ```
    {: .Example}

3. Due to how Yarn manages memory, you need to modify your YARN configuration when bulk-importing large datasets. Make this change in your Yarn configuration, `ResourceManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml`:

    ```
    yarn.nodemanager.vmem-check-enabled=false
    ```
    {: .Example}

   You may also need to __temporarily__ make this additional configuration update as a workaround for memory allocation issues. Note that this update __is not recommended for production usage__, as it affects all YARN jobs and could cause your cluster to become unstable:

    ```
    yarn.nodemanager.pmem-check-enabled=false
    ```
    {: .Example}

</div>
</section>
