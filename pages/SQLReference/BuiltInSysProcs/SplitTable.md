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

The `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` system procedure computes
the split keys for a table or index, prior to importing that table in
HFile format. You must use this procedure in conjunction with the
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

The following table summarizes the parameters used by `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` and other Splice Machine data importation procedures.

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
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont">fileName</td>
            <td><p>The name of the file that you want to import.</p>
                <p>On a cluster, the file to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
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

## Examples

The [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic walks you through several examples of importing data with bulk HFiles.

## See Also

* [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

</div>
</section>
