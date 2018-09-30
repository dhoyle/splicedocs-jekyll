---
title: "Importing Data: Bulk HFile Examples"
summary: Walk-throughs of using the built-in bulk HFile import procedure.
keywords: import, ingest, bulk hfile
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importexampleshfile.html
folder: DeveloperTutorials/Import
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Examples of Using the Bulk HFile Import Procedure

This topic contains example walkthroughs of using the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure:

* [Example 1](#autosplit) uses the automatic table splitting built into `SYSCS_UTIL.BULK_IMPORT_HFILE` to import a table into your Splice Machine database.
* [Example 2](#computesplit) uses the `SYSCS_UTIL.SPLIT_TABLE_OR_INDEX` system procedure to calculate and pre-split a table and index before calling `SYSCS_UTIL.BULK_IMPORT_HFILE` to import the data into your Splice Machine database.

For general information about using Bulk HFile Import, see the [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic in this tutorial section.

## Syntax
To help you more easily understand the examples in this topic, this section repeats the declarations of each of the system procedures used in the examples.

#### SYSCS_UTIL.BULK_IMPORT_HFILE

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.BULK_IMPORT_HFILE (
        schemaName,
        tableName,
        insertColumnList | null,
        fileOrDirectoryName,
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

#### SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX (
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
            );
{: .FcnSyntax xml:space="preserve"}
</div>

## Example 1: Bulk HFile Import with Automatic Splitting {#autosplit}

This example details the steps used to import data in HFile format using
the Splice Machine `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure with
automatic splitting.

Follow these steps:

<div class="opsStepsList" markdown="1">
1.  Create a directory on HDFS for the import; for example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    {: .ShellCommand}
    </div>

    Make sure that the directory you create has permissions set to allow
    Splice Machine to write your csv and Hfiles there.
    {: .indentLevel1}

2.  Create table and index:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
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

        CREATE INDEX L_SHIPDATE_IDX on TPCH.LINEITEM(
            L_SHIPDATE,
            L_PARTKEY,
            L_EXTENDEDPRICE,
            L_DISCOUNT
        );
    {: .Example}
    </div>

3.  Import the HFiles Into Your Database
    {: .topLevel}

    Once you have split your table and indexes, call this procedure to
    generate and import the HFiles into your Splice Machine database:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                '/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/', false);
    {: .Example}
    </div>

    The generated HFiles are automatically deleted after being imported.
    {: .indentLevel1}
{: .boldFont}

</div>

## Example 2: Using `SPLIT_TABLE_OR_INDEX` to Pre-Split Your Data {#computesplit}

The example in this section details the steps used to import data in
HFile format by:

* specifying the split keys manually in a CSV file
* using `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` to pre-split the file you're importing
* calling `SYSCS_UTIL.BULK_IMPORT_HFILE` to import the file

Follow these steps:

<div class="opsStepsList" markdown="1">
1.  Create a directory on HDFS for the import; for example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    {: .ShellCommand}
    </div>

    Make sure that the directory you create has permissions set to allow
    Splice Machine to write your csv and Hfiles there.

2.  Create table and index:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
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

        CREATE INDEX L_SHIPDATE_IDX on TPCH.LINEITEM(
            L_SHIPDATE,
            L_PARTKEY,
            L_EXTENDEDPRICE,
            L_DISCOUNT
            );
    {: .Example}
    </div>

3.  Determine the split row keys for your table and set up the pre-splits:
    {: .topLevel}

    1.  Find primary key values that can horizontally split the table
        into roughly equal sized partitions.

        For this example, we provide 3 keys in a file named
        `lineitemKey.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our three keys includes a
        second column that is `null`\:

        <div class="preWrapperWide" markdown="1">
            1500000|
            3000000|
            4500000|
        {: .Example}
        </div>

        For every N lines of split data you specify, you'll end up with N+1 regions; for example, the above 3 splits will produce these 4 regions:

        <div class="preWrapperWide" markdown="1">
            0 -> 1500000
            1500000 -> 3000000
            3000000 -> 4500000
            4500000 -> (last possible key)
        {: .Example}

    2.  Specify the column names in the csv file in the `columnList`
        parameter; in our example, the primary key columns are:

        <div class="preWrapperWide" markdown="1">
            'L_ORDERKEY,L_LINENUMBER'
        {: .Example}
        </div>

    3.  Invoke `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` to pre-split your table file:

            call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
                    'LINEITEM',null, 'L_ORDERKEY,L_LINENUMBER',
                    'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
                    '|', null, null, null,
                    null, -1, '/BAD', true, null);
        {: .Example}
    {: .LowerAlphaPlainFont}

4.  Compute the split keys for your index:
    {: .topLevel}

    1.  Find index values that can horizontally split the table into
        roughly equal sized partitions.

    2.  For this example, we provide 2 index values in a file named
        `shipDateIndex.csv`, which will be specified as the value of the `fileName` parameter. Note that each of our keys includes `null`
        column values:

        <div class="preWrapperWide" markdown="1">
            1994-01-01|||
            1996-01-01|||
        {: .Example}
        </div>

    3.  Specify the column names in the csv file in the `columnList`
        parameter; in our example, the index columns are:

        <div class="preWrapperWide" markdown="1">
            'L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT'
        {: .Example}
        </div>

    4.  Invoke `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` to pre-split your index file:

            call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX('TPCH',
                    'LINEITEM', 'L_SHIPDATE_IDX',
                    'L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT',
                    'hdfs:///tmp/test_hfile_import/shipDateIndex.csv',
                    '|', null, null,
                    null, null, -1, '/BAD', true, null);
        {: .Example}
    {: .LowerAlphaPlainFont}

5.  Import the HFiles Into Your Database
    {: .topLevel}

    Once you have pre-split your table and indexes, call `SYSCS_UTIL.BULK_IMPORT_HFILE` to
    generate and import the HFiles into your Splice Machine database:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                    '/TPCH/1/lineitem', '|', null, null, null, null,
                    -1, '/BAD', true, null,
                    'hdfs:///tmp/test_hfile_import/', true);
    {: .Example}
    </div>

    The generated HFiles are automatically deleted after being imported.
    {: .indentLevel1}
{: .boldFont}

</div>

## See Also

*  [Importing Data: Tutorial Overview](tutorials_ingest_importoverview.html)
*  [Importing Data: Input Parameters](tutorials_ingest_importparams.html)
*  [Importing Data: Input Data Handling](tutorials_ingest_importinput.html)
*  [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html)
*  [Importing Data: Error Handling](tutorials_ingest_importerrors.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)

</div>
</section>
