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


Before using this procedure, `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`, you must first call the [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) procedure to compute the split points for the data you're importing. After computing the split keys, use this procedure to split the data into HFiles, and then call  &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
system procedure to import your data in HFile format.

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

A comma-separated list of split points for the table or index.
{: .paramDefnFirst}

This is the list of split points computed by a previous call to the
[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) procedure.
{: .paramDefn}

</div>

## Usage {#Usage}

The [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure needs the data that you're importing split into multiple HFiles before it actually imports the data into your database. You can achieve these splits in three ways:

* You can call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `false`. `SYSCS_UTIL.BULK_IMPORT_HFILE` samples the data to determine the splits, then splits the data into multiple HFiles, and then imports the data.

* You can split the data into HFiles with the
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable) procedure, which both computes the keys and performs the splits. You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data.

* You can split the data into HFiles by first calling the &nbsp;[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey) procedure to compute the split points, and then call this procedure,
 &nbsp;`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` procedure to split the table or index.  You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data.

In all cases, `SYSCS_UTIL.BULK_IMPORT_HFILE` automatically deletes the HFiles after the import process has completed.

The [Bulk HFile Import Examples](tutorials_ingest_importexampleshfile.html) section of our *Importing Data Tutorial* describes how these methods differ and provides examples of using them to import data.

## See Also

* [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)

</div>
</section>
