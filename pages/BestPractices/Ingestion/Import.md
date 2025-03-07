---
title: Basic Importing of Flat Files
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_ingest_import.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Basic Flat File Ingestion

This topic show you how to use Splice Machine's basic data ingestion methods, `IMPORT_DATA` and `MERGE_DATA_FROM_FILE`, to import data from flat files into your database. These highly performant procedure provide numerous data handling options, and perform constraint checking, which means that they detect and report on erroneous records (*bad data*) in the input file.

If you're ingesting all new data, use `IMPORT_DATA`; if you are also ingesting updates to existing records in your database table, use `MERGE_DATA_FROM_FILE`. You can only merge data into a table that has a primary key.

The remainder of this topic contains these sections:

* [About Basic Flat File Ingestion](#aboutflat)
* [Example: Basic Import of a Flat File](#eximport)
* [Example: Basic Merge of a Flat File](#exmerge)
* [Parameters Used With the Basic Import Procedures](#table1)

Our [Bulk HFile Import](bestpractices_ingest_bulkimport.html) procedure, `BULK_HFILE_IMPORT`, offers boosted ingestion speed when importing large (> 100GB) data sets, but does not perform constraint checking.

## About Basic Flat File Ingestion  {#aboutflat}

Here's what a call to the `IMPORT_DATA` procedure looks like, with required parameters highlighted:

<div class="preWrapper"><pre class="Example">
call SYSCS_UTIL.IMPORT_DATA('<span class="HighlightedCode">&lt;schemaName&gt;</span>', '<span class="HighlightedCode">&lt;tableName&gt;</span>', null,
        '<span class="HighlightedCode">&lt;inFilePath&gt;</span>', null, null, null, null, null, -1,
        '<span class="HighlightedCode">&lt;badRecordLogDirectory&gt;</span>', true, null);</pre>
</div>

All of the `null` parameter values specify that default values should be used. All of the parameters are described, along with their default values, in [Table 1](#table1). Here's a call with actual values plugged in:

```
call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'playerTeams', null, 'myData.csv',
       null, null, null, null, null, 0, 'importErrsDir', true, null);
```
{: .Example}

The `MERGE_DATA_FROM_FILE` procedure uses exactly the same parameters.
{: .noteNote}

In the above calls, the parameter values have the following meaning:
{: .spaceAbove}

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td class="CodeFont">'SPLICE'</td>
            <td>Import the data into a table in the `SPLICE` schema in our database.</td>
        </tr>
        <tr>
            <td class="CodeFont">'playerTeams'</td>
            <td>Import the data into the `playerTeams` table.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Import all columns of data in the file.</td>
        </tr>
        <tr>
            <td class="CodeFont">'myData.csv'</td>
            <td>The input file path.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Columns in the input file are separated by the `,` character.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Character strings in the input file are delimited with `"` characters.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Timestamp values are in <em>yyyy-MM-dd HH:mm:ss</em> format.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Date values are in <em>yyyy-MM-dd</em> format.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Time values are in <em>HH:mm:ss</em> format.</td>
        </tr>
        <tr>
            <td class="CodeFont">0</td>
            <td>Zero tolerance for bad records: any input error will terminate the import.</td>
        </tr>
        <tr>
            <td class="CodeFont">'importErrsDir'</td>
            <td>Information about any bad records is logged in this directory.</td>
        </tr>
        <tr>
            <td class="CodeFont">true</td>
            <td>Each record is contained in one line in the input file.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>The input uses UTF-8 character encoding.</td>
        </tr>
    </tbody>
</table>

## Example: Basic Import of a Flat File {#eximport}

Here's a very basic example of importing a flat file into a table in your Splice Machine database. Follow these steps:

1.  __Create a simple table named `testImport`:__

    ```
    CREATE SCHEMA test;
    SET SCHEMA test;

    CREATE TABLE testImport (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
    )
     ```
     {: .Example }

2.  __Access a simple file named `ttest.csv` from an S3 bucket on AWS. That file contains this data:__

    ```
    0|0
    1|2
    2|4
    3|6
    4|8
    ```
    {: .Example }

3.  __Use `IMPORT_DATA` to import that data into the `testImport` table:__

    ```
    splice> CALL SYSCS_UTIL.IMPORT_DATA('TEST', 'testImport', null,
                        's3a:/mypublicbucket/ttest.csv',
                        '|', null, null, null, null, 0,
                        'hdfs:///tmp/test_import/', false, null);

    rowsImported        |failedRows          |files      |dataSize            |failedLog
    -------------------------------------------------------------------------------------
    5                   |0                   |1          |20                  |NONE
    ```
    {: .Example}

    Note that this `IMPORT_DATA` call logs bad import records to a file on `HDFS`, and uses almost all default parameter values. The exception: our data file uses the `|` to delimit columns.  All of the parameters are summarized in [Table 1](#table1) below.
    {: .spaceAbove}

4.  __Use a `SELECT` statement to verify that all went well:__

    ```
    splice> SELECT * FROM testImport;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |1      |999
    1          |2          |2      |999
    2          |4          |3      |999
    3          |6          |4      |999
    4          |8          |5      |999

    6 rows selected
    ```
    {: .Example}

## Example: Basic Merge of a Flat File {#exmerge}

Here's a very basic example of using `MERGE_DATA_FROM_FILE` to add new records *and* update a few existing records in a table. This example ingests into the same table that we just used in the `IMPORT_DATA` example above.

1.  __Access a simple file named `mergetest.csv` from an S3 bucket on AWS. That file contains the following data. Note that the rows with key values `2` and `4` already exist in the table:__

    ```
    2|22
    4|44
    5|55
    6|66
    ```
    {: .Example }

2.  __Use `MERGE_DATA` to import that data into the `testImport` table:__

    ```
    splice> CALL SYSCS_UTIL.MERGE_DATA_FROM_FILE('TEST', 'testImport', null,
                        's3a:/mypublicbucket/mergetest.csv',
                        '|', null, null, null, null, 0,
                        'hdfs:///tmp/test_import/', false, null);

    rowsUpdated   |rowsInserted  |failedRows     |files  |dataSize           |failedLog
    -------------------------------------------------------------------------------------
    2             |2             |0              |1      |20                 |NONE

    1 row selected
    ```
    {: .Example }

3.  __Use a `SELECT` statement to verify that all went well:__

    ```
    splice> SELECT * FROM testImport;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |1          |999
    1          |2          |2          |999
    2          |22         |3          |999
    3          |6          |4          |999
    4          |44         |5          |999
    5          |55         |10001      |999
    6          |66         |10002      |999

    7 rows selected
    ```
    {: .Example}

    Note that this `MERGE_DATA_FROM_FILE` call uses exactly the same parameter values as does the previous call to `IMPORT_DATA`, with the exception of importing a different file. As you can see, two rows (`A1=2` and `A1=4`) were updated with new `B1` values, and two new rows were added by this merge call.
    {: .spaceAbove}

## Parameters Used With the Basic Import Procedures  {#table1}

The following table summarizes the parameters you use when calling the `IMPORT_DATA` or
 `MERGE_DATA_FROM_FILE` procedures.

The [Data Ingestion Parameter Values](bestpractices_ingest_params.html) topic in this chapter provides reference information for all of these parameters.
{: .noteNote}

<table>
    <caption class="tblCaption">Table 1: Basic Import Parameters</caption>
    <col width="25%"/>
    <col />
    <thead>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">schemaName</td>
            <td>The schema to import into.</td>
        </tr>
        <tr>
            <td class="CodeFont">tableName</td>
            <td>The table to import into.</td>
        </tr>
        <tr>
            <td class="CodeFont">insertColumnList</td>
            <td>A list of the columns to import; The default is to import all columns.</td>
        </tr>
        <tr>
            <td class="CodeFont">fileOrDirectoryName</td>
            <td>The file or directory of files to import.</td>
        </tr>
        <tr>
            <td class="CodeFont">columnDelimiter</td>
            <td>The character used to separate columns in the input; The default is the comma (<code>,</code>) character.</td>
        </tr>
        <tr>
            <td class="CodeFont">characterDelimiter</td>
            <td>The character used to delimit strings in the imported data; the default is the double-quote (<code>"</code>) character.</td>
        </tr>
        <tr>
            <td class="CodeFont">timestampFormat</td>
            <td>The format of timestamps stored in the file; The default is "<em>yyyy-MM-dd HH:mm:ss</em>".</td>
        </tr>
        <tr>
            <td class="CodeFont">dateFormat</td>
            <td>The format of date values stored in the file; The default is "<em>yyyy-MM-dd</em>".</td>
        </tr>
        <tr>
            <td class="CodeFont">timeFormat</td>
            <td>The format of time values stored in the file; The default is "<em>HH:mm:ss</em>".</td>
        </tr>
        <tr>
            <td class="CodeFont">badRecordsAllowed</td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. A value of `0` means that the import terminates as soon as a single bad record is detected; a value of `-1` means that all bad records are tolerated and logged.</td>
        </tr>
        <tr>
            <td class="CodeFont">badRecordDirectory</td>
            <td>The directory in which bad record information is logged.</td>
        </tr>
        <tr>
            <td class="CodeFont">oneLineRecords</td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.</td>
        </tr>
        <tr>
            <td class="CodeFont">charset</td>
            <td>The character encoding of the import file. The default value is UTF-8.</td>
        </tr>
    </tbody>
</table>


## For Additional Information

Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
* [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)


</div>
</section>
