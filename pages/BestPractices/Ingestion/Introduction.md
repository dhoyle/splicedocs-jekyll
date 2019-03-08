---
title: Splice Machine Ingestion Best Practices
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_intro.html
folder: BestPractices/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Data
This topic describes the different data ingestion use case for ingesting data into Splice Machine, and helps you to quickly identify which applies to your situation. It then provides a summary of that specific ingestion scenario, and links to another topic in this section that contains one or more detailed examples of implementing ingestion for such a use case.

The best way to proceed is to follow these steps:

1. Use [Table 1](#table1), below, to determine which use case applies to your situation, and click the *Read this section* link for your use case.
2. Read the summary information in that section to learn how to ingest your data.
3. Click the link in that section to the examples topic for your ingestion use case.
4. Ingest your data!


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

Splice Machine provides two major pathways for importing data and indexes from flat files into your database: our *standard import* system procedures are great for flat files, and our *bulk HFile import* procedures boosts performance by pre-splitting your data into Hadoop HFiles and ingesting those. Each pathway has several variations that offer different levels of complexity, performance, and functionality, as summarized in the following table:

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


* You'll find examples of using the standard import methods in the [*Importing Flat Files*](bestpractices_ingest_import.html) topic, in this section.
* You'll find examples of using the bulk import methods in the [*Bulk Importing Flat Files*](bestpractices_ingest_bulkimport.html) topic, also in this section.

No matter which method you decide upon, we strongly recommend debugging your ingest process with a small data sample before jumping into importing a large dataset.
{: .noteIcon}

## Ingesting with the Native Spark DataSource  {#sparkadapter}
The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark programs that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

## Ingesting Streaming Data  {#streaming}

This section presents two versions of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps: one version that runs in a Zeppelin notebook, and a second version that runs via spark-submit.



## Ingesting Data With an External Table  {#externaltable}

</div>
</section>
