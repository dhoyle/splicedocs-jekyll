---
title: "Importing Data: Input Data Handling"
summary: Detailed information about input data handling during ingestion.
keywords: import, load data, import data, importing from, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importinput.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Input Considerations

This topic provides detailed information about how the parameter values you specify when importing data are handled by Splice Machine's built-in import procedures.

For a summary of our import procedures and determining which to use, please see [Importing Data: Overview](tutorials_ingest_importoverview.html).

For reference descriptions of the parameters used by those import procedures, please see [Importing Data: Parameter Usage](tutorials_ingest_importparams.html).

This topic includes the following sections:

<table>
  <col width="35%"/>
  <col />
  <thead>
    <tr>
        <th>Section</th>
        <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td><a href="#Location">Specifying Your Input Data Location</a></td>
        <td>Describes how to specify the location of your input data when importing.</td>
    </tr>
    <tr>
        <td><a href="#InputFiles">Input Data File Format</a></td>
        <td>Information about input data files, including importing compressed files and multi-line records.</td>
    </tr>
    <tr>
        <td><a href="#Delimiters">Delimiters in Your Input Data</a></td>
        <td>Discusses the use of column and characters delimiters in your input data.</td>
    </tr>
    <tr>
        <td><a href="#DateFormats">Time and Date Formats in Input Records</a></td>
        <td>All about the date, time, and timestamp values in your input data.</td>
    </tr>
    <tr>
        <td><a href="#Updating">Importing and Updating Records</a></td>
        <td>Discusses importing new records and updating existing database records, handling missing values in the input data, and handling of generated and default values.</td>
    </tr>
    <tr>
        <td><a href="#LOBs">Importing CLOBs and BLOBs</a></td>
        <td>Discussion of importing CLOBs and BLOBs into your Splice Machine database.</td>
    </tr>
    <tr>
        <td><a href="#Scripting">Scripting Your Imports</a></td>
        <td>Shows you how to script your import processes.</td>
    </tr>
  </tbody>
</table>

## Specifying Your Input Data Location    {#Location}

Some customers get confused by the the `fileOrDirectoryName` parameter that's used in our import procedures.
How you use this depends on whether you are importing a single file or a
directory of files, and whether you're importing data into a standalone version or cluster version of Splice Machine. This section contains these three subsections:

