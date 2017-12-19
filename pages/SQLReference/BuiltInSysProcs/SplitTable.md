---
title: SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX built-in system procedure
summary: Built-in system procedure that computes split points for a table or index and splits it into HFiles.
keywords: compute split points, splice_table_or_index
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_splittable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX

The `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` system procedure computes
the split keys for a table or index, prior to importing that table in
HFile format. You must use this procedure in conjunction with the
[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
system procedure to import your data in HFile format.

This procedure combines the actions of two other system
procedures: [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html).
{: .noteNote}

See the *Usage Notes* section for more information and the *Example*
section to see an example of using these procedures together.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.COMPUTE_SPLIT_KEY (
    		schemaName,
    		tableName,
    		indexName,
    		columnList | null,
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
    		);
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="noteNote" markdown="1">
Almost all of the parameter values that you pass to this procedure
should match the parameter values that you pass to the
[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
procedures.

Also note that these parameters are also used in exactly the same was as
they are in the
[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedures.

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema of the table in which to compute the split key.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table in which to compute the split key.
{: .paramDefnFirst}

indexName
{: .paramName}

The name of the index in which to compute the split key. If this is
`null`, the split key is computed for the named table.
{: .paramDefnFirst}

columnList
{: .paramName}

The names, in single quotes, of the columns that appear in the input
CSV file (specified by fileName). If this is `null`, all columns of the
table appear in the input file.
{: .paramDefnFirst}

fileName
{: .paramName}

The name of the CSV file that contains the split key values for the
table or index. `NULL` values are allowed for a key column. Here's an
example of three key values, each with a `NULL` value in the second
column:
{: .paramDefnFirst}

<div class="preWrapper" markdown="1">
    1500000|3000000|4500000|
{: .Example}

</div>
</div>
<div class="paramList" markdown="1">
columnDelimiter
{: .paramName}

The character used to separate columns, Specify `null` if using the
comma (`,`) character as your delimiter.
{: .paramDefnFirst}

<div markdown="1">
In addition to using single characters, you can specify the following
special characters as delimiters:
{: .paramDefn}

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
</div>
characterDelimiter
{: .paramName}

Specifies which character is used to delimit strings in the imported
data. You can specify `null` or the empty string to use the default
string delimiter, which is the double-quote (`"`).
{: .paramDefnFirst}

<div markdown="1">
In addition to using single characters, you can specify the following
special characters as delimiters:
{: .paramDefn}

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
</div>
If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.
{: .paramDefnFirst}

To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
{: .paramDefn}

The [Example 1](#Examples) section below contains an example that uses the
single quote as the string delimiter character.
{: .noteNote}

timestampFormat
{: .paramName}

The format of timestamps stored in the file. You can set this to `null`
if there are no time columns in the file, or if the format of any
timestamps in the file match the `Java.sql.Timestamp` default format,
which is: "*yyyy-MM-dd HH:mm:ss*". See the [About Timestamp
Formats](#TimestampFormats) section below for more information about
timestamps.
{: .paramDefnFirst}

All of the timestamps in the file you are importing must use the same
format.
{: .noteNote}

dateFormat
{: .paramName}

The format of datestamps stored in the file. You can set this to `null`
if there are no date columns in the file, or if the format of any dates
in the file match pattern: "*yyyy-MM-dd*".
{: .paramDefnFirst}

timeFormat
{: .paramName}

The format of time values stored in the file. You can set this to null
if there are no time columns in the file, or if the format of any times
in the file match pattern: "*HH:mm:ss*".
{: .paramDefnFirst}

<div markdown="1">
maxBadRecords
{: .paramName}

The number of rejected (bad) records that are tolerated before the
import fails. If this count of rejected records is reached, the import
fails, and any successful record imports are rolled back.
{: .paramDefnFirst}

* If you specify `-1` as the value of this parameter, all record import
  failures are tolerated and logged.
* If you specify `0` as the value of this parameter, the import will
  fail if even one record is bad.

badRecordDirectory
{: .paramName}

The directory in which bad record information is logged. Splice Machine
logs information to the `<import_file_name>.bad` file in this directory;
for example, bad records in an input file named `foo.csv` would be
logged to a file named *badRecordDirectory*`/foo.csv.bad`.
{: .paramDefnFirst}

The default value is the directory in which the import files are found.
{: .paramDefn}

oneLineRecords
{: .paramName}

A Boolean value that specifies whether each line in the import file
contains one complete record:
{: .paramDefnFirst}

* If you specify `true` or `null`, then each record is expected to be
  found on a single line in the file.
* If you specify `false`, records can span multiple lines in the file.
{: .nested}

Multi-line record files are slower to load, because the file cannot be
split and processed in parallel; if you import a directory of multiple
line files, each file as a whole is processed in parallel, but no
splitting takes place.
{: .noteNote}

charset
{: .paramName}

The character encoding of the import file. The default value is UTF-8.
Currently, any other value is ignored and UTF-8 is used.
{: .paramDefnFirst}

</div>
</div>
## Results

`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` generates a keys file and then
sets up the splits in your database. You then call the
[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) system
procedure to split your table into HFiles and import your data.

## About Timestamp Formats   {#TimestampFormats}

The `timestampFormat` parameter specifies the format of timestamps in your input data. You can set this to `null` if either of these conditions is true:

* there are no time columns in the file
* all time stamps in the input match the `Java.sql.Timestamp` default format,
which is: \"*yyyy-MM-dd HH:mm:ss*\".

All of the timestamps in the file you are importing must use the same
format.
{: .noteIcon}

The [Importing Data Tutorial: Input Parameters](tutorials_ingest_importparams.html) topic provides detailed information about timestamp formats and handling.

[Working With Date and Time Values](developers_fundamentals_dates.html) in our Developer's Guide discusses working with date, time, and timestamp values in Splice Machine.


The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
