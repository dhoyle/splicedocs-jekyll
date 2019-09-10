---
title: Using Indexes to Tune Queries
summary: Using Indexes to Tune Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_indexes.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Indexes to Tune Queries

Splice Machine tables have primary keys either implicitly or explicitly defined; data is stored in the order of these keys. Splice Machine can use *secondary indexes* to improve the performance of data manipulation statements. In addition, `UNIQUE` indexes provide a form of data integrity checking.

The primary key is not optimal for all queries.
{: .noteNote}

Splice Machine implements indexes as tables, so creating a regular index is similar to creating a new table. This means that parallelization, which is essential for performance with big tables, is only possible when the index uses a sufficient number of regions. You can increase parallelism by optimizing how the index is split into regions.

Note that the standard form of the `CREATE INDEX` statement generates performant indexes for most tables: Splice Machine traverses the table and copies the specified column values to the index. For very large tables, this process can require a lot of time, and can generate an index that is split into uneven regions, which slows performance.

## Creating Performant Indexes for Very Large Tables

The remainder of this topic describes using the optional `SPLITKEYS` clause of our `CREATE INDEX` statement to efficiently create highly performant indexes for very large tables; this clause allows you to specify how to split the index into regions when it is generated, in these sections:

* [Specifying Split Keys for Index Creation](#splitkeys)
* [Using Bulk HFile Loading and Split Keys](#bulkload)

For more information about bulk HFile loading, please see our [Best Practices: Ingestion](bestpractices_ingest_intro.html) chapter.

## Specifying Split Keys for Index Creation  {#splitkeys}

There are several ways that you can specify split keys for creating your index, each of which is explored in this section:

* [Specifying Split Keys with Automatic Sampling](#sampled)
* [Specifying Split Keys in a File](#keyed)

### Specifying Split Keys with Automatic Sampling  {#sampled}
The simplest way to use split key indexing is to allow Splice Machine to sample the data in your table and determine the splits based on statistical analysis of that data by specifying `AUTO SPLITKEYS` in your `CREATE INDEX` statement. For example:

```
CREATE INDEX l_part_idx ON lineitem(
    l_partkey,
    l_orderkey,
    l_suppkey,
    l_shipdate,
    l_extendedprice,
    l_discount,
    l_quantity,
    l_shipmode,
    l_shipinstruct
) AUTO SPLITKEYS SAMPLE FRACTION 0.001;
```
{: .Example xml:space="preserve"}

Splice Machine scans and samples the base table to figure out how large the data range is. The sampled data set is used to encode index column values and calculate total size and quantile statistics. Then, using the total size, the maximum region size, and the sampling rate, we calculate the required number of regions required to accommodate the index data. Our calculation assumes that the regions will grow, so we only load a region half full.

You can optionally specify the sampling rate, as shown in the above example. If you leave the `SAMPLE FRACTION` subclause out, the default sampling rate is used:
* The default sampling rates is specified in the `splice.bulkImport.sample.fraction` configuration property in your `splite-site.xml` configuration file.
* The initial, default value in the configuration file is `0.005` (0.5%).

#### How Auto Sampling Works
The Splice Machine auto sampling algorithm calculates the number of regions required for the index with this formula:
```
num_regions = index_size / sampling_rate/max_region_size/2
```

The value of `max_region_size` is defined in the `hbase.hregion.max.filesize` property value.
{: .spaceAbove}

Split keys are calculated according to the quantile statistics for the index and the number of regions; this automatically accounts for highly skewed data.
{: .spaceAbove}

### Specifying Split Keys in a File  {#keyed}

Splice Machine encourages you to use automatic splitting; however, if you have a very large table and you're an expert user who is comfortable with manually determining split keys for the table, you can follow the steps in this section to create your own split keys CSV file and specify  and specify it in your `CREATE INDEX` statement. by specifying `AUTO SPLITKEYS` in your `CREATE INDEX` statement

Manual computation of split keys is only appropriate if you know the size and shape of your data. For example, if you have a very large table that happens to have a roughly equal amount of daily data stretching for many months or years, it is relatively straightforward to estimate the number of regions to create for the table with minimal skewing. If you cannot answer questions about the ‘skewness’ of your data, you should probably use our automatic method to create your index split keys.

You can specify either *logical* or *physical keys*:
* Logical keys are the primary key column values that you want to define the splits.
* Physical keys are actual split keys for the HBase table, in encoded HBase format.

#### Example: Specifying Logical Split Keys in a File {#logicalfile}
This is a step-by-step example of using `CREATE INDEX` with logical keys:

<div class="opsStepsList" markdown="1">
1.  Find index values that can horizontally split the index into roughly equal-sized paritions. Here is some guidance for calculating the split keys:

      1. First, estimate the number of regions required for the index by inspecting how many regions are used for the base table. The index usually needs less regions to accommodate data, because index data only contains index and primary key values. You can estimate from the table definition to calculate the number of regions:
         ```
         num_regions = index_column_size + PK_column_size) / total_column_size
         ```

      2. Run an SQL query to calculate some statistics and generate a histogram for leading index columns. For example, assuming the first column is `index_col1`, we can use this statement:
         ```
         splice> SELECT index_col1, COUNT(*) FROM TABLE GROUP BY index_col1 ORDER BY 1;
         ```

      3. Given the estimated number of regions and the histogram, you can find keys that can split the index into roughly equal sized regions.

2.  Next, calculate index values that will create evenly-sized regions for the index, and specify them in a CSV file. Since the example we're using includes 9 index columns, each line in our CSV file specifies values for those columns that define a split. For example, here's a partial listing of such a file:
    ```
    6952,67431,6953,1998-01-29,70640.1,0.06,38,SHIP      ,COLLECT COD
    13491,2563013,5993,1997-05-19,12640.41,0.09,9,AIR       ,NONE
    20158,3540711,7665,1994-07-29,5390.75,0.07,5,SHIP      ,COLLECT COD
    26665,527524,6666,1994-12-10,54116.44,0.06,34,SHIP      ,COLLECT COD
    32488,1364581,2489,1996-08-15,15625.28,0.05,11,FOB       ,TAKE BACK RETURN
    ```
    {: .Example}

3.  Save the split keys in a CSV file *on HDFS*. For this example, we create a local CSV file `/tmp/l_part_idx.csv`, and then copy it to HDFS with this command:
    ```
    hadoop dfs -copyFromLocal /tmp/l_part_idx.csv /tmp/l_part_idx.csv
    ```
    {: .ShellCommand}

4.  Create the index with the `CREATE INDEX` statement. For example:
    ```
    CREATE INDEX l_part_idx ON lineitem(
        l_partkey,
        l_orderkey,
        l_suppkey,
        l_shipdate,
        l_extendedprice,
        l_discount,
        l_quantity,
        l_shipmode,
        l_shipinstruct
    ) LOGICAL SPLITKEYS LOCATION '/tmp/l_part_idx.csv';
    ```
    {: .Example}

</div>

#### Example: Specifying Physical Split Keys in a File  {#physicalfile}
This is a variation of the same step-by-step example that uses physical keys instead of logical keys:

<div class="opsStepsList" markdown="1">
1.  Find index values that can horizontally split the index into roughly equal-sized paritions. Here is some guidance for calculating the split keys:

      1. First, estimate the number of regions required for the index by inspecting how many regions are used for the base table. The index usually needs less regions to accommodate data, because index data only contains index and primary key values. You can estimate from the table definition to calculate the number of regions:
         ```
         num_regions = index_column_size + PK_column_size) / total_column_size
         ```

      2. Run an SQL query to calculate some statistics and generate a histogram for leading index columns. For example, assuming the first column is `index_col1`, we can use this statement:
         ```
         splice> SELECT index_col1, COUNT(*) FROM TABLE GROUP BY index_col1 ORDER BY 1;
         ```

      3. Given the estimated number of regions and the histogram, you can find keys that can split the index into roughly equal sized regions.

2.  Next, calculate index values that will create evenly-sized regions for the index, and supply the encoded HBase table values in a file. Here's a partial example of the contents of a text file that contains such values:
    ```
\xDB(\x00\xE1\x07g\x00\xDB)\x00\x1F\xD4=\x00\xE4\x81u\x12\x01\x00\xDEp\x01\x00\xE1I\x01\x00UJKR""""""\x00EQNNGEV"EQF""""""""""""""\x00\xF0\xC1\xEC\xF0\x84\x8C
\xE04\xB3\x00\xE4'\x1B\xC5\x00\xD7i\x00\x1F\xD2\xB3\x00\xE4#u\x15 \x01\x00\xDE\xA0\x01\x00\xE0\xA0\x01\x00CKT"""""""\x00PQPG"""""""""""""""""""""\x00\xF2\x89\xE3\xBC\xA8\x82\x82
\xE0N\xBE\x00\xE46\x06\xE7\x00\xDD\xF1\x00\x1F\xCC\xFD\x00\xE3d\xA1\x86\x01\x00\xDE\x80\x01\x00\xE0`\x01\x00UJKR""""""\x00EQNNGEV"EQF""""""""""""""\x00\xF2\x8D\xC0\xEE\xB8\x82\x88
\xE0h)\x00\xE4\x08\x0C\xA4\x00\xDA\x0A\x00\x1F\xCD\x8A\x00\xE4e"uP\x01\x00\xDEp\x01\x00\xE1E\x01\x00UJKR""""""\x00EQNNGEV"EQF""""""""""""""\x00\xF2\x82\x81\xCA\xA0\x82\x88
\xE0~\xE8\x00\xE4\x14\xD2e\x00\xC9\xB9\x00\x1F\xD1\x0F\x00\xE4&sc\x90\x01\x00\xDE`\x01\x00\xE1"\x01\x00HQD"""""""\x00VCMG"DCEM"TGVWTP"""""""""\x00\xF2\x85\x9A\xA6\xA8\x82\x8E
    ```
    {: .Example}

3.  Save the split keys in a file *on HDFS*.

4.  Create the index with the `CREATE INDEX` statement. For example:
    ```
    CREATE INDEX l_part_idx ON lineitem(
        l_partkey,
        l_orderkey,
        l_suppkey,
        l_shipdate,
        l_extendedprice,
        l_discount,
        l_quantity,
        l_shipmode,
        l_shipinstruct
    ) PHYSICAL SPLITKEYS LOCATION '/tmp/l_part_idx.txt' HFILE LOCATION '/tmp/hfile';
    ```
    {: .Example}

</div>

## Using Bulk HFile Loading and Split Keys  {#bulkload}

You can use HBase Bulk HFile loading with split keys to increase the performance of index creation for a large table. You can use bulk HFiles no matter how you specify your split keys.

Bulk HFile index creation does not perform unique constraint checking.
{: .noteNote}

The examples are almost exactly the same as those in the previous section; the only difference is that each of these examples uses bulk HFiles to improve index creation performance, which means that you have to create a *staging directory* to temporarily store the generated HFiles and specify the location of that directory in the `HFILE LOCATION` subclause of your `CREATE INDEX` statement.

The temporary HFiles are moved to HBase once index creation is complete.

### Example: Using Bulk HFile Loading with Sampled Split Keys  {#bulksampled}
Here is a step-by-step example of using automatic splitting with Bulk HFiles to create an index on an existing table:

<div class="opsStepsList" markdown="1">
1.  Create a staging directory on HDFS to store the generated HFiles; for example:
    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/hfile
    ```
    {: .ShellCommand}

2.  Ensure that the staging directory has permissions that allow Splice Machine to write your HFiles to it.

    For a system employing encrypted HDFS zones, make sure that the staging directory is in the same encryption zone as HBase.
    {: .noteNote}

3.  Create the index with the `CREATE INDEX` statement. For example:
    ```
    CREATE INDEX L_PART_IDX ON lineitem(
         l_partkey,
         l_orderkey,
         l_suppkey,
         l_shipdate,
         l_extendedprice,
         l_discount,
         l_quantity,
         l_shipmode,
         l_shipinstruct
     ) AUTO SPLITKEYS SAMPLE FRACTION 0.001 HFILE LOCATION '/tmp/hfile';
    ```
    {: .Example}

</div>

## Example: Using Bulk HFile Loading with Specified Split Keys  {#bulkfile}
Here is a step-by-step example of specifying your own split keys in a file  and using them with Bulk HFile loading:

<div class="opsStepsList" markdown="1">
1.  Create a staging directory on HDFS to store the generated HFiles; for example:
    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/hfile
    ```
    {: .ShellCommand}

2.  Ensure that the staging directory has permissions that allow Splice Machine to write your HFiles to it.

    For a system employing encrypted HDFS zones, make sure that the staging directory is in the same encryption zone as HBase.
    {: .noteNote}

3.  Find index values that can horizontally split the index into roughly equal-sized paritions. Here is some guidance for calculating the split keys:

      1. First, estimate the number of regions required for the index by inspecting how many regions are used for the base table. The index usually needs less regions to accommodate data, because index data only contains index and primary key values. You can estimate from the table definition to calculate the number of regions:
         ```
         num_regions = index_column_size + PK_column_size) / total_column_size
         ```

      2. Run an SQL query to calculate some statistics and generate a histogram for leading index columns. For example, assuming the first column is `index_col1`, we can use this statement:
         ```
         splice> SELECT index_col1, COUNT(*) FROM TABLE GROUP BY index_col1 ORDER BY 1;
         ```

      3. Given the estimated number of regions and the histogram, you can find keys that can split the index into roughly equal sized regions.

4.  Next, calculate index values that will create evenly-sized regions for the index, and save them in a file. You can specify logical (primary key) values in a CSV file, or you can specify physical (HBase encoded) values in a text file.

    For example, here's a partial listing of a CSV file:
    ```
    6952,67431,6953,1998-01-29,70640.1,0.06,38,SHIP      ,COLLECT COD
    13491,2563013,5993,1997-05-19,12640.41,0.09,9,AIR       ,NONE
    20158,3540711,7665,1994-07-29,5390.75,0.07,5,SHIP      ,COLLECT COD
    26665,527524,6666,1994-12-10,54116.44,0.06,34,SHIP      ,COLLECT COD
    32488,1364581,2489,1996-08-15,15625.28,0.05,11,FOB       ,TAKE BACK RETURN
    ```
    {: .Example}

    And here's a partial listing of a file with encoded HBase split keys:
    {: .spaceAbove}

    ```
\xDB(\x00\xE1\x07g\x00\xDB)\x00\x1F\xD4=\x00\xE4\x81u\x12\x01\x00\xDEp\x01\x00\xE1I\x01\x00UJKR""""""\x00EQNNGEV"EQF""""""""""""""\x00\xF0\xC1\xEC\xF0\x84\x8C
\xE04\xB3\x00\xE4'\x1B\xC5\x00\xD7i\x00\x1F\xD2\xB3\x00\xE4#u\x15 \x01\x00\xDE\xA0\x01\x00\xE0\xA0\x01\x00CKT"""""""\x00PQPG"""""""""""""""""""""\x00\xF2\x89\xE3\xBC\xA8\x82\x82
\xE0N\xBE\x00\xE46\x06\xE7\x00\xDD\xF1\x00\x1F\xCC\xFD\x00\xE3d\xA1\x86\x01\x00\xDE\x80\x01\x00\xE0`\x01\x00UJKR""""""\x00EQNNGEV"EQF""""""""""""""\x00\xF2\x8D\xC0\xEE\xB8\x82\x88
\xE0h)\x00\xE4\x08\x0C\xA4\x00\xDA\x0A\x00\x1F\xCD\x8A\x00\xE4e"uP\x01\x00\xDEp\x01\x00\xE1E\x01\x00UJKR""""""\x00EQNNGEV"EQF""""""""""""""\x00\xF2\x82\x81\xCA\xA0\x82\x88
\xE0~\xE8\x00\xE4\x14\xD2e\x00\xC9\xB9\x00\x1F\xD1\x0F\x00\xE4&sc\x90\x01\x00\xDE`\x01\x00\xE1"\x01\x00HQD"""""""\x00VCMG"DCEM"TGVWTP"""""""""\x00\xF2\x85\x9A\xA6\xA8\x82\x8E
    ```
    {: .Example}

3.  Create or copy the file *on HDFS*. For example, we can create a local CSV file `/tmp/l_part_idx.csv`, and then copy it to HDFS with this command:
    ```
    hadoop dfs -copyFromLocal /tmp/l_part_idx.csv /tmp/l_part_idx.csv
    ```
    {: .ShellCommand}

4.  Create the index with the `CREATE INDEX` statement. For example:
    ```
    CREATE INDEX l_part_idx ON lineitem(
        l_partkey,
        l_orderkey,
        l_suppkey,
        l_shipdate,
        l_extendedprice,
        l_discount,
        l_quantity,
        l_shipmode,
        l_shipinstruct
    ) LOGICAL SPLITKEYS LOCATION '/tmp/l_part_idx.csv' HFILE LOCATION '/tmp/hfile';
    ```
    {: .Example}

    If you're using a file with physical keys, the last line looks like this instead:
    {: .spaceAbove}
    ```
    CREATE INDEX l_part_idx ON lineitem(
        l_partkey,
        l_orderkey,
        l_suppkey,
        l_shipdate,
        l_extendedprice,
        l_discount,
        l_quantity,
        l_shipmode,
        l_shipinstruct
    ) PHYSICAL SPLITKEYS LOCATION '/tmp/l_part_idx.txt' HFILE LOCATION '/tmp/hfile';
    ```
    {: .Example}
</div>

</div>
</section>
