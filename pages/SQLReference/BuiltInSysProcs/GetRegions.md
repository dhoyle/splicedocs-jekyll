---
title: SYSCS_UTIL.GET_REGIONS built-in system procedure
summary: Built-in system procedure that retrieves the list of regions containing a range of key values.
keywords: region compaction, compact region, minor compaction, COMPACT_REGION
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_getregions.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.GET_REGIONS

The `SYSCS_UTIL.GET_REGIONS` system procedure that retrieves the list of
regions containing a range of key values.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.GET_REGIONS( VARCHAR schemaName,
                            VARCHAR tableName,
                            VARCHAR indexName,
                            VARCHAR startKey,
                            VARCHAR endKey,
                            VARCHAR columnDelimiter,
                            VARCHAR characterDelimiter,
                            VARCHAR timestampFormat,
                            VARCHAR dateFormat,
                            VARCHAR timeFormat )
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

startKey
{: .paramName}

For a table, this is a comma-separated-value (CSV) representation of the
primary key value for the start of the regions in which you are
interested. For an index, this is the CSV representation of the index
columns. Specify `NULL` to indicate all regions.
{: .paramDefnFirst}

endKey
{: .paramName}

For a table, this is a comma-separated-value (CSV) representation of the
primary key value for the end of the regions in which you are
interested. For an index, this is the CSV representation of the index
columns.  Specify `NULL` to indicate all regions.
{: .paramDefnFirst}

columnDelimiter
{: .paramName}

The character used to separate columns in `startKey`. Specify `null` if
using the comma (`,`) character as your delimiter.
{: .paramDefnFirst}

characterDelimiter
{: .paramName}

Specifies which character is used to delimit strings in `startKey`. You
can specify `null` or the empty string to use the default string
delimiter, which is the double-quote (`"`).
{: .paramDefnFirst}

If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.
{: .paramDefn}

To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
{: .paramDefn}

The [Examples](#Examples) section below contains an example that uses
the single quote as the string delimiter character.
{: .noteNote}

timestampFormat
{: .paramName}

The format of timestamps in `startKey`. You can set this to `null` if
there are no time columns in the split key, or if the format of any
timestamps in the file match the `Java.sql.Timestamp` default format,
which is: "*yyyy-MM-dd HH:mm:ss*".
{: .paramDefnFirst}

See the [About Timestamp Formats](#TimestampFormats) section in the
[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) topic for
more information about timestamps.
{: .notePlain}

dateFormat
{: .paramName}

The format of datestamps in `startKey`. You can set this to `null` if
there are no date columns in the startKey, or if the format of any dates
in the split key match this pattern: "*yyyy-MM-dd*".
{: .paramDefnFirst}

timeFormat
{: .paramName}

The format of time values stored in `startKey`. You can set this to
`null` if there are no time columns in the file, or if the format of any
times in the split key match this pattern: "*HH:mm:ss*".
{: .paramDefnFirst}

</div>
## Usage

Specify the starting and ending key values, this procedure returns
information about all regions that span those key values.

## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_REGIONS` include
these values:

<table summary=" summary=&quot;Columns in Get_Regions results display&quot;">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>ENCODED_REGION_NAME</code></td>
                        <td>The HBase-encoded name of the region.</td>
                    </tr>
                    <tr>
                        <td><code>SPLICE_START_KEY</code></td>
                        <td>The unencoded start key, in CSV format, for the list of regions in which you are interested. This is the value you supplied in the <code>startKey</code> parameter. For example: <code>{1,2}</code>.</td>
                    </tr>
                    <tr>
                        <td><code>SPLICE_END_KEY</code></td>
                        <td>The unencoded end key for the region, in CSV format, for the list of regions in which you are interested.  This is the value you supplied in the <code>endKey</code> parameter. For example: <code>{1,6}</code>.</td>
                    </tr>
                    <tr>
                        <td><code>HBASE_START_KEY</code></td>
                        <td>The start key for the region, formatted as shown in the HBase Web UI. For example: <code>\x81\x00\x82</code>.</td>
                    </tr>
                    <tr>
                        <td><code>HBASE_END_KEY</code></td>
                        <td>The end key for the region, formatted as shown in the HBase Web UI. For example: <code>\x81\x00\x86</code>.</td>
                    </tr>
                    <tr>
                        <td><code>NUM_HFILES</code></td>
                        <td>The number of HBase Files contained in the region.</td>
                    </tr>
                    <tr>
                        <td><code>SIZE</code></td>
                        <td>The size, in bytes, of the region.</td>
                    </tr>
                    <tr>
                        <td><code>LAST_MODIFICATION_TIME</code></td>
                        <td>The most recent time at which the region was modified.</td>
                    </tr>
                    <tr>
                        <td><code>REGION_NAME</code></td>
                        <td>The unencoded name of the region.</td>
                    </tr>
                </tbody>
            </table>
## Example

The following call returns information about the regions that are in the
key range `{1,2}` to `{1,8}`:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_REGIONS( 'SPLICE','TestTable', null,
                             '1|2', '1|8', '|',null,null,null,null);
    ENCODED_REGION_NAME              |SPLICE_START_KEY |SPLICE_END_KEY |HBASE_START_KEY |HBASE_END_KEY |NUM_HFILES |SIZE  |LAST_MODIFICATION_TIME |REGION_NAME
    -----------------------------------------------------------------
    132c824b9e269006a8e0a3fad577bd12 |{ 1, 2}          |{ 1, 6}        |\x81\x00\x82    |\x81\x00\x86  |1          |1645  |2017-08-17 12:44:15.0  |splice:2944,\x81\x00\x82,1502999053574.132c824b9e269006a8e0a3fad577bd12.
    2ee995a552cbb75b7172eed27b917cab |{ 1, 6 }         |{ 1, 8 }       |\x81\x00\x86    |\x81\x00\x88  |1          |1192  |2017-08-17 08:37:56.0  |splice:2944,\x81\x00\x86,1502984266749.2ee995a552cbb75b7172eed27b917cab.

    2 rows selected
{: .Example xml:space="preserve"}

</div>

To list information about all regions instead, use `NULL` for the `startKey` and `endKey` values:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_REGIONS( 'SPLICE','TestTable', null,
                             null, null, '|',null,null,null,null);
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.COMPACT_REGION`](sqlref_sysprocs_compactregion.html)
* [`SYSCS_UTIL.GET_ENCODED_REGION_NAME`](sqlref_sysprocs_getencodedregion.html)
* [`SYSCS_UTIL.GET_START_KEY`](sqlref_sysprocs_getstartkey.html)
* [`SYSCS_UTIL.MAJOR_COMPACT_REGION`](sqlref_sysprocs_majorcompactregion.html)
* [`SYSCS_UTIL.MERGE_REGIONS`](sqlref_sysprocs_mergeregions.html)

</div>
</section>
