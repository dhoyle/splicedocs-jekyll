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

In this topic, we'll walk you through using our highly performant `BULK_IMPORT_HFILE` procedure to import flat files into your Splice Machine database. Bulk importing converts a data file into temporary HFiles (store files) before it is imported into your database by directly loading the generated StoreFiles into your Region Servers. Ideally, the temporary HFiles are of approximately equal size, which spreads your data evenly across the Region Servers.

We recommend using Bulk HFile importing; however, if your input might contain input errors that need checking, you need to use our our [basic import procedures](bestpractices_ingest_import.html) instead, because they perform constraint checking during ingestion.
{: .noteNote}

We'll start with an example, in the next section, that shows you how easily and quickly you can bulk import a file with [automatic bulk Hfile ingestion](#splitauto).

If you need even better performance from `BULK_HFILE_IMPORT` and are able to invest some extra effort, you can [manually specify the split key values](#splitkey) instead of using automatic splitting. This can be particularly valuable for very large datasets.

Finally, if you have significant expertise with your data, you can [manually specify the row boundaries](#splitrow) at which to split your data into HFiles.

You can also use bulk HFiles to speed up performance of the `INSERT` statement, as shown in the [Bulk Inserting Data](#bulkinsert) example at the end of this topic.

## Automatic Bulk HFile Ingestion  {#splitauto}

This section shows you how to use bulk importing of data with automatic sampling, which means that the `BULK_IMPORT_HFILE` procedure samples your data to determine how to evenly (approximately) split it into HFiles. Here's what a call to this procedure looks like, with required parameters highlighted:

<div class="preWrapper"><pre class="Example">
call SYSCS_UTIL.BULK_IMPORT_HFILE('<span class="HighlightedCode">&lt;schemaName&gt;</span>', '<span class="HighlightedCode">&lt;tableName&gt;</span>', null,
        '<span class="HighlightedCode">&lt;inFilePath&gt;</span>', null, null, null, null, null, -1,
        '<span class="HighlightedCode">&lt;badRecordLogDirectory&gt;</span>', true, null, '<span class="HighlightedCode">&lt;temporaryFileDir&gt;</span>', '<span class="HighlightedCode">&lt;skipSampling&gt;</span>');</pre>
</div>

All of the `null` parameter values specify that default values should be used. All of the parameters are described, along with their default values, in [Table 1]{#table1}. Here's a call with actual values plugged in:

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

### Example: Bulk HFile Import with Automatic Splitting  {#exsplitauto}

To use Bulk HFile import with automatic splitting, follow these steps:

1.  __Create a directory on HDFS for the temporary HFiles. For example:__

    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    ```
    {: .Example}

    Make sure that the directory you create has permissions set to allow
    Splice Machine to write your csv and Hfiles there.
<br />
2.  __Import your data:__

    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                's3a://splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
    ```
    {: .Example}

    Note that the final parameter, `skipSampling` is `false` in the above call; this tells `BULK_IMPORT_HFILE` to split the data based on its own sampling. All of the parameters are summarized in [Table 1](#table1) below.
    {: .spaceAbove}


## Parameters Used With the Data File Bulk Import Procedures  {#table1}

The following table summarizes the parameters you use when calling the `BULK_IMPORT_HFILE`,  `SYSCS_SPLIT_TABLE_OR_INDEX`, and `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` procedures.

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

## Manually Specifying Split Keys  {#splitkey}

If you don't get the performance you're hoping from with automatic bulk import, you can manually specify how `BULK_IMPORT_HFILE` should split your data by providing a CSV file with key values in it. You pass the CSV file in to the `SPLIT_TABLE_OR_INDEX` procedure to pre-split the data, and then call the `BULK_IMPORT_HFILE` procedure to import the HFiles, as shown in the example below.

### Example: Manually Specifying Split Key Values  {#exsplitkeys}

To use Bulk HFile import by manually specifying key values, follow these steps:


1.  __Find primary key values that can horizontally split the table into roughly equal sized partitions.__

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

	Note that `SYSCS_SPLIT_TABLE_OR_INDEX` uses the same parameters as our basic import procedures.
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

## Manually Specifying Row Boundaries  {#splitrow}

If you need to squeeze even more performance out of the ingestion, you can spend the time determining which row boundaries in your data will yield approximately even-sized HFiles. This adds complexity and requires extra effort, but may be worthwhie for extremely large datasets.

To use this method, you need to follow these steps:

1. Create a CSV file that defines the row boundaries.
2. Call `SYSCS_SPLIT_TABLE_OR_INDEX` to pre-split the table file.
3. Find the conglomerate ID of the table you're importing into.
4. Call `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` to split the table inside of the database.
5. Call `COMPUTE_SPLIT_KEY` to compute HBase split row keys and write them to a csv file.
6. Call `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` to set up the indexes in your database.
7. Call `BULK_IMPORT_HFILE` to import the data.

The next section contains an example of this process.

### Example: Manually Specifying Row Boundaries  {#exsplitrow}

Here are the steps:

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
<br />
4.  __Use `SHOW TABLES` to discover the conglomerate ID for the table you're importing into.__

    The `TPCH.LINEITEM` table in this example has conglomerate ID `1536`. This means that the split keys file for this table is in the `hdfs:///tmp/test_hfile_import/1536` directory. You\'ll see values like these:

    ```
    \xE4\x16\xE3`\xE4-\xC6\xC0\xE4D\xAA
    ```
    {: .Example}
<br />
5.  __Now use those values in a call to our system procedure to split the table inside the database:__
    ```
    call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS('TPCH','LINEITEM',
                null,'\xE4\x16\xE3`,\xE4-\xC6\xC0,\xE4D\xAA');
    ```
    {: .Example}
<br />
6.  __Now find index values that can horizontally split your index into equal-sized partitions.__

	For this example, we provide 2 index values in a file named `shipDateIndex.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our keys includes `null` column values:

	```
	1994-01-01|||
	1996-01-01|||
	```
    {: .Example}
<br />
7.  __Specify the column names in that csv file in the `columnList` parameter; in our example, the index columns are:__

	```
	L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT
	```
    {: .Example}
<br />
8.  __Invoke `SYSCS_UTIL.COMPUTE_SPLIT_KEY` to compute hbase split row keys and write them to a file:__

    ```
    call SYSCS_UTIL.COMPUTE_SPLIT_KEY('TPCH', 'LINEITEM', 'L_SHIPDATE_IDX',
            'L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT',
            'hdfs:///tmp/test_hfile_import/shipDateIndex.csv',
            '|', null, null, null, null, -1, '/BAD', true, null,
             'hdfs:///tmp/test_hfile_import/');
    ```
    {: .Example}
<br />
9.  __Set up the indexes in your database by first copying the row key values from the output file, and then using those values in a call to the `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` procedure to split the index:__

    ```
    call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS(
            'TPCH','LINEITEM','L_SHIPDATE_IDX',
            '\xEC\xB0Y9\xBC\x00\x00\x00\x00\x00\x80,
            \xEC\xBF\x08\x9C\x14\x00\x00\x00\x00\x00\x80');
    ```
    {: .Example}
<br />
10. __Import the HFiles Into Your Database__

    Once you have split your table and indexes, call the `BULK_IMPORT_HFILE` procedure to generate and import the HFiles into your Splice Machine database:
    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
            '/TPCH/1/lineitem', '|', null, null, null, null, -1,
            '/BAD', true, null,
            'hdfs:///tmp/test_hfile_import/', true);
    ```
    {: .Example}

## Bulk Inserting Data  {#bulkinsert}

There's one more way to use bulk HFiles for ingesting data into your Splice Machine tables: you can add a set of hints to an `INSERT` statement that tell the database to use bulk import technology to insert a set of query results into a table.

Splice Machine allows you to specify [optimization hints](developers_tuning_queryoptimization.html); one of these *hints*, `bulkImportDirectory` can be used to perform bulk loading with the SQL `INSERT` statement.

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

## For Additional Information

Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [SYSCS_UTIL.BULK_IMPORT_HFILE](sqlref_sysprocs_importhfile.html)
* [SYSCS_UTIL.COMPUTE_SPLIT_KEY](sqlref_sysprocs_computesplitkey.html)
* [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS](sqlref_sysprocs_splittableatpoints.html)
* [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html)


</div>
</section>
