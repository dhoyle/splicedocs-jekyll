---
title: Ingesting Data and Running Queries
summary: Ingesting Data and Running Queries
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: gettingstarted_ingesting.html
folder: GettingStarted
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Ingesting Data and Running Queries

This topic helps you to get started with importing data into your Splice Machine database and then querying that data, in these sections:

* Creating and Populating an Example Table
* Running database queries from a Zeppelin notebook*
* Using `Explain Plan` to explore the execution plan for a query

Once you've learned about importing, we strongly suggest visiting these *Best Practices* chapters, which  XXXX

* [Best Practices - Data Ingestion](bestpractices_ingest_overview.html) chapter, which describes and compares the different methods available for importing data in Splice Machine, including highly performant methods for ingesting extremely large datasets.
* [Best Practices - XXXXXXXXXXXXXXXXXXx]

## 1. Create and Populate our Example Table
First we'll create a table named `import_example` in a new schema named `ADMIN`, then we'll populate the `import_example` table with some simple data. For additional information about importing this data, see the [*Importing Data*](/#/notebook/2DVR1D5BP) notebook in our *Beginning Developers* course.

Click the  <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> *Run* button in the  the next paragraph to create and populate the table:


%splicemachine

CREATE TABLE admin.import_example (i int, v varchar(20), t timestamp);

call SYSCS_UTIL.IMPORT_DATA('ADMIN','import_example',null,'s3a://splice-examples/import/example1.csv',null,null,null,null,null,0,null,null,null);

## Running a Simple SQL Statement

Splice Machine supports ANSI SQL. Our example query uses an SQL `SELECT` statement to select records from the table we created in the previous paragraph.

This query selects all records in the `import_example` table that have `100` as the value of column `i`; try it by clicking the  <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> *Run* button in the  the next paragraph.


%splicemachine

select * from admin.import_example
where i = 100

## Exploring Query Execution Plans

If you have a query that is not performing as expected, you can run the `explain` command to display the execution plan for the query.

All you need to do is put `EXPLAIN` in front of the query and run that. This generates the plan, but does not actually run the query. Try it by clicking the  <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> *Run* button in the next paragraph.

%splicemachine

explain select * from admin.import_example a, admin.import_example b
where a.i = 100

### Some Explain Plan Details

To see the execution flow of a query, look at the generated plan from the *bottom up.*  The very first steps of the query are at the bottom, then each step follows above.

Each row includes the action being performed (a Scan, Join, grouping, etc.) followed by:

<table class="splicezepNoBorder">
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

We'll cover more about the engines, and the Spark engine in particular, later in this class.
</div>
</section>
