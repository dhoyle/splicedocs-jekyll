<div markdown="1">
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema of the table in which to import.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table in which to import.
{: .paramDefnFirst}

insertColumnList
{: .paramName}

The names, in single quotes, of the columns to import. If this is
`null`, all columns are imported.
{: .paramDefnFirst}

<div class="notePlain" markdown="1">
If you don\'t specify an `insertColumnList` and your input file contains
more columns than are in the table, then the the extra columns at the
end of each line in the input file **are ignored**. For example, if your
table contains columns `(a, b, c)` and your file contains columns `(a,
b, c, d, e)`, then the data in your file\'s `d` and `e` columns will be
ignored.

If you do specify an `insertColumnList`, and the number of columns
doesn\'t match your table, then any other columns in your table will be
replaced by the default value for the table column (or `NULL` if there
is no default for the column). For example, if your table contains
columns `(a, b, c)` and you only want to import columns `(a, c)`, then
the data in table\'s `b` column will be replaced with the default value
for that column.

</div>
fileOrDirectoryName <span class="bodyFont">(for IMPORT or UPSERT)</span>

 fileName <span class="bodyFont">(for MERGE)</span>
{: .paramName}

For the `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` or
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedures, this is either a single
file or a directory. If this is a single file, that file is imported; if
this is a directory, all of the files in that directory are imported.
{: .paramDefnFirst}

For the `SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure, this can only be a
single file (directories are not allowed).
{: .paramDefn}

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information. See [Importing Data from AWS](#Importin), below.
{: .noteIcon}

Note that files can be compressed or uncompressed, including BZIP2
compressed files.
{: .paramDefn}

<div class="notePlain" markdown="1">
Importing multiple files at once improves parallelism, and thus speeds
up the import process. Uncompressed files can be imported faster than
compressed files. When using compressed files, the compression algorithm
makes a difference; for example,

* `gzip`-compressed files cannot be split during importation, which
  means that import work on such files cannot be performed in parallel.
* In contrast, `bzip2`-compressed files can be split and thus can be
  imported using parallel tasks. Note that `bzip2` is CPU intensive
  compared to `LZ4` or `LZ0`, but is faster than gzip because files can
  be split.

</div>
</div>
<div class="paramList" markdown="1">
columnDelimiter
{: .paramName}

The character used to separate columns, Specify `null` if using the
comma (`,`) character as your delimiter.
{: .paramDefnFirst}

<div markdown="1">
In addition to using single characters, you can specify the following
special characters as delimiters:
{: .paramDefn}

<table summary="Special characters that can be used as character delimiters in imported files.">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Special character</th>
                            <th>Display</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>\t</code></td>
                            <td>Tab </td>
                        </tr>
                        <tr>
                            <td><code>\f</code></td>
                            <td>Formfeed</td>
                        </tr>
                        <tr>
                            <td><code>\b</code></td>
                            <td>Backspace</td>
                        </tr>
                        <tr>
                            <td><code>\\</code></td>
                            <td>Backslash</td>
                        </tr>
                        <tr>
                            <td><code>^a (or ^A)</code></td>
                            <td>
                                <p>Control-a</p>
                                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
</div>
characterDelimiter
{: .paramName}

Specifies which character is used to delimit strings in the imported
data. You can specify `null` or the empty string to use the default
string delimiter, which is the double-quote (`"`).
{: .paramDefnFirst}

<div markdown="1">
In addition to using single characters, you can specify the following
special characters as delimiters:
{: .paramDefn}

<table summary="Special characters that can be used as character delimiters in imported files.">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Special character</th>
                            <th>Display</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>\t</code></td>
                            <td>Tab </td>
                        </tr>
                        <tr>
                            <td><code>\f</code></td>
                            <td>Formfeed</td>
                        </tr>
                        <tr>
                            <td><code>\b</code></td>
                            <td>Backspace</td>
                        </tr>
                        <tr>
                            <td><code>\\</code></td>
                            <td>Backslash</td>
                        </tr>
                        <tr>
                            <td><code>^a (or ^A)</code></td>
                            <td>
                                <p>Control-a</p>
                                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
</div>
If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.
{: .paramDefnFirst}

