---
title: Binary_Export command
summary: Exports query results to binary format files.
keywords: csv file, export, compression, encoding, separator
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_binaryexport.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Binary_Export Command

The <span class="AppCommand">binary_export</span> command exports the results
of an SQL query to one or more binary files.

This command is currently limited to writing binary files only in `parquet` format; other formats will be supported in a future release.
{: .noteIcon}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    BINARY_EXPORT ( exportPath,
                    compression,
                    format )  <SQL_QUERY>;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
exportPath
{: .paramName}
The directory in which you want the export file(s) written.
{: .paramDefnFirst}

compress
{: .paramName}
A Boolean value that specifies whether (`true`) or not (`false`) to compress the exported files. Files are compressed using the `parquet` compression standard.
{: .paramDefnFirst}

format
{: .paramName}
The format in which to write the CSV files. The only format supported at this time is `parquet`.
{: .paramDefnFirst}
</div>

## Usage

The <span class="AppCommand">BINARY_EXPORT</span> command generates one or
more binary files and stores them in the directory that you specify in the
`exportPath` parameter. More than one output file can be generated to
enhance the parallelism and performance of this operation.

If `compression=true`, then each of the generated files is named with
this format:

 <div class="preWrapper" markdown="1">
    export_<N>.snappy.parquet
{: .AppCommand xml:space="preserve"}
</div>

The value of <span class="AppCommand">&lt;N&gt;</span> is a random
integer value.

### Merging the Exported Files

You can copy all of the exported files into a single file on your local
file system using the Hadoop FS command `getmerge`. The syntax for
`getmerge` is:

 <div class="fcnWrapperWide" markdown="1">
    hadoop fs -getmerge sourceDir localPath
{: .FcnSyntax xml:space="preserve"}

</div>

Use the *exportPath* directory as the value of `sourceDir` to copy all of
the exported CSV files to your *localPath*.

For more information about the `getmerge` command, see
[http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html#getmerge.][1]{:
target="_blank"}

## Examples

 <div class="preWrapperWide" markdown="1">
     splice> BINARY_EXPORT('/my/export/dir', true, 'parquet')
              SELECT a,b,sqrt(c) FROM t1 WHERE a > 100;
{: .AppCommand xml:space="preserve"}
</div>

## See Also
* The [Export command](cmdlineref_export.html) exports query results in CSV format.

</div>
</section>



[1]: http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html#getmerge
