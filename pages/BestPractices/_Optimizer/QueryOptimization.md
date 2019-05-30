---
title: Splice Machine Query Optimizer
summary: Overview of the Splice Machine Query Optimizer
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_intro.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# The Splice Machine Query Optimizer

## Overview
With a perfect optimizer, user does not need to worry about the efficiency of their SQL statement, it is optimizer’s responsibility to convert the SQL into a semantically equivalent and more performant execution plan.

In reality, we need some manual tuning/rewriting because of:

* Limitations in the optimizer’s heuristic rewrite functionalities
* Limitations in the search space the optimizer explores
* Inaccuracy in stats and cost estimation
* Parsing time concern

## Outline

* Explain and stats
  * Things to look in the explain
  * Use stats view to understand the characteristics of the tables
* Common performance problems
  * Skewness issue
  * Choice of access path (covering index, non-covering index, table scan)
  * Nested loop join performance
  * Join order - use of derived table to influence the join order
  * ...
* Use of hints to guide optimizer


## Explain and Statistics

* The order the plan executed is from bottom-up.
* For a binary join, the left table comes first, then the right table.
* Key facts to note in the explain:
  * Scan step: scannedRows vs. outputRows, predicates
  * Join step: join strategies and join columns
    * Nested loop join, it is the most general join strategy, but may not be efficient except for a special scenario
    * Broadcast join: is the right table small enough to fit in memory?
    * Sortmerge join: is there any skewness on the join columns?
  * Execution path: spark or control (the threshold for spark execution is 20K scanned rows)

```
Explain
select count(*) from tpch100.lineitem
where l_shipdate <= date({fn TIMESTAMPADD(SQL_TSI_DAY, -90, cast('1998-12-01 00:00:00' as timestamp))});

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

### Stats View

* Two system views related to stats
  * `sys.systablestatistics` and `sys.syscolumnstatistics`
* Key metrics from the stats views to understand the characteristics of the table:

```
splice> select total_row_count, total_size, stats_type, sample_fraction from sys.systablestatistics where schemaname='TPCH100' and tablename='LINEITEM';
TOTAL_ROW_COUNT       |TOTAL_SIZE          |STATS_TYPE |SAMPLE_FRACTION
-----------------------------------------------------------------------
600037902             |52803335376         |2          |0.0

1 row selected


select columnname, cardinality, null_count, min_value, max_value
from sys.syscolumnstatistics
where schemaname='TPCH100' and tablename='LINEITEM' and columnname='L_SHIPDATE';
;
COLUMNNAME     |CARDINALITY         |NULL_COUNT  |MIN_VALUE   |MAX_VALUE
---------------------------------------------------------------------------
L_SHIPDATE     |2291                |0           |1992-01-02  |1998-12-01

1 row selected

```
{: .Example}

### Skewness Issue
* In the presence of skewness, a few tasks have to do significantly more work than other tasks, and defeat the purpose of parallelism, and it could also lead to OOM.
* Skewness could exists in the base table on certain columns, it could also happen after certain joins
* Skewness usually causes trouble in the sortmerge join steps or grouped aggregate operations
* How to detect skewness
  * If execution goes through the spark path, we can look at the tasks on the Spark WebUI

```
select count(*) from --SPLICE-PROPERTIES joinOrder=FIXED
 orders --splice-properties index=null
 , lineitem --splice-properties joinStrategy=sortmerge , index=null
 where o_orderkey = l_orderkey;

Plan
----------------------------------------------------------------------------------------------------
Cursor(n=8,rows=1,updateMode=,engine=Spark)

  ->  ScrollInsensitive(n=7,totalCost=12864539.978,outputRows=1,outputHeapSize=0 B,partitions=1)
    ->  ProjectRestrict(n=6,totalCost=340616.507,outputRows=1,outputHeapSize=0 B,partitions=1)
      ->  GroupBy(n=5,totalCost=340616.507,outputRows=1,outputHeapSize=0 B,partitions=1)
        ->  ProjectRestrict(n=4,totalCost=1743694.924,outputRows=621157000,outputHeapSize=9.501 GB,partitions=6)
          ->  MergeSortJoin(n=3,totalCost=1743694.924,outputRows=621157000,outputHeapSize=9.501 GB,partitions=6,preds=[(O_ORDERKEY[4:1] = L_ORDERKEY[4:2])])
            ->  TableScan[LINEITEM(21184)](n=2,totalCost=1128075.256,scannedRows=600037902,outputRows=600037902,outputHeapSize=9.501 GB,partitions=6)
            ->  TableScan[ORDERS(21200)](n=1,totalCost=300004,scannedRows=150000000,outputRows=150000000,outputHeapSize=1.552 GB,partitions=6)

8 rows selected
```
{: .Example}

<img src="images/OptimizerSkew1.png" class="indentedMedium" />

### Slide 6

### Slide 7

### Slide 8

### Slide 9

### Slide 10

### Slide 11

### Slide 12

### Slide 13

### Slide 14

### Slide 15

### Slide 16

### Slide 17

### Slide 18

### Slide 19

### Slide 20

### Slide 21

### Slide 22

### Slide 23

### Slide 24

### Slide 25

### Slide 26

### Slide 27

### Slide 28

### Slide 29

### Slide 30

</div>
</section>
