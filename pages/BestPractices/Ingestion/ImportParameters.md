---
title: "Data Ingestion Parameter Values"
summary: Detailed specifications of the parameter values used in Splice Machine data ingestion.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_params.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Data Ingestion Parameter Values

This topic starts with a summary of the parameters used by the Splice Machine data ingestion procedures, and then provides additional details for each parameter.

## Overview of Parameters Used in Import Procedures

All of the Splice Machine data import procedures share a number of parameters that describe the table into which you're importing data, a number of input data format details, and how to handle problematic records.

The following table summarizes these parameters. Each parameter name links to its reference description, found below the table:

<table>
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Category</th>
            <th>Parameter</th>
            <th>Description</th>
            <th>Example Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2" class="BoldFont">Table Info</td>
            <td class="CodeFont"><a href="#schemaName">schemaName</a></td>
            <td>The name of the schema of the table into which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#tableName">tableName</a></td>
            <td>The name of the table into which to import.</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Data Location</td>
            <td class="CodeFont"><a href="#insertColumnList">insertColumnList</a></td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#fileOrDirectoryName">fileOrDirectoryName</a></td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p class="notePlain">The <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code> procedure only works with single files; <strong>you cannot specify a directory name</strong> when calling <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code>.</p>
            <p>On a cluster, the files to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
            <p>See the <a href="developers_cloudconnect_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> topic for information about accessing data on S3.</p>
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
        </tr>
        <tr>
            <td rowspan="7" class="BoldFont">Data Formats</td>
            <td class="CodeFont"><a href="#oneLineRecords">oneLineRecords</a></td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.
            </td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#charset">charset</a></td>
            <td>The character encoding of the import file. The default value is UTF-8.
            </td>
            <td class="CodeFont">null</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#columnDelimiter">columnDelimiter</a></td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|', '\t'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#characterDelimiter">characterDelimiter</a></td>
            <td>The character used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">'"', ''''</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#timestampFormat">timestampFormat</a></td>
            <td><p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
            <p class="noteIcon">All of the timestamps in the file you are importing must use the same format.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#dateFormat">dateFormat</a></td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#timeFormat">timeFormat</a></td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Problem Logging</td>
            <td class="CodeFont"><a href="#badRecordsAllowed">badRecordsAllowed</a></td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#badRecordDirectory">badRecordDirectory</a></td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Bulk HFile Import</td>
            <td class="CodeFont"><a href="#bulkImportDirectory">bulkImportDirectory</a></td>
            <td>For <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code>, this is the name of the  directory into which the generated HFiles are written prior to being imported into your database.</td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#skipSampling">skipSampling</a></td>
            <td><p>The <code>skipSampling</code> parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed. Set to <code>false</code> to have <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> automatically determine splits for you.</p>
            <p>This parameter is only used with the <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> system procedure.</p>
            </td>
            <td class="CodeFont">false</td>
        </tr>
    </tbody>
</table>

## Import Parameters Reference

This section provides reference documentation for all of the data importation parameters.

### `schemaName` {#schemaName}

The `schemaName` is a string that specifies the name of the schema of the table into which you are importing data.

**Example:** <span class="Example">`SPLICE`</span>

### `tableName` {#tableName}

The `tableName` is a string that specifies the name of the table into which you are importing data.

**Example:** <span class="Example">`playerTeams`</span>

### `insertColumnList` {#insertColumnList}

The `insertColumnList` parameter is a string that specifies the names, in single quotes, of the columns you wish to import. If this is `null`, all columns are imported.

* If you don\'t specify an `insertColumnList` and your input file contains
more columns than are in the table, then the the extra columns at the
end of each line in the input file **are ignored**. For example, if your
table contains columns `(a, b, c)` and your file contains columns `(a,
b, c, d, e)`, then the data in your file\'s `d` and `e` columns will be
ignored.
{: indentLevel1}

* If you do specify an `insertColumnList`, and the number of columns
doesn\'t match your table, then any other columns in your table will be
replaced by the default value for the table column (or `NULL` if there
is no default for the column). For example, if your table contains
columns `(a, b, c)` and you only want to import columns `(a, c)`, then
the data in table\'s `b` column will be replaced with the default value
for that column.
{: indentLevel1}

**Example:** <span class="Example">`ID, TEAM`</span>

See [*Importing and Updating Records*](#ImportColVals) below for additional information about handling of missing, generated, and default values during data importation.
{: .notePlain}

### `fileOrDirectoryName` {#fileOrDirectoryName}

The `fileOrDirectoryName` (or `fileName`) parameter is a string that specifies the location of the data that you're importing. This parameter is slightly different for different procedures:

* For the `SYSCS_UTIL.IMPORT_DATA` procedure, this is either a single
file or a directory. If this is a single file, that file is imported; if
this is a directory, all of the files in that directory are imported.

* For the `SYSCS_UTIL.MERGE_DATA_FROM_FILE` and `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure, this can only be a single file (directories are not allowed).

<div class="noteNote" markdown="1">
On a cluster, the files to be imported **MUST be on S3, HDFS (or
MapR-FS)**, as must the `badRecordDirectory` directory. If you're using
our Database Service product, files can only be imported from S3. The files must also be readable by the `hbase` user.
</div>

**Example:** <span class="Example">`data/mydata/mytable.csv`</span>

#### Importing from S3

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information.

**Example:** <span class="Example">`s3a://splice-benchmark-data/flat/TPCH/100/region`</span>

See [*Specifying Your Input Data Location*](#InputLocation) below for additional information about specifying your input data location.
{: .notePlain}

#### Importing Compressed Files

Note that files can be compressed or uncompressed, including BZIP2
compressed files.

<div class="notePlain" markdown="1">
Importing multiple files at once improves parallelism, and thus speeds
up the import process. Uncompressed files can be imported faster than
compressed files. When using compressed files, the compression algorithm
makes a difference; for example,

* `gzip`-compressed files cannot be split during importation, which
  means that import work on such files cannot be performed in parallel.
* In contrast, `bzip2`-compressed files can be split and thus can be
  imported using parallel tasks. Note that `bzip2` is CPU intensive
  compared to `LZ4` or `LZ0`, but is faster than gzip because files can
  be split.
</div>

### `oneLineRecords` {#oneLineRecords}

The `oneLineRecords` parameter is a Boolean value that specifies whether each line in the import file contains one complete record:

* If you specify `true` or `null`, then each record is expected to be
  found on a single line in the file.
* If you specify `false`, records can span multiple lines in the file.

Multi-line record files are slower to load, because the file cannot be
split and processed in parallel; if you import a directory of multiple
line files, each file as a whole is processed in parallel, but no
splitting takes place.

**Example:** <span class="Example">`true`</span>

### `charset` {#charset}

The `charset` parameter is a string that specifies the character encoding of the import file. The default value is `UTF-8`.

Currently, any value other than `UTF-8` is ignored, and `UTF-8` is used.
{: .noteNote}

**Example:** <span class="Example">`null`</span>

### `columnDelimiter` {#columnDelimiter}

The `columnDelimiter` parameter is a string that specifies the character used to separate columns, You can specify `null` if using the comma (`,`) character as your delimiter.

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as character delimiters in imported files.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Special character</th>
            <th>Display</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>'\t'</code></td>
            <td>Tab </td>
        </tr>
        <tr>
            <td><code>'\f'</code></td>
            <td>Formfeed</td>
        </tr>
        <tr>
            <td><code>'\b'</code></td>
            <td>Backspace</td>
        </tr>
        <tr>
            <td><code>'\\'</code></td>
            <td>Backslash</td>
        </tr>
        <tr>
            <td><code>'^a'</code><br />(or <code>'^A'</code>)</td>
            <td>
                <p>Control-a</p>
                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
            </td>
        </tr>
        <tr>
            <td><code>''''</code></td>
            <td>Single Quote (<code>'</code>)</td>
        </tr>
    </tbody>
</table>
<div class="indented" markdown="1">

#### Notes:
* To use the single quote (`'`) character as your column delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
</div>

**Example:** <span class="Example">`'|'`</span>

### `characterDelimiter` {#characterDelimiter}

The `characterDelimiter` parameter is a string that specifies which character is used to delimit strings in the imported data. You can specify `null` or the empty string to use the default string delimiter, which is the double-quote (`"`).

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as character delimiters in imported files.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Special character</th>
            <th>Display</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>'\t'</code></td>
            <td>Tab </td>
        </tr>
        <tr>
            <td><code>'\f'</code></td>
            <td>Formfeed</td>
        </tr>
        <tr>
            <td><code>'\b'</code></td>
            <td>Backspace</td>
        </tr>
        <tr>
            <td><code>'\\'</code></td>
            <td>Backslash</td>
        </tr>
        <tr>
            <td><code>'^a'</code><br />(or <code>'^A'</code>)</td>
            <td>
                <p>Control-a</p>
                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
            </td>
        </tr>
        <tr>
            <td><code>''''</code></td>
            <td>Single Quote (<code>'</code>)</td>
        </tr>
    </tbody>
</table>

<div class="indented" markdown="1">

#### Notes:
* If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.

* To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
</div>

**Example:** <span class="Example">`'"'`</span>

### `timestampFormat` {#timestampFormat}

The `timestampFormat` parameter specifies the format of timestamps in your input data. You can set this to `null` if either:

* there are no time columns in the file
* all time stamps in the input match the `Java.sql.Timestamp` default format,
which is: \"*yyyy-MM-dd HH:mm:ss*\".

All of the timestamps in the file you are importing must use the same
format.
{: .noteIcon}

Splice Machine uses the following Java date and time pattern letters to
construct timestamps:

<table summary="Timestamp format pattern letter descriptions">
    <col />
    <col />
    <col style="width: 330px;" />
    <thead>
        <tr>
            <th>Pattern Letter</th>
            <th>Description</th>
            <th>Format(s)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>y</code></td>
            <td>year</td>
            <td><code>yy or yyyy</code></td>
        </tr>
        <tr>
            <td><code>M</code></td>
            <td>month</td>
            <td><code>MM</code></td>
        </tr>
        <tr>
            <td><code>d</code></td>
            <td>day in month</td>
            <td><code>dd</code></td>
        </tr>
        <tr>
            <td><code>h</code></td>
            <td>hour (0-12)</td>
            <td><code>hh</code></td>
        </tr>
        <tr>
            <td><code>H</code></td>
            <td>hour (0-23)</td>
            <td><code>HH</code></td>
        </tr>
        <tr>
            <td><code>m</code></td>
            <td>minute in hour</td>
            <td><code>mm</code></td>
        </tr>
        <tr>
            <td><code>s</code></td>
            <td>seconds</td>
            <td><code>ss</code></td>
        </tr>
        <tr>
            <td><code>S</code></td>
            <td>tenths of seconds</td>
            <td class="CodeFont">
                <p>S, SS, SSS, SSSS, SSSSS or SSSSSS<span class="important">*</span></p>
                <p><span class="important">*</span><span class="bodyFont">Specify </span>SSSSSS <span class="bodyFont">to allow a variable number (any number) of digits after the decimal point.</span></p>
            </td>
        </tr>
        <tr>
            <td><code>z</code></td>
            <td>time zone text</td>
            <td><code>e.g. Pacific Standard time</code></td>
        </tr>
        <tr>
            <td><code>Z</code></td>
            <td>time zone, time offset</td>
            <td><code>e.g. -0800</code></td>
        </tr>
    </tbody>
</table>

The default timestamp format for Splice Machine imports is: `yyyy-MM-dd
HH:mm:ss`, which uses a 24-hour clock, does not allow for decimal digits
of seconds, and does not allow for time zone specification.

The standard Java library does not support microsecond precision, so you
**cannot** specify millisecond (`S`) values in a custom timestamp format
and import such values with the desired precision.
{: .noteNote}

#### Converting Out-of-Range Timestamp Values Upon Import

{% include splice_snippets/importtimestampfix.md %}

#### Timestamps and Importing Data at Different Locations {#TSConvert}

Note that timestamp values are relative to the geographic location at
which they are imported, or more specifically, relative to the timezone
setting and daylight saving time status where the data is imported.

This means that timestamp values from the same data file may appear
differently after being imported in different timezones.

#### Examples

The following tables shows valid examples of timestamps and their
corresponding format (parsing) patterns:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Timestamp value</th>
            <th>Format Pattern</th>
            <th>Notes</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>2013-03-23 09:45:00</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss</code></td>
            <td>This is the default pattern.</td>
        </tr>
        <tr>
            <td><code>2013-03-23 19:45:00.98-05</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSZ</code></td>
            <td>This pattern allows up to 2 decimal digits of seconds, and requires a time zone specification.</td>
        </tr>
        <tr>
            <td><code>2013-03-23 09:45:00-07</code></td>
            <td><code>yyyy-MM-dd HH:mm:ssZ</code></td>
            <td>This patterns requires a time zone specification, but does not allow for decimal digits of seconds.</td>
        </tr>
        <tr>
            <td><code>2013-03-23 19:45:00.98-0530</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSZ</code></td>
            <td>This pattern allows up to 2 decimal digits of seconds, and requires a time zone specification.</td>
        </tr>
        <tr>
            <td class="CodeFont">
                <p>2013-03-23 19:45:00.123</p>
                <p>2013-03-23 19:45:00.12</p>
            </td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSS</code></td>
            <td>
                <p>This pattern allows up to 3 decimal digits of seconds, but does not allow a time zone specification.</p>
                <p>Note that if your data specifies more than 3 decimal digits of seconds, an error occurs.</p>
            </td>
        </tr>
        <tr>
            <td><code>2013-03-23 19:45:00.1298</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSSS</code></td>
            <td>This pattern allows up to 4 decimal digits of seconds, but does not allow a time zone specification.</td>
        </tr>
    </tbody>
</table>

See [*Time and Date Formats in Input Records*](#InputDateFormats) below for additional information about date, time, and timestamp values.
{: .notePlain}

### `dateFormat` {#dateFormat}

The `dateFormat` parameter specifies the format of datestamps stored in the file. You can set this to `null` if either:

* there are no date columns in the file
* the format of any dates in the input match this pattern: \"*yyyy-MM-dd*\".

**Example:** <span class="Example">`yyyy-MM-dd`</span>

See [*Time and Date Formats in Input Records*](#InputDateFormats) below for additional information about date, time, and timestamp values.
{: .notePlain}

### `timeFormat` {#timeFormat}

The `timeFormat` parameter specifies the format of time values in your input data. You can set this to null if either:

* there are no time columns in the file
* the format of any times in the input match this pattern: \"*HH:mm:ss*\".

**Example:** <span class="Example">`HH:mm:ss`</span>

See [*Time and Date Formats in Input Records*](#InputDateFormats) below for additional information about date, time, and timestamp values.
{: .notePlain}

### `badRecordsAllowed` {#badRecordsAllowed}

The `badRecordsAllowed` parameter is integer value that specifies the number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back.

These values have special meaning:

* If you specify `-1` as the value of this parameter, all record import
  failures are tolerated and logged.
* If you specify `0` as the value of this parameter, the import will
  fail if even one record is bad.

**Example:** <span class="Example">`25`</span>

### `badRecordDirectory` {#badRecordDirectory}

The `badRecordDirectory` parameter is a string that specifies the directory in which bad record information is logged. The default value is the directory in which the import files are found.

Splice Machine logs information to the `<import_file_name>.bad` file in this directory; for example, bad records in an input file named `foo.csv` would be
logged to a file named *badRecordDirectory*`/foo.csv.bad`.

The `badRecordDirectory` directory must be writable by the hbase user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
    sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

**Example:** <span class="Example">`'importErrsDir'`</span>

### `bulkImportDirectory` {#bulkImportDirectory}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `bulkImportDirectory` parameter is a string that specifies the name of the  directory into which the generated HFiles are written prior to being
imported into your database. The generated files are automatically removed after they've been imported.

**Example:** <span class="Example">`'hdfs:///tmp/test_hfile_import/'`</span>

If you're using this procedure with our On-Premise database product, on a cluster with Cloudera Key Management Service (KMS) enabled, there are a few extra configuration steps required. Please see [this troubleshooting note](bestpractices_ingestion_troubleshooting.html#BulkImportKMS) for details.
{: .noteIcon}

### `skipSampling` {#skipSampling}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `skipSampling` parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed:

* If `skipSampling` is `true`, you need to use our &nbsp;&nbsp;[SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html) system procedure to compute splits for your table before calling `SYSCS_UTIL.BULK_IMPORT_HFILE`. This allows you more control over the splits, but adds a layer of complexity. You can learn about computing splits for your input data in the [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) topic of this chapter.

* If `skipSampling` is `false`, then `SYSCS_UTIL.BULK_IMPORT_HFILE`
samples your input data and computes the table splits for you, in the following steps. It:

    1. Scans (sample) the data
    2. Collects a rowkey histogram
    3. Uses that histogram to calculate the split key for the table
    4. Uses the calculated split key to split the table

**Example:** <span class="Example">`false`</span>


## Additional Information About Ingestion Parameters

This section contains the following details about how certain parameters are used by the Splice Machine ingestion procedures:

<table>
  <col width="35%"/>
  <col />
  <thead>
    <tr>
        <th>Section</th>
        <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td><a href="#InputLocation">Specifying Your Input Data Location</a></td>
        <td>Describes how to specify the location of your input data when importing.</td>
    </tr>
    <tr>
        <td><a href="#InputFiles">Input Data File Format</a></td>
        <td>Information about input data files, including importing compressed files and multi-line records.</td>
    </tr>
    <tr>
        <td><a href="#InputDelimiters">Delimiters in Your Input Data</a></td>
        <td>Discusses the use of column and characters delimiters in your input data.</td>
    </tr>
    <tr>
        <td><a href="#InputDateFormats">Time and Date Formats in Input Records</a></td>
        <td>All about the date, time, and timestamp values in your input data.</td>
    </tr>
    <tr>
        <td><a href="#ImportColVals">Inserting and Updating Column Values When Importing Data</a></td>
        <td>Discusses importing new records and updating existing database records, handling missing values in the input data, and handling of generated and default values.</td>
    </tr>
    <tr>
        <td><a href="#LOBs">Importing CLOBs and BLOBs</a></td>
        <td>Discussion of importing CLOBs and BLOBs into your Splice Machine database.</td>
    </tr>
    <tr>
        <td><a href="#Scripting">Scripting Your Imports</a></td>
        <td>Shows you how to script your import processes.</td>
    </tr>
  </tbody>
</table>

### Specifying Your Input Data Location    {#InputLocation}

Some customers get confused by the the `fileOrDirectoryName` parameter that's used in our import procedures.
How you use this depends on whether you are importing a single file or a
directory of files, and whether you're importing data into a standalone version or cluster version of Splice Machine. This section contains these three subsections:

* [Standalone Version Input File Path](#StandalonePath)
* [HBase Input File Path](#HBasePath)
* [AWS Input File Path](#AWSPath)

#### Standalone Version Input File Path  {#StandalonePath}

If you are running a stand alone environment, the name or path will be
to a file or directory on the file system. For example:

<div class="preWrapperWide" markdown="1">
    /users/myname/mydatadir/mytable.csv
{: .Example}

</div>

#### HBase Input File Path  {#HBasePath}

If you are running this on a cluster, the path is to a file on
HDFS (or the MapR File system). For example:

<div class="preWrapperWide" markdown="1">
    /data/mydata/mytable.csv/data/myname/mydatadir
{: .Example}

</div>

#### AWS S3 Input File Path {#AWSPath}

Finally, if you're importing data from an S3 bucket, you need to supply
your AWS access and secret key codes, and you need to specify an s3a
URL. This is also true for logging bad record information to an S3 bucket
directory, as will be the case when using our Database-as-Service
product.

For information about configuring Splice Machine access on AWS, please review our [Configuring an S3 Bucket for Splice Machine Access](developers_cloudconnect_configures3.html) topic, which walks you through using your AWS dashboard to generate and apply the necessary credentials.

Once you've established your access keys, you can include them inline; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, -1, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/importLog', true, null);
{: .Example}

</div>
Alternatively, you can specify the keys once in the `core-site.xml` file
on your cluster, and then simply specify the `s3a` URL; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, 0, '/BAD', true, null);
{: .Example}

</div>
To add your access and secret access keys to the `core-site.xml` file,
define the `fs.s3a.awsAccessKeyId` and `fs.s3a.awsSecretAccessKey`
properties in that file:

<div class="preWrapperWide" markdown="1">
    <property>
       <name>fs.s3a.awsAccessKeyId</name>
       <value>access key</value>
    </property>
    <property>
       <name>fs.s3a.awsSecretAccessKey</name>
       <value>secret key</value>
    </property>
{: .Example}

</div>

### Input Data File Formats {#InputFiles}

This section contains the following information about the format of the input data files that you're importing:

* [Importing Compressed Files](#CompressedFiles)
* [Importing Multi-line Records](#Multiline)
* [Importing Large Datasets in Groups of Files](#FileGroups)

#### Importing Compressed Files {#CompressedFiles}

We recommend importing files that are either uncompressed, or have been
compressed with <span class="CodeBoldFont">bz2</span> or <span
class="CodeBoldFont">lz4</span> compression.

If you import files compressed with `gzip`, Splice Machine cannot
distribute the contents of your file across your cluster nodes to take
advantage of parallel processing, which means that import performance
will suffer significantly with `gzip` files.

#### Importing Multi-line Records {#Multiline}

If your data contains line feed characters like `CTRL-M`, you need to
set the `oneLineRecords` parameter to `false`. Splice Machine will
accommodate to the line feeds; however, the import will take longer
because Splice Machine will not be able to break the file up and
distribute it across the cluster.

To improve import performance, avoid including line feed characters in
your data and set the `oneLineRecords` parameter to `true`.
{: .notePlain}

#### Importing Large Datasets in Groups of Files {#FileGroups}

If you have a lot of data (100s of millions or billions of records), you
may be tempted to create one massive file that contains all of your
records and import that file; Splice Machine recommends against this;
instead, we urge you to manage your data in smaller files. Specifically,
we suggest that you split your data into files that are:

* approximately 40 GB
* have approximately 50 million records, depending on how wide your
  table is

If you have a lot of files, group them into multiple directories, and
import each directory individually. For example, here is a structure our
Customer Success engineers like to use:

* /data/mytable1/group1
* /data/mytable1/group2
* /data/mytable1/group3
{: .codeList}

If you are importing a lot of data, our [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) bulk import procedure greatly improves data loading performance by splitting the data into HFiles, doing the import, and then deleting the HFiles. You can have `SYSCS_UTIL.BULK_IMPORT_HFILE` use sampling to determine the keys to use for splitting your data by, or you can use the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) procedure to compute the splits, and then call the bulk import procedure. For more information, see the [Best Practices: Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) topic in this chapter.

### Delimiters in Your Input Data {#InputDelimiters}

This section discusses the delimiters that you use in your input data, in these subsections:

* [Using Special Characters for Delimiters](#DelimSpecials)
* [Column Delimiters](#DelimColumn)
* [Character Delimiters](#DelimChar)

#### Use Special Characters for Delimiters {#DelimSpecials}

One common gotcha we see with customer imports is when the data you're
importing includes a special character that you've designated as a
column or character delimiter. You'll end up with records in your bad
record directory and can spend hours trying to determine the issue, only
to discover that it's because the data includes a delimiter character.
This can happen with columns that contain data such as product
descriptions.

#### Column Delimiters {#DelimColumn}

The standard column delimiter is a comma (`,`); however, we've all
worked with string data that contains commas, and have figured out to
use a different column delimiter. Some customers use the pipe (`|`)
character, but frequently discover that it is also used in some
descriptive data in the table they're importing.

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as column delimiters in imported files.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Special character</th>
            <th>Display</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>\t</code></td>
            <td>Tab </td>
        </tr>
        <tr>
            <td><code>\f</code></td>
            <td>Formfeed</td>
        </tr>
        <tr>
            <td><code>\b</code></td>
            <td>Backspace</td>
        </tr>
        <tr>
            <td><code>\\</code></td>
            <td>Backslash</td>
        </tr>
        <tr>
            <td><code>^a (or ^A)</code></td>
            <td>
                <p>Control-a</p>
                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
            </td>
        </tr>
    </tbody>
</table>

We recommend using a control character like `CTRL-A` for your column
delimiter. This is known as the SOH character, and is represented by
0x01 in hexadecimal. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to [create a script file](#Scripting) and type the control character using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-A` for the value of the column delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^A` when you type it in vi or vim.

#### Character Delimiters {#DelimChar}

By default, the character delimiter is a double quote. This can produce
the same kind of problems that we see with using a comma for the column
delimiter: columns values that include embedded quotes or use the double
quote as the symbol for inches. You can use escape characters to include
the embedded quotes, but it's easier to use a special character for your
delimiter.

We recommend using a control character like `CTRL-A` for your column
delimiter. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to [create a script file](#Scripting) and type the control character using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-G` for the value of the character delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^G` when you type it in vi or vim.

### Time and Date Formats in Input Records {#InputDateFormats}

Perhaps the most common difficulty that customers have with importing
their data is with date, time, and timestamp values.

Splice Machine adheres to the Java `SimpleDateFormat` syntax for all
date, time, and timestamp values, `SimpleDateFormat` is described here:

<a href="https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html" target="_blank">https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html</a>
{: .indentLevel1}

Splice Machine's implementation of `SimpleDateFormat` is case-sensitive;
this means, for example, that a lowercase `h` is used to represent an
hour value between 0 and 12, whereas an uppercase `H` is used to
represent an hour between 0 and 23.

#### All Values Must Use the Same Format

Splice Machine's Import procedures only allow you to specify one format
each for the date, time, and timestamp columns in the table data you are
importing. This means that, for example, every date in the table data
must be in the same format.

<div class="notePlain" markdown="1">
All of the `Date` values in the file (or group of files) you are
importing must use the same date format.

All of the `Time` values in the file (or group of files) you are
importing must use the same time format.

All of the `Timestamp` values in the file (or group of files) you are
importing must use the same timestamp format.

</div>

#### Converting Out-of-Range Timestamp Values Upon Import  {#TSConvert}

{% include splice_snippets/importtimestampfix.md %}

#### Additional Notes About Date, Time, and Timestamp Values

A few additional notes:

* Splice Machine suggests that, if your data contains any date or
  timestamp values that are not in the format `yyyy-MM-dd HH:mm:ss`, you
  create a simple table that has just one or two columns and test
  importing the format. This is a simple way to confirm that the
  imported data is what you expect.
* Detailed information about each of these data types is found in our SQL Reference Manual:
    * [Timestamp Data Type](#sqlref_datatypes_timestamp.html)
    * [Date Data Type](#sqlref_datatypes_date.html)
    * [Time Data Type](#sqlref_datatypes_time.html)


### Inserting and Updating Column Values When Importing Data   {#ImportColVals}

This section summarizes what happens when you are importing, upserting,
or merging records into a database table, based on:

* Whether you are importing a new record or updating an existing record.
* If the column is specified in your `insertColumnList` parameter.
* If the table column is a generated value or has a default value.

The important difference in actions taken when importing data occurs
when you are updating an existing record with the UPSERT or MERGE and
your column list does not contain the name of a table column:

* For newly inserted records, the default or auto-generated value is
  always inserted, as usual.
* If you are updating an existing record in the table with `UPSERT`, the
  default auto-generated value in that record is overwritten with a new
  value.
* If you are updating an existing record in the table with `MERGE`, the
  column value is not updated.

#### Importing a New Record Into a Database Table

The following table shows the actions taken when you are importing new
records into a table in your database. These actions are the same for
the `IMPORT_DATA` and `MERGE_DATA_FROM_FILE` procedures:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <span class="CodeFont">importColumnList</span>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value inserted into table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Default value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Generated value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>NULL is inserted into table column.</td>
                </tr>
            </tbody>
        </table>

The table below shows what happens with default and generated column
values when adding new records to a table using one of our import
procedures; we use an example database table created with this
statement:

    CREATE TABLE myTable (
                    colA INT,
                    colB CHAR(12) DEFAULT 'myDefaultVal',
                    colC INT);
{: .Example}

<table summary="Detailed example of what gets imported for different input values in a new record">
            <col />
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th><span class="CodeBoldFont">insertColumnList</span>
                    </th>
                    <th>Values in import record</th>
                    <th>Values inserted into database</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,NULL,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,DEFAULT,2</code></td>
                    <td><code>[1,"DEFAULT",2]</code></td>
                    <td><code>DEFAULT</code> is imported as a literal value</td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>1,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>3,4</code></td>
                    <td><code>[3,myDefaultVal,4]</code></td>
                    <td> </td>
                </tr>
            </tbody>
        </table>

Note that the value \`DEFAULT\` in the imported file **is not
interpreted** to mean that the default value should be applied to that
column; instead:

* If the target column in your database has a string data type, such as
  `CHAR` or `VARCHAR`, the literal value `"DEFAULT"` is inserted into
  your database..
* If the target column is not a string data type, an error will occur.

#### Importing Into a Table that Contains Generated or Default Values

When you export a table with generated columns to a file, the actual
column values are exported, so importing that same file into a different
database will accurately replicate the original table values.

If you are importing previously exported records into a table with a
generated column, and you want to import some records with actual values
and apply generated or default values to other records, you need to
split your import file into two files and import each:

* Import the file containing records with non-default values with the
  column name included in the `insertColumnList`.
* Import the file containing records with default values with the column
  name excluded from the `insertColumnList`.

#### Updating a Table Record with UPSERT

The following table shows the action taken when you are using the
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedure to update an existing
record in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Table column is overwritten with default value.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Table column is overwritten with newly generated value.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>Table column is overwritten with NULL value.</td>
                </tr>
            </tbody>
        </table>

#### Updating a Table Record with MERGE

The following table shows the action taken when you are using the
`SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure to update an existing record
in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>N/A</td>
                    <td>Table column is not updated.</td>
                </tr>
            </tbody>
        </table>

### Importing CLOBs and BLOBs {#LOBs}

When importing `CLOB`s, be sure to review these tips to avoid common problems:

* Be sure that the data you’re importing *does not* includes a special character that you’ve designated as a column or character delimiter. Otherwise, you’ll end up with records in your bad record directory and can spend hours trying to determine the issue, only to discover that it’s because the data includes a delimiter character.
* If your data contains line feed characters like `CTRL-M`, you need to set the `oneLineRecords` parameter to `false` to allow Splice Machine to properly handle the data; however, the import will take longer because Splice Machine will not be able to break the file up and distribute it across the cluster. To improve import performance, avoid including line feed characters in your data and set the `oneLineRecords` parameter to `true`.

At this time, the Splice Machine import procedures do not work
with columns of type `BLOB`. You can, however, create a virtual table interface
(VTI) that reads the `BLOB`s and inserts them into your database.

### Scripting Your Imports   {#Scripting}

You can make import tasks much easier and convenient by creating *import
scripts*. An import script is simply a call to one of the import
procedures; once you've verified that it works, you can use and clone
the script and run unattended imports.

An import script is simply a file in which you store `splice>` commands
that you can execute with the `run` command. For example, here's an
example of a text file named `myimports.sql` that we can use to import
two csv files into our database:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable1',null,'/data/mytable1/data.csv',null,null,null,null,null,0,'/BAD/mytable1',null,null);call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable2',null,'/data/mytable2/data.csv',null,null,null,null,null,0,'/BAD/mytable2',null,null);
{: .Example}

</div>
To run an import script, use the `splice> run` command; for example:

<div class="preWrapper" markdown="1">
    splice> run 'myimports.sql';
{: .Example}

</div>
You can also start up the `splice>` command line interpreter with the
name of a file to run; for example:

<div class="preWrapper" markdown="1">
    sqlshell.sh -f myimports.sql
{: .Example}

</div>
In fact, you can script almost any sequence of Splice Machine commands
in a file and run that script within the command line interpreter or
when you start the interpreter.



</div>
</section>
