---
title: SYSCS_UTIL.BULK_IMPORT_HFILE built-in system procedure
summary: Built-in system procedure that imports data from an hfile.
keywords: bulk import, hfile import, bulk_import_hfile, import_hfile
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_importhfile.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.BULK_IMPORT_HFILE

The `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure imports data into
your Splice Machine database by first generating HFiles and then
importing those HFiles.

Our HFile data import procedure leverages HBase bulk loading, which
allows it to import your data at a faster rate; however, using this
procedure instead of our standard
[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) procedure
means that <span class="CalloutFont">constraint checks are not performed
during data importation</span>.
{: .noteImportant}

## Selecting an Import Procedure

Splice Machine provides four system procedures for importing data:

* The [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) procedure imports each input record into a new record in your database.
* The [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedure updates existing records and adds new records to your database. It only differs from `SYSCS_UTIL.MERGE_DATA_FROM_FILE` in that upserting
 **overwrites** the generated or default value of a column that *is not specified* in your `insertColumnList` parameter when updating a record.
* The [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html) procedure updates existing records and adds new records to your database. .It only differs from `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` in that merging **does not
overwrite** the generated or default value of a column that *is not specified* in your `insertColumnList` parameter when updating a record.
* This procedure, [`SYSCS_BULK_IMPORT_HFILE,`](sqlref_sysprocs_importhfile.html) takes advantage of HBase bulk loading to import table data into your database by temporarily converting the table file that you’re importing into HFiles, importing those directly into your database, and then removing the temporary HFiles. This procedure has improved performance for large tables; however, the bulk HFile import requires extra work on your part and lacks constraint checking.

Our [Importing Data Tutorial](tutorials_ingest_importoverview.html) includes a decision tree and brief discussion to help you determine which procedure best meets your needs.

## Syntax

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

If you have specified `skipSampling=true` to indicate that you're computing the splits yourself,
as described [below](#Usage) , the parameter values that you pass to the
 &nbsp;[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) or &nbsp;
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) procedures should match the values
 that you pass to this procedure.
{: .noteNote}

## Parameters

The following table summarizes the parameters used by `SYSCS_UTIL.BULK_IMPORT_HFILE` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

{% include splice_snippets/importparamstable.md %}

## Usage {#Usage}

If you're using this procedure with our On-Premise database product, on a cluster with Amazon Key Management Service (KMS) enabled, there are a few extra configuration steps required. Please see [this troubleshooting note](onprem_info_troubleshoot.html#BulkImportKMS) for details.
{: .noteIcon}

The [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure needs the data that you're importing split into multiple HFiles before it actually imports the data into your database. You can achieve these splits in three ways:

* You can call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `false`. `SYSCS_UTIL.BULK_IMPORT_HFILE` samples the data to determine the splits, then splits the data into multiple HFiles, and then imports the data.

* You can split the data into HFiles with the &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) system procedure, which both computes the keys and performs the splits. You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data.

* You can split the data into HFiles by first calling the [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) procedure and then  calling the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedure to split the table or index.  You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data.

In all cases, `SYSCS_UTIL.BULK_IMPORT_HFILE` automatically deletes the HFiles after the import process has completed.

The [Bulk HFile Import Examples](tutorials_ingest_importexampleshfile.html) section of our *Importing Data Tutorial* describes how these methods differ and provides examples of using them to import data.

## Results

`SYSCS_UTIL.BULK_IMPORT_HFILE` displays a summary of the import
process results that looks like this:

<div class="preWrapperWide" markdown="1">

    rowsImported   |failedRows   |files   |dataSize   |failedLog
    -------------------------------------------------------------
    94             |0            |1       |4720       |NONE
{: .Example xml:space="preserve"}
</div>

## Examples

The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
