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
# SYSCS_UTIL.MERGE_DATA_FROM_FILE

The `SYSCS_UTIL.MERGE_DATA_FROM_FILE` system procedure imports data to update an existing record or create a new record in your database. You can choose to import all or a subset of the columns from the input data into your database using the `insertColumnList` parameter.

After a successful import completes, a simple report displays, showing
how many files were imported, and how many record imports succeeded or
failed.

## Selecting an Import Procedure

Splice Machine provides four system procedures for importing data:

* The [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) procedure imports each input record into a new record in your database.
* The [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedure updates existing records and adds new records to your database. It only differs from `SYSCS_UTIL.MERGE_DATA_FROM_FILE` in that upserting
 **overwrites** the generated or default value of a column that *is not specified* in your `insertColumnList` parameter when updating a record.
* This procedure, `SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure updates existing records and adds new records to your database. It only differs from `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` in that merging **does not
overwrite** the generated or default value of a column that *is not specified* in your `insertColumnList` parameter when updating a record.
* The [`SYSCS_BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure takes advantage of HBase bulk loading to import table data into your database by temporarily converting the table file that you’re importing into HFiles, importing those directly into your database, and then removing the temporary HFiles. This procedure has improved performance for large tables; however, the bulk HFile import requires extra work on your part and lacks constraint checking.

Our [Importing Data Tutorial](tutorials_ingest_importoverview.html) includes a decision tree and brief discussion to help you determine which procedure best meets your needs.

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

## Parameters

The following table summarizes the parameters used by `SYSCS_UTIL.MERGE_DATA_FROM_FILE` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

{% include splice_snippets/importparamstable.md %}

### Notes

* The `SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure only imports single files; it does not process directories. This means that the `fileOrDirectoryName` parameter value must be a file name.

## Results

`SYSCS_UTIL.MERGE_DATA_FROM_FILE` displays a summary of the import
process results that looks like this:

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

What distinguishes `SYSCS_UTIL.IMPORT_DATA` from the
 similar [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) and
 [`SYSCS_UTIL.SYSCS_MERGED_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedures is how each works with these specific conditions:

* You are importing only a subset of data from the input data into your table, either because the table contains less columns than does the input file, or because you've specified a subset of the columns in your `insertColumnList` parameter.
* Inserting and updating data in a column with generated values.
* Inserting and updating data in a column with default values.
* Handling of missing values.

The [Importing Data Tutorial: Input Handling](tutorials_ingest_importinput.html) topic describes how each of these conditions is handled by the different system procedures.

## Record Import Failure Reasons

When upserting data from a file, the input file you generate must
contain:

* the columns to be changed
* all `NON_NULL` columns

Typical reasons for a row (record) import to fail include:

* Improper data expected for a column.
* Improper number of columns of data.
* A primary key violation:&nbsp; [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](#) will
  only work correctly if the table into which you are inserting/updating
  has primary keys.

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

### Example 1: Updating our doc examples player data

This example shows the `MERGE_DATA` call used to update the Players in our documentation examples database:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.MERGE_DATA_FROM_FILE('SPLICEBBALL', 'Players',
        'ID, Team, Name, Position, DisplayName, BirthDate',
        '/Data/DocExamplesDb/Players.csv',
        null, null, null, null, null, 0, null, true, null);
    rowsImported        |failedRows          |files      |dataSize            |failedLog--------------------------------------------------------------------------------------
    94                  |0                   |1          |4720                |NONE
    1 row selected
{: .Example xml:space="preserve"}

</div>

### Example 2: Using single quotes to delimit strings

This example uses single quotes instead of double quotes as the character delimiter
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

See [Importing Data Usage Examples](tutorials_ingest_importexamples1.html) for more examples.

## See Also

* [Our Importing Data Tutorial](tutorials_ingest_importoverview.html)
* [Importing Data Usage Examples](tutorials_ingest_importexamples1.html)
* [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
* [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)

</div>
</section>
