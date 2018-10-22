---
title: "Importing Data: Using Bulk HFile Import"
summary: Describes how to use the bulk HFile import process to load large datasets.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importbulkhfile.html
folder: DeveloperTutorials/Import
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Using Bulk HFile Import
This topic describes how to import data (tables or indexes) using HFiles into your Splice
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

Due to how Yarn manages memory, you need to modify your YARN configuration when bulk-importing large datasets. Make these two changes in your Yarn configuration, `ResourceManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml`:

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
into multiple HFiles based on *split keys*, which determine how the data will be distributed into
regions. The objective is to compute splits such that roughly the same number of table rows will
end up in each region.

How your data is split into HFiles has a significant impact on performance; again, the goal is to split the data into evenly-sized numbers of rows.
{: .noteIcon}

You have these choices for determining how the data is split:

* You can call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter set to `false`; this procedure then samples and analyzes the data in your file and splits the data into temporary HFiles based on that analysis. [Example 1: Automatic Splitting](tutorials_ingest_importexampleshfile.html#autosplit) shows how to use the automatic splits computation built into the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure.

* You can *pre-split* your data by first creating a CSV file that specifies the split keys to use to perform the pre-splits, and then calling the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to pre-split your table or index file. You then call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter set to `true` to import the data. [Example 2: Computed Pre-Splits](tutorials_ingest_importexampleshfile.html#computesplit) shows how to pre-split your data using `SPLIT_TABLE_OR_INDEX` before performing the import.

* If you want even more control over how your data is split into evenly-sized regions, you can specify the row boundaries for pre-splitting yourself in a CSV file. You then
supply that file as a parameter to the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedure, which performs the pre-splitting, after which you call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter set to `true`. We recommend that only expert customers use this procedure.

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
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
