---
title: SYSCS_UTIL.COMPUTE_SPLIT_KEY built-in system procedure
summary: Built-in system procedure that computes the split keys for a table or index, prior to using the BULK_IMPORT_HFILE procedure to import data from HFiles.
keywords: compute split keys for HFile import, compute_split_key
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_computesplitkey.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.COMPUTE_SPLIT_KEY

Use the `SYSCS_UTIL.COMPUTE_SPLIT_KEY` system procedure to compute
the split keys for a table or index prior to calling the &nbsp; [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedure to split the data into HFiles. Once you've done that, call  &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
system procedure to import your data in HFile format.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.COMPUTE_SPLIT_KEY (
            schemaName,
            tableName,
            indexName,
            columnList | null,
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
            outputDirectory
    );
{: .FcnSyntax xml:space="preserve"}

</div>

## Parameters

The following table summarizes the parameters used by `SYSCS_UTIL.COMPUTE_SPLIT_KEY` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

The parameter values that you pass into this procedure should match the values that you use when you subsequently call the
 &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure to perform the import.
{: .noteIcon}

{% include splice_snippets/importparamstable.md %}

## Usage {#Usage}

The [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure needs the data that you're importing split into multiple HFiles before it actually imports the data into your database. You can achieve these splits in three ways:

* You can call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `false`. `SYSCS_UTIL.BULK_IMPORT_HFILE` samples the data to determine the splits, then splits the data into multiple HFiles, and then imports the data.

* You can split the data into HFiles with the
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`] procedure, which both computes the keys and performs the splits. You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data.

* You can split the data into HFiles by first calling this procedure,  &nbsp;`SYSCS_UTIL.COMPUTE_SPLIT_KEY`, and then  calling the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedure to split the table or index.  You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data.

In all cases, `SYSCS_UTIL.BULK_IMPORT_HFILE` automatically deletes the HFiles after the import process has completed.

The [Bulk HFile Import Examples](tutorials_ingest_importexampleshfile.html) section of our *Importing Data Tutorial* describes how these methods differ and provides examples of using them to import data.

## Examples

The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
