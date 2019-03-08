---
title: Importing Flat Files
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_import.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Importing Flat File

This topic presents examples of using the Splice Machine standard flat file ingestion methods: `IMPORT_DATA`, `UPSERT_DATA_FROM_FILE`, and `MERGE_DATA`, and contrasts the results of importing the same data with each method.

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_intro.html).


## Selecting the Best Method for Your Situation

Please make sure you can answer these questions before trying to determine the best method for importing your files:

* *Will you be importing all new data, or will you also be updating some existing records?*
* *Do you need constraint checking applied as the data is inserted into your database?*

Splice Machine provides three standard import procedures for ingesting flat files into your database. Each of the three system procedures uses the same parameters, which are summarized below, in [Table 1](#table1). Each procedure applies constraint checking during ingestion.

Which procedure you use depends on how you want to handle updating existing records during ingestion:

* If you're importing all new data and not updating existing records, use the `SYSCS_UTIL.IMPORT_DATA` procedure.

* If you're adding new data and updating existing records, the procedure you should use depends on how you want to handle updating an existing column value when the input column does not have a value:
  * Use the `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedure if you want the column value modified to its default value (or `NULL` if no default value is defined for the column in the schema).
  * Use the `SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure if you want the column values left unmodified when no corresponding column value is present in the input.

The [Examples](#Examples) section below shows an example of using each procedure and contrasts the results of importing data with them.

## Parameters Used With the Data File Import Procedures  {#table1}
The Splice Machine standard import procedures all use these parameter values:

<table>
    <caption class="tblCaption">Table 1: Standard Import Method Parameters</caption>
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
            <td>The character used to delimit strings in the imported data.</td>
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
            <td>The number of rejected (bad) records that are tolerated before the import fails.</td>
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

## Example: Comparing the Standard File Import Methods  {#Examples}
Follow the steps in this example to contrast how `IMPORT_DATA`, `UPSERT_DATA_FROM_FILE`, and `MERGE_DATA` work:

1.  __Create 3 simple tables, `testImport`, `testUpsert`, and `testMerge`:__

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


    CREATE TABLE testUpsert (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
     );

    CREATE TABLE testMerge (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
     );
     ```
     {: .Example}

     Note that the `c1` column in each table contains auto-generated values, and the `d1` column has a default value 999.
     {: .spaceAbove}

2.  __Access a simple file named `ttest.csv` from an S3 bucket on AWS. That file contains this data:__

    ```
    0|0
    1|2
    2|4
    3|6
    4|8
    ```
    {: .Example}
<br />
3.  __Use `IMPORT_DATA` to import that data into the `testImport` table, and then verify that all went well:__

    ```
    splice> CALL SYSCS_UTIL.IMPORT_DATA('TEST', 'testImport', null,
                        's3a:/mypublicbucket/ttest.csv',
                        '|', null, null, null, null, 0,
                        'hdfs:///tmp/test_import/', false, null);

    rowsImported        |failedRows          |files      |dataSize            |failedLog
    -------------------------------------------------------------------------------------
    5                   |0                   |1          |20                  |NONE

    splice> SELECT * FROM testImport;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |10002      |999
    2          |4          |10003      |999
    3          |6          |10004      |999
    4          |8          |10005      |999

    6 rows selected
    ```
    {: .Example}

    Note that this `IMPORT_DATA` call logs bad import records to a file on `HDFS`, and uses almost all default parameter values. The exception: our data file uses the `|` to delimit columns.
    {: .spaceAbove}

4.  __Populate our other two tables with the same data, so we can then observe the difference between upserting and merging into them:__

    ```
    INSERT INTO testUpsert(a1,b1) VALUES (1,1), (2,2), (3,3), (6,6);
    splice> select * from testUpsert;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    1          |1          |1          |999
    2          |2          |2          |999
    3          |3          |3          |999
    6          |6          |4          |999

    4 rows selected

    INSERT INTO testMerge (a1,b1) VALUES (1,1), (2,2), (3,3), (6,6);
    splice> select * from testMerge;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    1          |1          |1          |999
    2          |2          |2          |999
    3          |3          |3          |999
    6          |6          |4          |999

    4 rows selected
    ```
    {: .Example}
<br />
5.  __Now, we'll call `UPSERT_DATA_FROM_FILE` and show the results:__

    ```
    CALL SYSCS_UTIL.UPSERT_DATA_FROM_FILE('TEST', 'testUpsert', 'a1,b1',
                    's3a:/mypublicbucket/ttest.csv',
                    '|', null, null, null, null, 0,
                    hdfs:///tmp/test_upsert/, false, null);
    rowsImported        |failedRows          |files      |dataSize            |failedLog
    -------------------------------------------------------------------------------------
    5                   |0                   |1          |20                  |NONE

    splice> SELECT * FROM testUpsert;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |10002      |999
    2          |4          |10003      |999
    3          |6          |10004      |999
    4          |8          |10005      |999
    6          |6          |4          |999

    6 rows selected
    ```
    {: .Example}
<br />
6.  __And now we'll call `MERGE_DATA_FROM_FILE` and show the results of that:__

    ```
    CALL SYSCS_UTIL.MERGE_DATA_FROM_FILE('TEST', 'testMerge', 'a1,b1',
                    's3a:/mypublicbucket/ttest.csv',
                    '|', null, null, null, null, 0,
                    'hdfs:///tmp/test_merge/', false, null);
    rowsUpdated         |rowsInserted        |failedRows          |files      |dataSize            |failedLog
    ---------------------------------------------------------------------------------------------------------
    3                   |2                   |0                   |1          |20                  |NONE

    splice> select * from testMerge;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |1          |999
    2          |4          |2          |999
    3          |6          |3          |999
    4          |8          |10002      |999
    6          |6          |4          |999

    6 rows selected
    ```
    {: .Example}

__You'll notice that:__
{: .spaceAbove}

* The generated column (`c1`) is not included in the `insertColumnList`  parameter in these calls.
* The results are identical except for the values in the generated column.
* The generated values in `c1` are not updated in existing records when merging data, but are updated when upserting data.

## See Also

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_intro.html).

The other topics in this *Best Practices: Ingestion* section provide examples of other ingestion scenarios:

* [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html)
* [Ingestion in Your Spark App](bestpractices_ingest_sparkapp.html)
* [Ingesting Streaming Data](bestpractices_ingest_streaming.html)
* [Ingesting External Tables](bestpractices_ingest_externaltbl.html)

Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [SYSCS_UTIL.IMPORT_DATA](sqlref_sysprocs_importdata.html)
* [SYSCS_UTIL.UPSERT_DATA_FROM_FILE](sqlref_sysprocs_upsertdata.html)
* [SYSCS_UTIL.MERGE_DATA_FROM_FILE](sqlref_sysprocs_mergedata.html)


</div>
</section>
