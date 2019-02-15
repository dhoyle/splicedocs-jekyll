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

## Quick Guidelines

Where the data that you're ingesting is coming from defines which approach you should take to importing that data into Splice Machine; how to use each approach is described, along with examples, in a section within this topic:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>The Source of Your Data</th>
            <th class="spliceCheckbox">&nbsp;</th>
            <th>Read this Section</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">Spark DataFrame</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#sparkadapter">Ingesting with the Splice Machine Native Spark DataSource</a></td>
        </tr>
        <tr>
            <td class="ItalicFont">Real-time Streaming</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#streaming">Ingesting Streaming Data</a></td>
        </tr>
        <tr>
            <td class="ItalicFont">External Table</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#externalTable">Ingesting Data With an External Table</a></td>
        </tr>
        <tr>
            <td class="ItalicFont">Flat File</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#datafiles">Importing Data Files</a></td>
        </tr>
    </tbody>
</table>


## Ingesting with the Native Spark DataSource  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark programs that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

### Notebook Example of The Native Spark DataSource

This section presents a simple Zeppelin notebook example of moving data between a Spark DataFrame and a Splice Machine table in these steps:

1.  __Create the context:__

    Using the `%spark` interpreter in Zeppelin, create an instance of the `SplicemachineContext` class; this class interacts with your Splice Machine cluster in your Spark executors, and provides the methods that you can use to perform operations such as directly inserting into your database from a DataFrame:

    ```
    %spark
    import com.splicemachine.spark.splicemachine._
    import com.splicemachine.derby.utils._

    val JDBC_URL = "jdbc:splice://<yourJDBCUrl>:1527/splicedb;user=<yourUserId>;password=<yourPassword>"
    val splicemachineContext = new SplicemachineContext(JDBC_URL)
    ```
    {: .Example}

2.  __Create a DataFrame in Scala and populate it:__

    ```
    %spark
    val carsDF = Seq(
       (1, "Toyota", "Camry"),
       (2, "Honda", "Accord"),
       (3, "Subaru", "Impreza"),
       (4, "Chevy", "Volt")
    ).toDF("NUMBER", "MAKE", "MODEL")
    ```
    {: .Example}

    Though this DataFrame contains only a very small amount of data, the code in this example can be scaled to DataFrames of any size.

3.  __Create a Table in your Splice Machine Database__

    Now we'll create a simple table in our database, using the `%splicemachine` interpreter in Zeppelin:

    ```
    %splicemachine
    create table mySchema.carsTbl ( number int primary key,
                                    make  varchar(20),
                                    model varchar(20) );
    ```
    {: .Example}

4.  __Populate the Database Table from the DataFrame:__

    To ingest all of the data in the DataFrame into your database, simply use the `Insert` method of the Spark Adapter:

    ```
    %spark
    splicemachineContext.insert( carsDF, "mySchema.carsTbl");
    ```
    {: .Example}

    Ingesting data in this way is extremely performant because it requires no serialization or deserialization and works with any Spark DataFrame. You can also use the Native Spark DataSource to quickly query your database, and to update or delete records.
    {: .noteImportant}

## Ingesting Streaming Data  {#streaming}

This section presents two versions of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps: one version that runs in a Zeppelin notebook, and a second version that runs via spark-submit.

### Notebook Example of  Spark Streaming
This section presents the Zeppelin version of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps.

**************** NEED EXAMPLE HERE ******************

### Spark-submit Example of  Spark Streaming
This section presents the spark-submit version of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps.

**************** NEED EXAMPLE HERE ******************

## Ingesting Data With an External Table  {#externaltable}

**************** NEED EXAMPLE HERE ******************


## Importing Data Files  {#datafiles}

Splice Machine provides two major pathways for importing data and indexes from flat files into your database: standard import and bulk HFile import. Each pathway has several variations that offer different levels of complexity, performance, and functionality, as summarized in the following table:

### The Data File Ingestion Methods

