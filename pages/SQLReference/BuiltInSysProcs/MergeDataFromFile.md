---
title: SYSCS_UTIL.SYSCS_MERGE_DATA_FROM_FILE built-in system procedure
summary: Built-in system procedure that imports or updates data from a file into a table.
keywords: upserting, merging, merge data, merge_data_from_file
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_mergedata.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.MERGE_DATA_FROM_FILE   {#BuiltInSysProcs.MergeDataFromFile}

The `SYSCS_UTIL.MERGE_DATA_FROM_FILE` system procedure updates or
inserts data from a file to a subset of columns in a table. You choose
the subset of columns by specifying insert columns in your
`insertColumnList` parameter.

* If a matching record is found in the database, that record is updated
  with column values from the incoming record.
* If no matching record is found in the database, the incoming record is
  added to the database as a new record, exactly as it would be if had
  you called
  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html).

The syntax and usage of this procedure is almost identical to the syntax
and usage of the
[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
system procedure, except that `SYSCS_UTIL.MERGE_DATA_FROM_FILE` does not
overwrite the generated or default value of a column that *is not
specified* in your `insertColumnList` parameter. For more information,
see the [Inserting and Updating Column Values When
Importing](#ImportColVals) section below.

After a successful import completes, a simple report displays, showing
how many records were inserted or updated.

<div class="noteNote" markdown="1">
On a cluster, the files to be imported **MUST be on S3, HDFS (or
MapR-FS)**, as must the `badRecordDirectory` directory. If you're using
our Database Service product, files can only be imported from S3.

x
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
    call SYSCS_UTIL.MERGE_DATA_FROM_FILE (
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
{% include splice_snippets/importparamlist.md %}
## Results

`SYSCS_UTIL.MERGE_DATA_FROM_FILE` displays a summary of the import
process results that looks like this:

<div class="preWrapperWide" markdown="1">

    rowsImported   |failedRows   |files   |dataSize   |failedLog-------------------------------------------------------------
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

### Importing a Subset of Data From a File

When you import data from a file into a table, all of the data in the
file is not necessarily imported. This can happen in either of these
circumstances:

* If the table into which you're importing contains less columns than
  does the data file, the "extra" columns of data are ignored.
* If the `insertColumnList` in your import call specifies only a subset
  of the columns in the data file.

Please see the [Inserting and Updating Column Values When Importing
Data](#ImportColVals)section below for detailed information about how
table column values are updated when importing data with our different
procedures.

## Usage

This procedure will only work correctly if the table into which you are
inserting/updating data has primary keys.

When you generate the input file, it must:

* contain the columns to be changed
* contain all `NON_NULL` columns

## Record Import Failure Reasons

When upserting data from a file, the input file you generate must
contain:

* the columns to be changed
* all `NON_NULL` columns

Typical reasons for a row (record) import to fail include:

* Improper data expected for a column.
* Improper number of columns of data.
* A primary key violation: [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](#) will
  only work correctly if the table into which you are inserting/updating
  has primary keys.

{% include splice_snippets/importcolvals.md %}
## About Timestamp Formats   {#TimestampFormats}

{% include splice_snippets/importtimestampformats.md %}
Please see *[Working With Date and Time
Values](developers_fundamentals_dates.html)* in the *Developer's Guide*
for information working with timestamps, dates, and times.

## Examples   {#Examples}

The examples in this section illustrate using different timestamp
formats and different string delimiter characters.

### Example 1: Specifying a timestamp format for an entire table

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
    call SYSCS_UTIL.MERGE_DATA_FROM_FILE('app','tabx','c1,c2',
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

### Example 2: Importing strings with embedded special characters

This example imports a csv file that s newline (`Ctrl-M`) characters in
some of the input strings. We use the default double-quote as our
character delimiter to import data such as the following:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,"This field has two lines
    This is the second line of the field",Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
We then use the following call to import the data:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.MERGE_DATA_FROM_FILE('SPLICE','MYTABLE',null,'data.csv','\t',null,null,null,null,0,'BAD', false, null);
{: .Example xml:space="preserve"}

</div>
We can also explicitly specify double quotes (or any other character) as
our delimiter character for strings:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.MERGE_DATA_FROM_FILE('SPLICE','MYTABLE',null,'data.csv','\t','"',null,null,null,0,'BAD', false, null);
{: .Example xml:space="preserve"}

</div>
### Example 3: Using single quotes to delimit strings

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
    SYSCS_UTIL.MERGE_DATA_FROM_FILE('SPLICE','MYTABLE',null,'data.csv','\t','''',null,null,null,0,'BAD', false, null);
{: .Example xml:space="preserve"}

</div>
## See Also

* [Our Importing Data Tutorial](tutorials_ingest_importing.html)
* [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
* [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)

</div>
</section>
