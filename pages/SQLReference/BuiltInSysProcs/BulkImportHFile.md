---
title: SYSCS_UTIL.BULK_IMPORT_HFILE built-in system procedure
summary: Built-in system procedure that imports data from an hfile.
keywords: bulk import, hfile import, bulk_import_hfile, import_hfile
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_importhfile.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.BULK_IMPORT_HFILE

The `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure imports data into
your Splice Machine database by splitting the table or index file into HFiles and then
importing those HFiles. The splitting can be managed automatically by this procedure, or you
can pre-split the data before calling `SYSCS_UTIL.BULK_IMPORT_HFILE`.

Unlike our standard [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) procedure, our bulk HFile
procedure does not perform constraint checking while loading your data.
{: noteImportant}

Our []*Best Practices: Ingestion*] chapter includes an overview and examples of using bulk HFile import.

## Syntax

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

If you have specified `skipSampling=true` to indicate that you've computed *pre-splits* for your input data, the parameter values that you pass to that procedures must match the values that you pass to this procedure for the same-named parameters.
{: .noteNote}

## Parameters

This table includes a brief description of each parameter; additional information is available in the [Ingestion Parameter Values](bestpractices_ingest_params.html) topic of our *Importing Data* tutorial.

<table>
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
            <td class="CodeFont">insertColumnList</td>
            <td><p>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</p>
            <p class="noteNote">The individual column names in the <code>insertColumnList</code> do not need to be double-quoted, even if they contain special characters. However, if you do double-quote any column name, <strong>you must</strong> double-quote all of the column names.</p>
            </td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont">fileOrDirectoryName</td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p>On a cluster, the files to be imported <strong>MUST be in Azure Storage, S3, HDFS (or
            MapR-FS)</strong>. If you're using our Database Service product, you can import files from S3 or Azure Storage.</p>
            <p>See the <a href="developers_cloudconnect_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> or <a href="developers_cloudconnect_configureazure.html">Using Azure Storage</a> topics for information.</p>
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
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
            <p>On a cluster, this directory <span class="BoldFont">MUST be on Azure Storage, S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from Azure Storage or S3.</p>
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
        <tr>
            <td class="CodeFont">bulkImportDirectory  (outputDirectory)</td>
            <td>The name of the  directory into which the generated HFiles are written prior to being imported into your database. These files will be deleted after the import has finished.</td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont">skipSampling</td>
            <td>
                <p>The <code>skipSampling</code> parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed. Set to <code>false</code> to have <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> automatically determine splits for you.</p>

                <p>If <code>skipSampling</code> is <code>true</code>, you need to use <a href="sqlref_sysprocs_splittable.html"><code>SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX</code></a> (recommended) or <a href="sqlref_sysprocs_splittableatpoints.html"><code>SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS</code></a> (for expert users) to pre-compute splits for your table before calling <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code>.</p>

                <p>If <code>skipSampling</code> is <code>false</code>, then <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> samples your input data and computes the table splits for you by performing the following steps. It: </p>
                <ol>
                    <li>Scans (sample) the data.</li>
                    <li>Collects a rowkey histogram.</li>
                    <li>Uses that histogram to calculate the split key for the table.</li>
                    <li>Uses the calculated split key to split the table into HFiles.</li>
                </ol>
                <p>This allows you more control over the splits, but adds a layer of complexity. You can learn about computing splits for your input data in the <a href="bestpractices_ingest_bulkimport.html">Using Bulk HFile Import</a> topic of our Best Practices Guide.</p>
            </td>
            <td class="CodeFont">false</td>
        </tr>
    </tbody>
</table>

## Usage {#Usage}

Before it generate HFiles, `SYSCS_UTIL.BULK_IMPORT_HFILE` must use *split keys* to determine how to split
the data file into multiple HFiles. Splitting the file into evenly-size HFiles yields optimal data loading performance.

You have these choices for determining how the data is split:

* You can call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter set to `false`; this procedure then samples and analyzes the data in your file and splits the data into temporary HFiles based on that analysis. You'll find an example in the [Best Practices: Bulk Importing Flag Files](bestpractices_ingest_bulkimport.html) chapter of our Best Practices Guide.

* You can *pre-split* your data by first creating a CSV file that specifies the split keys to use to perform the pre-splits, and then calling the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to pre-split your table or index file. You'll also find an example of this in the [Best Practices: Bulk Importing Flag Files](bestpractices_ingest_bulkimport.html) chapter of our Best Practices Guide.
*
`SYSCS_UTIL.BULK_IMPORT_HFILE` automatically deletes the temporary HFiles after the import process has completed.
{: .noteNote}

## Usage Notes

A few important notes:

* Splice Machine advises you to __run a full compaction__ (with the  [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html) system procedure) after importing large amounts of data into your database.

* On a cluster, the files to be imported **MUST be on Azure Storage, S3, HDFS (or
MapR-FS)**, as must the `badRecordDirectory` directory. If you're using
our Database Service product, files can only be imported from Azure Storage or S3.

  In addition, the files must be readable by the `hbase` user, and the
`badRecordDirectory` directory must be writable by the `hbase` user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
        sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

## Results

`SYSCS_UTIL.BULK_IMPORT_HFILE` displays a summary of the import
process results that looks like this:

<div class="preWrapperWide" markdown="1">

    rowsImported   |failedRows   |files   |dataSize   |failedLog
    -------------------------------------------------------------
    94             |0            |1       |4720       |NONE
{: .Example xml:space="preserve"}
</div>

## Examples

You'll find examples of using this procedure in the [Best Practices: Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) topic of our Best Practices Guide.

## See Also

*  [Best Practices: Ingestion](bestpractices_ingest_overview.html)
*  [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)

</div>
</section>
