---
title: "Importing Data:  Error Handling"
summary: Describes how to use logging and how to handle errors during data ingestion.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importerrors.html
folder: DeveloperTutorials/Import
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Logging and Error Handling

This topic describes the logging and error handling features of Splice Machine data imports.

## Logging

Each of these import procedures includes a logging facility:

*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

Errors are logged to a file in the directory that you specify in the `badRecordDirectory` parameter when you call one of the procedures.

The `badRecordDirectory` parameter is a string that specifies the directory in which bad record information is logged. The default value is the directory in which the import files are found.

Splice Machine logs information to the `<import_file_name>.bad` file in this directory; for example, bad records in an input file named `foo.csv` would be logged to a file named *badRecordDirectory*`/foo.csv.bad`.

The `badRecordDirectory` directory must be writable by the hbase user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
    sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

On a cluster, the `badRecordDirectory` directory **MUST be on S3, HDFS (or
MapR-FS)**. If you're using our Database Service product, this directory must be on S3.
{: .noteNote}

## Stopping the Import Due to Too Many Errors

All of the import procedures also take a `badRecordsAllowed` or `maxBadRecords` parameter, the value of which determines how many erroneous input data record errors are allowed before the import is stopped. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back.

These `badRecordsAllowed` values have special meaning:

* If you specify `-1`, all record import failures are tolerated and logged.
* If you specify `0`, the import will fail as soon as one bad record is detected.

## Managing Logging When Importing Multiple Files

In addition to importing a single file, the &nbsp;[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) and
  &nbsp;[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedures can import all of the files in a directory.

When you are importing a large amount of data and have divided the files
you are importing into groups, then it's a good idea to change the
location of the bad record directory for each group; this will make
debugging bad records a lot easier for you.

You can change the value of the `badRecordDirectory` to include your
group name; for example, we typically use a strategy like the following:

<table style="width: 100%;">
    <col />
    <col />
    <thead>
        <tr>
            <th>Group Files Location</th>
            <th><span class="CodeBoldFont">badRecordDirectory</span> Parameter Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>/data/mytable1/group1</code></td>
            <td><code>/BAD/mytable1/group1</code></td>
        </tr>
        <tr>
            <td><code>/data/mytable1/group2</code></td>
            <td><code>/BAD/mytable1/group2</code></td>
        </tr>
        <tr>
            <td><code>/data/mytable1/group3</code></td>
            <td><code>/BAD/mytable1/group3</code></td>
        </tr>
    </tbody>
</table>
You'll then be able to more easily discover where the problem record is
located.

## See Also

*  [Importing Data: Tutorial Overview](tutorials_ingest_importoverview.html)
*  [Importing Data: Input Parameters](tutorials_ingest_importparams.html)
*  [Importing Data: Input Data Handling](tutorials_ingest_importinput.html)
*  [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html)
*  [Importing Data: Bulk HFile Index Creation](tutorials_ingest_importbulkindex.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

</div>
</section>
