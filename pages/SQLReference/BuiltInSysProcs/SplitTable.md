---
title: SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX built-in system procedure
summary: Built-in system procedure that computes split points for a table or index and splits it into HFiles.
keywords: compute split points, splice_table_or_index
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_splittable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX

The `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` system procedure pre-splits a table or index
that you are import in HFile format. You must use this procedure in conjunction with the
 &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
system procedure to import your data in HFile format.

## Syntax

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

## Parameters

The parameter values that you pass into this procedure should match the values for the same-named parameters that you use when you subsequently call the  &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure to perform the import.
{: .noteIcon}

This table includes a brief description of each parameter; additional information is available in the [Import Parameters](tutorials_ingest_importparams.html) topic of our *Importing Data* tutorial.

<table>
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Parameter</th>
            <th>Description</th>
            <th>Example Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">schemaName</td>
            <td>The name of the schema of the table into which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont">tableName</td>
            <td>The name of the table into which to import.</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
         <tr>
             <td class="CodeFont">indexName</td>
             <td>The name of the index into which to import.</td>
             <td class="CodeFont">playerTeamsIdx</td>
         </tr>
       <tr>
            <td class="CodeFont">columnList</td>
            <td>A comma-separated list of the columns used for split keys.</td>
            <td>See the [Example](#Example) below.</td>
        </tr>
        <tr>
            <td class="CodeFont">fileName</td>
            <td><p>The name of the file in which you have specified the split keys.</p>
                <p>On a cluster, this file <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our *Database Service* product, this file must be on S3.</p>
            </td>
            <td class="CodeFont">/data/mydata/mytable.csv</td>
        </tr>
        <tr>
            <td class="CodeFont">columnDelimiter</td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|', '\t'</td>
        </tr>
        <tr>
            <td class="CodeFont">characterDelimiter</td>
            <td>The character used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">'"', ''''</td>
        </tr>
        <tr>
            <td class="CodeFont">timestampFormat</td>
            <td><p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
            <p class="noteIcon">All of the timestamps in the file you are importing must use the same format.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">dateFormat</td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont">timeFormat</td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td class="CodeFont">maxBadRecords</td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont">badRecordDirectory</td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, it must be on S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td class="CodeFont">oneLineRecords</td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.
            </td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont">charset</td>
            <td>The character encoding of the import file. The default value is UTF-8.
            </td>
            <td class="CodeFont">null</td>
        </tr>
    </tbody>
</table>

## Usage {#Usage}

You can use the `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` procedure to pre-split a data file that you're importing with the [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure. Alternatively, `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` can sample the data in your file and create the split keys itself.

When you pre-split your data, make sure that you set the `skipSampling` parameter to `true` when calling `SYSCS_UTIL.BULK_IMPORT_HFILE`; that tells the bulk import procedure that you have already split your data.
{: .noteIcon}

The [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) section of our *Importing Data Tutorial* describes the different methods for using our bulk HFile import functionality.

## Example {#Example}

This example details the steps used to import data inHFile format by:

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
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

</div>
</section>
