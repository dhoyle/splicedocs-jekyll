---
title: "Importing Data: Parameter Usage"
summary: Detailed specifications of the parameter values used in Splice Machine data ingestion.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importparams.html
folder: DeveloperTutorials/Import
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Specifying the Import Parameter Values

This topic first shows you the syntax of each of the four import procedures, and then provides detailed information about the input parameters you need to specify when calling one of the Splice Machine data ingestion procedures.

## Import Procedures Syntax {#Syntax}

Three of our four data import procedures use identical parameters:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA (
    SYSCS_UTIL.UPSERT_DATA_FROM_FILE (
    SYSCS_UTIL.MERGE_DATA_FROM_FILE (
        schemaName,
        tableName,
        insertColumnList | null,
        fileOrDirectoryName,
        columnDelimiter | null,
        characterDelimiter | null,
        timestampFormat | null,
        dateFormat | null,
        timeFormat | null,
        badRecordsAllowed,
        badRecordDirectory | null,
        oneLineRecords | null,
        charset | null
      );
{: .FcnSyntax xml:space="preserve"}

</div>

The fourth procedure, `SYSCS_UTIL.BULK_IMPORT_HFILE`, adds a couple extra parameters at the end:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.BULK_IMPORT_HFILE
      ( schemaName,
        tableName,
        insertColumnList | null,
        fileName,
        columnDelimiter | null,
        characterDelimiter | null,
        timestampFormat | null,
        dateFormat | null,
        timeFormat | null,
        maxBadRecords,
        badRecordDirectory | null,
        oneLineRecords | null,
        charset | null,
        bulkImportDirectory,
        skipSampling
      );
{: .FcnSyntax xml:space="preserve"}

</div>

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
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#schemaName">schemaName</a></td>
            <td>The name of the schema of the table into which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#tableName">tableName</a></td>
            <td>The name of the table into which to import.</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Data Location</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#insertColumnList">insertColumnList</a></td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#fileOrDirectoryName">fileOrDirectoryName</a></td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p class="notePlain">The <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code> procedure only works with single files; <strong>you cannot specify a directory name</strong> when calling <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code>.</p>
            <p>On a cluster, the files to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
            <p>See the <a href="tutorials_ingest_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> topic for information about accessing data on S3.</p>
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
        </tr>
        <tr>
            <td rowspan="7" class="BoldFont">Data Formats</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#oneLineRecords">oneLineRecords</a></td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.
            </td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#charset">charset</a></td>
            <td>The character encoding of the import file. The default value is UTF-8.
            </td>
            <td class="CodeFont">null</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#columnDelimiter">columnDelimiter</a></td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|', '\t'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#characterDelimiter">characterDelimiter</a></td>
            <td>The character used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">'"', ''''</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#timestampFormat">timestampFormat</a></td>
            <td><p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
            <p class="noteIcon">All of the timestamps in the file you are importing must use the same format.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#dateFormat">dateFormat</a></td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#timeFormat">timeFormat</a></td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Problem Logging</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#badRecordsAllowed">badRecordsAllowed</a></td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#badRecordDirectory">badRecordDirectory</a></td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Bulk HFile Import</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#bulkImportDirectory">bulkImportDirectory</a></td>
            <td>For <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code>, this is the name of the  directory into which the generated HFiles are written prior to being imported into your database.</td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#skipSampling">skipSampling</a></td>
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

See [*Importing and Updating Records*](tutorials_ingest_importinput.html#Updating) for additional information about handling of missing, generated, and default values during data importation.
{: .notePlain}

### `fileOrDirectoryName` {#fileOrDirectoryName}

The `fileOrDirectoryName` (or `fileName`) parameter is a string that specifies the location of the data that you're importing. This parameter is slightly different for different procedures:

* For the `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` or
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedures, this is either a single
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

See [*Specifying Your Input Data Location*](tutorials_ingest_importinput.html#Location) for additional information about specifying your input data location.
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

See [*Time and Date Formats in Input Records*](tutorials_ingest_importinput.html#DateFormats) for additional information about date, time, and timestamp values.
{: .notePlain}

### `dateFormat` {#dateFormat}

The `dateFormat` parameter specifies the format of datestamps stored in the file. You can set this to `null` if either:

* there are no date columns in the file
* the format of any dates in the input match this pattern: \"*yyyy-MM-dd*\".

**Example:** <span class="Example">`yyyy-MM-dd`</span>

See [*Time and Date Formats in Input Records*](tutorials_ingest_importinput.html#DateFormats) for additional information about date, time, and timestamp values.
{: .notePlain}

### `timeFormat` {#timeFormat}

The `timeFormat` parameter specifies the format of time values in your input data. You can set this to null if either:

* there are no time columns in the file
* the format of any times in the input match this pattern: \"*HH:mm:ss*\".

**Example:** <span class="Example">`HH:mm:ss`</span>

See [*Time and Date Formats in Input Records*](tutorials_ingest_importinput.html#DateFormats) for additional information about date, time, and timestamp values.
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

Please review the [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic to understand how importing bulk HFiles works.

### `skipSampling` {#skipSampling}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `skipSampling` parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed:

* If `skipSampling` is `true`, you need to use our &nbsp;&nbsp;[SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html) system procedure to compute splits for your table before calling `SYSCS_UTIL.BULK_IMPORT_HFILE`. This allows you more control over the splits, but adds a layer of complexity. You can learn about computing splits for your input data in the [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic of this tutorial.

* If `skipSampling` is `false`, then `SYSCS_UTIL.BULK_IMPORT_HFILE`
samples your input data and computes the table splits for you, in the following steps. It:

    1. Scans (sample) the data
    2. Collects a rowkey histogram
    3. Uses that histogram to calculate the split key for the table
    4. Uses the calculated split key to split the table into HFiles

**Example:** <span class="Example">`false`</span>

Please review the [Bulk HFile Import Walkthrough](tutorials_ingest_importexampleshfile.html) topic to understand how importing bulk HFiles works.

## See Also

*  [Importing Data: Tutorial Overview](tutorials_ingest_importoverview.html)
*  [Importing Data: Input Data Handling](tutorials_ingest_importinput.html)
*  [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html)
*  [Importing Data: Error Handling](tutorials_ingest_importerrors.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

</div>
</section>
