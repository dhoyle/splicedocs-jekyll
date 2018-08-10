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
# Importing Data With the Bulk HFile Import Procedure

This tutorial describes how to import data using HFiles into your Splice
Machine database with the [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) system procedure. This topic includes these sections:

* [How Importing Your Data as HFiles Works](#How) presents an overview of
  using the HFile import functions.

* [Configuration Settings](#ConfigSettings) describes any configuration settings that you may need to modify when using the [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure to import data into your database.

* [Importing Data From the Cloud](#CloudAccess) links to our instructions for configuring Splice Machine access to your data in the cloud.

* [Manually Computing Table Splits](#ManualSplits) outlines the steps you use to manually compute table splits, if you prefer to not have that handled automatically.

* [Examples of Using `SYSCS_UTIL.BULK_IMPORT_HFILE`](#Examples) walks through using this procedure both with automatic table splits and with two different methods of manually computing table splits.

Our [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html) topic
walks you through using our standard import procedures (`SYSCS_UTIL.IMPORT_DATA`, `SYSCS_UTIL.SYSCS_UPSERT_DATA_FROM_FILE`, and `SYSCS_UTIL.SYSCS_MERGE_DATA_FROM_FILE`), which are simpler to use, though their performance is slightly lower than importing HFiles.

Bulk importing HFiles boosts import performance; however, constraint checking is not applied to the imported data. If you need constraint checking, use one of our standard import procedures.
{: .noteIcon}

## How Importing Your Data as HFiles Works   {#How}

Our HFile data import procedure leverages HBase bulk loading, which
allows it to import your data at a faster rate; however, using this
procedure instead of our standard
[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) procedure
means that *constraint checks are not performing during data
importation*.

You import a table as HFiles using our `SYSCS_UTIL.BULK_IMPORT_HFILE`
procedure, which temporarily converts the table file that you're
importing into HFiles, imports those directly into your database, and
then removes the temporary HFiles.

Before it generate HFiles, `SYSCS_UTIL.BULK_IMPORT_HFILE` must determine how to split the data
into multiple regions by looking at the primary keys and figuring out
which values will yield relatively evenly-sized splits; the objective is
to compute splits such that roughly the same number of table rows will
end up in each split.

You have two choices for determining the table splits:

* You can have `SYSCS_UTIL.BULK_IMPORT_HFILE` scan and analyze your table to
determine the best splits automatically by calling `SYSCS_UTIL.BULK_IMPORT_HFILE`
with the `skipSampling` parameter set to `false`. We walk you through using this approach
 in the first example below, [Example 1: Bulk HFile Import with Automatic Table Splitting](#AutoExample)

* You can compute the splits yourself and then call `SYSCS_UTIL.BULK_IMPORT_HFILE`
with the `skipSampling` parameter set to `true`. Computing the splits requires these steps, which are described in the next section, [Manually Computing Table Splits](#ManualSplits).

    1. Determine which values make sense for splitting your data
    into multiple regions. This means looking at the primary keys for the
    table and figuring out which values will yield relatively evenly-sized (in number of rows)
    splits.
    2. Call our system procedures to compute the HBase-encoded keys and set up the splits inside
    your Splice Machine database.
    3. Call the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure with the `skipSampling` parameter  to `true` to perform the import.

## Configuration Settings {#ConfigSettings}

Due to how Yarn manages memory, you need to modify your YARN configuration when bulk-importing large datasets. Make these two changes in your Yarn configuration:

<div class="preWrapperWide" markdown="1">
    yarn.nodemanager.pmem-check-enabled=false
    yarn.nodemanager.vmem-check-enabled=false
{: .Example}
</div>

### Extra Configuration Steps for KMS-Enabled Clusters

If you are a Splice Machine On-Premise Database customer and want to use bulk import on a cluster with Cloudera Key Management Service (KMS) enabled, you must complete a few extra configuration steps, which are described in [this troubleshooting note](bestpractices_onprem_importing.html#BulkImportKMS) for details.
{: .noteIcon}

## Importing Data From the Cloud  {#CloudAccess}

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information. Our [Configuring an S3 Bucket for Splice Machine Access](tutorials_ingest_configures3.html) walks you through using your AWS dashboard to generate and apply the necessary credentials.

## Manually Computing Table Splits {#ManualSplits}

If you\'re computing splits for your import (and calling the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure with
`skipSampling` parameter  to `true`), you need to select one of these two methods of computing the table splits:

* You can call [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to compute the splits; the [Example 2](#ManualSplitExample1) example walks you through this.

-or-

* You can call [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) to generate a keys file, and then call [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) to set up the splits in your database; the [Example 3](#ManualSplitExample2) example walks you through this.

In either case, after computing the splits, you call `SYSCS_UTIL.BULK_IMPORT_HFILE` to split your input file into HFiles, import your data, and then remove the temporary HFiles.

Here's a quick summary of how you can compute your table splits:

<div class="opsStepsList" markdown="1">
1.  Create a directory on HDFS for the import; for example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    {: .ShellCommand}
    </div>

2.  Determine primary key values that can horizontally split the table
    into roughly equal sized partitions.
    {: .topLevel}

    Ideally, each partition should be about 1/2 the size of your `hbase.hregion.max.filesize` setting, which leaves room for the region to grow after your data is imported.\\
    \\
    The size of each partition **must be less than** the value of `hbase.hregion.max.filesize`.
    {: .notePlain}

3.  Store those keys in a CSV file.
    {: .topLevel}

4.  Compute the split keys and then split the table.
    {: .topLevel}

5.  Repeat steps 1, 2, and 3 to split the indexes on your table.
    {: .topLevel}

6.  Call the &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure
    to split the input data file into HFiles and import the HFiles into your Splice Machine database. The HFiles are automatically deleted after being imported.
    {: .topLevel}

</div>

You'll find detailed descriptions of these steps in these two examples:
* [Example 2: Using `SPLIT_TABLE_OR_INDEX` to Compute Table Splits](#ManualSplitExample1)
* [Example 3: Using `SYSCS_UTIL.COMPUTE_SPLIT_KEY` and `SPLIT_TABLE_OR_INDEX_AT_POINTS` to Compute Table Splits](#ManualSplitExample2).

## Examples of Using `SYSCS_UTIL.BULK_IMPORT_HFILE`

This section contains example walkthroughs of using the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure in three different ways:

* [Example 1](#AutoExample) uses the automatic table splitting built into `SYSCS_UTIL.BULK_IMPORT_HFILE` to import a table into your Splice Machine database.

* [Example 2](#ManualSplitExample1) uses the `SYSCS_UTIL.COMPUTE_SPLIT_TABLE_OR_INDEX` system procedure to calculate the table splits before calling `SYSCS_UTIL.BULK_IMPORT_HFILE` to import a table into your Splice Machine database.

* [Example 3](#ManualSplitExample2) uses the `SYSCS_UTIL.COMPUTE_SPLIT_KEY` and
`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` system procedures to calculate the table splits before calling `SYSCS_UTIL.BULK_IMPORT_HFILE` to import a table into your Splice Machine database.

### Example 1: Bulk HFile Import with Automatic Table Splitting {#AutoExample}

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

### Example 2: Using `SPLIT_TABLE_OR_INDEX` to Compute Table Splits {#ManualSplitExample1}

The example in this section details the steps used to import data in
HFile format using the Splice Machine `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` and &nbsp;
`SYSCS_UTIL.BULK_IMPORT_HFILE` system procedures.

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

3.  Compute the split row keys for your table and set up the split in
    your database:
    {: .topLevel}

    1.  Find primary key values that can horizontally split the table
        into roughly equal sized partitions.

        For this example, we provide 3 keys in a file named
        `lineitemKey.csv`. Note that each of our three keys includes a
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

    3.  Invoke `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` to compute hbase
        split row keys and set up the splits

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
        `shipDateIndex.csv`. Note that each of our keys includes `null`
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

    4.  Invoke `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` to compute hbase
        split row keys and set up the index splits

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

    Once you have split your table and indexes, call this procedure to
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

### Example 3: Using `SYSCS_UTIL.COMPUTE_SPLIT_KEY` and `SPLIT_TABLE_OR_INDEX_AT_POINTS` to Compute Table Splits {#ManualSplitExample2}

The example in this section details the steps used to
import data in HFile format using the Splice Machine `SYSCS_UTIL.COMPUTE_SPLIT_KEY`, &nbsp;
`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`, and &nbsp;
`SYSCS_UTIL.BULK_IMPORT_HFILE` system procedures.

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
    {: .Example}
    </div>

3.  Compute the split row keys for the table:
    {: .topLevel}

    1.  Find primary key values that can horizontally split the table
        into roughly equal sized partitions.

        For this example, we provide 3 keys in a file named
        `lineitemKey.csv`. Note that each of our three keys includes a
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

    3.  Invoke `SYSCS_UTIL.COMPUTE_SPLIT_KEY` to compute hbase split row
        keys and write them to a file:

            call SYSCS_UTIL.COMPUTE_SPLIT_KEY('TPCH', 'LINEITEM',
                    null, 'L_ORDERKEY,L_LINENUMBER',
                    'hdfs:///tmp/test_hfile_import/lineitemKey.csv',
                    '|', null, null, null,
                    null, -1, '/BAD', true, null, 'hdfs:///tmp/test_hfile_import/');
        {: .Example}
    {: .LowerAlphaPlainFont}

4.  Set up the table splits in your database:
    {: .topLevel}

    1.  Use `SHOW TABLES` to discover the conglomerate ID for the
        `TPCH.LINEITEM` table, which for this example is `1536`. This
        means that the split keys file for this table is in the
        `hdfs:///tmp/test_hfile_import/1536` directory. You\'ll see
        values like these:

        <div class="preWrapperWide" markdown="1">
            \xE4\x16\xE3`\xE4-\xC6\xC0\xE4D\xAA
        {: .Example}
        </div>

    2.  Now use those values in a call to our system procedure to split
        the table inside the database:

            call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS('TPCH','LINEITEM',
                    null,'\xE4\x16\xE3`,\xE4-\xC6\xC0,\xE4D\xAA');
        {: .Example}
    {: .LowerAlphaPlainFont}

5.  Compute the split keys for your index:
    {: .topLevel}

    1.  Find index values that can horizontally split the table into
        roughly equal sized partitions.

    2.  For this example, we provide 2 index values in a file named
        `shipDateIndex.csv`. Note that each of our keys includes `null`
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

    4.  Invoke `SYSCS_UTIL.COMPUTE_SPLIT_KEY` to compute hbase split row
        keys and write them to a file:

        <div class="preWrapperWide" markdown="1">
            call SYSCS_UTIL.COMPUTE_SPLIT_KEY('TPCH', 'LINEITEM', 'L_SHIPDATE_IDX',
                    'L_SHIPDATE,L_PARTKEY,L_EXTENDEDPRICE,L_DISCOUNT',
                    'hdfs:///tmp/test_hfile_import/shipDateIndex.csv',
                    '|', null, null, null, null, -1, '/BAD', true, null,
                     'hdfs:///tmp/test_hfile_import/');
        {: .Example}
        </div>
    {: .LowerAlphaPlainFont}

6.  Set up the indexes in your database:
    {: .topLevel}

    1.  Copy the row key values from the output file:

        <div class="preWrapperWide" markdown="1">
            \xEC\xB0Y9\xBC\x00\x00\x00\x00\x00\x80
            \xEC\xBF\x08\x9C\x14\x00\x00\x00\x00\x00\x80
        {: .Example}
        </div>

    2.  Now call our system procedure to split the index:

        <div class="preWrapperWide" markdown="1">
            call SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS(
                    'TPCH','LINEITEM','L_SHIPDATE_IDX',
                    '\xEC\xB0Y9\xBC\x00\x00\x00\x00\x00\x80,
                    \xEC\xBF\x08\x9C\x14\x00\x00\x00\x00\x00\x80');
        {: .Example}
        </div>
    {: .LowerAlphaPlainFont}

7.  Import the HFiles Into Your Database
    {: .topLevel}

    Once you have split your table and indexes, call this procedure to
    generate and import the HFiles into your Splice Machine database:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call SYSCS_UTIL.BULK_IMPORT_HFILE('TPCH', 'LINEITEM', null,
                '/TPCH/1/lineitem', '|', null, null, null, null, -1,
                '/BAD', true, null,
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
*  [Importing Data: Error Handling](tutorials_ingest_importerrors.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
