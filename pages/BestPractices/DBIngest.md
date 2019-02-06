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
This topic provides an overview and examples of the different methods you can use to ingest data into your Splice Machine database, in these sections:

* The [Overview](#overview) section enumerates the ingestion methods that are available.
* [Selecting the Right Ingest Method](#method) helps you to decide which method makes the most sense for your particular situation.
* [Using Standard Import Procedures](#standard) delves into the details of and presents examples of using our standard import procedures (import, upsert, merge).
* [Using Bulk HFile Loading](#bulkload) provides details and examples of using bulk HFile loading.
* [Using the Native Spark DataSource](#spark) shows you how you can use the Splice Machine Native Spark DataSource to ingest data.
* [Using External Tables](#external) presents examples of accessing data in external tables.
* [Using Streaming](#streaming) describes and presents examples of streaming data into your database.

## Overview {#overview}
Question: What's the best way for me to ingest data into my Splice Machine database?

Splice Machine provides several different methods for ingesting data; which one you use depends on a number of factors. This topic will help you determine which method is best for you. Here's a quick overview of the available methods for ingestion:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Ingestion Method</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Standard file import</em></td>
            <td><p>All of the Splice Machine built-in import procedures work similarly:</p>
				<table>
				    <col />
				    <col />
				    <tbody>
				        <tr>
				            <td><code>Import_Data</code></td>
				            <td><p>Imports data into your database, creating a new record in your table for each record in the imported data.</p>
								<p><code>Import_Data</code> inserts the default value (or <code>NULL</code> if no default is specified in the schema) of a column when that column is not contained in the input record.</p>
							</td>
				        </tr>
				        <tr>
				            <td><code>Upsert_Data_From_File</code></td>
				            <td><p>Imports data into your database, either updating a matching record in your table with new values or creating a new record in the table.</p>
								<p>When <code>Upsert_Data_From_File</code>  finds a matching record in the table, it updates that row with all of the values in the input record; if the input does not contain a value for a column, that column in the row is updated with its default value  (or <code>NULL</code> if no default is specified in the schema).</p>
							</td>
				        </tr>
				        <tr>
				            <td><code>Merge_Data_From_File</code></td>
				            <td><p>Imports data into your database, either updating a matching row in your table with new values or creating a new record (row) in the table.</p>
								<p>Merging differs from upserting in how it handles updating a column when the input doesn't contain a value: <code>Merge_Data_From_File</code> does not modify the value of an column that's not specified in the input.</p>
							</td>
				        </tr>
				    </tbody>
				</table>
			</td>
        </tr>
        <tr>
            <td><em>Bulk HFile import</em></td>
            <td><p>For larger datasets, you can use the <code>BULK_IMPORT_HFILE</code> procedure, which temporarily splits your table file into HBase HFiles, directly inserts them into your database in bulk, and then removes the temporary HFiles.</p>
				<p class="noteIcon">Bulk importing has tremendous performance advantages; however bulk import does not check constraints.</p>
				<p>For even better performance, you can provide additional information to <code>BULK_IMPORT_HFILE</code> to help it distribute your data evenly into HBase regions; ideally, each region will end up containing the same number of table rows. You can tell <code>BULK_IMPORT_HFILE</code> to split your data in these ways:</p>
				<table>
				    <col />
				    <col />
				    <tbody>
				        <tr>
				            <td><em>Automatic Splitting</em></td>
				            <td><p>The  <code>BULK_IMPORT_HFILE</code> procedure automatically determines how to split your data into regions by sampling your input data.</p>
							</td>
				        </tr>
				        <tr>
				            <td><em>Pre-split data with split keys</em></td>
				            <td><p>You specify the key values to use and then call a procedure (<code>SPLIT_TABLE_OR_INDEX</code>) that  pre-splits your input data before you call <code>BULK_IMPORT_HFILE</code> to ingest the data.</p>
							</td>
				        </tr>
				    </tbody>
				        <tr>
				            <td><em>Pre-split data by row boundaries</em></td>
				            <td><p>You specify the row boundaries at which the data should be split, call a procedure (<code>SPLIT_TABLE_OR_INDEX_AT_POINTS</code>) that  pre-splits your input data before you call <code>BULK_IMPORT_HFILE</code> to ingest the data.</p>
								<p>Pre-splitting by row boundaries requires HBase expertise and keen knowledge of the data that you're ingesting.</p>
							</td>
				        </tr>
				    </tbody>
				    </tbody>
				</table>
			</td>
        </tr>
        <tr>
            <td><em>External table</em></td>
            <td><p>If your data resides in a flat file somewhere, you can:</p>
			 	<ul>
					<li>query that data directly without ingesting it into your database by creating an external table that references the file.</li>
					<li>create an external table spec and create an internal table in your database to map all or part of the external table, inserting data from the external table as part of the table creation process.</li>
				</ul>
			</td>
        </tr>
        <tr>
            <td><em>Native Spark DataSource</em></td>
            <td>The Splice Machine Native Spark DataSource is native to Spark and operates directly on DataFrames, which means that you can pull the contents of an entire DataFrame into your database without using a serialized connector.</td>
        </tr>
        <tr>
            <td><em>Streaming</em></td>
            <td>You can stream data directly into your database using Kafka.</td>
        </tr>
    </tbody>
</table>


## Selecting the Right Ingest Method  {#method}
Which method you should use to ingest your data depends on a number of factors. This section will help guide your decision.

Let's start with how you plan to get at your data:

* If you want to stream the data into Splice Machine, please jump to the [Ingest Streaming Data](#streaming) section.
* If you want to access the data as an external table, please jump to the [Using an External Table](#externaltable) section.
* Otherwise, continue on to our [Standard Import](#standard) section.

### Selecting the Right Standard Import Method

To get started, please make sure you know the answers to these basic questions:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Question</th>
            <th>Typical Values</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Where will your data be accessed?</td>
            <td><ol>
                    <li>In HDFS on a node in your cluster</li>
                    <li>On a local computer</li>
                    <li>In an S3 bucket on AWS</li>
                    <li>In BLOB storage on Azure</li>
                    <li>In a Spark DataFrame</li>
                </ol>
            </td>
        </tr>
        <tr>
            <td>What's the approximate size of the data?</td>
            <td><ol>
                    <li>size < 10GB</li>
                    <li>size < 100GB</li>
                    <li>size < 500GB</li>
                    <li>size >= 500GB</li>
                </ol>
            </td>
        </tr>
        <tr>
            <td>Do you need constraint checking applied as the data is inserted into your database?</td>
            <td><ol>
                    <li>Yes</li>
                    <li>No</li>
                </ol>
            </td>
        </tr>
    </tbody>
</table>

The following table 


Decision Tree(s) Here:
If your data is in a Spark DataFrame, see  Using the Native Spark DataSource
If you want to access the data in an external data without copying it into your database, see Using External Tables
If you are streaming data into your database, see Using Streaming
IF XXX, see Using Standard Import Procedures
If YYY, see Using Bulk HFile Loading


Using Standard Import Procedures
You should use one of the standard import procedures, which provide excellent performance,  if any of the following are true:
* You're importing a small amount of data (data_size <= XXXGB)
* You need constraint checking applied to the data that you're ingesting
* You need to update matching records in an existing table
If none of those factors are true, then you can take advantage of the performance boost provided by bulk HFile ingestion, which is described in the next section.


Using Bulk HFile Loading
If you're using bulk HFile import to ingest a dataset that's less than 300GB, you can simply tell the BULK_HFILE_IMPORT procedure to automatically compute the HFile splits by sampling the data. This is simpler than pre-splitting, and the performance hit due to the extra work of sampling isn't really noticeable for datasets of that size. Our tutorial contains an example of this.
When you use bulk import, Splice Machine temporarily creates temporary HFiles for your data, then ingests the data, and then deletes the temporary HFiles. If you're importing an indexed table, you can and should also use bulk import for ingesting your index.
For this section, we'll create a table and index with the following DDL:
        CREATE TABLE TPCH.LINEITEM (
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


        CREATE INDEX L_SHIPDATE_IDX on TPCH.LINEITEM(
            L_SHIPDATE,
            L_PARTKEY,
            L_EXTENDEDPRICE,
            L_DISCOUNT
        );
Automatic Splitting
To use Bulk HFile import with automatic splitting, you can follow these steps:
1. Create a directory on HDFS for the import. For example:
sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
1. Import your data:
call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                '/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
Pre-Splitting into HFiles
If you're familiar enough with your data to do so, specifying how to split your data will boost ingest performance, especially for very large datasets.  You have two choices for pre-splitting your data:
* You can specify how to split your data into HFiles by providing key values that will split your data into roughly equal-sized HFiles.
* If you have the expertise to do so, you  can specify table row boundaries at which to split your data into roughly equal-sized HFiles.
Note: Splice Machine recommends that you specify how to split your data whenever possible, as this can dramatically improve ingest performance.
Specifying Split Keys
To boost the bulk HFile ingestion performance by pre-splitting, we recommend specifying your own split keys. You do this by:
1. Create a CSV file that defines the split keys for your data:
   1. Find primary key values that can horizontally split the table into roughly equal-sized partitions
   2. 1. Call the SYSCS_SPLIT_TABLE_OR_INDEX procedure to split the dataset into HFiles:
call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
                    'LINEITEM',null, 'L_ORDERKEY,L_LINENUMBER',
                    'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
                    '|', null, null, null,
                    null, -1, '/BAD', true, null);


1. Create a CSV file that defines the split keys for your index:
   1. 1. Call the SYSCS_SPLIT_TABLE_OR_INDEX procedure to split the index into HFiles:
call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
                    'LINEITEM',null, 'L_ORDERKEY,L_LINENUMBER',
                    'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
                    '|', null, null, null,
                    null, -1, '/BAD', true, null);
1. Call the BULK_HFILE_IMPORT to import the HFiles into your database:
call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
                    'LINEITEM', 'L_SHIPDATE_IDX',
                    'L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT',
                    'hdfs:///tmp/test_hfile_import/shipDateIndex.csv',
                    '|', null, null,
                    null, null, -1, '/BAD', true, null);


Specify Row Boundary Splits
If you are comfortable with how HBase and HFiles work, and you're very familiar with how the data you're ingesting can be split into (approximately) evenly-sized regions, you can apply more finely-grained pre-split specifications, as follows[b]:
1. Create a CSV file that defines the row boundaries.
2. Call the SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS procedure to split the dataset into HFiles.
3. Call the BULK_HFILE_IMPORT to import the HFiles into your database.
Using the Native Spark DataSource


Using External Tables


Using Streaming
Documentation Links:
Our Importing Data Tutorial provides details about and examples of using the available methods for ingesting data.
And our SQL Reference Manual contains reference pages for each of the system procedures discussed in this article:
* SYSCS_UTIL.IMPORT_DATA
* SYSCS_UTIL.UPSERT_DATA_FROM_FILE
* SYSCS_UTIL.MERGE_DATA_FROM_FILE
* SYSCS_UTIL.BULK_IMPORT_HFILE
* SYSCS_UTIL.COMPUTE_SPLIT_KEY
* SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS
* SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX
[a]GENE: formatting is getting to the point where it's costing me a lot of time to use google docs instead of jekyll. I'll switch to Jekyll after we meet on this.
[b]Not sure if we want to elaborate on this option.
</div>
</section>
