---
title: Ingestion Troubleshooting
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_troubleshooting.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Troubleshooting Ingestion

This topic provides troubleshooting help for specific ingestion scenarios, in these subsections:

* [Ingestion Troubleshooting Tips for the Splice Machine Database](#dbtips)
* [Ingestion Troubleshooting Tips for On-Premise Database Product Only](#dbtips)

## Ingestion Troubleshooting Tips for the Splice Machine Database  {#dbtips}
This section contains the following tips for troubleshooting ingestion of data into your Splice Machine database:

* [Troubleshooting Ingestion: Tip 1](#scenario1)
* [Troubleshooting Ingestion: Tip 2](#scenario2)

### Troubleshooting Ingestion: 1  {#scenario1}

* Scenario description
* Troubleshooting specifics


### Troubleshooting Ingestion: 2  {#scenario2}

* Scenario description
* Troubleshooting specifics


## Ingestion Troubleshooting Tips for On-Premise Database Product Only  {#onpremtips}
This section contains the following tips for troubleshooting ingestion of  data into our *On-Premise Database* product:

* [Using Bulk Import on a KMS-Enabled Cluster](#BulkImportKMS)
* [Bulk Import of Very Large Datasets with Spark](#BulkImportSparkSep)

### Using Bulk Import on a KMS-Enabled Cluster {#BulkImportKMS}

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

### Bulk Import of Very Large Datasets with Spark  {#BulkImportSparkSep}

When using Splice Machine with Spark with Cloudera, bulk import of very large datasets can fail due to direct memory usage. Use the following settings to resolve this issue:

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

## See Also

* [Best Practices: Ingesting Data Overview](bestpractices_ingest_overview.html.html)
* [Importing Flat Files](bestpractices_ingest_import.html)
* [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html)
* [Ingestion in Your Spark App](bestpractices_ingest_sparkapp.html)
* [Ingesting External Tables](bestpractices_ingest_externaltbl.html)
* [Best Practices: Ingesting Streaming Data](bestpractices_ingest_streaming.html)

</div>
</section>
