---
summary: How to download, install, configure and verify your installation of Splice Machine on CDH.
title: Installing and Configuring Splice Machine for Cloudera Manager
keywords: Cloudera, CDH, installation, hadoop, hbase, hdfs, sqlshell.sh, sqlshell, parcel url
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_gtest.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

<a name="Usage" />Usage Notes
{: .heading2}

As mentioned earlier, you can have `SYSCS_UTIL.BULK_IMPORT_HFILE`
automatically compute the splits for your table; it does so by sampling
the data in the table, generating a histogram, and then using that
histogram to compute the import splits. `SYSCS_UTIL.BULK_IMPORT_HFILE`
automatically computes the splits when the `skipSampling` parameter is
set to `false`.
{: .body}

Computing Split Keys for HFile Import
{: .heading3}

If you are using `skipSampling=false` to allow automatic computation of
splits, you can ignore the rest of this section, and skip to the
[Examples](#Examples) section below.
{: .noteIcon}

If you\'re computing splits for your import (and setting the
`skipSampling` parameter to `true`), you need to use these three
Splice Machine system procedures together:

* `SYSCS_UTIL.COMPUTE_SPLIT_KEY` generates a keys file
*
* `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` sets up the splits
  in Splice Machine

* `SYSCS_UTIL.BULK_IMPORT_HFILE` splits your input file into HFiles,
  imports your data, and then removes the HFiles

Alternatively, you can use
[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
with `SYSCS_UTIL.BULK_IMPORT_HFILE`. The
`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` system procedure combines the
functionality of `SYSCS_UTIL.COMPUTE_SPLIT_KEY` and
`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`.

The process is as follows (and is shown in more detail in *Example 1*
and *Example 2* below):

<div class="opsStepsList" markdown="1">
1.  Create a directory on HDFS; for example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    {: .ShellCommand}

    </div>

    Make sure that the directory you create has permissions set to allow
    Splice Machine to write your csv and Hfiles there.
    {: .indentLevel1}

2.  Determine primary key values that can horizontally split the table
    into roughly equal sized partitions.
    {: .topLevel}

    <div class="noteNote" markdown="1">
    The value of your `hbase.hregion.max.filesize` setting; each
    partition should ideally be about 1/2 of that value, so that the
    region can grow after data is loaded.

    The sizes must be less than the `hbase.hregion.max.filesize value`.

    </div>

3.  Store those keys in a CSV file.
    {: .topLevel}

4.  Compute the split keys and then split the table.
    {: .topLevel}

    If you\'re using the combination of
    &nbsp;[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html)
    and
    &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)\:
    {: .indentLevel1}

    1.  Pass that CSV file into the
       &nbsp;[`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) procedure
        to compute the split row keys.

    2.  Examine the computed (and encoded) row keys, which were written
        to a file named keys in a subdirectory of your
        `OutputDirectory`.

        The name of the subdirectory is the conglomerate ID for the
        named table. You can find a table\'s conglomerate ID with the
        &nbsp;[`SHOW TABLES`](cmdlineref_showtables.html) command. 

    3.  Copy the encoded keys to your clipboard.

    4.  Call the
        &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedure,
        passing in the row key values from your clipboard. This splits
        your table inside the database.
    {: .LowerAlphaPlainFont}

    If you are using the single procedure
    &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
    instead:

    1.  Pass that CSV file into the
        &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) procedure to compute the split row keys and split your table inside the database.
    {: .LowerAlphaPlainFont}

5.  Repeat steps 1, 2, and 3 to split the indexes on your table.

6.  Call the
    &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure
    to split the input data file into HFiles and import the HFiles into
    your Splice Machine database. The HFiles are deleted after being
    imported.
{: .boldFont}

</div>

Example 1
{: .heading2 #Examples}

This example details the steps used to import data in HFile format using
the Splice Machine `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure with
automatic splitting.

Follow these steps :

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

Example 2
{: .heading2 #Examples}

The example in this section details the steps used to
import data in HFile format using the Splice Machine `SYSCS_UTIL.COMPUTE_SPLIT_KEY`,
`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`, and
`SYSCS_UTIL.BULK_IMPORT_HFILE` system procedures.

Follow these steps :

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
            1500000|3000000|4500000|
        {: .Example}

        </div>

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

Example 3
{: .heading2}

The example in this section details the steps used to import data in
HFile format using the Splice Machine
`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`, and
`SYSCS_UTIL.BULK_IMPORT_HFILE` system procedures.

Follow these steps :

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
            1500000|3000000|4500000|
        {: .Example}

        </div>

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

</div>
</section>
