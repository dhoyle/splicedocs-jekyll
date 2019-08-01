---
title: Using Explain Plan to Tune Queries
summary: Using Explain Plan to Tune Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_usingexplain.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Explain Plan to Tune Queries

This topic takes you through the following sequence of questions that will help you understand how to use `EXPLAIN` plans to improve the performance of your Splice machine queries:


1. Did your query run in Control (HBase) or Spark?

   Explain this and then tell them how to find out.



* How


## Question:  How do I know if my query went to Control (HBase) vs Spark?

There are several answers:

* If you want to know if your query _will_ go to Control vs Spark, just run an `EXPLAIN` on it first, and look at the top line of the `EXPLAIN` plan.
* If you want to know if your query _did_ go to Control or Spark, you can still run an `EXPLAIN` to see how it was executed; alternatively, if you ran it very recently, you can examine the Spark Job history in the Spark UI; it will appear in the history if it ran on Spark.


## Question:  I submitted a query and it went to control (HBase), but it seems to be taking forever.  What happened?

Queries that run on the HBase or Control side are supposed to run about 100 milliseconds or less (very rarely a little longer). If a query is mistakenly routed to the wrong engine, it can get stuck on the HBase side. Here's what to look out for:

* As always, make sure that your statistics are up to date; if you've added or updated a table recently, it's possible that those statistics have not yet been updated. See the [*Using Statistics to Tune Queries*](bestpractices_optimizer_statistics.html) topic for more information.

* Run an `EXPLAIN` on that query, and confirm that it is going to control.  If the query is (correctly) running on Spark, check its progress in the Spark UI.

* If your query _is_ running on control, the `EXPLAIN` might provide additional information regarding how long you can expect it to take. Note that queries with many scanned rows, joins between tables with many rows in the joins, and many aggregation functions can require additional compute time.

  Remember that you can add a [_hint_](bestpractices_optimizer_hints.html) to specify that you want a query to use the control engine.
  {: .noteIcon}

* If you realize you don't want to wait for that query to run on the control side, you can easily kill it.  Look for the instructions in <ref>

## Question:  How do I know which table is read first in a query?

That's the very bottom table in the `EXPLAIN` plan. Read the plan up from there (bottom-up).

## Question:  How do I know if an index is selected versus a main table?

The step of the plan will be `IndexScan` vs `TableScan` in the `Explain` plan.

## Question:  How do I know what the base table was for that index?

Look for the `baseTable=<tablename>` to the right of the `IndexScan` message in the `Explain` plan.

## Question:  What does IndexLookup mean?

This is an extra step required after an `IndexScan` to get additional columns of data not stored in the selected index used by the IndexScan, but needed in the chosen Plan.  Remember that you can use compound indexes with multiple columns.

## Question:  How do I get rid of IndexLookup steps in my plans?

You'll need what are called _covering indexes_; a covering index includes all columns referenced in the query, where the useful filtering columns are at the front. Otherwise, the Optimizer will use the Base table instead to avoid an `IndexLookup`.  In all cases, the Optimizer is making a cost estimation for which approach is the fastest (i.e. lowest cost).

## Question:  How do I know what indexes are on a table?

Use the `show indexes` command to see this information in tabular format. Here's an example

```
splice> show indexes from my_table;
TABLE_NAME    |INDEX_NAME       |COLUMN_NAME   |ORDINAL&|NON_UNIQUE|TYPE |ASC&|CONGLOM_NO
-----------------------------------------------------------------------------------------
MY_TABLE      |I1               |ID            |1       |true      |BTREE|A   |1937
MY_TABLE      |I1               |STATE_CD      |2       |true      |BTREE|A   |1937
MY_TABLE      |I1               |CITY          |3       |true      |BTREE|A   |1937

3 rows selected
```
{: .Example}

The key information is the `INDEX_NAME`, `COLUMN_NAME`, and `ORDINAL` column. The `INDEX_NAME` uniquely identifies those columns in the index (by `COLUMN_NAME`), and shows them in `ORDINAL` order.

## Question: I expected an index to be selected by the optimizer, but it did not.  Why not?

Splice Machine uses a cost-based optimizer, which means that its ultimate selection was a cost-based one, and that it found a choice that it deemed was a lower cost. The best way to dig into this is use hints, as follows:

1. Run an `EXPLAIN` plan, hinting your plan with your preferred index; note the final cost at the top of the `EXPLAIN` plan
2. Run an `EXPLAIN` plan without the hint, again noting the final cost at the top of the EXPLAIN plan; since your plan was not selected, this should be different.
3. Execute both SQL statements. Did the lower (best) cost run faster?  If not, let us know!

## Question: How do I know which join Strategy is best for my query?

It depends!  For example:
* For very small lookups with few, keyed rows, `NestedLoop` joins tend to do best.
* When many rows are involved on one side, but few rows on the other, a `BroadcastJoin` might be the best choice.
* `MergeJoins` work well when there are many rows on both sides but both tables are sorted by the join key.
* `SortMergeJoin` is an excellent workhorse when you have many rows on both sides but don't have any sorting to help you on both sides.
* Finally, you are back to `NestedLoop` sometimes again when the comparison operator on the join key is an inequality.

</div>
</section>
