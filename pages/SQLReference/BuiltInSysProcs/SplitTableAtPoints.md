---
title: SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS built-in system procedure
summary: Built-in system procedure that splits a table or index into HFiles based on split keys that were computed by the SYSCS_UTIL.SYSCS_COMPUTE_SPLIT_KEYS procedure.
keywords: split table at points, split_table_or_index_at_points
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_splittableatpoints.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS
This procedure splits a table or index file that you want to bulk import into HFiles, using the *split keys* that you specify. The split keys are specified in a CSV file that you can create in one of two ways:

* If you know how your data can best be split into evenly sized HFiles, you can manually create a CSV file, as described in our [Best Practices: Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) topic.
* You can call the [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) procedure to compute the split keys for the data and save them in a CSV file.

For more information about splitting your tables and indexes into HFiles, see the [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) section of our *Best Practices: Ingestion* chapter.

Splice Machine recommends using the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) system procedure instead of this one unless you're an expert user. The combination of using `SYSCS_UTIL.COMPUTE_SPLIT_KEY` with `SYSCS_UTIL.COMPUTE_SPLIT_KEY` is exactly equivalent to using `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`.
{: .noteIcon}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS (
            schemaName,
            tableName,
            indexName,
            splitPoints
            );
{: .FcnSyntax}

</div>

<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema of the table or index that you are splitting.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table you are splitting.
{: .paramDefnFirst}

indexName
{: .paramName}

The name of the index that you are splitting. If this is null, the
specified table is split; if this is non-null, the index is split
instead.
{: .paramDefnFirst}

splitPoints
{: .paramName}

A list of split points for the table or index, supplied in a CSV file; this list can be created by a previous call to the [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) procedure, or you can prepare it manually, in which case, it needs to follow the criteria specified in the next section, [Split Points CSV File Format](#csvfile).
{: .paramDefnFirst}

</div>

### Split Points CSV File Format {#csvfile}
If you are manually preparing the `splitPoints` CSV file, you must create a version of the file you are importing that contains only rows that are region boundary rows. Each row in the file:

* contains only the primary key column value, if you're importing a table.
* contains only the index column values, if you're importing an index.

## Usage {#Usage}

You can use the `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` procedure to pre-split a data file that you're importing with the [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure.

When you pre-split your data, make sure that you set the `skipSampling` parameter to `true` when calling `SYSCS_UTIL.BULK_IMPORT_HFILE`; that tells the bulk import procedure that you have already split your data.
{: .noteIcon}

The [Best Practices: Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) section of our *Importing Data Tutorial* describes the different methods for using our bulk HFile import functionality.

## See Also

*  [Best Practices: Ingestion](bestpractices_ingest_overview.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
*  [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)

</div>
</section>
