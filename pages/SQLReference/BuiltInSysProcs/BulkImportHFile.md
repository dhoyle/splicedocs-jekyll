---
title: SYSCS_UTIL.BULK_IMPORT_HFILE built-in system procedure
summary: Built-in system procedure that imports data from an hfile.
keywords: bulk import, hfile import, bulk_import_hfile, import_hfile
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_importhfile.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.BULK_IMPORT_HFILE

The `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure imports data into
your Splice Machine database by first generating HFiles and then
importing those HFiles. Our *Importing Data Tutorial* includes a section about [using bulk HFile import](tutorials_ingest_importbulkHfile.html) that explains the process.

Our HFile data import procedure leverages HBase bulk loading, which
allows it to import your data at a faster rate; however, using this
procedure instead of our standard
[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) procedure
means that <span class="CalloutFont">constraint checks are not performed
during data importation</span>.
{: .noteImportant}

This procedure is one of several built-in system procedures provided by Splice Machine for importing data into your database. See our [*Importing Data Tutorial*](tutorials_ingest_importoverview.html) for help with selecting the right process for your situation.

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

If you have specified `skipSampling=true` to indicate that you're using &nbsp;
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to compute the split keys, the parameter values that you pass to that procedures must match the values  that you pass to this procedure.
{: .noteNote}

## Parameters

The following table summarizes the parameters used by `SYSCS_UTIL.BULK_IMPORT_HFILE` and other Splice Machine data importation procedures. Each parameter name links to a more detailed description in our [Importing Data Tutorial](tutorials_ingest_importparams.html).

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
            <td class="CodeFont">insertColumnList</td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont">fileOrDirectoryName</td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p>On a cluster, the files to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
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
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
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
            <td>The name of the  directory into which the generated HFiles are written prior to being imported into your database.</td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont">skipSampling</td>
            <td>The <code>skipSampling</code> parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed. Set to <code>false</code> to have <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> automatically determine splits for you.</td>
            <td class="CodeFont">false</td>
        </tr>
    </tbody>
</table>

## Usage {#Usage}

If you're using this procedure with our On-Premise database product, on a cluster with Cloudera Key Management Service (KMS) enabled, there are a few extra configuration steps required. Please see [this troubleshooting note](bestpractices_onprem_importing.html#BulkImportKMS) for details.
{: .noteIcon}

The [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) procedure needs the data that you're importing split into multiple HFiles before it actually imports the data into your database. You can achieve these splits in two ways:

* You can call `SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `false`. `SYSCS_UTIL.BULK_IMPORT_HFILE` samples the data to determine the splits, then splits the data into multiple HFiles, and then imports the data.

* You can split the data into HFiles with the &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) system procedure, which both computes the keys and performs the splits. You then call
 &nbsp;`SYSCS_UTIL.BULK_IMPORT_HFILE` with the `skipSampling` parameter to `true` to import your data. For more information about splitting your tables and indexes into HFiles, see the [Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) section of our *Importing Data* tutorial.

In either case, `SYSCS_UTIL.BULK_IMPORT_HFILE` automatically deletes the temporary HFiles after the import process has completed.

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

The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html)

</div>
</section>
