---
title: Importing Data into Your Splice Machine Database
summary: How to use our Bulk HFile import feature to rapidly import large datasets into your Splice Machine database.
keywords: bulk import, bulk load, bulk data load, hfile import, hfile load, s3, aws, importing from
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_hfiles.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data in HFile Format Into Splice Machine

This tutorial describes how to import data using HFiles into your Splice
Machine database, and includes a number of examples. It also contains
specific tips to help you with the details of getting your data
correctly imported. This tutorial contains these sections:

* *How Importing Your Data as HFiles Works* presents an overview of
  using the HFile import functions.
* *Usage Notes* provides an overview of the steps you use to import your
  data as HFiles.
* *Examples* contains two example of importing data in HFile format.
* [Tips for Importing Data into Splice Machine](#Tips) provides specific
  tips for specifying your import parameters.

If you're importing data from an S3 bucket on AWS, please review our
[Configuring an S3 Bucket for Splice Machine
Access](tutorials_ingest_configures3.html) tutorial before proceeding.

Our [Importing Your Data tutorial](tutorials_ingest_importing.html)
walks you through using our standard import procedure, which is easier
to use, though slightly slower than importing HFiles.
{: .noteIcon}

## How Importing Your Data as HFiles Works   {#How}

Our HFile data import procedure leverages HBase bulk loading, which
allows it to import your data at a faster rate; however, using this
procedure instead of our standard
[`SYSCS_UTIL.IMPORT_DATA`](tutorials_ingest_importing.html) procedure
means that *constraint checks are not performing during data
importation*.

You import a table as HFiles using our `SYSCS_UTIL.BULK_IMPORT_HFILES`
procedure, which temporarily converts the table file that you're
importing into HFiles, imports those directly into your database, and
then removes the temporary HFiles. Before it generate HFiles,
`SYSCS_UTIL.BULK_IMPORT_HFILES` must determine how to split the data
into multiple regions by looking at the primary keys and figuring out
which values will yield relatively evenly-sized splits; the objective is
to compute splits such that roughly the same number of table rows will
end up in each split.

`SYSCS_UTIL.BULK_IMPORT_HFILES` can scan and analyze your table to
determine the best splits; or you can exercise control over those
splits.

To have `SYSCS_UTIL.BULK_IMPORT_HFILES` calculate the splits
automatically, simply call this procedure with the `skipSampling`
parameter set to `true`.

If you want to control the splits yourself, use these steps, which are
detailed in the *Examples* section below:

* You must determine which values make sense for splitting your data
  into multiple regions. This means looking at the primary keys for the
  table and figuring out which values will yield relatively evenly-sized
  splits, which means that roughly the same number of table rows will
  end up in each split.
* Calling one of our system procedures to compute the HBase-encoded keys
  to create those splits.
* Calling one of our system procedures to set up the splits inside
  your Splice Machine database.
* Call our `SYSCS_UTIL.BULK_IMPORT_HFILES` procedure, which temporarily
  converts the table file that you're importing into HFiles, imports
  those directly into your database, and then removes the temporary
  HFiles.

{% include splice_snippets/hfileimport_example.html %}
## Tips for Importing Data into Splice Machine   {#Tips}

This tutorial contains a number of tips that our users have found very
useful in determining the parameter settings to use when running an
import:

1.  [[Tip #1:  Use Special Characters for Delimiters](#Tip4)](#Tip4)
2.  [[Tip #2:  Avoid Problems With Date, Time, and Timestamp
    Formats](#Tip5)](#Tip5)
3.  [[Tip #3:  Change the Bad Directory for Each Table /
    Group](#Tip6)](#Tip6)
4.  [[Tip #4:  Importing Multi-line Records](#Tip7)](#Tip7)
5.  [[Tip #5:  Importing CLOBs and BLOBs](#Tip8)](#Tip8)
6.  [Tip #6:  Scripting Your Imports](#Tip9)

### Tip #1:  Use Special Characters for Delimiters   {#Tip4}

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
use a different column delimiter. Some customers use the pipe
(`|`) character, but frequently discover that it is also used in some
descriptive data in the table they're importing.

We recommend using a control character like `CTRL-A` for your column
delimiter. This is known as the SOH character, and is represented by
0x01 in hexadecimal. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to create a script file (see [Tip
#9](#Tip9)) and type the control character using a text editor like *vi*
or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-A` for the value of the column delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^A` when you type it in vi or vim.

#### Character Delimiters

By default, the character delimiter is a double quote. This can produce
the same kind of problems that we see with using a comma for the column
delimiter: columns values that include embedded quotes or use the double
quote as the symbol for inches. You can use escape characters to include
the embedded quotes, but it's easier to use a special character for your
delimiter.

We recommend using `CTRL-G`, which you can add to a script file (see
[Tip #9](#Tip9)), again using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-G` for the value of the character delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^G` when you type it in vi or vim.

### Tip #2:  Avoid Problems With Date, Time, and Timestamp Formats   {#Tip5}

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

### Tip #3:  Change the Bad Directory for Each Table / Group   {#Tip6}

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

### Tip #4:  Importing Multi-line Records   {#Tip7}

If your data contains line feed characters like `CTRL-M`, you need to
set the `oneLineRecords` parameter to `false`. Splice Machine will
accommodate to the line feeds; however, the import will take longer
because Splice Machine will not be able to break the file up and
distribute it across the cluster.

To improve import performance, avoid including line feed characters in
your data and set the `oneLineRecords` parameter to `true`.
{: .notePlain}

### Tip #5:  Importing CLOBs and BLOBs   {#Tip8}

If you are importing `CLOB`s, pay careful attention to tips [4](#Tip4)
and [7](#Tip7). Be sure to use special characters for both your column
and character delimiters. If your `CLOB` data can span multiple lines,
be sure to set the `oneLineRecords` parameter to `false`.

At this time, the Splice Machine import procedures do not import work
with columns of type `BLOB`. You can create a virtual table interface
(VTI) that reads the `BLOB`s and inserts them into your database.

### Tip #6:  Scripting Your Imports   {#Tip9}

You can make import tasks much easier and convenient by creating *import
scripts*. An import script is simply a call to one of the import
procedures; once you've verified that it works, you can use and clone
the script and run unattended imports.

An import script is simply a file in which you store `splice>` commands
that you can execute with the `run` command. For example, here's an
example of a text file named `myimports.sql` that we can use to import
two csv files into our database:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable1',null,'/data/mytable1/data.csv',null,null,null,null,null,0,'/BAD/mytable1',null,null);call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable2',null,'/data/mytable2/data.csv',null,null,null,null,null,0,'/BAD/mytable2',null,null
{: .Example}

</div>
To run an import script, use the `splice> run` command; for example:

<div class="preWrapper" markdown="1">
    splice> run 'myimports.sql';
{: .Example}

</div>
You can also start up the `splice>` command line interpreter with the
name of a file to run; for example:

<div class="preWrapper" markdown="1">
    sqlshell.sh -f myimports.sql
{: .Example}

</div>
In fact, you can script almost any sequence of Splice Machine commands
in a file and run that script within the command line interpreter or
when you start the interpreter.

</div>
</section>



[1]: https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html
