---
title: How to Import Data into Your Splice Machine Database
summary: How to import data into your Splice Machine database.
keywords: import, load data, import data, importing from, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importing.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# How to Import Data Into Splice Machine

This tutorial describes how to import data into your Splice Machine
database, and includes a number of examples. It also contains specific
tips to help you with the details of getting your data correctly
imported. This tutorial contains these sections:

* [Import Procedures Syntax](#Syntax) summarizes the syntax for calling
  the available Splice Machine import procedures, along with brief
  descriptions of the parameters. This syntax applies to all three of
  our data import procedures.
* [Inserting and Updating Column Values When Importing
  Data](#ImportColVals) summarizes how table column values are updated
  when importing data into a table.
* [Import Examples](#Import) contains several examples of importing
  data.
* [Tips for Importing Data into Splice Machine](#Tips) provides specific
  tips to apply when specifying your import parameters.

The Splice Machine data import procedures allow you to perform bulk
imports that utilize the parallel processing power of Hadoop's scale-out
architecture while distributing the data evenly into different region
servers to prevent "hot spots." We utilize a custom-built, asynchronous
write pipeline, which is an extension to the native HBase pipeline, to
accomplish this effort.

If you're importing data from an S3 bucket on AWS, please review our
[Configuring an S3 Bucket for Splice Machine
Access](tutorials_ingest_configures3.html) tutorial before proceeding.

Our [Importing HFile Data tutorial](#) walks you through using our HFile
import procedure, which uses similar syntax and has improved
performance; however, the bulk HFile import requires extra work on your
part and lacks constraint checking.
{: .noteIcon}

## Three Different Procedures for Loading Data

Splice Machine provides three built-in system procedures that you can
use for loading data into a database table, each of which uses identical
syntax. You can specify which columns in the input data are to be
imported in the `insertColumnList` parameter; these procedures differ in
how they handle updating records when you specify an input column list
that isn't 1-to-1 with the columns in the table.

* The &nbsp;[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
  procedure imports data into your database, creating a new record in
  your table for each record in the imported data, and inserts the
  default value of each column that is not specified in the input.
* The
 &nbsp;[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
  procedure inserts new records and *updates existing records* in the
  table. It also inserts or updates the value in the table of each
  column that is not specified in the input; inserting the default value
  (or NULL if there is no default) for that column.
* The
 &nbsp;[`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
  procedure also updates existing records; however, it does not replace
  values in the table for unspecified columns when updating an existing
  record in the table.

[Example 2](#Example2) illustrates how the `UPSERT` and `MERGE`
procedures differ in their handling of record updates.

## Import Procedures Syntax   {#Syntax}

In this section, we'll go through the syntax used with our import
procedures, using the `SYSCS_UTIL.IMPORT_DATA` built-in system procedure
for examples.

You'll find complete descriptions of these parameters in the reference
pages for the
[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html),  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html),  and
[`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
procedures.
{: .noteIcon}

The syntax for calling these procedures includes a large number of
parameters:

<div class="fcnWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA (
    		schemaName,
    		tableName,
    		insertColumnList | null,
    		fileOrDirectoryName,
    		columnDelimiter | null,
    		characterDelimiter | null,
    		timestampFormat | null,
    		dateFormat | null,
    		timeFormat | null,
    		badRecordsAllowed,
    		badRecordDirectory | null,
    		oneLineRecords | null,
    		charset | null
    		);
{: .FcnSyntax xml:space="preserve"}

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
## Import Examples   {#Import}

This section provides several examples of importing data into Splice
Machine:

* [Example 1: Importing data into a table with fewer columns than in the
  file](#Example1)
* [Example 2: How Upsert and Merge handle missing columns
  differently](#Example2)
* [Example 3: Importing a subset of data from a file into a
  table](#Example3)
* [Example 4: Specifying a timestamp format for an entire
  table](#Example4)
* [Example 5: Importing strings with embedded special characters
  ](#Example5)
* [Example 6: Using single quotes to delimit strings](#Example6)

### Example 1: Importing data into a table with fewer columns than in the file   {#Example1}

If the table into which you're importing data has less columns than the
data file that you're importing, how the "extra" data columns in the
input data are handled depends on whether you specify an
`insertColumnList`:

* If you don't specify a specify an insertColumnList and your input file
  contains more columns than are in the table, then the the extra
  columns at the end of each line in the input file are ignored. For
  example, if your table contains columns (a, b, c) and your file
  contains columns (a, b, c, d, e), then the data in your file's d and e
  columns will be ignored.
* If you do specify an insertColumnList, and the number of columns
  doesn't match your table, then any other columns in your table will be
  replaced by the default value for the table column (or NULL if there
  is no default for the column). For example, if your table contains
  columns (a, b, c) and you only want to import columns (a, c), then the
  data in table's b column will be replaced with the default value for
  that column.

Here's an example that does not specify a column list. If you create a
table with this statement:

<div class="preWrapper" markdown="1">
    CREATE TABLE playerTeams(ID int primary key, Team VARCHAR(32));
{: .Example xml:space="preserve"}

</div>
And your data file looks like this:

<div class="preWrapper" markdown="1">
    1,Cards,Molina,Catcher2,Giants,Posey,Catcher3,Royals,Perez,Catcher
{: .Example xml:space="preserve"}

</div>
When you import the file into `playerTeams`, only the first two columns
are imported:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams',null, 'myData.csv',
       null, null, null, null, null, 0, 'importErrsDir', true, null);SELECT * FROM playerTeams ORDER by ID;ID   |TEAM
    --------------
    1    |Cards2    |Giants
    3    |Royals3 rows selected
{: .Example xml:space="preserve"}

</div>
### How Missing Columns are Handled With an Insert Column List   {#Example2}

{% include splice_snippets/importprocsexample.md %}

### Example 3: Importing a subset of data from a file into a table   {#Example3}

This example uses the same table and import file as does the previous
example, and it produces the same results, The difference between these
two examples is that this one explicitly imports only the first two
columns (which are named `ID` and `TEAM`) of the file:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams', 'ID, TEAM', 'myData.csv',
     null, null, null, null, null, 0, 'importErrsDir', true, null);SELECT * FROM playerTeams ORDER by ID;ID   |TEAM
    --------------
    1    |Cards2    |Giants
    3    |Royals3 rows selected
{: .Example xml:space="preserve"}

</div>
### Example 4: Specifying a timestamp format for an entire table   {#Example4}

Use a single timestamp format for the entire table by explicitly
specifying a single `timeStampFormat`.

<div class="preWrapper" markdown="1">
    Mike,2013-04-21 09:21:24.98-05
    Mike,2013-04-21 09:15:32.78-04
    Mike,2013-03-23 09:45:00.68-05
{: .Example xml:space="preserve"}

</div>
You can then import the data with the following call:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('app','tabx','c1,c2',
    	'/path/to/ts3.csv',
    	',', '''',
    	'yyyy-MM-dd HH:mm:ss.SSZ',
    	null, null, 0, null, true, null);
{: .Example xml:space="preserve"}

</div>
Note that for any import use case shown above, the time shown in the
imported table depends on the timezone setting in the server timestamp.
In other words, given the same csv file, if imported on different
servers with timestamps set to different time zones, the value in the
table shown will be different. Additionally, daylight savings time may
account for a 1-hour difference if timezone is specified.

### Example 5: Importing strings with embedded special characters    {#Example5}

This example imports a csv file that includes newline (`Ctrl-M`)
characters in some of the input strings. We use the default double-quote
as our character delimiter to import data such as the following:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,"This field has two lines
    This is the second line of the field",Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
We then use the following call to import the data:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv' , '\t', null, null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
We can also explicitly specify double quotes (or any other character) as
our delimiter character for strings:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '"', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
### Example 6: Using single quotes to delimit strings   {#Example6}

This example performs the same import as the previous example, simply
substituting single quotes for double quotes as the character delimiter
in the input:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,'This field has two lines
    This is the second line of the field',Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
Note that you must escape single quotes in SQL, which means that you
actually define the character delimiter parameter with four single
quotes, as follow

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '''', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
## Tips for Importing Data into Splice Machine   {#Tips}

This tutorial contains a number of tips that our users have found very
useful in determining the parameter settings to use when running an
import:

1.  [[Tip #1: Specifying the File Location ](#Tip)](#Tip)
2.  [[Tip #2: Import Large Datasets in Groups of Files](#Tip2)](#Tip2)
3.  [[Tip #3: Don't Compress Your Files With GZIP](#Tip3)](#Tip3)
4.  [[Tip #4: Use Special Characters for Delimiters](#Tip4)](#Tip4)
5.  [[Tip #5: Avoid Problems With Date, Time, and Timestamp
    Formats](#Tip5)](#Tip5)
6.  [[Tip #6: Change the Bad Directory for Each Table /
    Group](#Tip6)](#Tip6)
7.  [[Tip #7: Importing Multi-line Records](#Tip7)](#Tip7)
8.  [[Tip #8: Importing CLOBs and BLOBs](#Tip8)](#Tip8)
9.  [[Tip #9: Scripting Your Imports](#Tip9)](#Tip9)

### Tip #1: Specifying the File Location    {#Tip}

Some customers get confused by the the `fileOrDirectoryName` parameter.
How you use this depends on whether you are importing a single file or a
directory of files. It also depends on which version of Splice Machine
you are running: the cloud-managed Splice Machine Database-as-Service,
on a managed cluster, or a standalone version.

If you are running a stand alone environment, the name or path will be
to a file or directory on the file system. For example:

<div class="preWrapperWide" markdown="1">
    /users/myname/mydata/mytable.csv/users/myname/mydatadir
{: .Example}

</div>
However, if you are running this on a cluster, the path is to a file on
HDFS (or the MapR File system). For example:

<div class="preWrapperWide" markdown="1">
    /data/mydata/mytable.csv/data/myname/mydatadir
{: .Example}

</div>
#### Specifying an AWS S3 File Location

Finally, if you're importing data from an S3 bucket, you need to supply
your AWS access and secret key codes, and you need to specify an s3a
URL. Similarly for logging bad record information to an S3 bucket
directory, as will be the case when using our Database-as-Service
product. You can include the access keys inline; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, -1, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/importLog', true, null);
{: .Example}

</div>
Alternatively, you can define the keys once in the `core-site.xml` file
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
### Tip #2: Import Large Datasets in Groups of Files   {#Tip2}

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

### Tip #3: Don't Compress Your Files With GZIP   {#Tip3}

We recommend importing files that are either uncompressed, or have been
compressed with <span class="CodeBoldFont">bz2</span> or <span
class="CodeBoldFont">lz4</span> compression.

If you import files compressed with `gzip`, Splice Machine cannot
distribute the contents of your file across your cluster nodes to take
advantage of parallel processing, which means that import performance
will suffer significantly with `gzip` files.

### Tip #4: Use Special Characters for Delimiters   {#Tip4}

One common gotcha we see with customer imports is when the data you're
importing includes a special character that you've designated as a
column or character delimiter. You'll end up with records in your bad
record directory and can spend hours trying to determine the issue, only
to discover that it's because the data includes a delimiter character.
This can happen with columns that contain data such as product
descriptions.

#### Column Delimiters

The standard column delimiter is a comma (`,`); however, we've all
worked with string data that contains commas, and have figured out to
use a different column delimiter. Some customers use the pipe (`|`)
character, but frequently discover that it is also used in some
descriptive data in the table they're importing.

We recommend using a control character like `CTRL-A` for your column
delimiter. This is known as the SOH character, and is represented by
0x01 in hexadecimal. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to create a script file (see [Tip
#9](#Tip9)) and type the control character using a text editor like *vi*
or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-A` for the value of the column delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^A` when you type it in vi or vim.

#### Character Delimiters

By default, the character delimiter is a double quote. This can produce
the same kind of problems that we see with using a comma for the column
delimiter: columns values that include embedded quotes or use the double
quote as the symbol for inches. You can use escape characters to include
the embedded quotes, but it's easier to use a special character for your
delimiter.

We recommend using `CTRL-G`, which you can add to a script file (see
[Tip #9](#Tip9)), again using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-G` for the value of the character delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^G` when you type it in vi or vim.

### Tip #5: Avoid Problems With Date, Time, and Timestamp Formats   {#Tip5}

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

### Tip #6: Change the Bad Directory for Each Table / Group   {#Tip6}

If you are importing a large amount of data and have divided the files
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

### Tip #7: Importing Multi-line Records   {#Tip7}

If your data contains line feed characters like `CTRL-M`, you need to
set the `oneLineRecords` parameter to `false`. Splice Machine will
accommodate to the line feeds; however, the import will take longer
because Splice Machine will not be able to break the file up and
distribute it across the cluster.

To improve import performance, avoid including line feed characters in
your data and set the `oneLineRecords` parameter to `true`.
{: .notePlain}

### Tip #8: Importing CLOBs and BLOBs   {#Tip8}

If you are importing `CLOB`s, pay careful attention to tips [4](#Tip4)
and [7](#Tip7). Be sure to use special characters for both your column
and character delimiters. If your `CLOB` data can span multiple lines,
be sure to set the `oneLineRecords` parameter to `false`.

At this time, the Splice Machine import procedures do not import work
with columns of type `BLOB`. You can create a virtual table interface
(VTI) that reads the `BLOB`s and inserts them into your database.

### Tip #9: Scripting Your Imports   {#Tip9}

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

* [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
* [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
* [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)

</div>
</section>



[1]: https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html
