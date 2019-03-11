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
This topic describes the different data ingestion use cases for ingesting data into Splice Machine, and helps you to quickly identify which applies to your situation. It then provides a summary of that specific ingestion scenario, and links to another topic in this section that contains one or more detailed examples of implementing ingestion for such a use case.

The best way to proceed is to follow these steps:

1. Use [Table 1](#table1), below, to determine which use case applies to your situation, and click the *Read this section* link for your use case.
2. Read the summary information in that section to learn how to ingest your data.
3. Click the link in that section to the examples topic for your ingestion use case.
4. Review the relevant examples and apply the pattent to ingesting your data.


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
            <th>Read this Section</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">You have flat files to import</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#datafiles">Ingesting Data Files</a></td>
        </tr>
        <tr>
            <td class="ItalicFont">You're ingesting data into a Spark app</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#sparkadapter">Ingesting Data in a Spark App</a></td>
        </tr>
        <tr>
            <td class="ItalicFont">You're writing a streaming app</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#streaming">Ingesting Streaming Data</a></td>
        </tr>
        <tr>
            <td class="ItalicFont">You are working with an external table</td>
            <td class="spliceCheckbox">&#x261B;</td>
            <td><a href="#externalTable">Ingesting Data From an External Table</a></td>
        </tr>
    </tbody>
</table>


## Ingesting Data Files  {#datafiles}

The most common ingestion scenario is importing flat files into your Splice Machine database.
process significantly improves data loading performance by temporarily splitting your tables and indexes into Hadoop HFiles and loading your data from those files.

Splice Machine provides two major pathways for importing data and indexes from flat files into your database: our *standard import* system procedures are great for flat files, and our *bulk HFile import* procedures boosts performance by pre-splitting your data into Hadoop HFiles and ingesting those. Each pathway has several variations that offer different levels of complexity, performance, and functionality.
 as summarized in the following table:

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
            <td class="spliceCheckboxBlue">&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Best for pulling in small datasets of new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td><code>UPSERT_DATA_FROM_FILE</code></td>
            <td class="spliceCheckboxBlue">&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td><code>MERGE_DATA_FROM_FILE</code></td>
            <td class="spliceCheckboxBlue">&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slow for very large datasets</p></td>
        </tr>
        <tr>
            <td rowspan="3"><code>BULK_IMPORT_HFILE</code></td>
            <td>Sampled splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;</td>
            <td>Enhanced performance</td>
            <td>No constraint checking</td>
        </tr>
        <tr>
            <td>Keys supplied for splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2714;&#x2714;&#x2714;</td>
            <td>Better performance, especially for extermely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify split keys for input data</p>
            </td>
        </tr>
        <tr>
            <td>Row boundaries supplied for splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2714;&#x2714;&#x2714;&#x2714;</td>
            <td>Best performance for extremely large datasets</td>
            <td><p>No constraint checking</p>
                <p>Must specify row boundaries for splitting input data</p>
            </td>
        </tr>
    </tbody>
</table>

Here are a few key factors that will guide your choice of procedure for importing your files:

* If you are updating existing records in your database during ingestion, you *must* use one of the standard import procedures; bulk HFile import *cannot update records*.
* If you need constraints applied during ingestion, you *must* use one of the standard import procedures; bulk HFile import *does not apply constraint checking*.
* Which standard import procedure (`IMPORT`, `UPSERT`, or `MERGE`) you use is determined by how you want existing records updated, as described in the [*Importing Flat Files*](bestpractices_ingest_import.html) topic in this section.
* Which bulk import procedure you use is determined by how you want to split your data into HFiles and how performant the ingestion process must be, as described in the [*Bulk Importing Flat Files*](bestpractices_ingest_bulkimport.html) topic in this section.

Note that all of the file import procedures require you to specify the same information about your data, such as: which delimiters are used, how dates and times are formatted, which character set is used, and how to handle invalidly formatted input records. You basically point the procedure at your source data and destination table/index, specify a few parameters, and start loading your data. With bulk HFile importing, you also need to decide how you want your data pre-split before starting the import.

Splice Machine recommends running a major compaction on a table after ingesting a significant amount of data into that table. For more information, see [Using Compaction and Vacuuming](developers_fundamentals_compaction.html).

No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample before jumping into importing a large dataset.
{: .noteIcon}

## Ingesting with the Native Spark DataSource  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark programs that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

Ingesting data into your database from Spark is simple: once the data is in a Spark DataFrame, you use the Native Spark DataSource's `insert` operation to insert the data into a table in your database. This operation is extremely quick, as Splice Machine reads the data into the table directly, without serializing it, sending it over a wire, and deserializing. You can similarly move data from a Splice Machine table into a Spark DataFrame with a single, non-serialized operation.

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
