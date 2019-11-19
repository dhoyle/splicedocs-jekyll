---
title: SYSCS_UTIL.DELETE_REGION built-in system procedure
summary: Built-in system procedure that deletes a region.
keywords: region deletion, delete region
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_deleteregion.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.DELETE_REGION

The `SYSCS_UTIL.DELETE_REGION` system procedure deletes a Splice Machine table or index region.

This procedure is intended for use only by expert database administrators. Use of this procedure requires extreme caution: you can easily create data inconsistencies.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.DELETE_REGION( VARCHAR schemaName,
                              VARCHAR tableName,
                              VARCHAR indexName,
                              VARCHAR regionName,
                              VARCHAR mergeRegion )
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

Specify the name of the index if you are deleting an index region; if you
are a table region, specify `NULL` for this parameter.
{: .paramDefn}

regionName
{: .paramName}

The **encoded** HBase name of the first of the two regions you want
merged. You can call the
[`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
procedure to look up the region name for an unencoded Splice Machine
table or index key.
{: .paramDefnFirst}

mergeRegion
{: .paramName}

Specify `TRUE` (case-insensitive) to merge the region after deleting all of its HFiles.
{: .paramDefnFirst}

</div>
## Usage

Before invoking `SYSCS_UTIL.DELETE_REGION(),`:
* Check region boundaries of the base table and indexes using the  [`SYSCS_UTIL.GET_REGIONS`](sqlref_sysprocs_getregions.html) procedure
* Identify the set of regions from their indexes and tables, and make sure the index regions contains indexes to base table regions.

This procedure is intended for use only by expert database administrators. Use of this procedure requires extreme caution and is intended: you can easily create data inconsistencies.
{: noteImportant}

## Configuration Parameters

There are several configuration options that you need to be aware of when using `SYSCS_UTIL.DELETE_REGION`:

* The `hbase.hbck.close.timeout` value specifies the amount of time to wait for a region to close. The default value is 2 minutes.
* The `hbase.hbck.assign.timeout` value specifies the amount of time to wait for a region to be assigned. The default value is 2 minutes.
* We recommend setting the value of `hbase.rpc.timeout` to 20 minutes when using this procedure.

## Results

This procedure does not display a result.

## Example

Here's an example of creating a table and then deleting a table region and an index region from it.

#### Create a Table and Index, and Split Them
<div class="preWrapperWide" markdown="1">
    splice> create table t(a int, b int, c int, primary key(a,b));
    0 rows inserted/updated/deleted
    splice> create index ti on t(a);
    0 rows inserted/updated/deleted
    splice> insert into t values (1,1,1), (2,2,2), (4,4,4),(5,5,5);
    4 rows inserted/updated/deleted
    splice> call syscs_util.syscs_split_table_or_index_at_points('SPLICE','T',null,'\x83');
    Statement executed.
    splice> call syscs_util.syscs_split_table_or_index_at_points('SPLICE','T','TI','\x83');
    Statement executed.
{: .Example xml:space="preserve"}
</div>


#### Display region information for base table and index
<div class="preWrapperWide" markdown="1">
    splice> call syscs_util.get_regions('SPLICE', 'T', 'TI',null,null,null,null,null,null,null);
    ENCODED_REGION_NAME              |SPLICE_START_KEY |SPLICE_END_KEY |HBASE_START_KEY |HBASE_END_KEY |NUM_HFILES |SIZE |LAST_MODIFICATION_TIME |REGION_NAME
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    02953478d84fcb1a7bb44f3eba0c9036 |{ NULL }         |{ 3 }          |                |\x83          |1          |1073 |2017-12-12 11:12:34.0  |splice:1809,,1513105953325.02953478d84fcb1a7bb44f3eba0c9036.
    1c1ee3dd90817576ef1148d91666defa |{ 3 }            |{ NULL }       |\x83            |              |1          |1073 |2017-12-12 11:12:34.0  |splice:1809,\x83,1513105953325.1c1ee3dd90817576ef1148d91666defa.

    2 rows selected
    splice> call syscs_util.get_regions('SPLICE', 'T', null,null,null,null,null,null,null,null);
    ENCODED_REGION_NAME              |SPLICE_START_KEY |SPLICE_END_KEY |HBASE_START_KEY |HBASE_END_KEY |NUM_HFILES |SIZE |LAST_MODIFICATION_TIME |REGION_NAME
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    19c21ae5b0b2767403a8beff3148b646 |{ NULL, NULL}    |{ 3, NULL }    |                |\x83          |1          |1045 |2017-12-12 11:12:08.0  |splice:1792,,1513105927824.19c21ae5b0b2767403a8beff3148b646.
    6c8ac07d50cc2e606562dc1949705374 |{ 3, NULL }      |{ NULL, NULL } |\x83            |              |1          |1045 |2017-12-12 11:12:08.0  |splice:1792,\x83,1513105927824.6c8ac07d50cc2e606562dc1949705374.

    2 rows selected
{: .Example xml:space="preserve"}
</div>

#### Delete one region from base table and one region from index
<div class="preWrapperWide" markdown="1">
    splice> call syscs_util.delete_region('SPLICE','T',null,'19c21ae5b0b2767403a8beff3148b646', true);
    Statement executed.
    splice> call syscs_util.delete_region('SPLICE','T','TI','02953478d84fcb1a7bb44f3eba0c9036', true);
    Statement executed.
{: .Example xml:space="preserve"}
</div>

#### Verify the results
<div class="preWrapperWide" markdown="1">
    splice> call syscs_util.get_regions('SPLICE', 'T', 'TI',null,null,null,null,null,null,null);
    ENCODED_REGION_NAME              |SPLICE_START_KEY |SPLICE_END_KEY |HBASE_START_KEY |HBASE_END_KEY |NUM_HFILES |SIZE |LAST_MODIFICATION_TIME |REGION_NAME
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    5e8d1ffdf5e8aaa4e85a851caf17a2d9 |{ NULL }         |{ NULL }       |                |              |1          |1073 |2017-12-12 11:14:15.0  |splice:1809,,1513106054547.5e8d1ffdf5e8aaa4e85a851caf17a2d9.

    1 row selected
    splice> select count(*) from t --splice-properties index=null
    > ;
    1
    --------------------
    2

    1 row selected
    splice> select count(*) from t --splice-properties index=ti
    > ;
    1
    --------------------
    2

    1 row selected
{: .Example xml:space="preserve"}
</div>

## See Also

* [`SYSCS_UTIL.GET_START_KEY`](sqlref_sysprocs_getstartkey.html)
* [`SYSCS_UTIL.GET_REGIONS`](sqlref_sysprocs_getregions.html)
* [`SYSCS_UTIL.MERGE_REGIONS`](sqlref_sysprocs_mergeregions.html)

</div>
</section>
