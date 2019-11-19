---
title: Splice Machine Best Practices - Importing Data
summary: Best practices for importing data
keywords: importing
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_onprem_importing.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Best Practices for Importing Data

This section contains best practice and troubleshooting information related to importing  data into our *On-Premise Database* product, in these topics:

* [Using Bulk Import on a KMS-Enabled Cluster](#BulkImportKMS)
* [Bulk Import of Very Large Datasets with Spark](#BulkImportSparkSep)

{% include splice_snippets/onpremonlytopic.md %}

## Using Bulk Import on a KMS-Enabled Cluster {#BulkImportKMS}

If you are a Splice Machine On-Premise Database customer and want to use bulk import on a cluster with Cloudera Key Management Service (KMS) enabled, you must complete these extra configuration steps:

1. Make sure that the `bulkImportDirectory` is in the same encryption zone as is HBase.
2. Add these properties to `hbase-site.xml` to load secure Apache BulkLoad and to put its staging directory in the same encryption zone as HBase:
   <div class="preWrapperWide"><pre class="Plain">&lt;property&gt;
      &lt;name&gt;hbase.bulkload.staging.dir&lt;/name&gt;
      &lt;value&gt;<span class="HighlightedCode">&lt;YourStagingDirectory&gt;</span>&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
      &lt;name&gt;hbase.coprocessor.region.classes&lt;/name&gt;
      &lt;value&gt;org.apache.hadoop.hbase.security.access.SecureBulkLoadEndpoint&lt;/value&gt;
    &lt;/property&gt;</pre>
   </div>

   Replace <span class="HighlightedCode">&lt;YourStagingDirectory&gt;</span> with the path to your staging directory, and make sure that directory is in the same encryption zone as HBase; for example:
   ````
       <value>/hbase/load/staging</value>
   ````

For more information about KMS, see <a href="https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_sg_kms.html" target="_blank">https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_sg_kms.html</a>.


## Bulk Import of Very Large Datasets with Spark  {#BulkImportSparkSep}

When using Splice Machine with Spark with Cloudera, bulk import of very large datasets can fail due to direct memory usage. Use the following settings to resolve this issue:

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
