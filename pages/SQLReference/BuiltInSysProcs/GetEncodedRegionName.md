---
title: SYSCS_UTIL.GET_ENCODED_REGION_NAME built-in system procedure
summary: Built-in system procedure that returns the encoded name of the HBase region that contains the Splice Machine table primary key or index values specified in unencodedKey.
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getencodedregion.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.GET_ENCODED_REGION_NAME

The `SYSCS_UTIL.GET_ENCODED_REGION_NAME` system procedure returns the
encoded name of the HBase region that contains the Splice Machine table
primary key or index values for the `unencodedKey` value that you
specify.

You can call this procedure to retrieve an encoded HBase region name
prior to calling the `SYSCS_UTIL.MAJOR_COMPACT_REGION`,
`SYSCS_UTIL.COMPACT_REGION`, or `SYSCS_UTIL.MERGE_REGIONS` procedures.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.GET_ENCODED_REGION_NAME( VARCHAR schemaName,
                                        VARCHAR tableName,
                                        VARCHAR indexName,
                                        VARCHAR unencodedKey,
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

Specify `NULL` to indicate that the `unencodedKey` is the primary key of
the base table; specify an index name to indicate that the `
unencodedKey` is an index value.
{: .paramDefn}

unencodedKey
{: .paramName}

For a table, this is a comma-separated-value (CSV) representation of the
table's primary key (unencoded). For an index, this is the CSV
representation of the index columns, also unencoded.
{: .paramDefnFirst}

columnDelimiter
{: .paramName}

The character used to separate columns in `unencodedKey`. Specify `null`
if using the comma (`,`) character as your delimiter.
{: .paramDefnFirst}

characterDelimiter
{: .paramName}

Specifies which character is used to delimit strings in `unencodedKey`.
You can specify `null` or the empty string to use the default string
delimiter, which is the double-quote (`"`).
{: .paramDefnFirst}

If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.
{: .paramDefnFirst}

To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
{: .paramDefnFirst}

The [Examples](#Examples) section below contains an example that uses
the single quote as the string delimiter character.
{: .noteNote}

timestampFormat
{: .paramName}

The format of timestamps in `unencodedKey`. You can set this to `null`
if there are no time columns in the split key, or if the format of any
timestamps in the file match the `Java.sql.Timestamp` default format,
which is: "*yyyy-MM-dd HH:mm:ss*".
{: .paramDefnFirst}

See the [About Timestamp Formats](#TimestampFormats) section in the
[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) topic for
more information about timestamps.
{: .notePlain}

dateFormat
{: .paramName}

The format of datestamps in `unencodedKey`. You can set this to `null`
if there are no date columns in the unencodedKey, or if the format of
any dates in the split key match this pattern: "*yyyy-MM-dd*".
{: .paramDefnFirst}

timeFormat
{: .paramName}

The format of time values stored in `unencodedKey`. You can set this to
`null` if there are no time columns in the file, or if the format of any
times in the split key match this pattern: "*HH:mm:ss*".
{: .paramDefnFirst}

</div>
## Usage

Use this procedure to retrieve the HBase-encoded name of a table or
index region in your database. These system procedures required encoded
region names as parameter values:

* [`SYSCS_UTIL.COMPACT_REGION`](sqlref_sysprocs_compactregion.html)
* [`SYSCS_UTIL.MAJOR_COMPACT_REGION`](sqlref_sysprocs_majorcompactregion.html)
* [`SYSCS_UTIL.MERGE_REGIONS`](sqlref_sysprocs_mergeregions.html)

## Results

The displayed results of calling
`SYSCS_UTIL.SYSCS_GET_ENCODED_REGION_NAME` include these values:

<table summary=" summary=&quot;Columns in Get_Encoded_Region_Name results display&quot;">
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
                        <td><code>START_KEY</code></td>
                        <td>The HBase starting key for the region.</td>
                    </tr>
                    <tr>
                        <td><code>END_KEY</code></td>
                        <td>The HBase ending key for the region.</td>
                    </tr>
                </tbody>
            </table>
## Examples

The following call will retrieve the encoded region name for `TESTTABLE`
for a table row that has key value `1|2`:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_ENCODED_REGION_NAME(
                    'SPLICE', 'TESTTABLE', null, '1|2', '|', null, null, null, null););
    ENCODED_REGION_NAME                     |START_KEY      |END_KEY
    -----------------------------------------------------------------------
    8ffc80e3f8ac3b180441371319ea90e2        |\x81\x00\x82   |\x81\x00\x84

    1 row selected
{: .Example xml:space="preserve"}

</div>
This call will retrieve the encoded region name for `TESTTABLE` for a
region that contains index value `1996-04-12,155190,21168.23,0.04`:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.GET_ENCODED_REGION_NAME(
                    'SPLICE', 'TESTTABLE', 'SHIP_INDEX','1996-04-12|155190|21168.23|0.04',
                    '|', null, null, null, null);
    ENCODED_REGION_NAME              |START_KEY                                         |END_KEY
    --------------------------------------------------------------------------------------------
    ff8f9e54519a31e15f264ba6d2b828a4 |\xEC\xC1\x15\xAD\xCD\x80\x00\xE1\x06\xEE\x00\xE4V&|

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.COMPACT_REGION`](sqlref_sysprocs_compactregion.html)
* [`SYSCS_UTIL.GET_START_KEY`](sqlref_sysprocs_getstartkey.html)
* [`SYSCS_UTIL.GET_REGIONS`](sqlref_sysprocs_getregions.html)
* [`SYSCS_UTIL.MAJOR_COMPACT_REGION`](sqlref_sysprocs_majorcompactregion.html)
* [`SYSCS_UTIL.MERGE_REGIONS`](sqlref_sysprocs_mergeregions.html)

</div>
</section>