* [Standalone Version Input File Path](#StandalonePath)
* [HBase Input File Path](#HBasePath)
* [AWS Input File Path](#AWSPath)

### Standalone Version Input File Path  {#StandalonePath}

If you are running a stand alone environment, the name or path will be
to a file or directory on the file system. For example:

<div class="preWrapperWide" markdown="1">
    /users/myname/mydata/mytable.csv/users/myname/mydatadir
{: .Example}

</div>

### HBase Input File Path  {#HBasePath}

If you are running this on a cluster, the path is to a file on
HDFS (or the MapR File system). For example:

<div class="preWrapperWide" markdown="1">
    /data/mydata/mytable.csv/data/myname/mydatadir
{: .Example}

</div>

### AWS S3 Input File Path {#AWSPath}

Finally, if you're importing data from an S3 bucket, you need to supply
your AWS access and secret key codes, and you need to specify an s3a
URL. This is also true for logging bad record information to an S3 bucket
directory, as will be the case when using our Database-as-Service
product.

For information about configuring Splice Machine access on AWS, please review our [Configuring an S3 Bucket for Splice Machine Access](tutorials_ingest_configures3.html) topic, which walks you through using your AWS dashboard to generate and apply the necessary credentials.

Once you've established your access keys, you can include them inline; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, -1, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/importLog', true, null);
{: .Example}

</div>
Alternatively, you can specify the keys once in the `core-site.xml` file
on your cluster, and then simply specify the `s3a` URL; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, 0, '/BAD', true, null);
{: .Example}

</div>
To add your access and secret access keys to the `core-site.xml` file,
define the `fs.s3a.awsAccessKeyId` and `fs.s3a.awsSecretAccessKey`
properties in that file:

<div class="preWrapperWide" markdown="1">
    <property>   <name>fs.s3a.awsAccessKeyId</name>   <value>access key</value></property><property>   <name>fs.s3a.awsSecretAccessKey</name>   value>secret key</value></property>
{: .Example}

</div>

## Input Data File Format {#InputFiles}

This section contains the following information about the format of the input data files that you're importing:

* [Importing Compressed Files](#CompressedFiles)
* [Importing Multi-line Records](#Multiline)
* [Importing Large Datasets in Groups of Files](#FileGroups)

### Importing Compressed Files {#CompressedFiles}

We recommend importing files that are either uncompressed, or have been
compressed with <span class="CodeBoldFont">bz2</span> or <span
class="CodeBoldFont">lz4</span> compression.

If you import files compressed with `gzip`, Splice Machine cannot
distribute the contents of your file across your cluster nodes to take
advantage of parallel processing, which means that import performance
will suffer significantly with `gzip` files.

### Importing Multi-line Records {#Multiline}

If your data contains line feed characters like `CTRL-M`, you need to
set the `oneLineRecords` parameter to `false`. Splice Machine will
accommodate to the line feeds; however, the import will take longer
because Splice Machine will not be able to break the file up and
distribute it across the cluster.

To improve import performance, avoid including line feed characters in
your data and set the `oneLineRecords` parameter to `true`.
{: .notePlain}

### Importing Large Datasets in Groups of Files {#FileGroups}

If you have a lot of data (100s of millions or billions of records), you
may be tempted to create one massive file that contains all of your
records and import that file; Splice Machine recommends against this;
instead, we urge you to manage your data in smaller files. Specifically,
we suggest that you split your data into files that are:

* approximately 40 GB
* have approximately 50 million records, depending on how wide your
  table is

If you have a lot of files, group them into multiple directories, and
import each directory individually. For example, here is a structure our
Customer Success engineers like to use:

* /data/mytable1/group1
* /data/mytable1/group2
* /data/mytable1/group3
{: .codeList}


## Delimiters in Your Input Data {#Delimiters}

This section discusses the delimiters that you use in your input data, in these subsections:

* [Using Special Characters for Delimiters](#DelimSpecials)
* [Column Delimiters](#DelimColumn)
* [Character Delimiters](#DelimChar)

### Use Special Characters for Delimiters {#DelimSpecials}

One common gotcha we see with customer imports is when the data you're
importing includes a special character that you've designated as a
column or character delimiter. You'll end up with records in your bad
record directory and can spend hours trying to determine the issue, only
to discover that it's because the data includes a delimiter character.
This can happen with columns that contain data such as product
descriptions.

### Column Delimiters {#DelimColumn}

The standard column delimiter is a comma (`,`); however, we've all
worked with string data that contains commas, and have figured out to
use a different column delimiter. Some customers use the pipe (`|`)
character, but frequently discover that it is also used in some
descriptive data in the table they're importing.

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as column delimiters in imported files.">
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

We recommend using a control character like `CTRL-A` for your column
delimiter. This is known as the SOH character, and is represented by
0x01 in hexadecimal. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to [create a script file](#Scripting) and type the control character using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-A` for the value of the column delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^A` when you type it in vi or vim.

### Character Delimiters {#DelimChar}

By default, the character delimiter is a double quote. This can produce
the same kind of problems that we see with using a comma for the column
delimiter: columns values that include embedded quotes or use the double
quote as the symbol for inches. You can use escape characters to include
the embedded quotes, but it's easier to use a special character for your
delimiter.

We recommend using a control character like `CTRL-A` for your column
delimiter. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to [create a script file](#Scripting) and type the control character using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-G` for the value of the character delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^G` when you type it in vi or vim.

## Time and Date Formats in Input Records {#DateFormats}

Perhaps the most common difficulty that customers have with importing
their data is with date, time, and timestamp values.

Splice Machine adheres to the Java `SimpleDateFormat` syntax for all
date, time, and timestamp values, `SimpleDateFormat` is described here:

[https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html][1]{:
target="_blank"}
{: .indentLevel1}

Splice Machine's implementation of `SimpleDateFormat` is case-sensitive;
this means, for example, that a lowercase `h` is used to represent an
hour value between 0 and 12, whereas an uppercase `H` is used to
represent an hour between 0 and 23.

### All Values Must Use the Same Format

Splice Machine's Import procedures only allow you to specify one format
each for the date, time, and timestamp columns in the table data you are
importing. This means that, for example, every date in the table data
must be in the same format.

<div class="notePlain" markdown="1">
All of the `Date` values in the file (or group of files) you are
importing must use the same date format.

All of the `Time` values in the file (or group of files) you are
importing must use the same time format.

All of the `Timestamp` values in the file (or group of files) you are
importing must use the same timestamp format.

</div>

### Additional Notes

A few additional notes:

* The `Timestamp` data type has a range of `1678-01-01` to `2261-12-31`.
  Some customers have used dummy timestamp values like `9999-01-01`,
  which will fail because the value is out of range for a timestamp.
  Note that this is not an issue with `Date` values.
* Splice Machine suggests that, if your data contains any date or
  timestamp values that are not in the format `yyyy-MM-dd HH:mm:ss`, you
  create a simple table that has just one or two columns and test
  importing the format. This is a simple way to confirm that the
  imported data is what you expect.
* Detailed information about each of these data types is found in our SQL Reference Manual:
    * [Timestamp Data Type](#sqlref_datatypes_timestamp.html)
    * [Date Data Type](#sqlref_datatypes_date.html)
    * [Time Data Type](#sqlref_datatypes_time.html)

## Importing and Updating Records {#Updating}

This section describes certain aspects of how records are imported and updated when you import data into your database, including these subsections:

* [Inserting and Updating Column Values When Importing Data](#ImportColVals)
* [Inserting and Updated Generated or Default Values](#GeneratedUpdate)
* [Handling Missing Values](#MissingValues)

### Inserting and Updating Column Values When Importing Data   {#ImportColVals}

This section summarizes what happens when you are importing, upserting,
or merging records into a database table, based on:

* Whether you are importing a new record or updating an existing record.
* If the column is specified in your `insertColumnList` parameter.
* If the table column is a generated value or has a default value.

The important difference in actions taken when importing data occurs
when you are updating an existing record with the UPSERT or MERGE and
your column list does not contain the name of a table column:

* For newly inserted records, the default or auto-generated value is
  always inserted, as usual.
* If you are updating an existing record in the table with `UPSERT`, the
  default auto-generated value in that record is overwritten with a new
  value.
* If you are updating an existing record in the table with `MERGE`, the
  column value is not updated.

#### Importing a New Record Into a Database Table

The following table shows the actions taken when you are importing new
records into a table in your database. These actions are the same for
all three importation procedures (IMPORTing, UPSERTing, or MERGEing):

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <span class="CodeFont">importColumnList</span>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value inserted into table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Default value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Generated value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>NULL is inserted into table column.</td>
                </tr>
            </tbody>
        </table>

The table below shows what happens with default and generated column
values when adding new records to a table using one of our import
procedures; we use an example database table created with this
statement:

    CREATE TABLE myTable (
                    colA INT,
                    colB CHAR(12) DEFAULT 'myDefaultVal',
                    colC INT);
{: .Example}

<table summary="Detailed example of what gets imported for different input values in a new record">
            <col />
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th><span class="CodeBoldFont">insertColumnList</span>
                    </th>
                    <th>Values in import record</th>
                    <th>Values inserted into database</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,NULL,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,DEFAULT,2</code></td>
                    <td><code>[1,"DEFAULT",2]</code></td>
                    <td><code>DEFAULT</code> is imported as a literal value</td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>1,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>3,4</code></td>
                    <td><code>[3,myDefaultVal,4]</code></td>
                    <td> </td>
                </tr>
            </tbody>
        </table>

Note that the value \`DEFAULT\` in the imported file **is not
interpreted** to mean that the default value should be applied to that
column; instead:

* If the target column in your database has a string data type, such as
  `CHAR` or `VARCHAR`, the literal value `"DEFAULT"` is inserted into
  your database..
* If the target column is not a string data type, an error will occur.

### Importing Into a Table that Contains Generated or Default Values

When you export a table with generated columns to a file, the actual
column values are exported, so importing that same file into a different
database will accurately replicate the original table values.

If you are importing previously exported records into a table with a
generated column, and you want to import some records with actual values
and apply generated or default values to other records, you need to
split your import file into two files and import each:

* Import the file containing records with non-default values with the
  column name included in the `insertColumnList`.
* Import the file containing records with default values with the column
  name excluded from the `insertColumnList`.

#### Updating a Table Record with UPSERT

The following table shows the action taken when you are using the
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedure to update an existing
record in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Table column is overwritten with default value.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Table column is overwritten with newly generated value.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>Table column is overwritten with NULL value.</td>
                </tr>
            </tbody>
        </table>

#### Updating a Table Record with MERGE

The following table shows the action taken when you are using the
`SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure to update an existing record
in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>N/A</td>
                    <td>Table column is not updated.</td>
                </tr>
            </tbody>
        </table>

## Importing CLOBs and BLOBs {#LOBs}

If you are importing `CLOB`s, pay careful attention to tips [4](#Tip4)
and [7](#Tip7). Be sure to use special characters for both your column
and character delimiters. If your `CLOB` data can span multiple lines,
be sure to set the `oneLineRecords` parameter to `false`.

At this time, the Splice Machine import procedures do not import work
with columns of type `BLOB`. You can create a virtual table interface
(VTI) that reads the `BLOB`s and inserts them into your database.

## Scripting Your Imports   {#Scripting}

You can make import tasks much easier and convenient by creating *import
scripts*. An import script is simply a call to one of the import
procedures; once you've verified that it works, you can use and clone
the script and run unattended imports.

An import script is simply a file in which you store `splice>` commands
that you can execute with the `run` command. For example, here's an
example of a text file named `myimports.sql` that we can use to import
two csv files into our database:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable1',null,'/data/mytable1/data.csv',null,null,null,null,null,0,'/BAD/mytable1',null,null);call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable2',null,'/data/mytable2/data.csv',null,null,null,null,null,0,'/BAD/mytable2',null,null);
{: .Example}

</div>
To run an import script, use the `splice> run` command; for example:

<div class="preWrapper" markdown="1">
    splice> run 'myimports.sql';
{: .Example}

</div>
You can also start up the `splice>` command line interpreter with the
name of a file to run; for example:

<div class="preWrapper" markdown="1">
    sqlshell.sh -f myimports.sql
{: .Example}

</div>
In fact, you can script almost any sequence of Splice Machine commands
in a file and run that script within the command line interpreter or
when you start the interpreter.

## See Also

*  [Importing Data: Tutorial Overview](tutorials_ingest_importoverview.html)
*  [Importing Data: Input Parameters](tutorials_ingest_importparams.html)
*  [Importing Data: Error Handling](tutorials_ingest_importerrors.html)
*  [Importing Data: Usage Examples](tutorials_ingest_importexamples1.html)
*  [Importing Data: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html)
*  [Importing Data: Importing TPCH Data](tutorials_ingest_importexamplestpch.html)
*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)
