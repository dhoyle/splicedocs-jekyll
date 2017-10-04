---
title: SYSCS_UTIL.MERGE_REGIONS built-in system procedure
summary: Built-in system procedure that merges two adjacent table or index regions.
keywords: region merge, merge regions
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_mergeregions.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.MERGE_REGIONS

The `SYSCS_UTIL.MERGE_REGIONS` system procedure merges two adjacent
Splice Machine table regions or two adjacent Splice Machine index
regions.

Region names must be specified in HBase-encoded form. You can retrieve
the encoded name for a region by calling the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
system procedure.

You might use this procedure if you want to collect older data into a
smaller set of regions to minimize the number of regions required.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.MERGE_REGIONS( VARCHAR schemaName)
                              VARCHAR tableName,
                              VARCHAR indexName,
                              VARCHAR regionName1,
                              VARCHAR regionName2 )
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

Specify the name of the index if you are merging index regions; if you
are merging table regions, specify `NULL` for this parameter.
{: .paramDefn}

regionName1
{: .paramName}

The **encoded** HBase name of the first of the two regions you want
merged. You can call the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
procedure to look up the region name for an unencoded Splice Machine
table or index key.
{: .paramDefnFirst}

regionName2
{: .paramName}

The **encoded** HBase name of the second of the two regions you want
merged. You can call the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
procedure to look up the region name for an unencoded Splice Machine
table or index key.
{: .paramDefnFirst}

</div>
## Usage

You can merge two adjacent table regions by specifying `NULL` for the
index name. To merge two adjacent index regions, specify both the table
name and the index name.

## Results

This procedure does not return a result.

If the specified regions are not adjacent, you'll see an error message,
and no merging will be performed.

## Examples

The following call will merge two adjacent regions of a table, after you
have called `SYSCS_UTIL.GET_ENCODED_REGION_NAME` to retrieve the encoded
key values for each region:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.MERGE_REGIONS('SPLICE','TESTTABLE', NULL,
                                          'cf0163796bba8666b1183788fc7bc31b',
                                          '4e11260fb5ae106a681574be90709449');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
And this call will merge two adjacent regions of an index, after you
have called `SYSCS_UTIL.GET_ENCODED_REGION_NAME` to retrieve the encoded
key values for each region::

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.MERGE_REGIONS('SPLICE','TESTTABLE', 'SHIP_INDEX',
                                          '5a59b4a46a8a0a7180a469dbe0b40fad',
                                          '039ba9b2ecdf458b3293bd9e74e88f65');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.COMPACT_REGION`](sqlref_sysprocs_compactregion.html)
* [`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
* [`SYSCS_UTIL.GET_REGIONS`](sqlref_sysprocs_getregions.html)
* [`SYSCS_UTIL.GET_START_KEY`](sqlref_sysprocs_getstartkey.html)
* [`SYSCS_UTIL.MAJOR_COMPACT_REGION`](sqlref_sysprocs_majorcompactregion.html)

</div>
</section>
