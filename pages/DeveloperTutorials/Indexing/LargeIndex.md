---
title: "Creating Indexes for Large Tables"
summary: Describes different approaches for indexing large tables.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_indexing_largeindex.html
folder: DeveloperTutorials/Indexing
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Creating Indexes for Large Tables
This topic describes how to use bulk HFile index creation to index an existing table with the [`CREATE INDEX`](sqlref_statements_createindex.html) statement.

When you are creating an index on a large table and need extra performance, you can use the HFile bulk loading approach described in this topic. Because Splice Machine implements indexes as tables, creating a regular index is similar to creating a new table, which means that parallelization is only possible when the index uses a sufficient number of regions. You can increase parallelism by using bulk HFile loading.

Bulk HFile index creation does not perform unique constraint checking.
{: .noteNote}

You use bulk HFile index creation with `CREATE INDEX` by including the `SPLITKEYS` clause in your statement; you have two options:
* You can specify that you want Splice Machine to sample the data in the table and automatically compute the split keys for you, as described below, in the [Automatic Splitting](#autosplit) section.
* You can manually determine the split keys yourself and supply them in a CSV file, as described in the [Manual SPlitting](#manualsplit) section.

### Automatic Splitting {#autosplit}
The easiest way to use bulk HFile index creation is to allow Splice Machine to sample the data in your table and determine the splits based on statistical analysis of that data. You do this by specifying `SPLITKEYS AUTO` in your `CREATE INDEX` statement.

When you specify automatic splitting, Splice Machine scans and samples the base table is scanned to figure out how large the data range is. The sampled data set is used to encode index column values and calculate total size and quantile statistics. Then, using the total size, the maximum region size, and the sampling rate, we calculate the required number of regions required to accommodate the index data. Our calculation assumes that the regions will grow, so we only load a region half full.

Calculating the number of regions required for the index uses this formula:
```
num_regions = index_size / sampling_rate/max_region_size/2
```

*  The value of `max_region_size` is defined in the `hbase.hregion.max.filesize` property value.
*  The default `sampling_rate` for `SPLITKEYS AUTO` is `0.005` or `0.5%`. You can adjust this value by adding a property value to your `splice-site.xml` configuration file. For example:
    ```
    <property>
        <name>splice.bulkImport.sample.fraction</name>
        <value>0.005</value>
    </property>
    ```
Split keys are calculated according to the quantile statistics for the index and the number of regions; this automatically accounts for highly skewed data.
{: .spaceAbove}

### Example
Here is a step-by-step example of using automatic splitting to create an index on an existing table:

<div class="opsStepsList" markdown="1">
1.  Create a staging directory on HDFS to store the generated HFiles; these HFiles will be moved to HBase after index creation. For example:
    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/hbase-staging/tmp_bulk_clm_line_idx
    ```
    {: .ShellCommand}

2.  Ensure that the staging directory has permissions that allow Splice Machine to write your HFiles to it.

    For a system employing encrypted HDFS zone, make sure that the staging directory is in the same encryption zone as HBase.
    {: .noteNote}

3.  Create the index with the `CREATE INDEX` statement. For example:
    ```
    CREATE INDEX l_shipdate_idx
      ON lineitem( l_shipdate, l_partkey, l_extendedprice, l_discount )
      SPLITKEYS AUTO
      HFILE LOCATION '/hbase-staging/tmp_bulk_clm_line_idx';
    ```
    {: .Example}
</div>

### Manual Splitting {#manualsplit}

Splice Machine encourages you to use automatic splitting; however, if you have a very large table and you're an expert user who is comfortable with manually determining split keys for the table, you can follow these steps to create your own split keys CSV file and specify it in your `CREATE INDEX` statement.

Manual computation of split keys is only appropriate if you know the size and shape of your data. For example, if you have a very large table that happens to have a roughly equal amount of daily data stretching for many months or years, it is relatively straightforward to estimate the number of regions to create for the table with minimal skewing. If you cannot answer questions about the ‘skewness’ of your data, you should probably use our automatic method to create your index split keys.

#### Example
Here is a step-by-step example of computing your own split keys:

<div class="opsStepsList" markdown="1">
1.  Create a staging directory on HDFS to store the generated HFiles; these HFiles will be moved to HBase after index creation. For example:
    ```
    sudo -su hdfs hadoop fs -mkdir hdfs:///tmp/test_hfile_import
    ```
    {: .ShellCommand}

2.  Ensure that the staging directory has permissions that allow Splice Machine to write your HFiles to it.

    For a system employing encrypted HDFS zone, make sure that the staging directory is in the same encryption zone as HBase.
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

4.  For this example, we have calculated two index values that are delimited by ‘|’. Each of our keys in this example happens to include null column values:
    ```
        1994-01-01|||
        1996-01-01|||
    ```
    {: .Example}

5.  Save the split keys in a CSV file on HDFS. For this example, we create a local CSV file `/tmp/shipDateIndex.csv`, and then copy it to HDFS with this command:
    ```
    hadoop dfs -copyFromLocal /tmp/shipDataIndex.csv /tmp/shipDataIndex.csv
    ```
    {: .ShellCommand}

6.  Create the index with the `CREATE INDEX` statement. For example:
    ```
    CREATE INDEX l_shipdate_idx
      ON lineitem( l_shipdate, l_partkey, l_extendedprice, l_discount )
      SPLITKEYS LOCATION '/tmp/shipDateIndex.csv'
      COLUMNDELIMITER '|'
      HFILE LOCATION '/tmp/test_hfile_import';
    ```
    {: .Example}

</div>


## See Also

*  [Importing Data: Using Bulk HFile Import](tutorials_ingest_importhbulkhfile.html)
*  [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html)
*  [`CREATE INDEX`](sqlref_statements_createindex.html)

</div>
</section>
