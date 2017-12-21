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

The `SYSCS_UTIL.IMPORT_DATA` system procedure imports data to a new record in a table. You can choose to import all or a subset of the columns from the input data into your database using the `insertColumnList` parameter.

After a successful import completes, a simple report displays, showing
how many files were imported, and how many record imports succeeded or
failed.

## Selecting an Import Procedure

Splice Machine provides four system procedures for importing data:

* This procedure, `SYSCS_UTIL.IMPORT_DATA`, imports each input record into a new record in your database.
* The [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedure updates existing records and adds new records to your database. It only differs from `SYSCS_UTIL.MERGE_DATA_FROM_FILE` in that upserting
 **overwrites** the generated or default value of a column that *is not specified* in your `insertColumnList` parameter when updating a record.
* The [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedure updates existing records and adds new records to your database. It only differs from `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` in that merging **does not
overwrite** the generated or default value of a column that *is not specified* in your `insertColumnList` parameter when updating a record.
* The [`SYSCS_BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure takes advantage of HBase bulk loading to import table data into your database by temporarily converting the table file that you’re importing into HFiles, importing those directly into your database, and then removing the temporary HFiles. This procedure has improved performance for large tables; however, the bulk HFile import requires extra work on your part and lacks constraint checking.

Our [Importing Data Tutorial](tutorials_ingest_importoverview.html) includes a decision tree and brief discussion to help you determine which procedure best meets your needs.

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

## Importing and Updating Records

What distinguishes `SYSCS_UTIL.IMPORT_DATA` from the similar
 &nbsp;[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) and
 &nbsp;[`SYSCS_UTIL.SYSCS_MERGED_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedures is how each works with these specific conditions:

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

## Usage Notes

A few important notes:

* Splice Machine advises you to run a full compaction (with the  [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html) system procedure) after importing large amounts of data into your database.

* On a cluster, the files to be imported **MUST be on S3, HDFS (or
MapR-FS)**, as must the `badRecordDirectory` directory. If you're using
our Database Service product, files can only be imported from S3.

  In addition, the files must be readable by the `hbase` user, and the
`badRecordDirectory` directory must be writable by the `hbase` user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
        sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

## Examples   {#Examples}

This section presents a couple simple examples.

The [Importing Data Usage Examples](tutorials_ingest_importexamples1.html) topic contains a more extensive set of examples.

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
    94                  |0                   |1          |4720                |NONE
    1 row selected
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

See [Importing Data Usage Examples](tutorials_ingest_importexamples1.html) for more examples.

## See Also

* [Our Importing Data Tutorial](tutorials_ingest_importoverview.html)
* [Importing Data Usage Examples](tutorials_ingest_importexamples1.html)
* [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
* [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)

</div>
</section>
