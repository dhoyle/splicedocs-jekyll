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
