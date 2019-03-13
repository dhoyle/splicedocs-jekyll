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

This topic describes using our `BULK_IMPORT_HFILE` procedure to import flat files into your Splice Machine database. Our Bulk HFile import yields high performance for larger datasets by pre-splitting your files into Hadoop HFiles; the splitting can be done in three ways: automatic sampling, by key values, and by row, each of which has complexity/performance trade-offs.

When you use Bulk HFile importing, constraint checking is not applied as your data is loaded into your database. If you need constraint checking, please use our [standard import procedures](bestpractices_ingest_import.html).
{: .noteImportant}

This topic starts with a discussion of bulk HFile importing and pre-splitting your input data, then describes the parameters you use when calling our bulk import methods, and then presents these examples of using the `BULK_IMPORT_HFILE` procedure:

* [Bulk Import with Sampled Splitting](#bulksampled)
* [Bulk Import with Key Value Pre-Splits](#bulksplitkeys)
* [Bulk Import with Row Pre-Splits](#bulksplitrows)

You can also use bulk HFiles to speed up performance of the `INSERT` statement, as shown in the [Bulk Insert](#bulkinsert) example at the end of this topic.
{: .noteNote}

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html); for examples of using our standard flat file import procedures, see [Importing Flat Files](bestpractices_ingest_import.html), also in this section.

## How to Use Bulk HFile Import

You use bulk HFile import just as you would use our standard import procedures, with one additional requirement: our `BULK_IMPORT_HFILE` procedure has to be pre-split into temporary HFiles (store files) before it is imported into your database by directly loading the generated StoreFiles into your Region Servers. Ideally, the temporary HFiles are of approximately equal size, which spreads your data evenly across the Region Servers.

You can use three different methods of pre-splitting your data, each of which has complexity/performance trade-offs, as described in the next section. Here's a typical call to `BULK_IMPORT_HFILE`; this call uses sampling (the simplest method) to split the data and imports data in the `/TPCH/1/LINEITEM` file into a table named `LINEITEM` in the `TPCH` schema in your database:

```
call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
        '/TPCH/1/lineitem', '|', null, null, null, null, -1,
        '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
```
{: .Example}

The above call to `BULK_IMPORT_HFILE` includes a number of `null` values, which indicate that default values should be used for those parameters. In this call:
{: .spaceAbove}

* Date and time values are formatted in standard format
* Commas are used to separate values
* String values are enclosed in double quotes
* The `-1` value means that the import should continue processing when any bad input records are found, logging input errors to files in the `hdfs:///tmp/test_hfile_import` directory
* The `false` final parameter (`skipSampling=false`) tells `BULK_IMPORT_HFILE` that it should sample the input data and perform the pre-splits itself. The next section includes descriptions of the parameters that you use for bulk importing.

### About Pre-Splitting Your Data
Pre-splitting is the process of preparing and loading HFiles (HBase’s own file format) directly into the RegionServers, thus bypassing the write path; this requires significantly less resources, reduces latency, and avoids frequent garbage collection, all of which can occur when importing un-split datasets, especially when they're very large. Optimally, your data should be split into almost equal-sized HFiles, which allows the data to be spread evenly across your cluster nodes and allows for maximum parallelism.

The following table summarizes the three methods for pre-splitting your data for bulk HFile ingestion:


<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Pre-split Method</th>
            <th>Added Complexity</th>
            <th>Discussion</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Sampling</td>
            <td>None</td>
            <td><p>Simply tell <code>BULK_IMPORT_HFILE</code> to sample your data to determine the splits. This generally produces excellent performance.</p>
                <p>See the <a href="bulksampled">Bulk Import with Sampled Splitting Example</a> below.</p>
            </td>
        </tr>
        <tr>
            <td>Split Keys Provided</td>
            <td>Moderate</td>
            <td><p>You need to determine which key values will yield roughly equal splits and specify them in a CSV file. This can improve the performance of bulk ingestion.</p>
                <p>To use this method, you pass the CSV file to the <code>SPLIT_TABLE_OR_INDEX</code> procedure to pre-split the data, and then call the <code>BULK_IMPORT_HFILE</code> procedure to import the HFiles.</p>
                <p>See the <a href="#bulksplitkeys">Bulk Import with Key Value Pre-Splits</a> for an example.</p>
            </td>
        </tr>
        <tr>
            <td>Row Boundaries Provided</td>
            <td>High</td>
            <td><p>You need to find the row boundaries in your data that will yield roughly equal splits and specify them in a CSV file. This requires the most examination of your data, and can produce the best performance.</p>
                <p>To use this method, you pass the CSV file to the <code>SPLIT_TABLE_OR_INDEX_AT_POINTS</code> procedure to pre-split the data, and then call the <code>BULK_IMPORT_HFILE</code> procedure to import the HFiles.</p>
                <p>See the example in the <a href="#bulksplitrows">Bulk Import with Row Pre-Splits</a> section below.</p>
                <p class="noteIcon">Due to the complexity of this approach, Splice Machine recommends reserving it for extreme circumstances, such as needing to ingest enormous data files in a highly performant manner.</p>
            </td>
        </tr>
    </tbody>
</table>

### Parameters Used With the Data File Bulk Import Procedures  {#table1}

The following table summarizes the parameters you use when calling the `BULK_IMPORT_HFILE` procedure. Note that the `SYSCS_SPLIT_TABLE_OR_INDEX` and `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` pre-splitting procedures use almost exactly the same set of parameters:

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

## Example: Bulk Import with Sampled Splitting  {#bulksampled}

To use Bulk HFile import with sampled splitting, you can follow these steps:

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

    Note that the final parameter, `skipSampling` is `false` in the above call; this tells `BULK_IMPORT_HFILE` to split the data based on its own sampling.
    {: .spaceAbove}
<br />

## Example: Bulk Import with Key Value Pre-Splits  {#bulksplitkeys}

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


## Example: Bulk Import with Row Pre-Splits  {#bulksplitrows}

If you're comfortable with how HBase and HFiles work, and you're very familiar with how the data you're ingesting can be split into (approximately) evenly-sized regions, you can apply more finely-grained pre-split specifications, as follows:

1. Create a CSV file that defines the row boundaries.
2. Call `SYSCS_SPLIT_TABLE_OR_INDEX` to pre-split the table file.
3. Find the conglomerate ID of the table you're importing into.
4. Call `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` to split the table inside of the database.
5. Call `COMPUTE_SPLIT_KEY` to compute HBase split row keys and write them to a csv file.
6. Call `SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` to set up the indexes in your database.
7. Call `BULK_IMPORT_HFILE` to import the data.

Specifying row boundaries requires significant expertise and can be complicated. We only recommend using this approach when supplying split keys does not yield the performance you require.
{: .noteIcon}

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

## Example: Bulk Insert  {#bulkinsert}

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

When you use `bulkImportDirectory` with the `INSERT` statement, you __must also specify these two hints:
{: .spaceAbove}

* `useSpark=true`, since Splice Machine uses Spark to generate the HFiles
* `skipSampling`: set this to `false` to indicate that Splice Machine should sample the data that you're inserting to determine how to split it into HFiles; set it to `true` to indicate that the data you're inserting has already been split into HFiles.


## See Also

Our SQL Reference Manual includes reference pages for each of these system procedures, which include full information about the parameters, additional examples, and discussion of handling special cases and input errors:

* [SYSCS_UTIL.IMPORT_DATA](sqlref_sysprocs_importdata.html)
* [SYSCS_UTIL.UPSERT_DATA_FROM_FILE](sqlref_sysprocs_upsertdata.html)
* [SYSCS_UTIL.MERGE_DATA_FROM_FILE](sqlref_sysprocs_mergedata.html)
* [SYSCS_UTIL.BULK_IMPORT_HFILE](sqlref_sysprocs_importhfile.html)
* [SYSCS_UTIL.COMPUTE_SPLIT_KEY](sqlref_sysprocs_computesplitkey.html)
* [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS](sqlref_sysprocs_splittableatpoints.html)
* [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html)

</div>
</section>
