---
title: "Importing Data: Using Bulk HFile Import"
summary: Describes how to use the bulk HFile import process to load large datasets.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importbulkHfile.html
folder: DeveloperTutorials/Import
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Using Bulk HFile Import
This topic describes how to import data using HFiles into your Splice
Machine database with the [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) system procedure. This process significantly improves data loading performance by temporarily splitting your tables and indexes into Hadoop HFiles and loading your data from those files.

Bulk importing HFiles boosts import performance; however, constraint checking is not applied to the imported data. If you need constraint checking, use one of our standard import procedures, which are described in the [introduction](tutorials_ingest_importoverview.html) to this tutorial.
{: .noteIcon}

This topic includes these sections:
* [How to Use Bulk HFile Import](#Howitworks)
* [How to Split Your Data into HFiles](#HowToSplit)

The [Importing Data: Examples of Using the Bulk HFile Import Procedure](tutorials_ingest_importexampleshfile.html) topic in this tutorial presents examples of using bulk HFile import.

## How to Use Bulk HFile Import   {#Howitworks}
This section describes how bulk HFile import works, and includes information about the mechanics of using bulk import in Splice Machine, including:
* [Configuration Settings](#ConfigSettings)
* [Importing Data From the Cloud](#CloudAccess)

HBase bulk loading is the process of preparing and loading HFiles (HBase’s own file format) directly into RegionServers, bypassing the write pipeline. Our HFile data import procedure leverages bulk loading by temporarily converting your table (or index) file into HFiles, which are then directly imported into your Splice Machine database at a very high ingestion rate. The temporary files are automatically deleted once ingestion is complete.

How your data is split into HFiles (and thus into RegionServers) has a major impact on import performance; ideally, you want your data distributed into relatively evenly-sized regions. Splice Machine provides two methods for determining those splits, as described in the next section, [How to Split Your Data into HFiles](#HowToSplit).

### Configuration Settings {#ConfigSettings}

Due to how Yarn manages memory, you need to modify your YARN configuration when bulk-importing large datasets. Make these two changes in your Yarn configuration:

<div class="preWrapperWide" markdown="1">
    yarn.nodemanager.pmem-check-enabled=false
    yarn.nodemanager.vmem-check-enabled=false
{: .Example}
</div>

#### Extra Configuration Steps for KMS-Enabled Clusters

If you are a Splice Machine On-Premise Database customer and want to use bulk import on a cluster with Cloudera Key Management Service (KMS) enabled, you must complete a few extra configuration steps, which are described in [this troubleshooting note](bestpractices_onprem_importing.html#BulkImportKMS) for details.
{: .noteIcon}

### Importing Data From the Cloud  {#CloudAccess}

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information. Our [Configuring an S3 Bucket for Splice Machine Access](tutorials_ingest_configures3.html) walks you through using your AWS dashboard to generate and apply the necessary credentials.

## How to Split Your Data into HFiles {#HowToSplit}

Before it generate HFiles, `SYSCS_UTIL.BULK_IMPORT_HFILE` must determine how to split the data
into multiple regions by looking at the primary keys and figuring out
which values will yield relatively evenly-sized splits; the objective is
to compute splits such that roughly the same number of table rows will
end up in each split.

You have two choices for determining the table splits:

* You can have `SYSCS_UTIL.BULK_IMPORT_HFILE` scan and analyze your table to
determine the best splits automatically by calling `SYSCS_UTIL.BULK_IMPORT_HFILE`
with the `skipSampling` parameter set to `false`. It then splits the data into temporary HFiles and 

* You can compute the splits yourself and then call `SYSCS_UTIL.BULK_IMPORT_HFILE`
with the `skipSampling` parameter set to `true`. Computing the splits requires these steps, which are described in the next section, [Manually Computing Table Splits](#ManualSplits).

    1. Determine which values make sense for splitting your data
    into multiple regions. This means looking at the primary keys for the
    table and figuring out which values will yield relatively evenly-sized (in number of rows)
    splits.
    2. Call our system procedures to compute the HBase-encoded keys and set up the splits inside
    your Splice Machine database.
    3. Call the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure with the `skipSampling` parameter  to `true` to perform the import.




How your data is split into HFiles has an impact on performance; Splice Machine provides two mechanisms for computing the keys used to split your data:
* Our `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure can sample the data that you're importing and automatically determine the split keys, as described in the [Automatic Splits Computation](#AutoSplit) section below.
* You can use our `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` system procedure to determine the split keys prior to calling `SYSCS_UTIL.BULK_IMPORT_HFILE`, , as described in the [Manual Splits Computation](#ManualSplit) section below.


### Automatic Splits Computation {#AutoSplit}

### Manual Splits Computation {#ManualSplit}


by leveraging HFile bulk Before it generate HFiles, `SYSCS_UTIL.BULK_IMPORT_HFILE` must determine how to split the data
into multiple regions by looking at the primary keys and figuring out
which values will yield relatively evenly-sized splits; the objective is
to compute splits such that roughly the same number of table rows will
end up in each split.


======================

 This topic includes these sections:
* [Examples of Using `SYSCS_UTIL.BULK_IMPORT_HFILE`](#Examples) walks through using this procedure both with automatic table splits and with two different methods of manually computing table splits.

Our [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html) topic
walks you through using our standard import procedures (`SYSCS_UTIL.IMPORT_DATA`, `SYSCS_UTIL.SYSCS_UPSERT_DATA_FROM_FILE`, and `SYSCS_UTIL.SYSCS_MERGE_DATA_FROM_FILE`), which are simpler to use, though their performance is slightly lower than importing HFiles.




This topic describes how

* [How Importing Your Data as HFiles Works](#How) presents an overview of
  using the HFile import functions.

* [Configuration Settings](#ConfigSettings) describes any configuration settings that you may need to modify when using the [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure to import data into your database.

* [Importing Data From the Cloud](#CloudAccess) links to our instructions for configuring Splice Machine access to your data in the cloud.

* [Manually Computing Table Splits](#ManualSplits) outlines the steps you use to manually compute table splits, if you prefer to not have that handled automatically.

## Manually Computing Table Splits {#ManualSplits}

If you\'re computing splits for your import (and calling the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure with
`skipSampling` parameter  to `true`), you need to call [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to compute the splits the [Example 2](#ManualSplitExample1) example walks you through this.

-or-

* You can call [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) to generate a keys file, and then call [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) to set up the splits in your database; the [Example 3](#ManualSplitExample2) example walks you through this.

In either case, after computing the splits, you call `SYSCS_UTIL.BULK_IMPORT_HFILE` to split your input file into HFiles, import your data, and then remove the temporary HFiles.

Here's a quick summary of how you can compute your table splits:

<div class="opsStepsList" markdown="1">
1.  Create a directory on HDFS for the import; for example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    {: .ShellCommand}
    </div>

2.  Determine primary key values that can horizontally split the table
    into roughly equal sized partitions.
    {: .topLevel}

    Ideally, each partition should be about 1/2 the size of your `hbase.hregion.max.filesize` setting, which leaves room for the region to grow after your data is imported.\\
    \\
    The size of each partition **must be less than** the value of `hbase.hregion.max.filesize`.
    {: .notePlain}

3.  Store those keys in a CSV file.
    {: .topLevel}

4.  Compute the split keys and then split the table.
    {: .topLevel}

5.  Repeat steps 1, 2, and 3 to split the indexes on your table.
    {: .topLevel}

6.  Call the &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure
    to split the input data file into HFiles and import the HFiles into your Splice Machine database. The HFiles are automatically deleted after being imported.
    {: .topLevel}

</div>

You'll find detailed descriptions of these steps in the examples in the [Bulk HFile Import Examples](tutorials_ingest_importexampleshfile.html) topic of this tutorial:
* [Example 1: Automatic Splitting](tutorials_ingest_importexampleshfile.html#AutoExample) shows how to use the automatic splits computation built into the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure.
* [Example 2: Manual Splitting](tutorials_ingest_importexampleshfile.html#ManualExample) shows how to pre-split your data using `SPLIT_TABLE_OR_INDEX` before performing the import.

## See Also

*  [Importing Data: Tutorial Overview](tutorials_ingest_importoverview.html)
*  [Importing Data: Input Parameters](tutorials_ingest_importparams.html)
*  [Importing Data: Input Data Handling](tutorials_ingest_importinput.html)
*  [Importing Data: Error Handling](tutorials_ingest_importerrors.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

</div>
</section>
