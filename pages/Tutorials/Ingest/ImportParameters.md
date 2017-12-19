---
title: "Importing Data: Parameter Usage"
summary: Detailed specifications of the parameter values used in Splice Machine data ingestion.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importparams.html
folder: Tutorials/Ingest
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

The fourth procedure, `SYSCS_UTIL.BULK_IMPORT_FILE`, adds a couple extra parameters at the end:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.BULK_IMPORT_FILE
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

{% include splice_snippets/importparamstable.md %}

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

**Example:** <span class="Example">`'|'`</span>

See [*Column Delimiters*](tutorials_ingest_importinput.html#DelimColumn) for additional information about column delimiters.
{: .notePlain}

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

<div class="indented" markdown="1">
#### Notes:
* If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.

* To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
</div>

**Example:** <span class="Example">`''`</span>

See [*Character Delimeters*](tutorials_ingest_importinput.html#DelimChar) for additional information about character delimiters.
{: .notePlain}

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

#### Timestamps and Importing Data at Different Locations

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

**Example:** <span class="Example">`'importErrsDir'`</span>

### `bulkImportDirectory` {#bulkImportDirectory}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `bulkImportDirectory` parameter is a string that specifies the name of the  directory into which the generated HFiles are written prior to being
imported into your database. The generated files are automatically removed after they've been imported.

**Example:** <span class="Example">`'hdfs:///tmp/test_hfile_import/'`</span>

Please review the [Bulk HFile Import Walkthrough](tutorials_ingest_importexampleshfile.html) topic to understand how importing bulk HFiles works.

### `skipSampling` {#skipSampling}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `skipSampling` parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed:

* If `skipSampling` is `true`, you need to use our &nbsp;&nbsp;[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) and [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) system procedures to manually split your table before calling `SYSCS_UTIL.BULK_IMPORT_HFILE`. This allows you more control over the splits, but adds a layer of complexity.

* If `skipSampling` is `false`, then `SYSCS_UTIL.BULK_IMPORT_HFILE`
samples your input data and computes the table splits for you, in the following steps. It:

    1. Scans (sample) the data
    2. Collects a rowkey histogram
    3. Uses that histogram to calculate the split key for the table
    4. Uses the calculated split key to split the table into HFiles

**Example:** <span class="Example">`false`</span>

Please review the [Bulk HFile Import Walkthrough](tutorials_ingest_importexampleshfile.html) topic to understand how importing bulk HFiles works.