The following table summarizes the different methods you can use to import data files into your Splice Machine database:

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
            <td class="spliceCheckbox">**</td>
            <td class="spliceCheckbox">**</td>
            <td><p>Constraint checking</p>
                <p>Best for pulling in small datasets of new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td><code>UPSERT_DATA_FROM_FILE</code></td>
            <td class="spliceCheckbox">**</td>
            <td class="spliceCheckbox">**</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td><code>MERGE_DATA_FROM_FILE</code></td>
            <td class="spliceCheckbox">**</td>
            <td class="spliceCheckbox">**</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td rowspan="3"><code>BULK_IMPORT_HFILE</code></td>
            <td>Sampled splitting</td>
            <td class="spliceCheckbox">***</td>
            <td class="spliceCheckbox">***</td>
            <td>Enhanced performance</td>
            <td>No constraint checking</td>
        </tr>
        <tr>
            <td>Keys supplied for splitting</td>
            <td class="spliceCheckbox">****</td>
            <td class="spliceCheckbox">****</td>
            <td>Better performance, especially for extermely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify split keys for input data</p>
            </td>
        </tr>
        <tr>
            <td>Row boundaries supplied for splitting</td>
            <td class="spliceCheckbox">*****</td>
            <td class="spliceCheckbox">*****</td>
            <td>Best performance for extremely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify row boundaries for splitting input data</p>
            </td>
        </tr>
    </tbody>
</table>

### Selecting the Best Method for Your Situation

Please make sure you can answer these questions before trying to determine the best method for you to use:

* *Will you be importing all new data, or will you also be updating some existing records?*
* *Do you need constraint checking applied as the data is inserted into your database?*
* *How much data are you importing (e.g 1GB, 1TB, ...)?*
* *Are you able to determine how to split your data into evenly-sized partitions?*

Examine the following factors to guide you to the right method for your situation:

<table>
    <col width="40%" />
    <col width="60%" />
    <thead>
        <tr>
            <th>Factor</th>
            <th>Guidelines</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><p><em>Some existing records may be updated.</em></p>
            </td>
            <td>Use one of the following, depending on how you want to handle updating an existing column value when the input column does not have a value:</p>
                <ul class="bullet">
                    <li>Use the <code>UPSERT_DATA_FROM_FILE</code> procedure if you want the column value modified to its default value (or <code>NULL</code> if no default value is defined for the column in the schema).</li>
                    <li>Use the <code>MERGE_DATA_FROM_FILE</code> procedure if you want the column values left unmodified when no corresponding column value is present in the input.</li>
                </ul>
                <p>These methods perform constraint checking during ingestion.</p>
                <p>See the <a href="#standardexamples">Standard Data File Import Examples</a> section below.</p>
            </td>
        </tr>
        <tr>
            <td><p><em>You're importing all new records and require constraint checking.</em></p>
            </td>
            <td><p>Use the <code>IMPORT_DATA</code> procedure.</p>
                <p>See the <a href="#standardexamples">Standard Data File Import Examples</a> section below.</p>
           </td>
        </tr>
        <tr>
            <td><p><em>You're importing a large dataset without updates or constraint checking, and performance is important.</em></p>
                <p>Splice Machine recommends using bulk importing when ingesting very large datasets.</p>
            </td>
            <td><p>Use one of the variants of the <code>BULK_IMPORT_HFILE</code> procedure; from least complex to most complex, they are:</p>
                <ul class="bullet">
                    <li>Telling <code>BULK_IMPORT_HFILE</code> to sample the data and determine the splits. There's an example in the <a href="bulksampled">Bulk Import with Sampled Splitting Example</a> section below.</li>
                    <li>Manually supply, in a csv file, key values to split the data into HFiles. This takes more effort than sampled data, and produces better performance. See the <a href="#bulksplitkeys">Bulk Import with Key Value Pre-Splits</a> for an example.</li>
                    <li>Supply a list of row boundaries where the data should be split. This requires the most expertise and can yield the greatest performance; you'll find an example in the <a href="#bulksplitrows">Bulk Import with Row Pre-Splits</a> section below.</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample before jumping into importing a large dataset.
{: .noteIcon}

