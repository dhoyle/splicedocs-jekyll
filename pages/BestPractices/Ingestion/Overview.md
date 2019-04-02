---
title: Splice Machine Ingestion Best Practices
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_overview.html
folder: BestPractices/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Data - Overview

In this *Ingesting Data Best Practices* topic, we'll introduce you to the various methods you can use to ingest data into your Splice Machine database, guide you to the best method to use for your specific situation, and then direct you to example(s) that walk you through the steps to implement your ingestion solution.

To get started, use [Table 1](#table1), below, to determine which use case applies to your situation, then click the *How it Works* link in the table. You'll see a summary of how to ingest your data, and a link to a separate page that contains one or more detailed examples.

## Pick Your Use Case  {#table1}

Where the data that you're ingesting is coming from defines which approach you should take to importing that data into Splice Machine; how to use each approach is described, along with examples, in a section within this topic:

<table>
    <caption class="tblCaption">Table 1: Data Ingestion Use Cases</caption>
    <col />
    <col />
    <thead>
        <tr>
            <th>Your Use Case</th>
            <th class="spliceCheckbox">&nbsp;</th>
            <th>What to Read</th>
            <th>Relative Complexity</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">You have flat files to import</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#datafiles">Ingesting Flat Files</a></td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;<span class="bodyFont"><br />to<br /></span> &#x2713;&#x2713;&#x2713;&#x2713;&#x2713;<br /><span class="bodyFont">(see below)</span></td>
        </tr>
        <tr>
            <td class="ItalicFont">You're writing a Spark app</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#sparkadapter">Ingesting Data in a Spark App</a></td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;</td>
        </tr>
        <tr>
            <td class="ItalicFont">You're writing a streaming app</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#streaming">Ingesting Streaming Data</a></td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;&#x2713;</td>
        </tr>
        <tr>
            <td class="ItalicFont">You're accessing data in an external table</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#externalTable">Importing Data From an External Table</a></td>
            <td class="spliceCheckboxBlue">&#x2713;</td>
        </tr>
    </tbody>
</table>


## Importing Flat Files  {#datafiles}

The most common ingestion scenario is importing flat files into your Splice Machine database; typically, CSV files stored on a local computer, in the cloud, or in HDFS on your cluster. Splice Machine offers two primary methods for importing your flat files: *bulk HFile imports* and *basic flat file imports*. Each method has a few variants, which we'll describe later.

* Bulk HFile imports are highly performant because the import function pre-splits your data into Hadoop HFiles and imports them directly, which enhances the parallelism of the ingestion processing. When importing larger datasets, this can yield 10x ingestion performance compared to basic import methods. Splice Machine recommends that you use bulk HFile importing large files containing new data.

* Basic flat file imports are also performant, and have two important features that may be of importance to you: 1) you can update existing records in addition to adding new records (if and only if the table you're importing into has a Primary Key), and 2) constraint checking is applied to inserts and updates when using basic import methods.

No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample before jumping into importing a large dataset; this will help you to quickly debug any input problems.
{: .noteIcon}

### Determining Which Method to Use

There are three basic determinants for determining which method to use are:

1. Are you importing all new data or do will you also be updating records in an existing table?
2. Do you need constraint checking applied to the data you're importing?
3. Are you importing data files larger than 100GB?

The following table summarizes the decision framework for ingesting flat files:

<table>
    <col width="120px" />
    <col width="160px" />
    <col width="90px" />
    <col />
    <thead>
        <tr>
            <th>All New Data?</th>
            <th>Apply Constraints?</th>
            <th>Data Size</th>
            <th>Strategy</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>NO</td>
            <td>N/A</td>
            <td>N/A</td>
            <td><p>Use <code>MERGE_DATA</code>.</p>
                <p class="noteNote">The table into which you're merging data must have a primary key.</p></td>
        </tr>
        <tr>
            <td rowspan="3">YES</td>
            <td>YES</td>
            <td>N/A</td>
            <td>Use <code>IMPORT_DATA</code>.</td>
        </tr>
        <tr>
            <td rowspan="2">NO</td>
            <td><code>&lt;=100GB</code></td>
            <td>Use <code>IMPORT_DATA</code>; if that doesn't yield the performance you need, use <code>BULK_HFILE_IMPORT</code> with automatic splitting.</td>
        </tr>
        <tr>
            <td><code>&gt;100GB</code></td>
            <td><p>Use <code>BULK_HFILE_IMPORT</code> with automatic splitting; if that doesn't yield the performance you need, use <code>BULK_HFILE_IMPORT</code> with manual splitting.</p>
                <p class="noteNote">Manual splitting adds complexity and requires knowledge of your data: you must determine the key values that will split your input data into approximately evenly-sized partitions (regions).</p>
            </td>
        </tr>
    </tbody>
</table>

Note that all of the file import procedures require you to specify the same information about your data, such as: which delimiters are used, how dates and times are formatted, which character set is used, and how to handle invalidly formatted input records. You basically point the procedure at your source data and destination table/index, specify a few parameters, and start loading your data.

### About Bulk HFile Import

When you use bulk HFile import, Splice Machine first notes the points in your data where it can be split. During ingestion, the `BULK_IMPORT_HFILE` procedure splits the file into temporary Hadoop HFiles (store files) at those points. The store files are then loaded directly into your Region Servers. Ideally, the temporary HFiles are of approximately equal size, which spreads your data evenly across the Region Servers.

Splice Machine offers two bulk import variations:

* *Automatic Splitting* is the easier method because the `BULK_HFILE_IMPORT` procedure takes care of determining the key values that will evenly split your input data into HFiles. The procedure does this by sampling your data to figure out how to split it into (approximately) equal-sized HFiles.

* In *Manual Splitting*, you need to determine those key values yourself, which means that you need to know your data well enough to do that. Because `BULK_HFILE_IMPORT` does not have to sample your data, manual splitting can increase performance, though it adds complexity.

### Contrasting How Standard and Bulk Import Work

To help you better understand how standard and bulk import work differently, consider these significant differences in import processing:

* When using standard import methods, the data you're importing is added to your table; when the table fills a region, the table is split across two regions, and the new region starts filling with table data. With bulk import methods, all of the table regions are pre-allocated, and imported data is copied into those regions in parallel.

* When using standard import methods, Splice Machine uses the standard HBase write path, which writes to the HBase Write-ahead-Log (WAL), writes to memstore, flushes to disk, and causes compaction and region splitting. Bulk import bypasses all of this, which results in significantly improved performance.

{% comment %}
#### An Illustrative Example
Here's a very simple example to illustrate the difference. Suppose you're importing 100GB rows of data into an empty table, and that when the table was created, one 10GB region was allocated for it.

__TBD:__ Illustrate the difference in import activity for standard (1 region, then 2, then 4 with increasing parallelism, transactional) versus bulk (pre-allocated regions written in parallel, not transactional)
{% endcomment %}

### For Additional Information and Examples

* See the [*Bulk Importing Flat Files*](bestpractices_ingest_bulkimport.html) topic in this Best Practices chapter for detailed information about and examples of using bulk HFile ingestion.

* See the [*Basic Flat File Ingestion*](bestpractices_ingest_import.html) topic in this Best Practices chapter for more information about and examples of using basic flat file ingestion.


## Ingesting Data in a Spark App  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark apps (for use with spark-submit) that take advantage of the Native Spark DataSource, or you can use the DataSource in your Zeppelin notebooks.

Ingesting data into your Splice Machine database from Spark is simple: once the data is in a Spark DataFrame, you use the Native Spark DataSource's `insert` or `merge` operations to insert the data into a table in your database. These operations are extremely quick, because Splice Machine reads the data into the table directly, without serializing it, sending it over a wire, and deserializing. You can similarly move data from a Splice Machine table into a Spark DataFrame with a single, non-serialized operation.

The [*Ingesting Data in a Spark App*](bestpractices_ingest_sparkapp.html) topic in this Best Practices chapter contains an example of using the Native Spark DataSource in a standalone Spark application.

## Ingesting Streaming Data  {#streaming}

It's also easy to stream data into your Splice Machine database using Spark. The [*Ingesting Streaming Data*](bestpractices_ingest_streaming.html) topic in this Best Practices chapter presents  a sample program  that uses Spark and Kafka to ingest real-time data into a Splice Machine table.

## Ingesting Data With an External Table  {#externaltable}

Splice Machine supports *external tables*, which are flat files that you can reference, query, and update inside your database. One common use for external tables is to facilitate ingesting the data in a flat file into a table that you've created in your database. All you need to do is:

* Use the `CREATE EXTERNAL TABLE` statement to specify where your external file is and how it is formatted.
* Use the `INSERT INTO` statement to select data from the external file and insert it into a table in your database.

The [*Ingesting Data From an External Table*](bestpractices_ingest_externaltbl.html) topic in this Best Practices chapter contains an example of importing data from an ORC file.


</div>
</section>
