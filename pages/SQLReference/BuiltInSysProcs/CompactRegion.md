---
title: SYSCS_UTIL.COMPACT_REGION built-in system procedure
summary: Built-in system procedure that performs a minor compaction on a table or index region.
keywords: region compaction, compact region, minor compaction, COMPACT_REGION
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_compactregion.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.COMPACT_REGION

The `SYSCS_UTIL.COMPACT_REGION` system procedure performs a minor
compaction on a table region or an index region.

Region names must be specified in HBase-encoded format. You can retrieve
the encoded name for a region by calling the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
system procedure.

A common reason for calling this procedure is to improve compaction
performance by only compacting recent updates in a table. For example,
you might confine any updates to regions of the current month, so older
regions need not be re-compacted.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.COMPACT_REGION( VARCHAR schemaName,
                               VARCHAR tableName,
                               VARCHAR indexName,
                               VARCHAR startKey)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema of the table.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table to compact.
{: .paramDefnFirst}

indexName
{: .paramName}

`NULL` or the name of the index.
{: .paramDefnFirst}

Specify the name of the index you want to compact; if you are compacting
the table, specify `NULL` for this parameter.
{: .paramDefn}

regionName
{: .paramName}

The **encoded** HBase name of the region you want compacted. You can
call the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
procedure to look up the region name for an unencoded Splice Machine
table or index key.
{: .paramDefnFirst}

</div>
<div markdown="1">
## Usage

You can compact a table region by specifying `NULL` for the index name.
To compact an index region, specify both the table name and the index
name.

Region compaction is asynchronous, which means that when you invoke this
procedure from the command line, Splice Machine issues a compaction
request to HBase, and returns control to you immediately; HBase will
determine when to subsequently run the compaction.

</div>
## Results

This procedure does not return a result.

## Examples

The following example will perform a minor compaction on the region with
encoded key value `8ffc80e3f8ac3b180441371319ea90e2` for table
`testTable`. The encoded key value is first retrieved by passing the
unencoded key value, `1|2`, into the
`SYSCS_UTIL.GET_ENCODED_REGION_NAME` procedure:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_ENCODED_REGION_NAME('SPLICE', 'TESTTABLE', null, '1|2', '|', null, null, null, null););
    ENCODED_REGION_NAME                     |START_KEY                                         |END_KEY
    ------------------------------------------------------------------------------------------------------------------
    8ffc80e3f8ac3b180441371319ea90e2        |\x81\x00\x82                                      |\x81\x00\x84
    
    1 row selected
    
    splice> CALL SYSCS_UTIL.COMPACT_REGION('SPLICE', 'testTable', NULL, '8ffc80e3f8ac3b180441371319ea90e2');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
And this example performs a minor compaction on the region with encoded
index key value `ff8f9e54519a31e15f264ba6d2b828a4` for index `testIndex`
on table `testTable`. The encoded key value is first retrieved by
passing the unencoded index key value,
`1996-04-12|155190|21168.23|0.04`, into the
`SYSCS_UTIL.GET_ENCODED_REGION_NAME` procedure:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_ENCODED_REGION_NAME('SPLICE', 'TESTTABLE', 'SHIP_INDEX','1996-04-12|155190|21168.23|0.04', '|', null, null, null, null);
    ENCODED_REGION_NAME                     |START_KEY                                         |END_KEY
    ------------------------------------------------------------------------------------------------------------------
    ff8f9e54519a31e15f264ba6d2b828a4        |\xEC\xC1\x15\xAD\xCD\x80\x00\xE1\x06\xEE\x00\xE4V&|
    
    1 row selected
    
    splice> CALL SYSCS_UTIL.COMPACT_REGION('SPLICE', 'testTable', 'testIndex', 'ff8f9e54519a31e15f264ba6d2b828a4');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
* [`SYSCS_UTIL.GET_REGIONS`](sqlref_sysprocs_getregions.html)
* [`SYSCS_UTIL.GET_START_KEY`](sqlref_sysprocs_getstartkey.html)
* [`SYSCS_UTIL.MAJOR_COMPACT_REGION`](sqlref_sysprocs_majorcompactregion.html)
* [`SYSCS_UTIL.MERGE_REGIONS`](sqlref_sysprocs_mergeregions.html)

</div>
</section>

