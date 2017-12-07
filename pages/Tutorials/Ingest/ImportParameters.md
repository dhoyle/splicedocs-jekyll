---
title: "Importing Data: Specifying Import Parameters"
summary: Detailed specifications of the parameter values used in Splice Machine data ingestion.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importparams.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Specifying the Import Parameter Values

This topic provides detailed information about the input parameters you need to specify when calling one of the Splice Machine data ingestion procedures.

##



The syntax for calling these procedures includes a large number of
parameters:

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA (

## Database Table Details

schemaName
tableName

## Data To Import
fileOrDirectoryName
insertColumnList

## Input Data Format Specifics
oneLineRecords
charset
characterDelimiter
timestampFormat
dateFormat
timeFormat

## Bad Record Logging and Error Handling
badRecordsAllowed
badRecordDirectory



</div>
These parameters are described in detail in the [SQL Reference
Manual](sqlref_sysprocs_importdata.html); here are brief descriptions:

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
            <td><code>schemaName</code></td>
            <td>The name of the schema of the table in which to import.</td>
            <td><code>SPLICE</code></td>
        </tr>
        <tr>
            <td><code>tableName</code></td>
            <td>The name of the table in which to import</td>
            <td><code>playerTeams</code></td>
        </tr>
        <tr>
            <td><code>insertColumnList</code></td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td><code>'ID, TEAM'</code></td>
        </tr>
        <tr>
            <td><code>fileOrDirectoryName</code></td>
            <td>
                <p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
                <p class="noteNote">You can specify a directory or a single file when using the <code>SYSCS_UTIL.IMPORT_DATA</code> or <code>SYSCS_UTIL.UPSERT_DATA_FROM_FILE</code> procedures; however, you can only specify a single file when using the <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code> procedure.</p>
                <p>If you're importing data from an S3 bucket on AWS, please review our <a href="tutorials_ingest_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> tutorial before proceeding.</p>
                <p class="noteIcon">You must specify a directory in an S3 bucket when importing data into your Splice Machine Database-as-Service database, and you must possess the access key/secret key pair for that S3 bucket.</p>
                <p>See these tips:</p>
                <ul class="bullet">
                    <li><a href="#Tip">Tip #1:  Specifying the File Location
</a>
                    </li>
                    <li><a href="#Tip2">Tip #2:  Import Large Datasets in Groups of Files</a>
                    </li>
                    <li><a href="#Tip3">Tip #3:  Don't Compress Your Files With GZIP</a>
                    </li>
                </ul>
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
        </tr>
        <tr>
            <td><code>columnDelimiter</code></td>
            <td>
                <p>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </p>
                <p>See <a href="#Tip4">Tip #4:  Use Special Characters for Delimiters</a>.</p>
            </td>
            <td class="CodeFont">
                <p>'|'</p>
            </td>
        </tr>
        <tr>
            <td><code>characterDelimiter</code></td>
            <td>
                <p>The character is used to delimit strings in the imported data. </p>
                <p>See <a href="#Tip4">Tip #4:  Use Special Characters for Delimiters</a>.</p>
            </td>
            <td><code>''</code></td>
        </tr>
        <tr>
            <td><code>timestampFormat</code></td>
            <td>
                <p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
                <p>See <a href="#Tip5">Tip #5:  Avoid Problems With Date, Time, and Timestamp Formats</a>.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td><code>dateFormat</code></td>
            <td>
                <p>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</p>
                <p>See <a href="#Tip5">Tip #5:  Avoid Problems With Date, Time, and Timestamp Formats</a>.</p>
            </td>
            <td><code>yyyy-MM-dd</code></td>
        </tr>
        <tr>
            <td><code>timeFormat</code></td>
            <td>
                <p>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".</p>
                <p>See <a href="#Tip5">Tip #5:  Avoid Problems With Date, Time, and Timestamp Formats</a>.</p>
            </td>
            <td><code>HH:mm:ss</code></td>
        </tr>
        <tr>
            <td><code>badRecordsAllowed</code></td>
            <td>
                <p>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back.
Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.</p>
            </td>
            <td class="CodeFont">
                <p>25</p>
            </td>
        </tr>
        <tr>
            <td><code>badRecordDirectory</code></td>
            <td>
                <p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <em>badRecordDirectory</em><code>/foo.csv.bad</code>.</p>
                <p>If you're logging bad record information to an S3 bucket on AWS, please review our <a href="tutorials_ingest_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> tutorial before proceeding.</p>
                <p class="noteIcon">you must specify a directory in an S3 bucket when importing data into your Splice Machine Database-as-Service database, and you must possess the access key/secret key pair for that S3 bucket.</p>
                <p>See these tips:</p>
                <ul class="bullet">
                    <li><a href="#Tip">Tip #1:  Specifying the File Location</a></li>
                    <li><a href="#Tip6">Tip #6:  Change the Bad Directory for Each Table / Group</a>.</li>
                </ul>
            </td>
            <td><code>'importErrsDir'</code></td>
        </tr>
        <tr>
            <td><code>oneLineRecords</code></td>
            <td>
                <p>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines. </p>
                <p>See <a href="#Tip7">Tip #7:  Importing Multi-line Records</a>.</p>
            </td>
            <td><code>true</code></td>
        </tr>
        <tr>
            <td><code>charset</code></td>
            <td>
                <p>The character encoding of the import file. The default value is UTF-8. </p>
                <p class="noteIcon">Currently, any other value is ignored and UTF-8 is used.</p>
            </td>
            <td><code>null</code></td>
        </tr>
    </tbody>
</table>
{% include splice_snippets/importcolvals.md %}
