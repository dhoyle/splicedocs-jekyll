---
title: "Importing Data: Specifying Import Parameters"
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

This topic provides detailed information about the input parameters you need to specify when calling one of the Splice Machine data ingestion procedures.

## Import Parameters Overview

All of the Splice Machine data import procedures share a number of parameters that describe the table into which you're importing data, a number of input data format details, and how to handle problematic records; the following table summarizes these parameters. Each parameter name links to a more complete description below the table.

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
            <td class="CodeFont">[schemaName](#schemaName)</td>
            <td>The name of the schema of the table in which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont">[tableName](#tableName)</td>
            <td>The name of the table in which to import</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Data Location</td>
            <td class="CodeFont">[insertColumnList](#insertColumnList)</td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont">[fileOrDirectoryName](#fileOrDirectoryName)</td>
            <td>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
        </tr>
        <tr>
            <td rowspan="7" class="BoldFont">Data Formats</td>
            <td class="CodeFont">[oneLineRecords](#oneLineRecords)</td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.
            </td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont">charset</td>
            <td>The character encoding of the import file. The default value is UTF-8.
            </td>
            <td class="CodeFont">null</td>
        </tr>
        <tr>
            <td class="CodeFont">[columnDelimiter](#columnDelimiter)</td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|'</td>
        </tr>
        <tr>
            <td class="CodeFont">[characterDelimiter](#characterDelimiter)</td>
            <td>The character is used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">''</td>
        </tr>
        <tr>
            <td class="CodeFont">[timestampFormat](#timestampFormat)</td>
            <td>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">[dateFormat](#dateFormat)</td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont">[timeFormat](#timeFormat)</td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Problem Logging</td>
            <td class="CodeFont">[badRecordsAllowed](#badRecordsAllowed)</td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont">[badRecordDirectory](#badRecordDirectory)</td>
            <td>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
    </tbody>
</table>

## Parameter Details

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx

### <code>schemaName</code> {#schemaName}

The <code>schemaName</code> is the name of the schema of the table into which you are importing data.

### <code>tableName</code>

The <code>tableName</code> is the name of the table into which you are importing data.

### <code>insertColumnList</code>

The names, in single quotes, of the columns to import. If this is
`null`, all columns are imported.

If you don\'t specify an `insertColumnList` and your input file contains
more columns than are in the table, then the the extra columns at the
end of each line in the input file **are ignored**. For example, if your
table contains columns `(a, b, c)` and your file contains columns `(a,
b, c, d, e)`, then the data in your file\'s `d` and `e` columns will be
ignored.

If you do specify an `insertColumnList`, and the number of columns
doesn\'t match your table, then any other columns in your table will be
replaced by the default value for the table column (or `NULL` if there
is no default for the column). For example, if your table contains
columns `(a, b, c)` and you only want to import columns `(a, c)`, then
the data in table\'s `b` column will be replaced with the default value
for that column.


### <code>fileOrDirectoryName</code>

For the `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` or
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedures, this is either a single
file or a directory. If this is a single file, that file is imported; if
this is a directory, all of the files in that directory are imported.

For the `SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure, this can only be a
single file (directories are not allowed).

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information.

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

### <code>oneLineRecords</code>

A Boolean value that specifies whether each line in the import file
contains one complete record:

* If you specify `true` or `null`, then each record is expected to be
  found on a single line in the file.
* If you specify `false`, records can span multiple lines in the file.

Multi-line record files are slower to load, because the file cannot be
split and processed in parallel; if you import a directory of multiple
line files, each file as a whole is processed in parallel, but no
splitting takes place.
{: .noteNote}

### <code>charset</code>

The character encoding of the import file. The default value is <code>UTF-8</code>.
Currently, any other value is ignored and <code>UTF-8</code> is used.

### <code>columnDelimiter</code>

The character used to separate columns, You can specify `null` if using the
comma (`,`) character as your delimiter.

In addition to using single characters, you can specify the following
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

### <code>characterDelimiter</code>

Specifies which character is used to delimit strings in the imported
data. You can specify `null` or the empty string to use the default
string delimiter, which is the double-quote (`"`).

In addition to using single characters, you can specify the following
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

#### Notes:
* If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.

* To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.

### <code>timestampFormat</code>

The format of timestamps stored in the file. You can set this to `null`
if there are no time columns in the file, or if the format of any
timestamps in the file match the `Java.sql.Timestamp` default format,
which is: \"*yyyy-MM-dd HH:mm:ss*\".

All of the timestamps in the file you are importing must use the same
format.
{: .noteNote}


### <code>dateFormat</code>

The format of datestamps stored in the file. You can set this to `null`
if there are no date columns in the file, or if the format of any dates
in the file match pattern: \"*yyyy-MM-dd*\".

### <code>timeFormat</code>

The format of time values stored in the file. You can set this to null
if there are no time columns in the file, or if the format of any times
in the file match pattern: \"*HH:mm:ss*\".

### <code>badRecordsAllowed</code>

The number of rejected (bad) records that are tolerated before the
import fails. If this count of rejected records is reached, the import
fails, and any successful record imports are rolled back.

* If you specify `-1` as the value of this parameter, all record import
  failures are tolerated and logged.
* If you specify `0` as the value of this parameter, the import will
  fail if even one record is bad.

### <code>badRecordDirectory</code>

The directory in which bad record information is logged. Splice Machine
logs information to the `<import_file_name>.bad` file in this directory;
for example, bad records in an input file named `foo.csv` would be
logged to a file named *badRecordDirectory*`/foo.csv.bad`.

The default value is the directory in which the import files are found.
