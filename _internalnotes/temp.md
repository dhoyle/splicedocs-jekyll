

my understanding is that **if you know the splitkeys you can create the file containing the splitkeys then call SPLIT_TABLE_OR_INDEX()**. *if you want splice to figure out the splitkeys then call COMPUTE_SPLIT_KEY() + SPLIT_TABLE_OR_INDEX_AT_POINTS()*.

mbrown [3:47 PM]
so
i suggest something liek the: if the customer has a static set of data that will not change much, then compute_split_key will give a perfect answer
however, if their data is a moving target, they shoudl pre-split it with their brain, not with our statstics helper function.
i view the challenge as a goal for the 'data architect'.  They should *know* how the database will change as time passes
for instance, if you build a table that is intended to have a 12 month rolling window of data, but initially load it with 6 months of historical
then it should probably be split *evenly* over the entire 12 months, not just over the historical 6 months.
then, in 6 months time, once it is 'full', it would be possible to drop old paritions and create new ones in a very efficient manner

wtang [4:11 PM]
I agree https://doc.splicemachine.com/tutorials_ingest_importexampleshfile.html#ManualSplits needs to be reworked to be more readable. Murray’s motivating example is also correct for using compute_split_key() if you want to control how to accommodate future data growth according to a “partitioning” scheme (for both data retention and query performance).

You can call SYSCS_UTIL.BULK_IMPORT_HFILE and set skipSampling to false to allow SYSCS_UTIL.BULK_IMPORT_HFILE to sample data to determine the splits, then splits the data into multiple HFiles, and then imports the data.

You can split the data into HFiles with SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX, which both computes the keys and performs the splits. You then call  SYSCS_UTIL.BULK_IMPORT_HFILE and set skipSampling to true to import your data.

You can also split the data into HFiles by first calling the SYSCS_UTIL.COMPUTE_SPLIT_KEY procedure and then calling the SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS procedure to split the table or index. You then call  SYSCS_UTIL.BULK_IMPORT_HFILE and set skipSampling to true to import your data.
doc.splicemachine.com
Importing Data: Bulk HFile Examples | Splice Machine Documentation
Walk-throughs of using the built-in bulk HFile import procedure.

garyh [4:25 PM]
Okay, that makes sense and is helpful. However, if I’m telling someone how to choose among our three options (3rd = let bulk_import compute the splits), how do I distinguish between that and using Compute_split_key, which seems like it does almost the same thing and uses pretty much the same parameters ??

mbrown [4:31 PM]
so i think there are really two options to import:
1) SYSCS_UTIL.BULK_IMPORT_HFILE with 'skipSampling false', i.e. lets us automatically do a full sampling and split it for you.  Perfect for static data sets.
2) create a split points file 'by hand' or 'offline, and pass it into SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS before loading anything; then call SYSCS_UTIL.BULK_IMPORT_HFILE with 'skipSampling true'

The *practical* reason to call SYSCS_UTIL.COMPUTE_SPLIT_KEY is probably for making a *new index* on an *existing table*.  In that case the data exists, and you want the index to be created quickly with the rationally correct same split points as the base table.
its the _or_index part which gives it away. you can bulk load indexes too, and pre-split them to the 'right' degree of parallelism, so that the indexes are fast and appropriately parallel, to match the base table

garyh [4:40 PM]
Thanks for that; however, “Probably” makes us tech writers nervous. should I explain to readers that _that_ is THE reason for using Compute_split_key?  If not, I’ll need help with a better explanation

wtang [4:41 PM]
Please work with Jun on the wording. Or you can call a short meeting with Jun and me.

garyh [4:43 PM]
@jun Can you suggest wording for why to use Compute_Split_Key ?  If too difficult, perhaps you can spend a couple minutes with Wei and me tomorrow morning (we have a meeting at 11) ???

jun [4:50 PM]
Compute_Split_Key() only calculates split point in HBase encoding given a csv file of primary/index key values. The output can be used by SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS to split table. This two step approach can be combined into SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX.
@garyh I think the documentation already explains well https://doc.splicemachine.com/sqlref_sysprocs_computesplitkey.html
doc.splicemachine.com
SYSCS_UTIL.COMPUTE_SPLIT_KEY built-in system procedure | Splice Machine Documentation
Built-in system procedure that computes the split keys for a table or index, prior to using the BULK_IMPORT_HFILE procedure to import data from HFiles.
COMPUTE_SPLIT_KEY() + SPLIT_TABLE_OR_INDEX_AT_POINTS() = SPLIT_TABLE_OR_INDEX()


FROM: tutorials_ingest_importexampleshfile.html

# XXX Computing Splits XXX

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


## Why Manually Compute Splits?

* You can have `SYSCS_UTIL.BULK_IMPORT_HFILE` scan and analyze your table to
determine the best splits automatically by calling `SYSCS_UTIL.BULK_IMPORT_HFILE`
with the `skipSampling` parameter set to `false`. We walk you through using this approach
 in the first example below, [Example 1: Bulk HFile Import with Automatic Table Splitting](#AutoExample)

* You can compute the splits yourself and then call `SYSCS_UTIL.BULK_IMPORT_HFILE`
with the `skipSampling` parameter set to `true`. Computing the splits requires these steps, which are described in the next section, [Manually Computing Table Splits](#ManualSplits).


## Overview of Computing Table and Index Splits


    1. Determine which values make sense for splitting your data
    into multiple regions. This means looking at the primary keys for the
    table and figuring out which values will yield relatively evenly-sized (in number of rows)
    splits.
    2. Call our system procedures to compute the HBase-encoded keys and set up the splits inside
    your Splice Machine database.
    3. Call the `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure with the `skipSampling` parameter  to `true` to perform the import.

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


## Manually Computing Table Splits {#ManualSplits}

* You can call [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to compute the splits; the [Example 2](#ManualSplitExample1) example walks you through this.

-or-

* You can call [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`](sqlref_sysprocs_computesplitkey.html) to generate a keys file, and then call [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) to set up the splits in your database; the [Example 3](#ManualSplitExample2) example walks you through this.



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
