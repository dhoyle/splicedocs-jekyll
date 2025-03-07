---
title: Export command
summary: Exports query results to CSV&#160;files.
keywords: csv file, export, compression, encoding, separator
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_export.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Export Command

The <span class="AppCommand">export</span> command exports the results
of an SQL query to a CSV (comma separated value) file.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    EXPORT ( exportPath,
             compression,
             replicationCount,
             fileEncoding,
             fieldSeparator,
             quoteCharacter,
             quoteMode )  <SQL_QUERY>;
{: .FcnSyntax xml:space="preserve"}

</div>

–OR–

<div class="fcnWrapperWide" markdown="1">
    EXPORT TO <exportPath>
    AS 'csv'
    COMPRESSION <compression>
    REPLICATION_COUNT <replicationCount>
    ENCODING <encoding>
    FIELD_SEPARATOR <fieldSeparator>
    QUOTE_CHARACTER <quoteCharacter>
    QUOTE_MODE <quoteMode>  
    <SQL_QUERY>;
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="paramList" markdown="1">
exportPath
{: .paramName}

The directory in which you want the export file(s) written.
{: .paramDefnFirst}

compression
{: .paramName}

A Boolean or string value that specifies how to compress the exported files; you can specify one of
the following values:
{: .paramDefnFirst}

<div markdown="0">
    <table summary="Possible values for compression">
            <col />
            <col />
            <thead>
                <tr>
                    <th>Value</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>true</code></td>
                    <td>The exported files are compressed using <code>gzip</code>.</td>
                </tr>
                <tr>
                    <td><code>false</code></td>
                    <td>Exported files are not compressed.</td>
                </tr>
                <tr>
                    <td><code>'gz'</code> or <code>'gzip'</code></td>
                    <td>The exported files are compressed using <code>gzip</code>.</td>
                </tr>
                <tr>
                    <td><code>'bz2'</code> or <code>'bzip2'</code></td>
                    <td>The exported files are compressed using <code>bzip2</code>.</td>
                </tr>
                <tr>
                    <td><code>'none'</code></td>
                    <td>Exported files are not compressed.</td>
                </tr>
            </tbody>
        </table>
</div>

replicationCount
{: .paramName}

The file system block replication count to use for the exported
CSV files.
{: .paramDefnFirst}

You can specify any positive integer value. The default value is `1`.
{: .paramDefn}

fileEncoding
{: .paramName}

The character set encoding to use for the exported CSV files.
{: .paramDefnFirst}

You can specify any character set encoding that is supported by the
Java Virtual Machine (JVM). The default encoding is `UTF-8`.
{: .paramDefn}

fieldSeparator
{: .paramName}

The character to use for separating fields in the exported CSV files.
{: .paramDefnFirst}

The default separator character is the comma (`,`).
{: .paramDefn}

quoteCharacter
{: .paramName}

The character to use for quoting output in the exported CSV files.
{: .paramDefnFirst}

The default quote character is the double quotation mark (`"`).
{: .paramDefn}

quoteMode
{: .paramName}

The quoteMode to use for quoting output in the exported CSV files.
{: .paramDefnFirst}

The default setting `DEFAULT` specifies the default behavior, where quote characters are only used when the column content could lead to an ambiguity. The `ALWAYS` setting specifies that CHAR and VARCAR data types are always quoted in the exported CSV file.
{: .paramDefn}

</div>

## Usage

The <span class="AppCommand">EXPORT</span> command generates one or
more
CSV files and stores them in the directory that you specified in the
`exportPath` parameter. More than one output file is generated to
enhance the parallelism and performance of this operation.

If `compression=true`, then each of the generated files is named with
this format:

 <div class="preWrapper" markdown="1">
    export_<N>.csv.gz
{: .AppCommand xml:space="preserve"}

</div>

If `compression=false`, then each of the generated files is named with
this format:

 <div class="preWrapper" markdown="1">
    export_<N>.csv
{: .AppCommand}

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
             -- This example uses all default options:
     splice> EXPORT('/my/export/dir', false, null, null, null, null)
              SELECT a,b,sqrt(c) FROM t1 join t2 on t1.a=t2.a2;

             -- This example explicitly specifies options:
    splice> EXPORT('/my/export/dir', 'bz2', 3, 'utf-8', '|', ';')
              SELECT a,b,sqrt(c) FROM t1 join t2 on t1.a=t2.a2;
{: .AppCommand xml:space="preserve"}

</div>

The following syntax:
<div class="preWrapperWide" markdown="1">
    EXPORT ('/tmp/', null, null, null, null, '#') <SQL_QUERY>;
{: .AppCommand xml:space="preserve"}

</div>
Can be replaced with
<div class="preWrapperWide" markdown="1">
    EXPORT TO '/tmp' AS 'csv' QUOTE_CHARACTER '#'
    <SQL_QUERY>;
{: .AppCommand xml:space="preserve"}

</div>

And the following syntax:
<div class="preWrapperWide" markdown="1">
    EXPORT_BINARY ( exportPath,
                    compression,
                    format )  <SQL_QUERY>;
{: .AppCommand xml:space="preserve"}

</div>
Can be replaced with
<div class="preWrapperWide" markdown="1">
    EXPORT TO 'exportPath' AS 'format' COMPRESSION compression
    <SQL_QUERY>;
{: .AppCommand xml:space="preserve"}

</div>

## See Also
* The [Export_Binary command](cmdlineref_exportbinary.html) exports query results in binary format.


</div>
</section>



[1]: http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html#getmerge
