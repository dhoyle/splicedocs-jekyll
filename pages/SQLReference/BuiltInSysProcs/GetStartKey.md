---
title: SYSCS_UTIL.GET_START_KEY built-in system procedure
summary: Built-in system procedure that retrieves the starting key value, in unencoded format, for a specified HBase region.
keywords: hbase region, region, start key
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_getstartkey.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.GET_START_KEY

The `SYSCS_UTIL.GET_START_KEY` system procedure that retrieves retrieves
the starting key value, in unencoded format, for a specified HBase
region.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.GET_START_KEY( VARCHAR schemaName,
                            VARCHAR tableName,
                            VARCHAR indexName,
                            VARCHAR encodedRegionName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema of the table.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table.
{: .paramDefnFirst}

indexName
{: .paramName}

`NULL` or the name of the index.
{: .paramDefnFirst}

Specify `NULL` to indicate that the `startKey` is the primary key of the
base table; specify an index name to indicate that the `startKey` is an
index value.
{: .paramDefn}

encodedRegionName
{: .paramName}

The HBase-encoded name of the region, which you can retrieve using the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
system procedure.
{: .paramDefnFirst}

</div>
## Usage

Use this procedure to discover the starting key value for an HBase
region.

## Results

Displays the start key for the region in Splice Machine unencoded
format.

## Example

The following call returns the start key for an HBase table region:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_START_KEY('SPLICE', 'myTable', null,  '9d427082bedabb79656369b353e401cc');
    START_KEY
    --------------------------------------------------
    { 2, NULL }
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
The following call returns the start key for for the region that stores
index `myIndex` on table `myTable`:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_START_KEY('SPLICE', 'myTable', 'myIndex','b35fe82916cdd1d48bb5c43f60a9b8b5');
    START_KEY
    --------------------------------------------------
    { 1996-04-11, 67310, 45983.16, 0.09 }
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.COMPACT_REGION`](sqlref_sysprocs_compactregion.html)
* [`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
* [`SYSCS_UTIL.GET_REGIONS`](sqlref_sysprocs_getregions.html)
* [`SYSCS_UTIL.MAJOR_COMPACT_REGION`](sqlref_sysprocs_majorcompactregion.html)
* [`SYSCS_UTIL.MERGE_REGIONS`](sqlref_sysprocs_mergeregions.html)

</div>
</section>

