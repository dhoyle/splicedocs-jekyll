---
title: Using Explain Plan to Tune Queries
summary: Using Explain Plan to Tune Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_explain.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Explain Plan to Tune Queries

If you have a query that is not performing as expected, you can run the `explain` command to display the execution plan for the query. You can then examine the plan to determine where it looks like too much time is being spent in the query's execution flow

To generate an explain plan, simply put `explain` in front of a query. For example:

When you use `explain` in front of a query, the query itself does not run.
{: .noteIcon}


```
EXPLAIN
SELECT COUNT(*) FROM tpch100.lineitem
WHERE l_shipdate <= DATE({fn TIMESTAMPADD(SQL_TSI_DAY, -90, CAST('1998-12-01 00:00:00' as TIMESTAMP))});

Plan
----
Cursor(n=6,rows=1,updateMode=,engine=Spark)
  ->  ScrollInsensitive(n=5,totalCost=2010896.134,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  ProjectRestrict(n=4,totalCost=20131.62,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  GroupBy(n=3,totalCost=20131.62,outputRows=1,outputHeapSize=0 B,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=241579.259,outputRows=198012508,outputHeapSize=1.014 GB,partitions=12)
          ->  IndexScan[L_SHIPDATE_IDX(21345)](n=1,totalCost=241579.259,scannedRows=198012508,outputRows=198012508,outputHeapSize=1.014 GB,partitions=12,baseTable=LINEITEM(21184),preds=[(L_SHIPDATE[0:1] <= date(TIMESTAMPADD(1998-12-01 00:00:00.0, 4, -90) ))])

6 rows selected
```
{: .Example}


## Examining an Explain Plan

To see the execution flow of a query, look at the generated plan from the *bottom up.*  The very first steps of the query are at the bottom, then each step follows above.

Each row includes the action being performed (a Scan, Join, grouping, etc.) followed by:

<table class="noBorder">
    <col />
    <col />
    <tbody>
        <tr>
            <td><em>n count</em></td>
            <td>The step of the plan (and again you can see as we go from the bottom up the count starts from 1 and goes up from there)</td>
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
            <td>The estimated number of (HBase) regions are involved in that step of the plan</td>
        </tr>
        <tr>
            <td><em>preds</em></td>
            <td>Which filtering predicates are applied in that step of the plan</td>
        </tr>
    </tbody>
</table>

We will see that the `scannedRows` and `outputRows` are key numbers to monitor as we tune query performance.

In the *explain* example that we just ran, we can see we are scanning table `import_example` twice, then joining them with a particular strategy; in this case, the strategy is a nested-loop join.

### Joins

Here are a few key notes about reviewing joins in a plan:

<table class="noBorder">
    <col />
    <col />
    <tbody>
        <tr>
            <td>Nested loop join</td>
            <td>This is the most general join strategy, but may only be efficient for a special scenario.</td>
        </tr>
        <tr>
            <td>Broadcast join</td>
            <td>Is the right table small enough to fit in memory?</td>
        </tr>
        <tr>
            <td>Sortmerge join</td>
            <td>Is there any skewness on the join columns?</td>
        </tr>
    </tbody>
</table>


### Which Execution Path (Which Engine)?
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
================================================================================



</div>
</section>
