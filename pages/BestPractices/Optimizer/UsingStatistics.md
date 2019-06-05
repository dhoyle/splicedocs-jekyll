---
title: Using Statistics to Tune Queries
summary: Using Statistics to Tune Queries
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_statistics.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Statistics to Tune Queries

In addition to looking at the query execution plan, you can query two system views for key metrics about tables:

* The [Table Statistics View](#tableStats) contains statistical information for tables in your database.
* The [Column Statistics View](#columnStats) contains statistical information about each column in a table.

You can use the metrics in these tables to help you understand the characteristics of the tables in your queries, which can provide insights into how to optimize those queries.

### Table Statistics View  {tableStats}

The `SYS.SYSTABLESTATISTICS` table contains row count and total size information for each table:

  ```
  splice> SELECT total_row_count, total_size, stats_type, sample_fraction FROM SYS.SYSTABLESTATISTICS WHERE schemaname='TPCH100' AND tablename='LINEITEM';
  TOTAL_ROW_COUNT       |TOTAL_SIZE          |STATS_TYPE |SAMPLE_FRACTION
  -----------------------------------------------------------------------
  600037902             |52803335376         |2          |0.0

  1 row selected
  ```
  {: .Example}

### Column Statistics View  {columnStats}

The `SYS.SYSCOLUMNSTATISTICS` table contains statistical information about each column in each table:

  ```
  SELECT columnname, cardinality, null_count, min_value, max_value
  FROM SYS.SYSCOLUMNSTATISTICS
  WHERE schemaname='TPCH100' AND tablename='LINEITEM' AND columnname='L_SHIPDATE';
  ;
  COLUMNNAME     |CARDINALITY         |NULL_COUNT  |MIN_VALUE   |MAX_VALUE
  ---------------------------------------------------------------------------
  L_SHIPDATE     |2291                |0           |1992-01-02  |1998-12-01

  1 row selected

  ```
  {: .Example}



</div>
</section>
