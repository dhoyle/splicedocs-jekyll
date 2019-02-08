---
title: Splice Machine Ingestion Best Practices
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_database_ingestion.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Data
This topic provides an overview and examples of the different methods you can use to ingest data into your Splice Machine database, and guides you to using the best option for ingesting *your* data.

## Selecting the Right Ingest Method
Which method is best for ingesting your data depends on a number of factors. This section will help guide your decision.

Let's start with how you plan to get at your data:

* If you have data in a Spark DataFrame, see the section about [Ingesting with the Splice Machine Native Spark DataSource](#sparkadapter), which allows you to insert data directly from a DataFrame into your database, providing great performance by eliminating the need to serialize and deserialize the data.

* If you want to stream the data into Splice Machine, please skip ahead to the [Ingesting Streaming Data](#streaming) section.

* If you want to access the data as an external table, please skip ahead to the [Ingesting Data With an External Table](#externaltable) section.

* Otherwise, continue on to our [Importing Data Files](#datafiles) section, below.

## Importing Data Files  {#datafiles}

Splice Machine provides two major pathways for importing data and indexes from files into your database: standard import and bulk HFile import. Each pathway has several variations that offer different levels of complexity, performance, and functionality, as summarized in the following table:

<table>
    <col width="10%" />
    <col width="24%" />
    <col width="10%" />
    <col width="10%" />
    <col width="23%" />
    <col width="23%" />
    <thead>
        <tr>
            <th>Type</th>
            <th>Import Method</th>
            <th>Complexity</th>
            <th>Performance</th>
            <th>Pros</th>
            <th>Cons</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="3">Standard</td>
            <td><code>IMPORT_DATA</code></td>
            <td>Low</td>
            <td>Standard</td>
            <td><p>Constraint checking</p>
                <p>Best for pulling in small datasets of new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td><code>UPSERT_DATA_FROM_FILE</code></td>
            <td>Low</td>
            <td>Standard</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td><code>MERGE_DATA_FROM_FILE</code></td>
            <td>Low</td>
            <td>Standard</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td rowspan="3"><code>BULK_IMPORT_HFILE</code></td>
            <td>Sampled splitting</td>
            <td>Moderate</td>
            <td>Medium</td>
            <td>Enhanced performance</td>
            <td>No constraint checking</td>
        </tr>
        <tr>
            <td>Keys supplied for splitting</td>
            <td>High</td>
            <td>High</td>
            <td>Better performance, especially for extermely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify split keys for input data</p>
            </td>
        </tr>
        <tr>
            <td>Row boundaries supplied for splitting</td>
            <td>Very High</td>
            <td>Best</td>
            <td>Best performance for extremely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify row boundaries for splitting input data</p>
            </td>
        </tr>
    </tbody>
</table>

### About Pre-Splitting Data for Bulk Import

The Bulk Import options enhance ingestion performance for larger datasets by pre-splitting the input data into temporary HBase HFiles (store files), then using the HBase bulk import mechanism to then directly load the generated StoreFiles into your Region Servers.

Pre-splitting is the process of preparing and loading HFiles (HBase’s own file format) directly into the RegionServers, thus bypassing the write path; this requires significantly less resources, reduces latency, and avoids frequent garbage collection, all of which can occur when importing un-split datasets, especially when they're very large. Optimally, your data is split into almost equal-sized HFiles, which allows the data to be spread evenly across your cluster nodes and allows for maximum parallelism.

The `BULK_IMPORT_HFILES` procedure can use sampling to determine which keys to use and split the data; this generally produces excellent results.

If you already know which key values will produce even splits of your data, you can create a csv file of key values to use, and call our `SPLIT_TABLE_OR_INDEX` procedure to pre-split your data prior to calling `BULK_IMPORT_HFILES`; this further enhances ingest performance.  For some especially large datasets, it can be worthwhile to go even one step further by using exact row boundaries to pre-split your data; this requires expertise and introduces extra complexity, but can also push performance.

### Selecting the Right Data Files Method

To get started, please make sure you know the answers to these basic questions:

<table>
    <col width="55%" />
    <col width="45%" />
    <thead>
        <tr>
            <th>Question</th>
            <th>Typical Answers</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Where will your data be accessed?</td>
            <td><ul class="bullet">
                    <li>In HDFS on a node in your cluster</li>
                    <li>On a local computer</li>
                    <li>In an S3 bucket on AWS</li>
                    <li>In BLOB storage on Azure</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>What's the size range of the data?</td>
            <td><ul class="bullet">
                    <li>10GB</li>
                    <li>100GB</li>
                    <li>500GB</li>
                    <li>1TB</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Do you need constraint checking applied as the data is inserted into your database?</td>
            <td><ul class="bullet">
                    <li>Yes</li>
                    <li>No</li>
                </ul>
            </td>
        <tr>
            <td>Do you know your data well enough to understand how to split it into approximately evenly-sized partitions?</td>
            <td><ul class="bullet">
                    <li>Yes</li>
                    <li>No</li>
                </ul>
            </td>
        </tr>
        </tr>
    </tbody>
</table>

#### Quick Guidelines
Here are three simple guidelines to quickly guide you to the right choice, based on your answers to the above questions:

1. __If you need constraint checking as the data is imported into your database, or if the size of your dataset is less than 10GB:__

   Use a *standard import method*; choose which based on the following:

   * If you're importing all new data, use the `IMPORT_DATA` method.
   * If you are updating existing records as well as importing new records, then your choice depends on how you want updates  handled when a column value is missing in the input:

     - Use the `UPSERT_DATA_FROM_FILE` procedure if you want the column value modified to its default value (if any is defined in the schema) or `NULL`.
     - Use the `MERGE_DATA_FROM_FILE` procedure if you want the column values left unmodified when no corresponding column value is present in the input.
     {: .bullet}

     See the [Standard Data File Import Examples](#standardexamples) section below for examples.
<br /><br />
2. __If you have a dataset whose size is between 10GB and XXXGB:__

   Use bulk import with sampled splitting, letting `BULK_IMPORT_HFILES` sample the data and perform the splitting. See [Bulk Import with Sampled Splitting Example](#bulksampled) section below for an example.
<br /><br />
3. __If you have a dataset whose size is greater than XXXGB:__

   Use one of the bulk import methods:

   * Bulk import with sampled splitting will provide excellent performance.  See the [Bulk Import with Sampled Splitting Example](#bulksampled) section below.
   * Pre-splitting your data by specifying key values takes a bit of extra work, but will boost the performance, especially for larger datasets. See the [Bulk Import with Key Value Pre-Splits](#bulksplitkeys) section below for an example.
   * If you need even faster ingestion, then instead of selecting key values to determine where to split your data, you can specify row boundaries within your data as the split points. This requires expert knowledge of your data and adds a layer of complexity. See the [Bulk Import with Row Pre-Splits](#bulksplitrows) section below for an example.</p>
<br /><br />
No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample before jumping into importing a large dataset.
{: .noteIcon}

## Ingestion Examples


### Standard Data File Import Examples  {#standardexamples}
All three of the Splice Machine standard import procedures, take the same parameter values:

<table>
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

In this example, we'll:

1.  Create 3 simple tables, `testImport`, `testUpsert`, and `testMerge`:

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

2.  Access a simple file named `ttest.csv` from an S3 bucket on AWS. That file contains this data:

    ```
    0|0
    1|2
    2|4
    3|6
    4|8
    ```
    {: .Example}

3.  Use `IMPORT_DATA` to import that data into the `testImport` table, and then verify that all went well:

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

4.  Populate our other two tables with the same data, so we can then observe the difference between upserting and merging into them:

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

5.  Now, we'll call `UPSERT_DATA_FROM_FILE` and show the results:

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

6.  And now we'll call `MERGE_DATA_FROM_FILE` and show the results of that:

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

You'll notice that:
{: .spaceAbove}

* The generated column (`c1`) is not included in the `insertColumnList`  parameter in these calls.
* The results are identical except for the values in the generated column.
* The generated values in `c1` are not updated in existing records when merging data, but are updated when upserting data.


Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [SYSCS_UTIL.IMPORT_DATA](sqlref_sysprocs_importdata.html)
* [SYSCS_UTIL.UPSERT_DATA_FROM_FILE](sqlref_sysprocs_upsertdata.html)
* [SYSCS_UTIL.MERGE_DATA_FROM_FILE](sqlref_sysprocs_mergedata.html)

*************************************************  START HERE ***********************************************
### Bulk Import with Sampled Splitting Example  {#bulksampled}

To use Bulk HFile import with sampled splitting, you can follow these steps:

1.  Create a directory on HDFS for the import. For example:
    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    ```

2.  Import your data:
    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                '/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
    ```

### Bulk Import with Key Value Pre-Splits  {#bulksplitkeys}

To pre-split your data by specifying split key values:

1.  Create a CSV file that defines the split keys for your data. Do this by finding primary key values that can horizontally split the table into roughly equal-sized partitions. Our split keys files is named `lineitemKey.csv`.

2.  Call the SYSCS_SPLIT_TABLE_OR_INDEX procedure to split the dataset into HFiles:

    ```
    call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
                    'LINEITEM',null, 'L_ORDERKEY,L_LINENUMBER',
                    'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
                    '|', null, null, null,
                    null, -1, '/BAD', true, null);
    ```

3.  Call BULK_HFILE_IMPORT to ingest the data into your table:


### Bulk Import with Row Pre-Splits  {#bulksplitrows}

If you're comfortable with how HBase and HFiles work, and you're very familiar with how the data you're ingesting can be split into (approximately) evenly-sized regions, you can apply more finely-grained pre-split specifications, as follows:

1. Create a CSV file that defines the row boundaries.
2. Call the SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS procedure to split the dataset into HFiles.
3. Call the BULK_HFILE_IMPORT to import the HFiles into your database.

Specifying row boundaries requires significant expertise. We recommend XXXXXXX
{: .noteIcon}

## Ingesting with the Native Spark DataSource  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data.

You can write Spark programs that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

## Ingesting Streaming Data  {#streaming}


## Ingesting Data With an External Table  {#externaltable}

## Documentation Links:

Our Importing Data Tutorial provides details about and examples of using the available methods for ingesting data.

And our SQL Reference Manual contains reference pages for each of the system procedures discussed in this article:
* SYSCS_UTIL.IMPORT_DATA
* SYSCS_UTIL.UPSERT_DATA_FROM_FILE
* SYSCS_UTIL.MERGE_DATA_FROM_FILE
* SYSCS_UTIL.BULK_IMPORT_HFILE
* SYSCS_UTIL.COMPUTE_SPLIT_KEY
* SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS
* SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX

</div>
</section>
