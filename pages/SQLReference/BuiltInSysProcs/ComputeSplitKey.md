---
title: SYSCS_UTIL.COMPUTE_SPLIT_KEY built-in system procedure
summary: Built-in system procedure that computes the split keys for a table or index, prior to using the BULK_IMPORT_HFILE procedure to import data from HFiles.
keywords: compute split keys for HFile import, compute_split_key
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_computesplitkey.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.COMPUTE_SPLIT_KEY

You can use the `SYSCS_UTIL.COMPUTE_SPLIT_KEY` system procedure to compute
the split keys for a table or index prior to calling the &nbsp; [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedure to pre-split the data that you're importing into HFiles.

Splice Machine recommends using the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) system procedure instead of this one unless you're an expert user. The combination of using `SYSCS_UTIL.COMPUTE_SPLIT_KEY` with `SYSCS_UTIL.COMPUTE_SPLIT_KEY` is exactly equivalent to using `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`.
{: .noteIcon}
{: .noteIcon}

For more information about splitting your tables and indexes into HFiles, see the [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) section of our *Best Practices* Guide.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.COMPUTE_SPLIT_KEY (
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
            outputDirectory
    );
{: .FcnSyntax xml:space="preserve"}

</div>

## Parameters

The parameter values that you pass into this procedure should match the values that you use when you subsequently call the
 &nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure to perform the import.
{: .noteIcon}

This table includes a brief description of each parameter; additional information is available in the [Ingestion Parameter Values](bestpractices_ingest_params.html) topic of our *Importing Data* tutorial.

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
            <td class="CodeFont">insertColumnList</td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont">fileOrDirectoryName</td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p>On a cluster, the files to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
            <p>See the <a href="developers_cloudconnect_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> topic for information about accessing data on S3.</p>
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
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
            <td class="CodeFont">badRecordsAllowed</td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont">badRecordDirectory</td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td class="CodeFont">bulkImportDirectory  (outputDirectory)</td>
            <td><p>For <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code>, this is the name of the  directory into which the generated HFiles are written prior to being imported into your database.</p>
            <p>For the <code>SYSCS_UTIL.COMPUTE_SPLIT_KEY</code> procedure, where it is named <code>outputDirectory</code>, this parameter specifies the directory into which the split keys are written.</p>
            </td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont">skipSampling</td>
            <td><p>The <code>skipSampling</code> parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed. Set to <code>false</code> to have <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> automatically determine splits for you.</p>
            <p>This parameter is only used with the <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> system procedure.</p>
            </td>
            <td class="CodeFont">false</td>
        </tr>
    </tbody>
</table>

## Usage {#Usage}
This procedure generates a split keys file in CSV format, which you pass into the `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`. That procedure pre-splits the data that you then import with &nbsp;&nbsp;[`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html).

The functionality of the [`SYSCS_UTIL.COMPUTE_SPLIT_KEY`] and [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html) procedures has been combined into one simplified procedure: &nbsp;&nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html). We recommend using the simplified procedure, which performs exactly the same functions.
{: .noteIcon}

The [Best Practices: Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) section of our *Importing Data Tutorial* describes the different methods for using our bulk HFile import functionality.

## See Also

*  [Best Practices: Ingestion](bestpractices_ingest_overview.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)
*  [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`](sqlref_sysprocs_splittableatpoints.html)

</div>
</section>
