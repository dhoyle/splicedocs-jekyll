---
title: "Importing Data: Tutorial Overview"
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
# Importing Data Into Your Splice Machine Database

This tutorial guides you through importing (loading) data into your Splice Machine database. It contains these topics:

<table>
    <col width="185px"/>
    <col />
    <thead>
        <tr>
            <th>Tutorial Topic</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="#Overview">1: Tutorial Overview</a></td>
            <td><em>This topic</em>. Introduces the import options that are available to you and helps you determine which option best meets your needs.</td>
        </tr>
        <tr>
            <td><a href="tutorials_ingest_importparams.html">2: Parameter Usage</a></td>
            <td>Provides detailed specifications of the parameter values you must supply to the import procedures.</td>
        </tr>
        <tr>
            <td><a href="tutorials_ingest_importinput.html">3: Input Data Handling</a></td>
            <td>Provides detailed information and tips about input data handling during ingestion.</td>
        </tr>
        <tr>
            <td><a href="tutorials_ingest_importerrors.html">4: Error Handling</a></td>
            <td>Helps you to understand and use logging to discover and repair any input data problems that occur during an ingestion process.</td>
        </tr>
        <tr>
            <td><a href="tutorials_ingest_importexamples1.html">5: Usage Examples</a></td>
            <td>Walks you through examples of importing data with the &nbsp; <code>SYSCS_UTIL.IMPORT_DATA</code>, <code>SYSCS_UTIL.UPSERT_DATA_FROM_FILE</code>, and <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code> system procedures.</td>
        </tr>
        <tr>
            <td><a href="tutorials_ingest_importexampleshfile.html">6: Bulk HFile Examples</a></td>
            <td>Walks you through examples of using the <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> system procedure.</td>
        </tr>
        <tr>
            <td><a href="tutorials_ingest_importexamplestpch.html">7: Importing TPCH Data</a></td>
            <td>Walks you through importing TPCH sample data into your database.</td>
        </tr>
    </tbody>
</table>

## Overview of Importing Data Into Your Database {#Overview}

The remainder of this topic introduces you to importing (loading) data into your Splice Machine database. It summarizes the different import procedures we provide, presents a quick look at the procedure declarations, and helps you to decide which one matches your conditions. It contains the following sections:

* [Data Import Procedures](#ImportProcs) summarizes the built-in system procedures that you can use to import your data.
* [Which Procedure Should I Use to Import My Data?](#WhichProc) presents a decision tree that makes it easy to decide which procedure to use for your circumstances.
* [Import Procedures Syntax](#Syntax) shows the syntax for our import procedures.

## Data Import Procedures {#ImportProcs}

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
            <td class="CodeFont">SYSCS_UTIL.BULK_IMPORT_HFILE</td>
            <td>Takes advantage of HBase bulk loading to import table data into your database by temporarily converting the table file that you’re importing into HFiles, importing those directly into your database, and then removing the temporary HFiles. This procedure uses syntax very similar to the other import procedures and has improved performance for large tables; however, the bulk HFile import requires extra work on your part and lacks constraint checking.</td>
        </tr>
    </tbody>
</table>

## Which Procedure Should I Use to Import My Data? {#WhichProc}

The following diagram helps you decide which of our data importation procedures best fits your needs:

<img src="images/WhichImportProc.png">
{: .nestedTightSpacing}

### Notes

* The `IMPORT_DATA` procedure imports new records into a database. The `UPSERT_DATA_FROM_FILE` and `MERGE_DATA_FROM_FILE` procedures import new records and update existing records. Importing all new records is faster because the database doesn't need to check if the record already exists in the database.
* If your table contains auto-generated column values and you don't want those values overwritten when a record gets updated, use the `MERGE_DATA_FROM_FILE` procedure (`UPSERT_DATA_FROM_FILE` will overwrite).
* The `BULK_IMPORT_HFILE` procedure is great when you're importing a very large dataset and need extra performance. However, it does not perform constraint checking.

## Import Procedures Syntax {#Syntax}

Here are the declarations of our four data import procedures; as you can see, three of our four import procedures use identical parameters, and the fourth (`SYSCS_UTIL.BULK_IMPORT_HFILE`) adds a couple extra parameters at the end:

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA (
            schemaName,
            tableName,
            insertColumnList | null,
            fileOrDirectoryName,
            columnDelimiter | null,
            characterDelimiter | null,
            timestampFormat | null,
            dateFormat | null,
            timeFormat | null,
            badRecordsAllowed,
            badRecordDirectory | null,
            oneLineRecords | null,
            charset | null
            );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.UPSERT_DATA_FROM_FILE (
           schemaName,
           tableName,
           insertColumnList | null,
           fileOrDirectoryName,
           columnDelimiter | null,
           characterDelimiter | null,
           timestampFormat | null,
           dateFormat | null,
           timeFormat | null,
           badRecordsAllowed,
           badRecordDirectory | null,
           oneLineRecords | null,
           charset | null
    );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.MERGE_DATA_FROM_FILE (
           schemaName,
           tableName,
           insertColumnList | null,
           fileOrDirectoryName,
           columnDelimiter | null,
           characterDelimiter | null,
           timestampFormat | null,
           dateFormat | null,
           timeFormat | null,
           badRecordsAllowed,
           badRecordDirectory | null,
           oneLineRecords | null,
           charset | null
    );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.BULK_IMPORT_HFILE (
        schemaName,
        tableName,
        insertColumnList | null,
        fileName,
        columnDelimiter | null,
        characterDelimiter | null,
        timestampFormat | null,
        dateFormat | null,
        timeFormat | null,
        maxBadRecords,
        badRecordDirectory | null,
        oneLineRecords | null,
        charset | null,
        bulkImportDirectory,
        skipSampling
    );
{: .FcnSyntax xml:space="preserve"}

</div>

You'll find descriptions and detailed reference information for all of these parameters in the [Import Parameters](tutorials_ingest_importparams.html) topic of this tutorial.

And you'll find detailed reference descriptions of all four procedures in our [SQL Reference Manual](sqlref_intro.html).

## See Also

*  [Importing Data: Input Parameters](tutorials_ingest_importparams.html)
*  [Importing Data: Input Data Handling](tutorials_ingest_importinput.html)
*  [Importing Data: Error Handling](tutorials_ingest_importerrors.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
