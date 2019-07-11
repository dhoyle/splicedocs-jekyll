---
title: Getting Started with Loading Data and Running Queries
summary: Loading Data and Running Queries
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: gettingstarted_loadandrun.html
folder: GettingStarted
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Getting Started with Loading Data and Running Queries

This topic helps you to get started with importing data into your Splice Machine database and then querying that data, in these sections:

* [1. Create and populate an example table](#loaddata)
* [2. Run database queries from the command line](#runqueries)
* [3. Import data with custom formatting](#customimport)
* [4. Exploring query execution plans](#exploreplans)

Once you've gotten started with importing data here, we strongly suggest visiting these other sections in our documentation:

* The [Best Practices - Data Ingestion](bestpractices_ingest_overview.html) chapter describes and compares the different methods available for importing data in Splice Machine, including highly performant methods for ingesting extremely large datasets.
* The [Best Practices - Splice Machine Optimizer](bestpractices_ingest_optimizer.html) chapter provides detailed instructions about using query execution plans, statistics, hints, and other techniques to boost performance of your queries.
* Our [Developer's Guide](developers_intro.html) contains a number of topics to help you take advantage of available features.

## 1. Create and Populate an Example Table  {#loaddata}

Our first step is to create a table that we can import data into and then query that data. Follow these steps:

<div class="opsStepsList" markdown="1">

1.  Create an example table named `import_example`:

    ```
    CREATE TABLE import_example (i int, v varchar(20), t timestamp);
    ```
    {: .Example}

2.  Import data into the new table:

    We suggest starting with some very simple data, so you can used to the process. For expediency, we provide public access to a CSV file in a public bucket that you can load into the table:

    ```
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','import_example',null,'s3a://splice-examples/import/example1.csv',null,null,null,null,null,0,null,null,null);
    ```
    {: .Example}

    Of course, you can create a table with whatever fields you choose and load data into that; just make sure you update the parameters in the [`IMPORT_DATA`](sqlref_sysprocs_importdata.html) to align with how your source file is formatted.

    Note that we specified `SPLICE` as the schema name for our new table. `SPLICE` is the default schema when you start up.
</div>

## 2. Run Database Queries from the Command Line  {#runqueries}

Splice Machine supports ANSI SQL. Our first example query uses an SQL `SELECT` statement to select all records in the `import_example` table that have `100` as the value of column `i`.

Now use the <span class="AppCommand">splice&gt;</span> command line interperter to run the query:

```
splice> select * from import_example
> where i = 100;
```
{: .Example}

Note that you can modify the capitalization of terms as you like; the following query is exactly equivalent to the above `select` statement:
```
splice> SELECT * FROM IMPORT_EXAMPLE
> WHERE i = 100;
```
{: .Example}


## Import Data with Custom Formatting  {#customimport}

Splice Machine offers a number of highly performant methods for importing data into your database; these are described, along with examples, in our [Best Practices - Ingesting Data](bestpractices_ingesting_intro.html).

In this topic, we're using the standard `IMPORT_DATA` method with CSV files. When you import data from flat files into your database, you need to specify a number of details about your data files to get them correctly imported. Syntax for the `IMPORT_DATA` command looks like this:

```
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
```
{: .Example}

You have probably also noticed that we used default values by specifying `null` for all of the parameters that have defaults; here's what those defaults mean:

<table>
    <col />
    <col />
    <caption class="tblCaption">Import Data Parameter Default Values</caption>
    <thead>
        <tr>
            <th>Parameter</th>
            <th>NULL Value Details</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>insertColumnList</code></td>
            <td>Our column list exactly matches the columns and ordering of columns in the table, so there's not need to specify a list.</td>
        </tr>
        <tr>
            <td><code>columnDelimiter</code></td>
            <td>Our data uses the default comma character (<code>,</code>) to delimit columns.</td>
        </tr>
        <tr>
            <td><code>stringDelimiter</code></td>
            <td>None of our data fields contain the comma character, so we don't need a string delimiter character.</td>
        </tr>
        <tr>
            <td><code>timestampFormat</code></td>
            <td>Our data matches the default timestamp format, which is <code>yyyy-MM-dd HH:mm:ss</code></td>
        </tr>
        <tr>
            <td><code>dateFormat</code></td>
            <td>Our data doesn't contain any date columns, so there's no need to specify a format.</td>
        </tr>
        <tr>
            <td><code>timeFormat</code></td>
            <td>Our data doesn't contain any time columns, so there's no need to specify a format.</td>
        </tr>
        <tr>
            <td><code>badRecordDirectory</code></td>
            <td>We left this <code>null</code>, which is allowable, but not considered a good practice. Splice Machine advises specifying a bad record directory so that you can diagnose any record import problems.</td>
        </tr>
        <tr>
            <td><code>oneLineRecords</code></td>
            <td>We were able to leave this as <code>null</code> because our records each fit on one line. If your data contains any newline characters, you must specify <code>false</code> for this parameter, and you must include delimiters around the data.</td>
        </tr>
        <tr>
            <td><code>charset</code></td>
            <td>This parameter is currently ignored; Splice Machine assumes that your data uses utf-8 encoding.</td>
        </tr>
    </tbody>
</table>


<p class="noteNote">You can find full details about these parameters, including the default value for each, in the &nbsp; <a href="sqlref_sysprocs_importdata.html"><code>SYSCS_UTIL.IMPORT_DATA</code></a> reference page.</p>

Here's a brief checklist to help you prepare your data files for trouble-free ingestion with `IMPORT_DATA`:

<table>
    <col />
    <col />
    <caption class="tblCaption">Import Data Checklist</caption>
    <thead>
        <tr>
            <th>Data File Detail</th>
            <th>Specific Requirements</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Field delimited?</td>
            <td>The fields in each row <strong>must</strong> have delimiters between them</td>
        </tr>
        <tr>
            <td>Rows terminated?</td>
            <td>Each row <strong>must</strong> be terminated with a newline character</td>
        </tr>
        <tr>
            <td>Header row included?</td>
            <td>Header rows are not allowed; if your data contains one, you <strong>must</strong> remove it.</td>
        </tr>
        <tr>
            <td><code>Date</code>, <code>time</code>, <code>timestamp</code> data types</td>
            <td> If you are using <code>date</code>, <code>time</code>, and/or <code>timestamp</code> data types in the target table, you need to know how that data is represented in the flat file; your file <strong>must</strong> use a consistent representation, and you must specify that format when using the import command.</td>
        </tr>
        <tr>
            <td><code>Char</code> and <code>Varchar</code> data</td>
            <td><p>If any of your <code>char</code> or <code>varchar</code> data contains your delimiter character, you <strong>need to use</strong> a special character delimiter.</p>
                <p>If any of your <code>char</code> or <code>varchar</code> data contains newline characters, you <strong>need to use</strong> the <code>oneLineRecords</code> parameter.</p>
            </td>
        </tr>
    </tbody>
</table>


<p class="noteIcon">Importing a large file can take a few minutes, so it's a good idea to test your import, delimiting, date formatting, etc., on a small amount of data first before loading all of your data.</p>


### Custom Input Data Formats Example

Now let's create a second table, again loading data into it from a example CSV file that Splice Machine has made publicly accessible. This file requires a few non-default parameter values:

* We specify that we only want to load two columns: `v,t`.
* This file uses the `|` character as a column delimiter because some of its values include the default (`,`) delimiter.
* This file includes commas and newlines in some input strings, so we need to enclose string data in single quotes; this is specified as `''''` in the parameter values.
* Timestamps in this file include microseconds, so we specify the `yyyy-MM-dd HH:mm:ss.SSSSSS` format.
* Some input records include newlines, so we specify that `oneLineRecords=false`.

Here's the call:

```
call SYSCS_UTIL.IMPORT_DATA('DEV1','import_example2','v,t','s3a://splice-examples/import/example2.csv','|','''','yyyy-MM-dd HH:mm:ss.SSSSSS',null,null,0,null,false,null)
```
{: .Example}


## Exploring Query Execution Plans  {#exploreplans}

If you have a query that is not performing as expected, you can run the `explain` command to display the execution plan for the query.

All you need to do is put `EXPLAIN` in front of the query and run that. This generates the plan, but does not actually run the query. For example:

```
explain select * from import_example a, import_example b
where a.i = 100;

Plan
--------------------------------------------------------------------------------------------------------------------------------------
Cursor(n=5,rows=360,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=4,totalCost=1744.96,outputRows=360,outputHeapSize=2.109 KB,partitions=1)
    ->  NestedLoopJoin(n=3,totalCost=1657.16,outputRows=360,outputHeapSize=2.109 KB,partitions=1)
      ->  TableScan[IMPORT_EXAMPLE(1584)](n=2,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=2.109 KB,partitions=1)
      ->  TableScan[IMPORT_EXAMPLE(1584)](n=1,totalCost=4.04,scannedRows=20,outputRows=18,outputHeapSize=54 B,partitions=1,preds=[(A.I[0:1] = 100)])

5 rows selected
```

Query execution plans are one tool that Splice Machine offers to help you boost performance; for additional information about interpreting plans and other optimization techniques, see [Best Practices - Splice Machine Optimizer](bestpractices_optimizer_intro.html) topic.

### Some Explain Plan Details

To see the execution flow of a query, look at the generated plan from the *bottom up.*  The very first steps of the query are at the bottom, then each step follows above.

Each row includes the action being performed (a Scan, Join, grouping, etc.) followed by:

<table class="noBorder">
    <col />
    <col />
    <tbody>
        <tr>
            <td><em>n count</em></td>
            <td>The step of the plan; not that the count (step 1) starts at the bottom and goes up from there)</td>
        </tr>
        <tr>
            <td><em>totalCost</em></td>
            <td>The estimated cost for this step (and any substeps below it)</td>
        </tr>
        <tr>
            <td><em>scannedRows (for Table or Index Scan steps)</em></td>
            <td>The estimated count of how many rows need to be scanned in this step</td>
        </tr>
        <tr>
            <td><em>outputRows</em></td>
            <td>The estimated count of how many rows are passed to the next step in the plan</td>
        </tr>
        <tr>
            <td><em>outputHeapSize</em></td>
            <td>The estimated count of how much data is passed to the next step in the plan</td>
        </tr>
        <tr>
            <td><em>partitions</em></td>
            <td>The estimated number of (HBase) regions that are involved in that step of the plan</td>
        </tr>
        <tr>
            <td><em>preds</em></td>
            <td>Which filtering predicates are applied in that step of the plan</td>
        </tr>
    </tbody>
</table>

We will see that the *scannedRows* and *outputRows* are key numbers to monitor as we tune query performance.

In the *explain* example that we just ran, we can see we are scanning table `import_example` twice, then joining them with a particular strategy; in this case, the strategy is a nested-loop join.

### Which Engine?
The final steps, `Scroll Insensitive` and `Cursor` are typical end steps to the query execution.  There is one __very important__ piece of information shown on the `Cursor` line at the end:

    Cursor(n=5,rows=360,updateMode=, engine=control)

This line shows you which *engine* is used for the query. The engine parameter indicates which engine Splice Machine plans to use.

<div class="noteIcon">
<p>As you may know, Splice Machine is a dual-engine database:</p>
<ul style="margin-bottom:0; padding-bottom:0">
<li>Fast-running queries (e.g. those only processing a few rows) typically get executed on the <code>control</code> side, directly in HBase.</li>
<li>Longer-running queries or queries that process a lot of data go through <code>Spark</code>.</li>
</ul>
</div>

For more information about using query execution plans to optimize your queries, see our [Best Practices - Using Explain Plan to Tune Queries](bestpractices_optimizer_explain.html) topic.

</div>
</section>
