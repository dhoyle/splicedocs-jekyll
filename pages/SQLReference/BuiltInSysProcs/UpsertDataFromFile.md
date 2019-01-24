---
title: SYSCS_UTIL.SYSCS_UPSERT_DATA_FROM_FILE built-in system procedure
summary: Built-in system procedure that imports or updates data from a file into a table.
keywords: upserting, upsert data, upsert_data_from_file
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_upsertdata.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.UPSERT_DATA_FROM_FILE

The `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` system procedure imports data to update an existing record or create a new record in your database. You can choose to import all or a subset of the columns from the input data into your database using the `insertColumnList` parameter.

After a successful import completes, a simple report displays, showing
how many files were imported, and how many record imports succeeded or
failed.

This procedure is one of several built-in system procedures provided by Splice Machine for importing data into your database. See our [*Importing Data Tutorial*](tutorials_ingest_importoverview.html) for help with selecting the right process for your situation.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.UPSERT_DATA_FROM_FILE (
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

The following table summarizes the parameters used by `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

<table>
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Parameter</th>
            <th>Description</th>
            <th>Example Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">schemaName</td>
            <td>The name of the schema of the table into which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont">tableName</td>
            <td>The name of the table into which to import.</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
        <tr>
            <td class="CodeFont">insertColumnList</td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont">fileOrDirectoryName</td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
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
            <td class="CodeFont">columnDelimiter</td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|', '\t'</td>
        </tr>
        <tr>
            <td class="CodeFont">characterDelimiter</td>
            <td>The character used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">'"', ''''</td>
        </tr>
        <tr>
            <td class="CodeFont">timestampFormat</td>
            <td><p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
            <p class="noteIcon">All of the timestamps in the file you are importing must use the same format.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">dateFormat</td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont">timeFormat</td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td class="CodeFont">badRecordsAllowed</td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont">badRecordDirectory</td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td class="CodeFont">oneLineRecords</td>
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
    </tbody>
</table>

## Results

`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` displays a summary of the import
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

What distinguishes `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` from the similar
 &nbsp;[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) and
  &nbsp;[`SYSCS_UTIL.SYSCS_MERGED_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedures is how each works with
   these specific conditions:

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
* A primary key violation:&nbsp; [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](#) will
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

This example shows the `UPSERT_DATA` call used to update the Players in our documentation examples database:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.UPSERT_DATA_FROM_FILE('SPLICEBBALL', 'Players',
        'ID, Team, Name, Position, DisplayName, BirthDate',
        '/Data/DocExamplesDb/Players.csv',
        null, null, null, null, null, 0, null, true, null);
    rowsImported        |failedRows          |files      |dataSize            |failedLog--------------------------------------------------------------------------------------
    94                  |0                   |1          |4720                |NONE
    1 row selected
{: .Example xml:space="preserve"}

</div>

### Example 2: Importing strings with embedded special characters

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
    SYSCS_UTIL.UPSERT_DATA_FROM_FILE( 'SPLICE', 'MYTABLE', null, 'data.csv',
                                      '\t', null, null, null, null, 0, 'BAD', false, null );
{: .Example xml:space="preserve"}

</div>
We can also explicitly specify double quotes (or any other character) as
our delimiter character for strings:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.UPSERT_DATA_FROM_FILE( 'SPLICE','MYTABLE',null,'data.csv',
                                      '\t', '"', null, null, null, 0,'BAD', false, null);
{: .Example xml:space="preserve"}

</div>

See [Importing Data Usage Examples](tutorials_ingest_importexamples1.html) for more examples.

## See Also

* [Our Importing Data Tutorial](tutorials_ingest_importoverview.html)
* [Importing Data Usage Examples](tutorials_ingest_importexamples1.html)
* [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
* [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_importdata.html)

</div>
</section>
