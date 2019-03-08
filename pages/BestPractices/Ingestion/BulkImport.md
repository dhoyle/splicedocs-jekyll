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

This topic starts with a discussion of pre-splitting your input data, then describes the parameters you use when calling our bulk import methods, and then presents these examples of using the `BULK_IMPORT_HFILE` procedure:

* [Bulk Import with Sampled Splitting](#bulksampled)
* [Bulk Import with Key Value Pre-Splits](#bulksplitkeys)
* [Bulk Import with Row Pre-Splits](#bulksplitrows)

You can also use bulk HFiles to speed up performance of the `INSERT` statement, as shown in the [Bulk Insert](#bulkinsert) example.
{: .noteNote}

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_intro.html).

## About Pre-Splitting Data for Bulk Import

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx
            <td><p><em>You're importing a large dataset without updates or constraint checking, and performance is important.</em></p>
                <p>Splice Machine recommends using bulk importing when ingesting very large datasets.</p>
            </td>
            <td><p>Use one of the variants of the <code>BULK_IMPORT_HFILE</code> procedure; from least complex to most complex, they are:</p>
                <ul class="bullet">
                    <li>Telling <code>BULK_IMPORT_HFILE</code> to sample the data and determine the splits. There's an example in the <a href="bulksampled">Bulk Import with Sampled Splitting Example</a> section below.</li>
                    <li>Manually supply, in a csv file, key values to split the data into HFiles. This takes more effort than sampled data, and produces better performance. See the <a href="#bulksplitkeys">Bulk Import with Key Value Pre-Splits</a> for an example.</li>
                    <li>Supply a list of row boundaries where the data should be split. This requires the most expertise and can yield the greatest performance; you'll find an example in the <a href="#bulksplitrows">Bulk Import with Row Pre-Splits</a> section below.</li>
                </ul>
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx

The Bulk Import options enhance ingestion performance for larger datasets by pre-splitting the input data into temporary HBase HFiles (store files), then using the HBase bulk import mechanism to then directly load the generated StoreFiles into your Region Servers.

Pre-splitting is the process of preparing and loading HFiles (HBase’s own file format) directly into the RegionServers, thus bypassing the write path; this requires significantly less resources, reduces latency, and avoids frequent garbage collection, all of which can occur when importing un-split datasets, especially when they're very large. Optimally, your data is split into almost equal-sized HFiles, which allows the data to be spread evenly across your cluster nodes and allows for maximum parallelism.

The `BULK_IMPORT_HFILE` procedure can use sampling to determine which keys to use and split the data; this generally produces excellent results.

If you already know which key values will produce even splits of your data, you can create a csv file of key values to use, and call our `SPLIT_TABLE_OR_INDEX` procedure to pre-split your data prior to calling `BULK_IMPORT_HFILE`; this further enhances ingest performance.  For some especially large datasets, it can be worthwhile to go even one step further by using exact row boundaries to pre-split your data; this requires expertise and introduces extra complexity, but can also push performance.


## Parameters Used With the Data File Bulk Import Procedures  {#table1}

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

You might notice that the bulk import procedures use the same set of parameters as do our standard import procedures, with two additions: the final two parameters, `bulkImportDirectory` and `skipSampling` only apply to the bulk import methods.

## Example: Bulk Import with Sampled Splitting  {#bulksampled}

To use Bulk HFile import with sampled splitting, you can follow these steps:

1.  __Create a directory on HDFS for the temporary HFiles. For example:__

    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    ```
    {: .Example}

<br />
2.  __Import your data:__

    ```
    call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                's3a://splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
    ```
    {: .Example}

    Note that the final parameter, `skipSampling` is `false` in the above call; this tells `BULK_IMPORT_HFILE` to split the data based on its own sampling.
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
2. Call the SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS procedure to split the dataset into HFiles.
3. Call the BULK_HFILE_IMPORT to import the HFiles into your database.

Specifying row boundaries requires significant expertise. We only recommend using this approach when supplying split keys does not yield the performance you require.
{: .noteIcon}

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

When you use `bulkImportDirectory` with the `INSERT` statement, you must also specify these two hints:
{: .spaceAbove}

* `useSpark=true`, since Splice Machine uses Spark to generate the HFiles
* `skipSampling`: set this to `false` to indicate that Splice Machine should sample the data that you're inserting to determine how to split it into HFiles; set it to `true` to indicate that the data you're inserting has already been split into HFiles.


## See Also
For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_intro.html).

The other topics in this *Best Practices: Ingestion* section provide examples of other ingestion scenarios:

* [Importing Flat Files](bestpractices_ingest_import.html)
* [Ingestion in Your Spark App](bestpractices_ingest_sparkapp.html)
* [Ingesting Streaming Data](bestpractices_ingest_streaming.html)
* [Ingesting External Tables](bestpractices_ingest_externaltbl.html)

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