To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.  
  
 The [Examples](#Examples) section below contains an example that uses
the single quote as the string delimiter character.
{: .noteNote}

timestampFormat
{: .paramName}

The format of timestamps stored in the file. You can set this to `null`
if there are no time columns in the file, or if the format of any
timestamps in the file match the `Java.sql.Timestamp` default format,
which is: \"*yyyy-MM-dd HH:mm:ss*\". See the [About Timestamp
Formats](#TimestampFormats) section below for more information about
timestamps.
{: .paramDefnFirst}

All of the timestamps in the file you are importing must use the same
format.
{: .noteNote}

dateFormat
{: .paramName}

The format of datestamps stored in the file. You can set this to `null`
if there are no date columns in the file, or if the format of any dates
in the file match pattern: \"*yyyy-MM-dd*\".
{: .paramDefnFirst}

timeFormat
{: .paramName}

The format of time values stored in the file. You can set this to null
if there are no time columns in the file, or if the format of any times
in the file match pattern: \"*HH:mm:ss*\".
{: .paramDefnFirst}

<div markdown="1">
badRecordsAllowed
{: .paramName}

The number of rejected (bad) records that are tolerated before the
import fails. If this count of rejected records is reached, the import
fails, and any successful record imports are rolled back.
{: .paramDefnFirst}

* If you specify `-1` as the value of this parameter, all record import
  failures are tolerated and logged.
* If you specify `0` as the value of this parameter, the import will
  fail if even one record is bad.
{: .bulletNested}

In previous releases of Splice Machine, this parameter was named
`failBadRecordCount`, and a value of `0` meant that all record import
failures were tolerated. This has been changed, and you now must specify
a value of `-1` for `badRecordsAllowed` to tolerate all bad records.
{: .noteIcon}

badRecordDirectory
{: .paramName}

The directory in which bad record information is logged. Splice Machine
logs information to the `<import_file_name>.bad` file in this directory;
for example, bad records in an input file named `foo.csv` would be
logged to a file named *badRecordDirectory*`/foo.csv.bad`.
{: .paramDefnFirst}

The default value is the directory in which the import files are found.
{: .paramDefn}

oneLineRecords
{: .paramName}

A Boolean value that specifies whether each line in the import file
contains one complete record:
{: .paramDefnFirst}

* If you specify `true` or `null`, then each record is expected to be
  found on a single line in the file.
* If you specify `false`, records can span multiple lines in the file.
{: .bulletNested}

Multi-line record files are slower to load, because the file cannot be
split and processed in parallel; if you import a directory of multiple
line files, each file as a whole is processed in parallel, but no
splitting takes place.
{: .noteNote}

charset
{: .paramName}

The character encoding of the import file. The default value is UTF-8.
Currently, any other value is ignored and UTF-8 is used.
{: .paramDefnFirst}

</div>
</div>
## <a name="Importin" />Importing Data from AWS

If you are importing data that is stored in an S3 bucket on Amazon Web
Services (*AWS*), you need to specify the file location in an `s3a` URL
that includes the access key and secret access key for the bucket.

Please review our [Configuring an S3 Bucket for Splice Machine
Access](tutorials_ingest_configures3.html) tutorial to make sure you\'ve
set up access permissions that allow Splice Machine to access the
bucket.
{: .notePlain}

You can include the access keys inline; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, -1, '/Users/hive', true, null);
{: .Example}

</div>
Alternatively, you can define the keys once in the `core-site.xml` file
on your cluster, and then simply specify the `s3a` URL; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, 0, '/BAD', true, null);
{: .Example}

</div>
### Adding Your Keys to core-site.xml

To add your access and secret access keys to the `core-site.xml` file,
define the `fs.s3a.awsAccessKeyId` and `fs.s3a.awsSecretAccessKey`
properties in that file:

<div class="preWrapperWide" markdown="1">
    <property>   <name>fs.s3a.awsAccessKeyId</name>   <value>access key</value></property><property>   <name>fs.s3a.awsSecretAccessKey</name>   value>secret key</value></property>
{: .Example}

</div>
Here\'s an example of the property definitions:

<div class="preWrapperWide" markdown="1">
    <property>   <name>fs.s3a.awsAccessKeyId</name>   <value>AKIAIOSFODNN7EXAMPLE</value></property><property>   <name>fs.s3a.awsSecretAccessKey</name>   value>wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY</value></property>
{: .Example}

</div>
</div>

