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

## Selecting the Right Ingest Method  {#method}
Which method you should use to ingest your data depends on a number of factors. This section will help guide your decision.

Let's start with how you plan to get at your data:

* If you have data in a Spark DataFrame, see the section about [Ingesting with the Native Spark DataSource](#sparkadapter), which allows you to insert data directly from a DataFrame into your database, providing great performance by eliminating the need to serialize and deserialize the data.
* If you want to stream the data into Splice Machine, please jump to the [Ingesting Streaming Data](#streaming) section.
* If you want to access the data as an external table, please jump to the [Ingesting Data With an External Table](#externaltable) section.
* Otherwise, continue on to our [Importing Data Files](#datafiles) section.

## Importing Data Files  {#datafiles}

Splice Machine provides two major pathways for importing data and indexes from files (typically in CSV format) into your database: standard import and bulk HFile import; each pathway has different variations that use different system procedures. The following table summarizes some of the pros and cons of using each variation:

<table>
    <col width="24%" />
    <col width="14%" />
    <col width="14%" />
    <col width="24%" />
    <col width="24%" />
    <thead>
        <tr>
            <th>Import Method</th>
            <th>Complexity</th>
            <th>Performance</th>
            <th>Pros</th>
            <th>Cons</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>IMPORT_DATA</code></td>
            <td>Low</td>
            <td>Standard</td>
            <td><p>Constraint checking</p>
                <p>Best for small datasets</p>
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
            <td><code>BULK_IMPORT_HFILE</code> with<br />automatic Splitting</td>
            <td>Moderate</td>
            <td>Medium</td>
            <td>Enhanced performance</td>
            <td>No constraint checking</td>
        </tr>
        <tr>
            <td><code>BULK_IMPORT_HFILE</code> with<br />pre-Split Keys</td>
            <td>High</td>
            <td>High</td>
            <td>Better performance</td>
            <td><p>No constraint checking</p>
                <p>Must specify split keys for input data</p>
            </td>
        </tr>
        <tr>
            <td><code>BULK_IMPORT_HFILE</code> with<br />pre-Split Row Boundaries</td>
            <td>Very High</td>
            <td>Best</td>
            <td>Best performance, especially for extremely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify row boundaries for splitting input data</p>
            </td>
        </tr>
    </tbody>
</table>

### About Pre-Splitting Data

When you use the `BULK_IMPORT_HFILE` procedure to import your data, your input dataset is split into temporary HBase HFiles, then imported into your database. When the process is done, the temporary files are deleted.

This approach can yield significant performance boosts, especially for large datasets. Why? Because when splits are specified for the input dataset, Splice Machine can pre-split the data into HFiles and take advantage of the bulk loading mechanism in HBase. Pre-splitting is the process of preparing and loading HFiles (HBase’s own file format) directly into the RegionServers, thus bypassing the write path; this requires significantly less resources, reduces latency, and avoids frequent garbage collection, all of which can occur when importing un-split datasets, especially when they're very large. Optimally, you compute pre-splits that will generate roughly equal-sized HFiles, which can then be mapped into (approximately) equal-size regions, which produces optimal performance.

The `BULK_IMPORT_HFILES` procedure can automatically determine the key which keys to use for splitting the data; this generally produces excellent results. If you already know how your data can be evenly partitioned, you can manually provide the key values or row boundaries for even better performance. The examples later in this document show you how to accomplish this.

### Selecting the Right Data Files Method

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
        <tr>
            <td>Do you understand your data well enough to know how to split it into approximately evenly-sized partitions?</td>
            <td><ol>
                    <li>Yes</li>
                    <li>No</li>
                </ol>
            </td>
        </tr>
        </tr>
    </tbody>
</table>

Here are some simple guidelines to quickly guide you to the right choice, based on your answers to those questions:

* If you need constraint checking applied during ingestion, you must choose one of the standard import methods: Import, Upsert, or Merge. Your choice should be based on this criteria:
  * If you're importing all new data, use `IMPORT_DATA`.
  * If you are importing updates in addition to new data, then your choice depends on how you want updated records handled:
      - `UPSERT_DATA` replaces the value of every column in the updated record, using default values (or `NULL` if no default is defined) for any column values not contained in the input data.
      - `MERGE_DATA` does not replace the value of a column that is not specified in the input data.

* If you're ingesting a dataset that whose size is less than 10GB or so, there's no need to use bulk HFiles. You can choose whichever standard import method works best for you, as described above.

* If you have a dataset whose size is less than 250GB or so, you should use bulk loading. The least complicated way to do this is to use the automatic splitting feature of `BULK_IMPORT_HFILES`. For enhanced bulk import performance, it may be worth your while to deal with the added complexity of specifying your own pre-split keys or region boundaries.

No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample.

### Using Standard Import Procedures
You should use one of the standard import procedures, which provide excellent performance,  if any of the following are true:
* You're importing a small amount of data (data_size <= XXXGB)
* You need constraint checking applied to the data that you're ingesting
* You need to update matching records in an existing table


## Using Bulk HFile Loading
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

#### Automatic Splitting
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

#### Specifying Split Keys
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


#### Specifying Row Boundary Splits
If you are comfortable with how HBase and HFiles work, and you're very familiar with how the data you're ingesting can be split into (approximately) evenly-sized regions, you can apply more finely-grained pre-split specifications, as follows[b]:
1. Create a CSV file that defines the row boundaries.
2. Call the SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS procedure to split the dataset into HFiles.
3. Call the BULK_HFILE_IMPORT to import the HFiles into your database.

## Ingesting with the Native Spark DataSource  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data.

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
