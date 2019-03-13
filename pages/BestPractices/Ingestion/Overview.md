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

In this *Ingesting Data Best Practices* topic, we'll introduce you to the various methods you can use to ingest data into your Splice Machine database, and we'll guide you to the best method to use for your specific situation. To get started, use [Table 1](#table1), below, to determine which use case applies to your situation, then click the *How it Works* link in the table. You'll see a summary of how to ingest your data, and a link to a separate page that contains one or more detailed examples.

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
            <th>How it Works</th>
            <th>Relative Complexity</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">You have flat files to import</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#datafiles">Importing Flat Files</a></td>
            <td class="spliceCheckboxBlue">1 to 3</td>
        </tr>
        <tr>
            <td class="ItalicFont">You're writing a Spark app</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#sparkadapter">Ingesting Data in a Spark App</a></td>
            <td class="spliceCheckboxBlue">2</td>
        </tr>
        <tr>
            <td class="ItalicFont">You're writing a streaming app</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#streaming">Ingesting Streaming Data</a></td>
            <td class="spliceCheckboxBlue">3</td>
        </tr>
        <tr>
            <td class="ItalicFont">You're accessing data in an external table</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#externalTable">Importing Data From an External Table</a></td>
            <td class="spliceCheckboxBlue">1</td>
        </tr>
    </tbody>
</table>


## Importing Flat Files  {#datafiles}

The most common ingestion scenario is importing flat files into your Splice Machine database; typically, CSV files stored on a local computer, in the cloud, or somewhere in your cluster, on HDFS. Splice Machine offers two primary methods for importing your flat files: *bulk HFile imports* and *standard flat file imports*. Each method has a few variants, which we'll describe below.

* Bulk HFile imports are highly performant because the import function pre-splits your data into Hadoop HFiles and imports them directly. When importing larger datasets, this can yield 10x ingestion performance compared to standard import methods. Splice Machine recommends that you use bulk HFile importing when possible; there are only restrictions: 1) bulk HFile importing cannot update existing records in your database, and 2) constraint checks are not applied to new records when using bulk HFile importing.

* Standard flat file imports are also performant, and have two important features that may be of importance to you: 1) you can update existing records in addition to adding new records (if and only if the table you're importing into has a Primary Key), and 2) constraint checking is applied to inserts and updates when using standard import methods.

The following table summarizes the relative performance, complexity, and functionality of our flat file ingestion methods:

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
            <td rowspan="3"><code>BULK_IMPORT_HFILE</code></td>
            <td>Sampled splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;&#x2713;</td>
            <td><p>Enhanced performance</p>
                <p>No major compaction required after ingestion</p>
            </td>
            <td>No constraint checking</td>
        </tr>
        <tr>
            <td>Keys supplied for splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2714;&#x2714;&#x2714;&#x2714;</td>
            <td><p>Better performance, especially for extermely large datasets</p>
                <p>No major compaction required after ingestion</p>
            </td>
            <td><p>No constraint checking</p>
                <p>Must specify split keys for input data</p>
            </td>
        </tr>
        <tr>
            <td>Row boundaries supplied for splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2714;&#x2714;&#x2714;&#x2714;&#x2714;</td>
            <td><p>Best performance for extremely large datasets</p>
                <p>No major compaction required after ingestion</p>
            </td>
            <td><p>No constraint checking</p>
                <p>Must specify row boundaries for splitting input data</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">Standard</td>
            <td><code>IMPORT_DATA</code></td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Best for pulling in small datasets of new records</p>
            </td>
            <td><p>Slow for very large datasets</p>
                <p>Should run major compaction after large import</p>
            </td>
        </tr>
        <tr>
            <td><p><code>UPSERT_DATA_FROM_FILE</code></p>
                <p><code>MERGE_DATA_FROM_FILE</code></p>
            </td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p>
                <p>Table must have primary key</p>
                <p>Should run major compaction after large import</p>
            </td>
        </tr>
    </tbody>
</table>

Our bulk HFile variations offers different levels of performance and require different levels of complexity, based on how you specify the HFile splits, keeping in mind that the ideal solution is to split your data into evenly-sized HFiles. The easiest way is to use *sampled* splitting, which adds no complexity on your part: Splice Machine samples your data to determine how to split your files. If that doesn't yield the performance you need, you can analyze your data to determine and specify the key values at which the data should be split. And if you need even greater performance, you can find and specify the row boundaries in your data files that will yield even splits.

If you don't need to apply constraints or update records, use our Bulk HFile import procedure; you'll likely get the performance you want with sampled splitting, which introduces no added complexity. And if you need to boost that performance, you can choose to invest in determining the splits yourself.

If you're updating records in an existing table, importing a small dataset (less than 100GB), or you do need to apply constraints, use one of our standard import methods: `IMPORT`, `UPSERT`, or `MERGE`. They all share the same complexity and set of parameters, and they all apply constraint checking; the difference is in how each updates (or doesn't) existing records.



