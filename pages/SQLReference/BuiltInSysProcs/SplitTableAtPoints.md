---
title: SYSCS_UTIL.SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS built-in system procedure
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

The `SYSCS_UTIL.SPLIT_TABLE_OR_INDEX_AT_POINTS` system procedure sets up
table or index splits in your database, prior to importing that table in
HFile format.

You must use this procedure in conjunction with two others:

* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](#)
* [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

See the *Usage Notes* section for more information and the *Example*
section to see an example of using these procedures together.

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
 

## Results

`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` does not produce
results.


The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)

</div>
</section>
