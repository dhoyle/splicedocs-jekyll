---
title: SYSCS_UTIL.IMPORT_DATA built-in system procedure
summary: Built-in system procedure that imports data to a subset of columns in a table.
keywords: import data, import_data, load data
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_importdata.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.IMPORT_DATA

The `SYSCS_UTIL.IMPORT_DATA` system procedure imports data to a subset
of columns in a table. You choose the subset of columns by specifying
insert columns.

Splice Machine also provides two built-in system procedures that will
import new records *and* update existing records in a table:
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` and
`SYSCS_UTIL.MERGE_DATA_FROM_FILE`; these operate similarly, but apply
different semantics when updating existing records. For more
information, see the [Inserting and Updating Column Values When
Importing](#ImportColVals) section below..
{: .noteIcon}

After a successful import completes, a simple report displays, showing
how many files were imported, and how many record imports succeeded or
failed.

<div class="noteNote" markdown="1">
On a cluster, the files to be imported **MUST be on S3, HDFS (or
MapR-FS)**, as must the `badRecordDirectory` directory. If you're using
our Database Service product, files can only be imported from S3.

In addition, the files must be readable by the `hbase` user, and the
`badRecordDirectory` directory must be writable by the hbase user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
    sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}

</div>
</div>
## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA (
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

## Parameters

The following table summarizes the parameters used by `SYSCS_UTIL.IMPORT_DATA` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

{% include splice_snippets/importparamstable.md %}

## Results

`SYSCS_UTIL.IMPORT_DATA` displays a summary of the import process
results that looks like this:

<div class="preWrapperWide" markdown="1">

    rowsImported   |failedRows   |files   |dataSize   |failedLog
    -------------------------------------------------------------
    94             |0            |1       |4720       |NONE
{: .Example xml:space="preserve"}

</div>
This procedure also logs rejected record activity into `.bad` files in
the `badRecordDirectory` directory; one file for each imported file.
{: .spaceAbove}

After importing a large amount of data into a table, it is useful to run
a full compaction on table; see the
[`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html)
system procedure.
{: .noteNote}

## Importing and Updating Records

What distinguishes `SYSCS_UTIL.IMPORT_DATA` from the similar [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) and [`SYSCS_UTIL.SYSCS_MERGED_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedures is how each works with these specific conditions:

* You are importing only a subset of data from the input data into your table, either because the table contains less columns than does the input file, or because you've specified a subset of the columns in your `insertColumnList` parameter.
* Inserting and updating data in a column with generated values.
* Inserting and updating data in a column with default values.
* Handling of missing values.

The [Importing Data Tutorial: Input Handling](tutorials_ingest_importinput.html) topic describes how each of these conditions is handled by the different system procedures.

## Record Import Failure Reasons

Typical reasons for a row (record) import to fail include:

* Improper data expected for a column.
* Improper number of columns of data.
* A primary key violation:&nbsp; [`SYSCS_UTIL.IMPORT_DATA`](#) will only work
  correctly if the table into which you are inserting/updating has
  primary keys.

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

## Usage Notes

We have seen a problem in which the compaction queue grows quite large
after importing large amounts of data, and are investigating a solution;
for now, please use the following workaround:

Run a full compaction on tables into which you have imported a large
amount of data, using the
[`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html)
system procedure.
{: .noteRelease}

## Examples   {#Examples}

The examples in this section illustrate using different timestamp
formats and different string delimiter characters when importing data with  `SYSCS_UTIL.IMPORT_DATA.`

### Example 1: Importing our doc examples player data

This example shows the `IMPORT_DATA` call used to import the Players
table into our documentation examples database:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.IMPORT_DATA('SPLICEBBALL', 'Players',
        'ID, Team, Name, Position, DisplayName, BirthDate',
        '/Data/DocExamplesDb/Players.csv',
        null, null, null, null, null, 0, null, true, null);
    rowsImported        |failedRows          |files      |dataSize            |failedLog--------------------------------------------------------------------------------------
    94                  |0                   |1          |4720                |NONE1 row selected
{: .Example xml:space="preserve"}

</div>
### Example 2: Specifying a timestamp format for an entire table

Use a single timestamp format for the entire table by explicitly
specifying a single `timeStampFormat`.

<div class="preWrapper" markdown="1">
    Mike,2013-04-21 09:21:24.98-05
    Mike,2013-04-21 09:15:32.78-04
    Mike,2013-03-23 09:45:00.68-05
{: .Example xml:space="preserve"}

</div>
You can then import the data with the following call:

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.IMPORT_DATA('app','tabx','c1,c2',
       '/path/to/ts3.csv',
       ',', '''',
       'yyyy-MM-dd HH:mm:ss.SSZ',
       null, null, 0, null, true, null);
{: .Example xml:space="preserve"}

</div>
Note that for any import use case shown above, the time shown in the
imported table depends on the timezone setting in the server timestamp.
In other words, given the same csv file, if imported on different
servers with timestamps set to different time zones, the value in the
table shown will be different. Additionally, daylight savings time may
account for a 1-hour difference if timezone is specified.

### Example 3: Importing strings with embedded special characters

This example imports a csv file that includes newline (`Ctrl-M`)
characters in some of the input strings. We use the default double-quote
as our character delimiter to import data such as the following:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,"This field has two lines
    This is the second line of the field",Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
We then use the following call to import the data:

<div class="preWrapperWide" markdown="1">
    splie> CALL SYSCS_UTIL.IMPORT_DATA( 'SPLICE',
       'MYTABLE',
       null,
       'data.csv',
       '\t',null,null,null,null,0,
       'Status', false, null);
{: .Example xml:space="preserve"}

</div>
We can also explicitly specify double quotes (or any other character) as
our delimiter character for strings:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.IMPORT_DATA( 'SPLICE',
       'MYTABLE',
       null,
       'data.csv',
       '\t','"',null,null,null,0,
       'Status', true, null);
{: .Example xml:space="preserve"}

</div>
### Example 4: Using single quotes to delimit strings

This example performs the same import as the previous example, simply
substituting single quotes for double quotes as the character delimiter
in the input:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,'This field has two lines
    This is the second line of the field',Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
Note that you must escape single quotes in SQL, which means that you
actually define the character delimiter parameter with four single
quotes, as follow

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.IMPORT_DATA('SPLICE',
       'MYTABLE',
       null,
       'data.csv',
       '\t','''',null,null,null,0,
       'Status', false, null);
{: .Example xml:space="preserve"}

</div>


## See Also

* [Our Importing Data Tutorial](tutorials_ingest_importoverview.html)
* [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
* [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)

</div>
</section>
