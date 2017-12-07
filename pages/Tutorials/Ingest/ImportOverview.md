---
title: "Importing Data: Overview"
summary: An overview of the procedures and options for importing data into your Splice Machine database.
keywords: import, load data, import data, importing from, ingest
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importoverview.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Overview of Splice Machine Data Ingestion (Importing Data)

This tutorial XXXXXXXXXXXXXXXXXXx

## About Importing Data into Your Database

XXXXXX

This topic summarizes the different ingest procedure options we provide, and helps you to decide which one matches your conditions.

The remainder of this tutorial is split into these topics:

* The [Input Data Handling](tutorials_ingest_importinput.html) page provides detailed information about input data handling during ingestion.
* The [Import Parameters](tutorials_ingest_importparams.html) page provides detailed specifications of the parameter values you must supply to the import procedures.
* The [Input Logging and Error Handling](tutorials_ingest_importerrors.html) page helps you to understand and use logging to discover and repair any input data problems that occur during an ingestion process.
* The [Import Examples](tutorials_ingest_importexamples1.html) walks you through examples of importing data with the `SYSCS_UTIL.IMPORT_DATA`, `SYSCS_UTIL.UPSERT_DATA_FROM_FILE`, and `SYSCS_UTIL.MERGE_DATA_FROM_FILE` system procedures.
* The [Bulk HFile Import Example](tutorials_ingest_importexamples2.html) walks you through using the `SYSCS_UTIL.BULK_IMPORT_HFILES` system procedure.

## Data Ingest Options

Splice Machine includes four different procedures for importing data into your database, three of which use identical syntax; the fourth provides a more behind-the-scenes method that is quicker when loading large data sets, but requires more work and care on your part. The table below summarizes these import procedures:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>System Procedure</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">SYSCS_UTIL.IMPORT_DATA</td>
            <td>Imports data into your database, creating a new record in your table for each record in the imported data.

            <span class="CodeFont">SYSCS_UTIL.IMPORT_DATA</span> inserts the default value of each column that is not specified in the input.</td>
        </tr>
        <tr>
            <td class="CodeFont">SYSCS_UTIL.UPSERT_DATA_FROM_FILE</td>
            <td>Imports data into your database, creating new records and *updating existing records* in the table. Identical to <span class="CodeFont">SYSCS_UTIL.IMPORT_DATA</span> except that will update matching records.

            <span class="CodeFont">SYSCS_UTIL.UPSERT_DATA_FROM_FILE</span> also inserts or updates the value in the table of each column that is not specified in the input; inserting the default value (or NULL if there is no default) for that column.</td>
        </tr>
        <tr>
            <td class="CodeFont">SYSCS_UTIL.MERGE_DATA_FROM_FILE</td>
            <td>Imports data into your database, creating new records and *updating existing records* in the table. Identical to <span class="CodeFont">SYSCS_UTIL.UPSERT_DATA_FROM_FILE</span> except that it does not replace  values in the table for unspecified columns when updating an existing record in the table.</td>
        </tr>
        <tr>
            <td class="CodeFont">SYSCS_UTIL.BULK_IMPORT_HFILES</td>
            <td>Takes advantage of HBase bulk loading to import table data into your database by temporarily converting the table file that you’re importing into HFiles, importing those directly into your database, and then removing the temporary HFiles. This procedure uses syntax very similar to the other import procedures and has improved performance for large tables; however, the bulk HFile import requires extra work on your part and lacks constraint checking.</td>
        </tr>
    </tbody>
</table>

## Which Method Should I Use to Import My Data

INSERT DECISION TREE FLOWCHART HERE