## Standard Data File Import Examples  {#standardexamples}
This section includes by summarizing the parameters that are common to all of the built-in system procedures for importing data, and then presents an example that shows the use of and contrasts the results of importing data into a table with each of the three *standard import* methods.

### The Common Ingest Procedure Parameters  {#table1}
All of the Splice Machine standard import procedures use these same parameter values:

<table>
    <caption class="tblCaption">Table 1: Common Ingest Parameters</caption>
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

### Example: Comparing the Standard File Import Methods
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

### See Also

Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [SYSCS_UTIL.IMPORT_DATA](sqlref_sysprocs_importdata.html)
* [SYSCS_UTIL.UPSERT_DATA_FROM_FILE](sqlref_sysprocs_upsertdata.html)
* [SYSCS_UTIL.MERGE_DATA_FROM_FILE](sqlref_sysprocs_mergedata.html)

## Bulk HFile Import Examples  {#standardexamples}

This section  starts with a discussion of pre-splitting your input data, and then presents these examples of using the `BULK_IMPORT_HFILE` procedure:

* [Bulk Import with Sampled Splitting](#bulksampled)
* [Bulk Import with Key Value Pre-Splits](#bulksplitkeys)
* [Bulk Import with Row Pre-Splits](#bulksplitrows)

You can also use bulk HFiles to speed up performance of the `INSERT` statement, as shown in the [Bulk Insert](#bulkinsert) example.
{: .noteNote}


### About Pre-Splitting Data for Bulk Import

The Bulk Import options enhance ingestion performance for larger datasets by pre-splitting the input data into temporary HBase HFiles (store files), then using the HBase bulk import mechanism to then directly load the generated StoreFiles into your Region Servers.

Pre-splitting is the process of preparing and loading HFiles (HBase’s own file format) directly into the RegionServers, thus bypassing the write path; this requires significantly less resources, reduces latency, and avoids frequent garbage collection, all of which can occur when importing un-split datasets, especially when they're very large. Optimally, your data is split into almost equal-sized HFiles, which allows the data to be spread evenly across your cluster nodes and allows for maximum parallelism.

The `BULK_IMPORT_HFILE` procedure can use sampling to determine which keys to use and split the data; this generally produces excellent results.

If you already know which key values will produce even splits of your data, you can create a csv file of key values to use, and call our `SPLIT_TABLE_OR_INDEX` procedure to pre-split your data prior to calling `BULK_IMPORT_HFILE`; this further enhances ingest performance.  For some especially large datasets, it can be worthwhile to go even one step further by using exact row boundaries to pre-split your data; this requires expertise and introduces extra complexity, but can also push performance.

### Bulk HFile Import Parameters

The `BULK_IMPORT_HFILE` procedure uses  parameters shown in [Table 1](#table1), and these two additional parameters:

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
            <td class="CodeFont">bulkImportDirectory</td>
            <td>The HDFS directory where you want the temporary HFiles stored until the import completes.</td>
        </tr>
        <tr>
            <td class="CodeFont">skipSampling</td>
            <td>Specify `true` if you've pre-split the data; `false` to have this procedure determine the splits by sampling the data.</td>
        </tr>
    </tbody>
</table>

### Example: Bulk Import with Sampled Splitting  {#bulksampled}

To use Bulk HFile import with sampled splitting, you can follow these steps:

1.  __Create a directory on HDFS for the temporary HFiles. For example:__
    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    ```
<br />
2.  __Import your data:__
    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                's3a://splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
    ```

    Note that the final parameter, `skipSampling` is `false` in the above call; this tells `BULK_IMPORT_HFILE` to split the data based on its own sampling.
<br />

### Example: Bulk Import with Key Value Pre-Splits  {#bulksplitkeys}

If you don't get the performance you're hoping from with sampled bulk import, you can pre-split your data by specifying split key values. In this example, we are also importing an index, so we also need to pre-split the index. You can pre-split your data by following steps like those used in this example:

1.  __Find primary key values that can horizontally split the table into roughly equal sized partitions.__

    For this example, we provide 3 keys in a file named `lineitemKey.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our three keys includes a second column that is `null`:__

	```
	1500000|
	3000000|
	4500000|
	```
    {: .Example}

	For every N lines of split data you specify, you’ll end up with N+1 regions; for example, the above 3 splits will produce these 4 regions:

	```
	0 -> 1500000
	1500000 -> 3000000
	3000000 -> 4500000
	4500000 -> (last possible key)
	```
    {: .Example}
<br />
2.  __Specify the column names in the csv file in the `columnList` parameter; in our example, the primary key columns are:__

	```
	L_ORDERKEY,L_LINENUMBER
	```
    {: .Example}
<br />
3.  __Invoke  the `SYSCS_SPLIT_TABLE_OR_INDEX` procedure to pre-split the table file:__

	```
	call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
        	'LINEITEM',null, 'L_ORDERKEY,L_LINENUMBER',
        	'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
        	'|', null, null, null,
        	null, -1, '/BAD', true, null);
	```
    {: .Example}

	Note that `SYSCS_SPLIT_TABLE_OR_INDEX` uses the same parameters as our standard import procedures.
    {: .spaceAbove}
<br />

4.  __Now find index values that can horizontally split your index into equal-sized partitions.__

	For this example, we provide 2 index values in a file named `shipDateIndex.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our keys includes `null` column values:

	```
	1994-01-01|||
	1996-01-01|||
	```
    {: .Example}
<br />
5.  __Specify the column names in that csv file in the `columnList` parameter; in our example, the index columns are:__

	```
	L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT
	```
    {: .Example}
<br />
6.  __Invoke SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX to pre-split your index file:__

	```
	call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
	        'LINEITEM', 'L_SHIPDATE_IDX',
	        'L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT',
	        'hdfs:///tmp/test_hfile_import/shipDateIndex.csv',
	        '|', null, null,
	        null, null, -1, '/BAD', true, null);
	```
    {: .Example}
<br />
7.  __Import the HFiles into your database:__

    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                's3a://splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null,
                -1, '/BAD', true, null,
                'hdfs:///tmp/test_hfile_import/', true);
    ```
    {: .Example}

    Note that the final parameter, `skipSampling` is `true` in the above call; this tells `BULK_IMPORT_HFILE` that the data has already been pre-split into HFiles.


### Example: Bulk Import with Row Pre-Splits  {#bulksplitrows}

If you're comfortable with how HBase and HFiles work, and you're very familiar with how the data you're ingesting can be split into (approximately) evenly-sized regions, you can apply more finely-grained pre-split specifications, as follows:

1. Create a CSV file that defines the row boundaries.
2. Call the SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS procedure to split the dataset into HFiles.
3. Call the BULK_HFILE_IMPORT to import the HFiles into your database.

Specifying row boundaries requires significant expertise. We only recommend using this approach when supplying split keys does not yield the performance you require.
{: .noteIcon}

### Example: Bulk Insert  {#bulkinsert}

Splice Machine allows you to specify [optimization hints](#developers_tuning_queryoptimization.html); one of these *hints*, `bulkImportDirectory` can be used to perform bulk loading with the SQL `INSERT` statement.

Here's a simple example:

    ```
    DROP TABLE IF EXISTS myUserTbl;
    CREATE TABLE myUserTbl AS SELECT
        user_id,
        report_date,
        type,
        region,
        country,
        access,
        birth_year,
        gender,
        product,
        zipcode,
        licenseID
    FROM licensedUserInfo
    WITH NO DATA;


    INSERT INTO myUserTbl --splice-properties bulkImportDirectory='/tmp',
    useSpark=true,
    skipSampling=false
    SELECT * FROM licensedUserInfo;
    ```
    {: .Example}

When you use `bulkImportDirectory` with the `INSERT` statement, you must also specify these two hints:
{: .spaceAbove}

* `useSpark=true`, since Splice Machine uses Spark to generate the HFiles
* `skipSampling`: set this to `false` to indicate that Splice Machine should sample the data that you're inserting to determine how to split it into HFiles; set it to `true` to indicate that the data you're inserting has already been split into HFiles.


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
