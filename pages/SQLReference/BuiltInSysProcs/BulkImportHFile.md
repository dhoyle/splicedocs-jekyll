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

## Two Methods for Using `SYSCS_UTIL.BULK_IMPORT_HFILE`

You can tell this procedure to automatically sample your data compute
the split keys for generating the HFiles to import (parameter
`skipSampling=false`), or you can control the split key computation
yourself by using other system procedures to compute the split keys
before calling `SYSCS_UTIL.IMPORT_DATA` with parameter
`skipSampling=true`).

If you are computing the splits, you use this procedure in conjunction
with either:

* The
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) system
  procedure.
* The
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) system
  procedure, which combines the functionality of those two procedures.

See the *Usage Notes* section for more information and the *Example*
section to see an example of using these procedures together.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.BULK_IMPORT_FILE (
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

If you are computing the splits, then almost all of the parameter values
that you pass to this procedure should match the parameter values that
you pass to the
[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
procedures.
{: .noteNote}

## Parameters

The following table summarizes the parameters used by `SYSCS_UTIL.BULK_IMPORT_FILE` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

{% include splice_snippets/importparamstable.md %}

## Results

You use these three system procedures together:

* The &nbsp;[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) prodedure generates a keys file
* You use the keys file in conjunction with the &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) system procedure to split your table
* You then call the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure to import your data.


## About Timestamp Formats   {#TimestampFormats}

The `timestampFormat` parameter specifies the format of timestamps in your input data. You can set this to `null` if either of these conditions is true:

* there are no time columns in the file
* all time stamps in the input match the `Java.sql.Timestamp` default format,
which is: \"*yyyy-MM-dd HH:mm:ss*\".

All of the timestamps in the file you are importing must use the same
format.
{: .noteIcon}

The [Importing Data Tutorial: Input Parameters](tutorials_ingest_importparams.html) topic provides detailed information about timestamp formats and handling.

[Working With Date and Time Values](developers_fundamentals_dates.html) in our Developer's Guide discusses working with date, time, and timestamp values in Splice Machine.

## Examples

The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
