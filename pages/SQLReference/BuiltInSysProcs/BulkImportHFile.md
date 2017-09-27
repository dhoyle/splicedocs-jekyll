---
title: SYSCS_UTIL.BULK_IMPORT_HFILE built-in system procedure
summary: Built-in system procedure that imports data from an hfile.
keywords: bulk import, hfile import, bulk_import_hfile, import_hfile
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_importhfile.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.BULK_IMPORT_HFILE

The `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure imports data into
your Splice Machine database by first generating HFiles and then
importing those HFiles.

Our HFile data import procedure leverages HBase bulk loading, which
allows it to import your data at a faster rate; however, using this
procedure instead of our standard
[`SYSCS_UTIL.IMPORT_DATA`](tutorials_ingest_importing.html) procedure
means that <span class="CalloutFont">constraint checks are not performed
during data importation</span>.
{: .noteImportant}

## Two Methods for Using `SYSCS_UTIL.BULK_IMPORT_HFILE`

You can tell this procedure to automatically sample your data compute
the split keys for generating the HFiles to import (parameter
`skipSampling=false`), or you can control the split key computation
yourself by using other system procedures to compute the split keys
before calling `SYSCS_UTIL.IMPORT_DATA` with parameter
`skipSampling=true`).

If you are computing the splits, you use this procedure in conjunction
with either:

* The
  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) system
  procedure.
* The
  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) system
  procedure, which combines the functionality of those two procedures.

See the *Usage Notes* section for more information and the *Example*
section to see an example of using these procedures together.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.BULK_IMPORT_FILE (
    		schemaName,
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
<div class="noteNote" markdown="1">
If you are computing the splits, then almost all of the parameter values
that you pass to this procedure should match the parameter values that
you pass to the
[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
procedures.

Also note that these parameters are also used in exactly the same was as
they are in the
[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedures.

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema of the table in which to import the data.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table into which to import the data.
{: .paramDefnFirst}

insertColumnList
{: .paramName}

The names, in single quotes, of the columns to import. If this is
`null`, all columns are imported.
{: .paramDefnFirst}

<div class="notePlain" markdown="1">
If you don't specify a specify an `insertColumnList` and your input file
contains more columns than are in the table, then the the extra columns
at the end of each line in the input file **are ignored**. For example,
if your table contains columns `(a, b, c)` and your file contains
columns `(a, b, c, d, e)`, then the data in your file's `d` and `e`
columns will be ignored.

If you do specify an `insertColumnList`, and the number of columns
doesn't match your table, then any other columns in your table will be
replaced by the default value for the table column (or `NULL` if there
is no default for the column). For example, if your table contains
columns `(a, b, c)` and you only want to import columns `(a, c)`, then
the data in table's `b` column will be replaced with the default value
for that column.

</div>
fileName
{: .paramName}

The name of the data file that you are importing into your database.
{: .paramDefnFirst}

If you're importing data from an S3 bucket on AWS, please review our
[Configuring an S3 Bucket for Splice Machine
Access](tutorials_ingest_configures3.html) tutorial before proceeding.
{: .noteIcon}

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

 The [Example 1](#Examples){: .WithinBook .MCXref .xref .xrefWithinBook
xrefformat="{para}"} section below contains an example that uses the
single quote as the string delimiter character.
{: .noteNote}

timestampFormat
{: .paramName}

The format of timestamps stored in the file. You can set this to `null`
if there are no time columns in the file, or if the format of any
timestamps in the file match the `Java.sql.Timestamp` default format,
which is: "*yyyy-MM-dd HH:mm:ss*". See the [About Timestamp
Formats](#TimestampFormats){: .WithinBook .MCXref .xref .xrefWithinBook
xrefformat="{para}"} section below for more information about
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

A `BIGINT` value that represents the number of rejected (bad) records
that are tolerated before the import fails. If this count of rejected
records is reached, the import fails, and any successful record imports
are rolled back.
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

bulkImportDirectory
{: .paramName}

The directory into which the generated HFiles are written prior to being
imported into your database. Note that the generated files are
automatically removed after they've been imported.
{: .paramDefnFirst}

skipSampling
{: .paramName}

Set `skipSampling` to `false` to have `SYSCS_UTIL.BULK_IMPORT_HFILE`
sample your data and compute the split key for you, in these steps:
{: .paramDefnFirst}

* scan (sample) the data
* collect a rowkey histogram
* use that histogram to calculate the split key for the table
* use the calculated split key to split the table
{: .bulletNested}

If `skipSampling` is `true`, `SYSCS_UTIL.BULK_IMPORT_HFILE` does not
compute the split key for you.
{: .paramDefn}

</div>
</div>
## Results

`SYSCS_UTIL.COMPUTE_SPLIT_KEY` generates a keys file, which you use in
conjunction with the
[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)
system procedure to split your table, prior to calling the
[`SYSCS_UTIL.BULK_IMPORT_HFILE`](#) system procedure to import your
data.

{% include splice_snippets/importtimestampformats.md %}

Please see *[Working With Date and Time
Values](developers_fundamentals_dates.html)* in the *Developer's Guide*
for information working with timestamps, dates, and times.

{% include splice_snippets/hfileimport_example.md %}
## See Also

* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