* If you are updating existing records in your database during ingestion, you *must* use one of the standard import procedures; bulk HFile import *cannot update records*.
* If you need constraints applied during ingestion, you *must* use one of the standard import procedures; bulk HFile import *does not apply constraint checking*.
* Which standard import procedure (`IMPORT`, `UPSERT`, or `MERGE`) you use is determined by how you want existing records updated, as described in the [*Importing Flat Files*](bestpractices_ingest_import.html) topic in this section.
* Which bulk import procedure you use is determined by how performant the ingestion process must be and how you want to split your data into HFiles, as described in the [*Bulk Importing Flat Files*](bestpractices_ingest_bulkimport.html) topic in this section.

***NOTE: UPSERT/MERGE Do not handle deletes  (gene calls this net change importing)


Note that all of the file import procedures require you to specify the same information about your data, such as: which delimiters are used, how dates and times are formatted, which character set is used, and how to handle invalidly formatted input records. You basically point the procedure at your source data and destination table/index, specify a few parameters, and start loading your data.

Splice Machine recommends running a major compaction on a table after ingesting a significant amount of data into that table. For more information, see [Using Compaction and Vacuuming](developers_fundamentals_compaction.html).  *****NOT FOR HFILE BULK****--> Another bonus for bulk

No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample before jumping into importing a large dataset.
{: .noteIcon}

****ADVERTISE: FULL INFO FOR others here  (repeat links from above)

## Ingesting with the Native Spark DataSource  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark apps (for use with spark-submit) that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

Ingesting data into your Splice Machine database from Spark is simple: once the data is in a Spark DataFrame, you use the Native Spark DataSource's `insert` operation to insert the data into a table in your database. This operation is extremely quick, as Splice Machine reads the data into the table directly, without serializing it, sending it over a wire, and deserializing. You can similarly move data from a Splice Machine table into a Spark DataFrame with a single, non-serialized operation.

The [*Ingesting Data in a Spark App*](bestpractices_ingest_sparkapp.html) topic contains examples of using the Native Spark DataSource in both a Zeppelin notebook and with Spark submit.

## Ingesting Streaming Data  {#streaming}

This section presents two versions of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps: one version that runs in a Zeppelin notebook, and a second version that runs via spark-submit.



## Ingesting Data With an External Table  {#externaltable}

Splice Machine supports *external tables*, which are flat files that you can reference, query, and update inside your database. One common use for external tables is to facilitate ingesting the data in a flat file into a table that you've created in your database. All you need to do is:

* Use the `CREATE EXTERNAL TABLE` statement to specify where your external file is and how it is formatted.
* Use the `INSERT INTO` statement to select data from the external file and insert it into a table in your database.

The [*Ingesting Data From an External Table*](bestpractices_ingest_externaltbl.html) topic contains an example of importing data from an ORC file.


## See Also

* [Importing Flat Files](bestpractices_ingest_import.html)
* [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html)
* [Ingestion in Your Spark App](bestpractices_ingest_sparkapp.html)
* [Ingesting Streaming Data](bestpractices_ingest_streaming.html)
* [Ingesting External Tables](bestpractices_ingest_externaltbl.html)
* [Troubleshooting Ingestion](bestpractices_ingest_troubleshooting.html)

</div>
</section>
