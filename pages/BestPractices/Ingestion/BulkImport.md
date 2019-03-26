---
title: Bulk Importing Flat Files
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_bulkimport.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Bulk Importing Flat Files

In this topic, we'll walk you through using our highly performant `BULK_IMPORT_HFILE` procedure to import flat files into your Splice Machine database. Bulk importing splits a data file into temporary HFiles (store files) before it is imported into your database by directly loading the generated StoreFiles into your Region Servers. Ideally, the temporary HFiles are of approximately equal size, which spreads your data evenly across the Region Servers.

We recommend using Bulk HFile importing; however, if your input might contain data errors that need checking, you must use our our [basic import procedures](bestpractices_ingest_import.html), `IMPORT_DATA` or `MERGE_DATA_FROM_FILE` instead, because they perform constraint checking during ingestion.
{: .noteNote}

The remainder of this topic contains these sections:

* [About Bulk HFile Import](#aboutBulkHfile)
* [Using Automatic Bulk HFile Import](#splitauto)
* [Using Manual Bulk HFile Import](#splitkey)
* [Bulk Importing Indexes](#indexhandling)
* [Parameters Used With Bulk Import](#table1)

You can also use bulk HFiles to speed up performance of the `INSERT` statement, as shown in the [Using Bulk Insert](#bulkinsert) example at the end of this topic.


## About Bulk HFile Import  {#aboutBulkHfile}

When you use bulk HFile import, Splice Machine first notes the points in your data where it can be split. During ingestion, the `BULK_IMPORT_HFILE` procedure splits the file into temporary Hadoop HFiles (store files) at those points. The store files are then loaded directly into your Region Servers. Ideally, the temporary HFiles are of approximately equal size, which spreads your data evenly across the Region Servers.

Splice Machine offers two bulk import variations:

* *Automatic Splitting* is the easier method because the `BULK_HFILE_IMPORT` procedure takes care of determining the key values that will evenly split your input data into HFiles. The procedure does this by sampling your data to figure out how to split it into (approximately) equal-sized HFiles. The next section, [automatic bulk Hfile ingestion](#splitauto) shows you how easily and quickly you can bulk import a file with automatic splitting.

* If you need even better performance from `BULK_HFILE_IMPORT` and are able to invest some extra effort, you can use [*Manual Splitting*](#splitkey) instead of using automatic splitting; this can be particularly valuable for very large datasets. Because `BULK_HFILE_IMPORT` does not have to sample your data to determine the splits, manual splitting can increase performance, though it adds some complexity and requires that you have enough knowledge of your data to determine where the splits should occur.

If you're going to index the table you're importing, Splice Machine recommends that you create the index prior to using bulk import. This allows the index to also be pre-split into regions, which will prevent downstream bottlenecks.
{: .noteIcon}

## Using Automatic Bulk HFile Import  {#splitauto}

This section shows you how to use bulk importing of data with automatic sampling, which means that the `BULK_IMPORT_HFILE` procedure samples your data to determine how to evenly (approximately) split it into HFiles. Here's what a call to this procedure looks like, with required parameters highlighted:

<div class="preWrapper"><pre class="Example">
call SYSCS_UTIL.BULK_IMPORT_HFILE('<span class="HighlightedCode">&lt;schemaName&gt;</span>', '<span class="HighlightedCode">&lt;tableName&gt;</span>', null,
        '<span class="HighlightedCode">&lt;inFilePath&gt;</span>', null, null, null, null, null, -1,
        '<span class="HighlightedCode">&lt;badRecordLogDirectory&gt;</span>', true, null, '<span class="HighlightedCode">&lt;temporaryFileDir&gt;</span>', '<span class="HighlightedCode">&lt;skipSampling&gt;</span>');</pre>
</div>

All of the `null` parameter values specify that default values should be used. All of the parameters are described, along with their default values, in [Table 1](#table1). Here's a call with actual values plugged in:

```
call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
        '/TPCH/1/lineitem', '|', null, null, null, null, -1,
        '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
```
{: .Example}

In the above call, the parameter values have the following meaning:
{: .spaceAbove}

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td class="CodeFont">'TPCH'</td>
            <td>Import the data into a table in the `TPCH` schema in our database.</td>
        </tr>
        <tr>
            <td class="CodeFont">'LINEITEM'</td>
            <td>Import the data into the `LINEITEM` table.</td>
        </tr>
        <tr>
            <td class="CodeFont">null</td>
            <td>Import all columns of data in the file.</td>
        </tr>
        <tr>
            <td class="CodeFont">'/TPCH/1/lineitem'</td>
            <td>The input file path.</td>
        </tr>
        <tr>
            <td class="CodeFont">'|'</td>
            <td>Columns in the input file are separated by the `|` character.</td>
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
            <td class="CodeFont">-1</td>
            <td>Any number of rejected (bad) records will be tolerated.</td>
        </tr>
        <tr>
            <td class="CodeFont">'/BAD'</td>
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
        <tr>
            <td class="CodeFont">'hdfs:///tmp/test_hfile_import/'</td>
            <td>The HDFS directory where temporary HFiles are stored until the import completes.</td>
        </tr>
        <tr>
            <td class="CodeFont">false</td>
            <td>Use automatic sampling.</td>
        </tr>
    </tbody>
</table>

### Example: Automatic Bulk HFile Import  {#exsplitauto}

To use Bulk HFile import with automatic splitting, follow these steps:


1.  __Create the table in your Splice Machine database:__

    ```
    splice> CREATE TABLE TPCH.LINEITEM (
                L_ORDERKEY BIGINT NOT NULL,
                L_PARTKEY INTEGER NOT NULL,
                L_SUPPKEY INTEGER NOT NULL,
                L_LINENUMBER INTEGER NOT NULL,
                L_QUANTITY DECIMAL(15,2),
                L_EXTENDEDPRICE DECIMAL(15,2),
                L_DISCOUNT DECIMAL(15,2),
                L_TAX DECIMAL(15,2),
                L_RETURNFLAG VARCHAR(1),
                L_LINESTATUS VARCHAR(1),
                L_SHIPDATE DATE,
                L_COMMITDATE DATE,
                L_RECEIPTDATE DATE,
                L_SHIPINSTRUCT VARCHAR(25),
                L_SHIPMODE VARCHAR(10),
                L_COMMENT VARCHAR(44),
                PRIMARY KEY(L_ORDERKEY,L_LINENUMBER)
            );
    ```
    {: .Example}
<br />
2.  __Create the index in your Splice Machine database:__

    ```
   splice>  CREATE INDEX L_SHIPDATE_IDX on TPCH.LINEITEM(
                L_SHIPDATE,
                L_PARTKEY,
                L_EXTENDEDPRICE,
                L_DISCOUNT
            );
    ```
    {: .Example}
<br />
3.  __Create a directory on HDFS for the temporary HFiles. For example:__

    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    ```
    {: .Example}

    Make sure that the directory you create has permissions set to allow
    Splice Machine to write your CSV and Hfiles there.
    {: .spaceAbove}

4.  __Import your data:__

    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                's3a://splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
    ```
    {: .Example}

    Note that the final parameter, `skipSampling`, is `false` in the above call; this tells `BULK_IMPORT_HFILE` to split the data based on its own sampling. All of the parameters are summarized in [Table 1](#table1) below.
    {: .spaceAbove}


## Using Manual Bulk HFile Import {#splitkey}

If you don't get the performance you're hoping from with automatic bulk import, you can manually specify how `BULK_IMPORT_HFILE` should split your data by providing a CSV file with key values in it. You pass the CSV file in to the `SPLIT_TABLE_OR_INDEX` procedure to pre-split the data, and then call the `BULK_IMPORT_HFILE` procedure to import the HFiles, as shown in the example below.

*Pre-splitting* means that `SPLIT_TABLE_OR_INDEX` notes where to split the table that you're importing into during ingestion, and stores that split information. When you call `BULK_IMPORT_HFILE` with the `skipSampling` parameter set to `true`, the procedure makes use of that information to split the table.

The remainder of this section contains these subsections:
* [Manual Bulk Import Basics](#manualbasics) provides basic information about manual bulk import.
* [Bulk Importing Indexes](#indexhandling) presents options for indexes on bulk imported tables.
* [Example: Manual Bulk HFile Import](#exsplitkeys) shows an example of using bulk import.

### Manual Bulk Import Basics  {#manualbasics}

The basic flow for manual bulk import is:

1. Create a new table in your Splice Machine database.
2. Optionally create an index on that table.
3. Determine key values for the table that will split it evenly and store them in a CSV file.
4. Call `SPLIT_TABLE_OR_INDEX` with the table name and that CSV file
5. Optionally:
   a. Determine key values that will split the index evenly and store them in a CSV file.
   b. Call `SPLIT_TABLE_OR_INDEX` with the table name, index name, and that CSV file.
5. Call `BULK_IMPORT_HFILE` with `skipSampling=true` to import the file.

You can use the `SPLIT_TABLE_OR_INDEX` in two ways:

* To compute splits for a table into which you're about to bulk import a file: specify a table name, but not an index name, and the name of the CSV file that contains the table split key values.

* To compute splits for an index on a table into which you're about to bulk import a file: specify a table name, an index name, and the name of the CSV that contains the index split key values.

In both cases, `SPLIT_TABLE_OR_INDEX` associates the split key information with the table so that `BULK_IMPORT_HFILE` can use it during ingestion. If you pre-split your table, we also recommend that you pre-split your index; otherwise, your index table could eventually become a performance bottleneck. If your index includes your primary key, this is simple: you can use the same split key values for both.

When you call `BULK_IMPORT_HFILE` with `skipSampling=true`, it assumes that you have previously called `SPLIT_TABLE_OR_INDEX` to pre-split the table; if you call it without first pre-splitting the table, `BULK_IMPORT_HFILE` will store the entire file in one region; such a table will suffer from very poor performance until you perform a major compaction.
{: .noteImportant}


### Example: Manual Bulk HFile Import {#exsplitkeys}

To use Bulk HFile import by manually specifying key values, follow the steps below:

1.  __Create the table in your Splice Machine database:__

    ```
    splice> CREATE TABLE TPCH.LINEITEM (
                L_ORDERKEY BIGINT NOT NULL,
                L_PARTKEY INTEGER NOT NULL,
                L_SUPPKEY INTEGER NOT NULL,
                L_LINENUMBER INTEGER NOT NULL,
                L_QUANTITY DECIMAL(15,2),
                L_EXTENDEDPRICE DECIMAL(15,2),
                L_DISCOUNT DECIMAL(15,2),
                L_TAX DECIMAL(15,2),
                L_RETURNFLAG VARCHAR(1),
                L_LINESTATUS VARCHAR(1),
                L_SHIPDATE DATE,
                L_COMMITDATE DATE,
                L_RECEIPTDATE DATE,
                L_SHIPINSTRUCT VARCHAR(25),
                L_SHIPMODE VARCHAR(10),
                L_COMMENT VARCHAR(44),
                PRIMARY KEY(L_ORDERKEY,L_LINENUMBER)
            );
    ```
    {: .Example}
<br />
2.  __Create the index in your Splice Machine database:__

    ```
   splice>  CREATE INDEX L_SHIPDATE_IDX on TPCH.LINEITEM(
                L_SHIPDATE,
                L_PARTKEY,
                L_EXTENDEDPRICE,
                L_DISCOUNT
            );
    ```
    {: .Example}
<br />
3.  __Find primary key values that can horizontally split the table into roughly equal sized partitions.__

    For this example, we provide 3 keys in a file named `lineitemKey.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our three keys includes a second column that is `null`:__

	```
	1500000|
	3000000|
	4500000|
	```
    {: .Example}

	For every N lines of split data you specify, you’ll end up with N+1 regions; for example, the above 3 splits will produce these 4 regions:
    {: .spaceAbove}

	```
	0 -> 1500000
	1500000 -> 3000000
	3000000 -> 4500000
	4500000 -> (last possible key value)
	```
    {: .Example}
<br />
4.  __Specify the column names in the CSV file in the `columnList` parameter; in our example, the primary key columns are:__

	```
	L_ORDERKEY,L_LINENUMBER
	```
    {: .Example}
<br />
5.  __Invoke  the `SYSCS_SPLIT_TABLE_OR_INDEX` procedure to pre-split the table file:__

	```
	call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
        	'LINEITEM',null, 'L_ORDERKEY,L_LINENUMBER',
        	'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
        	'|', null, null, null,
        	null, -1, '/BAD', true, null);
	```
    {: .Example}

	Note that `SYSCS_SPLIT_TABLE_OR_INDEX` uses the same parameters as our basic import procedures.
    {: .spaceAbove}

6.  __Now find index values that can horizontally split your index into equal-sized partitions.__

	For this example, we provide 2 index values in a file named `shipDateIndex.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our keys includes `null` column values:

	```
	1994-01-01|||
	1996-01-01|||
	```
    {: .Example}
<br />
7.  __Specify the column names in that CSV file in the `columnList` parameter; in our example, the index columns are:__

	```
	L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT
	```
    {: .Example}
<br />
8.  __Invoke SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX to pre-split your index file:__

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
9. __Import the file into your database:__

    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                's3a://splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null,
                -1, '/BAD', true, null,
                'hdfs:///tmp/test_hfile_import/', true);
    ```
    {: .Example}

    Note that the final parameter, `skipSampling` is `true` in the above call; this tells `BULK_IMPORT_HFILE` that the data has already been pre-split into HFiles.
    {: .spaceAbove}


## Parameters Used With Bulk Import  {#table1}

The following table summarizes the parameters you use when calling the `BULK_IMPORT_HFILE` and `SYSCS_SPLIT_TABLE_OR_INDEX` procedures.

The [Data Ingestion Parameter Values](bestpractices_ingest_params.html) topic in this chapter provides reference information for all of these parameters.
{: .noteNote}

<table>
    <caption class="tblCaption">Table 1: Bulk HFile Import Parameters</caption>
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

## Using Bulk Insert  {#bulkinsert}

There's one more way to use bulk HFiles for ingesting data into your Splice Machine tables: you can add a set of hints to an `INSERT` statement that tell the database to use bulk import technology to insert a set of query results into a table.

Splice Machine allows you to specify [optimization hints](developers_tuning_queryoptimization.html){: target="_blank"}; one of these *hints*, `bulkImportDirectory`, can be used to perform bulk loading with the SQL `INSERT` statement.

You do this by adding these hints to the `INSERT`:
* The `bulkImportDirectory` hint is used just as it is with the `BULK_HFILE_IMPORT` procedure: to specify where to store the temporary HFiles used for the bulk import.
* The `useSpark=true` hint tells Splice Machine to use the Spark engine for this insert. This is __required__ for bulk HFile inserts.
* The `skipSampling` hint is used just as it is with the `BULK_HFILE_IMPORT` procedure (see [Table 1](#table1)): to tell the bulk insert to compute the splits automatically or that the splits have been supplied manually.

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
<br />
## For Additional Information

Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [SYSCS_UTIL.BULK_IMPORT_HFILE](sqlref_sysprocs_importhfile.html)
* [SYSCS_UTIL.COMPUTE_SPLIT_KEY](sqlref_sysprocs_computesplitkey.html)
* [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html)


</div>
</section>
