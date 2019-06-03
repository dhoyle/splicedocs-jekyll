If you have a query that is not performing as expected, you can run the `explain` command to display the execution plan for the query.

All you need to do is put `EXPLAIN` in front of the query and run that. This generates the plan, but does not actually run the query. Try it by clicking the  <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> *Run* button in the next paragraph.




To see the execution flow of a query, look at the generated plan from the *bottom up.*  The very first steps of the query are at the bottom, then each step follows above.

Each row includes the action being performed (a Scan, Join, grouping, etc.) followed by:

<table class="splicezepNoBorder">
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







## Collecting Statistics

The first commands you should learn about are the statistics collection commands:

* `ANALYZE TABLE` collects statistics for a specific table
* `ANALYZE SCHEMA` collects statistics for all tables in a schema.

Collecting statistics dramatically improves the estimation of costs that the optimizer relies on to find the best plan.

Let's take a look at the impact of running statistics on our import test table from *Importing Data* Notebook. You can most easily understand this by viewing the output from the `EXPLAIN` command. First, we'll click the  <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> *Run* button in the next paragraph to display the execution plan for our unoptimized query:



### The Importance of Statistics

You'll notice, as you probably did when running the `explain` in the *Importing Data* tutorial, that the row counts are not right. That's because we have __not__ run statistics yet. When statistics have not been run, the optimizer makes an estimate, but row counts will be rough approximations.

Let's collect some statistics by analyzing our table, and then we'll rerun the `explain`. When you click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, you'll see that the row counts are accurate.  Better accuracy on row counts gives us better cost data and better plans overall.

<p class="noteNote">Splice Machine recommends collecting statistics after initial loading of data into a table, and recollecting them if you've made significant changes to a table. Running the <code>analyze</code> command can take a bit of time, depending on the size of your database.</p>



## Major Compactions

Splice Machine stores its data in HBase *HFiles*. HBase is good at handling the creation of HFiles as needed; however, it's important to be aware that HBase does perform asynchronous maintenance tasks to keep HFiles working as efficiently as possible:

* HBase automatically kicks off *Minor compactions* as a minor HFiles housekeeping task.
* HBase triggers *Major compactions*, which perform deeper housekeeping work, less frequently; however, you can manually trigger these when appropriate.

If you've just imported a lot of data (say 10M rows or so), it may be worth your while to manually trigger a major compaction with the `PERFORM_MAJOR_COMPACTION_ON_TABLE` command. Click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, which triggers a major compaction of your `import_example` table.

<p class="noteIcon">Though major compactions can take some time to complete, they are worth doing for large tables that are used in a lot of analytic queries.</p>



## Joining Tables

Few queries are written without joins between tables.  Shortly we will get into the join strategies Splice Machine employs, but first let's cover what it means to be on the *right* or *left* side of a join.  To begin, we'll click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, which creates some tables and then runs an `EXPLAIN` on a join on those tables:


%splicemachine

create table dev1.join1 (i int);
create table dev1.join2 (i int);
create table dev1.join3 (i int);
create table dev1.join4 (i int);

explain select * from dev1.join1 a, dev1.join2 b, dev1.join3 c, dev1.join4 d
where a.i = b.i
and a.i = c.i
and a.i = d.i

Plan
Cursor(n=9,rows=17,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=8,totalCost=42.71,outputRows=17,outputHeapSize=76 B,partitions=1)
    ->  BroadcastJoin(n=7,totalCost=28.76,outputRows=17,outputHeapSize=76 B,partitions=1,preds=[(A.I[12:1] = D.I[12:4])])
      ->  TableScan[JOIN4(1776)](n=6,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=76 B,partitions=1)
      ->  BroadcastJoin(n=5,totalCost=20.52,outputRows=16,outputHeapSize=56 B,partitions=1,preds=[(A.I[8:1] = C.I[8:3])])
        ->  TableScan[JOIN3(1760)](n=4,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=56 B,partitions=1)
        ->  BroadcastJoin(n=3,totalCost=12.28,outputRows=16,outputHeapSize=36 B,partitions=1,preds=[(A.I[4:1] = B.I[4:2])])
          ->  TableScan[JOIN2(1744)](n=2,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=36 B,partitions=1)
          ->  TableScan[JOIN1(1728)](n=1,totalCost=4.04,scannedRows=20,outputRows=20,outputHeapSize=20 B,partitions=1)



For now, we'll ignore costs and join strategies and focus on the __order__ in which tables show up in the plan we just generated (with our `explain`).  Again, we need to think through this *bottom-up:* when examining our plan:

* The bottom-most table (`JOIN1`) is the *left-hand side*
* The next up table (`JOIN2`) is the *right-hand side*
* Each join needs a left-hand side and a right-hand side, so the bottom-most join will be joining tables `JOIN1` and `JOIN2`.
* The __result__ of this bottom-most join becomes the __NEW__ *left-hand side*, and the table above it (in this case `JOIN3`) will be the *right-hand side* for the next join, and so on.

It is often important to know what table (or join result) represents the left-hand or right-hand side of the join.


## Join Strategies

Databases employ different algorithms to efficiently perform a join, depending on the circumstances.  Here are the join strategies Splice Machine employs:

<table class="splicezep">
    <col />
    <col />
    <thead>
        <tr>
            <th>Join Strategy</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>SortMerge</code></td>
            <td>Sorts the data being joined and performs a merge on the results.</td>
        </tr>
        <tr>
            <td><code>Merge</code></td>
            <td>Performs a merge, but is not valid unless the data is not pre-sorted (via primary key or index) on the join key.</td>
        </tr>
        <tr>
            <td><code>Broadcast</code></td>
            <td>Requires the right-hand-side table to be small (< 1 million rows), so that this table can be copied to all nodes for local joins on each node.</td>
        </tr>
        <tr>
            <td><code>NestedLoop</code></td>
            <td>The general-purpose join strategy.</td>
        </tr>
    </tbody>
</table>

Each join strategy has its strengths and weaknesses, which are summarized here:

<table class="splicezep">
    <col />
    <col />
    <thead>
        <tr>
            <th>Join Strategy</th>
            <th>Strengths and Weaknesses</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>SortMerge</code></td>
            <td><p>On queries that process a lot of data, <code>SortMerge</code> is used when a <code>Merge</code> or <code>Broadcast is not valid</code>.</p>
                <p><code>SortMerge</code> is slower than <code>Merge</code> and <code>Broadcast</code>, but can be used in more instances.</p>
            </td>
        </tr>
        <tr>
            <td><code>Merge</code></td>
            <td><p><code>Merge</code> is generally the fastest query to process many rows of data on both the right and left side of the join.</p>
                <p>The data must be sorted on the join keys on both the right and left sides for <code>Merge</code> to work.</p>
            </td>
        </tr>
        <tr>
            <td><code>Broadcast</code></td>
            <td><p><code>Broadcast</code> is a very fast join algorithm, as long as the <em>right-hand</em> table of the join has 1 million or fewer rows.</p>
            </td>
        </tr>
        <tr>
            <td><code>NestedLoop</code></td>
            <td><p><code>NestedLoop</code> is the fastest join for <em>transaction-type/</em> queries (i.e. keyed lookups with few rows on each side of the join).</p>
                <p><code>NestedLoop</code> can be very slow if there are many rows on the right and/or left side.</p>
            </td>
        </tr>
    </tbody>
</table>



==================== from dev II ============================
TPCH Query 4

%splicemachine
-- QUERY 04
explain  select
	o_orderpriority,
	count(*) as order_count
from
	DEV2.orders
where
	o_orderdate >= date('1993-07-01')
	and o_orderdate < add_months('1993-07-01',3)
	and exists (
		select
			*
		from
			DEV2.lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority
-- END OF QUERY

Plan
Cursor(n=13,rows=60977812,updateMode=READ_ONLY (1),engine=Spark)
  ->  ScrollInsensitive(n=12,totalCost=2497080.846,outputRows=60977812,outputHeapSize=211.826 MB,partitions=46)
    ->  OrderBy(n=11,totalCost=1273929.78,outputRows=60977812,outputHeapSize=211.826 MB,partitions=46)
      ->  ProjectRestrict(n=10,totalCost=610400.203,outputRows=60977813,outputHeapSize=211.826 MB,partitions=46)
        ->  GroupBy(n=9,totalCost=114450.098,outputRows=60977813,outputHeapSize=211.826 MB,partitions=46)
          ->  ProjectRestrict(n=8,totalCost=83441.5,outputRows=13060701,outputHeapSize=211.826 MB,partitions=46)
            ->  MergeSortJoin(n=7,totalCost=114450.098,outputRows=60977813,outputHeapSize=211.826 MB,partitions=46,preds=[(ExistsFlatSubquery-0-1.L_ORDERKEY[7:1] = O_ORDERKEY[7:2])])
              ->  TableScan[ORDERS(1808)](n=6,totalCost=83441.5,scannedRows=41718750,outputRows=13060701,outputHeapSize=211.826 MB,partitions=46,preds=[(O_ORDERDATE[5:2] >= 1993-07-01),(O_ORDERDATE[5:2] < dataTypeServices: DATE )])
              ->  ProjectRestrict(n=5,totalCost=456938.375,outputRows=75281250,outputHeapSize=215.381 MB,partitions=46)
                ->  Distinct(n=4,totalCost=9933.443,outputRows=75281250,outputHeapSize=215.381 MB,partitions=1)
                  ->  ProjectRestrict(n=3,totalCost=456938.375,outputRows=75281248,outputHeapSize=215.381 MB,partitions=46)
                    ->  ProjectRestrict(n=2,totalCost=456938.375,outputRows=75281248,outputHeapSize=215.381 MB,partitions=46,preds=[(L_COMMITDATE[0:2] < L_RECEIPTDATE[0:3])])
                      ->  TableScan[LINEITEM(1792)](n=1,totalCost=456254,scannedRows=228125000,outputRows=228125000,outputHeapSize=215.381 MB,partitions=46)
FINISHED
Took 0 sec. Last updated by anonymous at December 27 2018, 6:16:29 PM. (outdated)




## Optimizing Query Performance

In this section we'll look at optimizing the execution plan for TPCH Query 4. We'll:

* Collect Statistics to Inform the Optimizer
* Add Indexes to Further Optimize the Plan
* Compare Execution Plans

When creating a plan for a query, our optimizer performs a number of important and valuable actions, including:

* It creates an access plan, which determine the best path for accessing the data the query will operate upon; for example, the access path might be to scan an entire table or to use an index.
* When joining tables, the optimizer evaluates the best *join order* and the *join strategy* to use.
* The optimizer unrolls subqueries to reduce processing time

Since there often are different options available (whether or not to use an index, which join order, etc.), we evaluate the different possibilities, score them, then choose the best we find.  Of course coming up with good scores requires good knowledge about your database, and that's where the statistics collection comes in.

You use our `analyze` command to collect statistics from your database, which the optimizer uses when planning the execution of a query.

<p class="noteIcon">Cost-based optimizers are powerful features of modern databases that enable query plans to change as the data profiles change. Optimizers make use of count distinct, quantiles, and most frequent item counts as heuristics.</p>

Collecting these metrics can be extremely expensive but if approximate results are acceptable (which is typically the case with query optimization), there is a class of specialized algorithms, called streaming algorithms, or *sketches*, that can produce results orders-of magnitude faster and with mathematically proven error bounds. Splice Machine leverages the <a href="https://datasketches.github.io/docs/TheChallenge.html" target="_blank">Yahoo Sketches Library</a> for its statistics gathering.

### Collect Statistics
Our first optimization is to collect statistics to inform the optimizer about our database. We use our `analyze` command to collect statistics on a schema (or table). This process requires a couple minutes.




### Rerun the Explain Plan After Collecting Statistics

Now let's re-run the `explain` plan for Query 4 and see how the optimizer changed the plan after gathering statistics. Note that the `scannedRows` estimate for `LINEITEM`  is appropriately at 6M rows, etc:

Plan
Cursor(n=13,rows=5,updateMode=READ_ONLY (1),engine=Spark)
  ->  ScrollInsensitive(n=12,totalCost=16637.672,outputRows=5,outputHeapSize=127 B,partitions=46)
    ->  OrderBy(n=11,totalCost=16637.569,outputRows=5,outputHeapSize=127 B,partitions=46)
      ->  ProjectRestrict(n=10,totalCost=16283.526,outputRows=1604125,outputHeapSize=127 B,partitions=46)
        ->  GroupBy(n=9,totalCost=3852.165,outputRows=1604125,outputHeapSize=39.081 MB,partitions=46)
          ->  ProjectRestrict(n=8,totalCost=3004,outputRows=435344,outputHeapSize=39.081 MB,partitions=46)
            ->  MergeSortJoin(n=7,totalCost=3852.165,outputRows=1604125,outputHeapSize=39.081 MB,partitions=46,preds=[(ExistsFlatSubquery-0-1.L_ORDERKEY[7:1] = O_ORDERKEY[7:2])])
              ->  TableScan[ORDERS(1808)](n=6,totalCost=3004,scannedRows=1500000,outputRows=435344,outputHeapSize=39.081 MB,partitions=46,preds=[(O_ORDERDATE[5:2] >= 1993-07-01),(O_ORDERDATE[5:2] < dataTypeServices: DATE )])
              ->  ProjectRestrict(n=5,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=46)
                ->  Distinct(n=4,totalCost=247.507,outputRows=1498948,outputHeapSize=23.587 MB,partitions=1)
                  ->  ProjectRestrict(n=3,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=46)
                    ->  ProjectRestrict(n=2,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=46,preds=[(L_COMMITDATE[0:2] < L_RECEIPTDATE[0:3])])
                      ->  TableScan[LINEITEM(1792)](n=1,totalCost=11286.284,scannedRows=6001215,outputRows=6001215,outputHeapSize=31.163 MB,partitions=46)


### Compare Execution Plans After Analyzing the Database

Now let's compare the plans to see what changed. At a quick glance, you'll notice that a very large difference in the `totalCost` numbers for every operation in the plan.  (Note
that your exact costs will vary slightly from what we show here, depending on your system):

#### After Collecting Statistics
```
Plan
Cursor(n=13,rows=5,updateMode=READ_ONLY (1),engine=Spark)
  ->  ScrollInsensitive(n=12,totalCost=16920.058,outputRows=5,outputHeapSize=127 B,partitions=41)
    ->  OrderBy(n=11,totalCost=16919.956,outputRows=5,outputHeapSize=127 B,partitions=41)
      ->  ProjectRestrict(n=10,totalCost=16517.046,outputRows=1604125,outputHeapSize=127 B,partitions=41)
        ->  GroupBy(n=9,totalCost=3955.595,outputRows=1604125,outputHeapSize=39.081 MB,partitions=41)
          ->  ProjectRestrict(n=8,totalCost=3004,outputRows=435327,outputHeapSize=39.081 MB,partitions=41)
            ->  MergeSortJoin(n=7,totalCost=3955.595,outputRows=1604125,outputHeapSize=39.081 MB,partitions=41,preds=[(ExistsFlatSubquery-0-1.L_ORDERKEY[7:1] = O_ORDERKEY[7:2])])
              ->  TableScan[ORDERS(1616)](n=6,totalCost=3004,scannedRows=1500000,outputRows=435327,outputHeapSize=39.081 MB,partitions=41,preds=[(O_ORDERDATE[5:2] >= 1993-07-01),(O_ORDERDATE[5:2] < dataTypeServices: DATE )])
              ->  ProjectRestrict(n=5,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=41)
                ->  Distinct(n=4,totalCost=277.69,outputRows=1501009,outputHeapSize=23.619 MB,partitions=1)
                  ->  ProjectRestrict(n=3,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=41)
                    ->  ProjectRestrict(n=2,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=41,preds=[(L_COMMITDATE[0:2] < L_RECEIPTDATE[0:3])])
                      ->  TableScan[LINEITEM(1600)](n=1,totalCost=11286.284,scannedRows=6001215,outputRows=6001215,outputHeapSize=31.163 MB,partitions=41)
```

#### Before Collecting Statistics
```
Plan
Cursor(n=13,rows=36753750,updateMode=READ_ONLY (1),engine=Spark)
  ->  ScrollInsensitive(n=12,totalCost=1576165.614,outputRows=36753750,outputHeapSize=139.022 MB,partitions=41)
    ->  OrderBy(n=11,totalCost=838921.423,outputRows=36753750,outputHeapSize=139.022 MB,partitions=41)
      ->  ProjectRestrict(n=10,totalCost=400696.835,outputRows=36753750,outputHeapSize=139.022 MB,partitions=41)
        ->  GroupBy(n=9,totalCost=98186.501,outputRows=36753750,outputHeapSize=139.022 MB,partitions=41)
          ->  ProjectRestrict(n=8,totalCost=75629,outputRows=11837789,outputHeapSize=139.022 MB,partitions=41)
            ->  MergeSortJoin(n=7,totalCost=98186.501,outputRows=36753750,outputHeapSize=139.022 MB,partitions=41,preds=[(ExistsFlatSubquery-0-1.L_ORDERKEY[7:1] = O_ORDERKEY[7:2])])
              ->  TableScan[ORDERS(1616)](n=6,totalCost=75629,scannedRows=37812500,outputRows=11837789,outputHeapSize=139.022 MB,partitions=41,preds=[(O_ORDERDATE[5:2] >= 1993-07-01),(O_ORDERDATE[5:2] < dataTypeServices: DATE )])
              ->  ProjectRestrict(n=5,totalCost=275416.5,outputRows=45375000,outputHeapSize=129.819 MB,partitions=41)
                ->  Distinct(n=4,totalCost=6717.476,outputRows=45375000,outputHeapSize=129.819 MB,partitions=1)
                  ->  ProjectRestrict(n=3,totalCost=275416.5,outputRows=45375000,outputHeapSize=129.819 MB,partitions=41)
                    ->  ProjectRestrict(n=2,totalCost=275416.5,outputRows=45375000,outputHeapSize=129.819 MB,partitions=41,preds=[(L_COMMITDATE[0:2] < L_RECEIPTDATE[0:3])])
                      ->  TableScan[LINEITEM(1600)](n=1,totalCost=275004,scannedRows=137500000,outputRows=137500000,outputHeapSize=129.819 MB,partitions=41)
```


### Optimize by Adding Indexes

Splice Machine tables have primary keys either implicit or explicitly defined. Data is stored in order of these keys.

<div class="noteNote" style="max-width:40%;">The primary key is not optimal for all queries.</div>

Unlike HBase and other key-value stores, Splice Machine can use *secondary indexes* to improve the performance of data manipulation statements. In addition, `UNIQUE` indexes provide a form of data integrity checking.

In Splice Machine, an index is just another HBase table, keyed on the index itself.

### Adding an index on ORDERS

Note that in the explain for this query, we are scanning the entire `ORDERS` table, even though we only will require a subset of the data. Adding an index on `O_ORDERDATE` should help. HOWEVER, it's important to know that the plan is telling us that even if we use an index, we still will be returning many rows to the next step (`outputRows>400K`).   This means that we should be careful to avoid the `IndexLookup` problem that we previously discussed, and that we should also add other columns that we'll need.


%splicemachine

create index DEV2.O_DATE_PRI_KEY_IDX on DEV2.ORDERS(
 O_ORDERDATE,
 O_ORDERPRIORITY,
 O_ORDERKEY
 );


Plan
Cursor(n=14,rows=5,updateMode=READ_ONLY (1),engine=Spark)
  ->  ScrollInsensitive(n=13,totalCost=14139.954,outputRows=5,outputHeapSize=127 B,partitions=46)
    ->  OrderBy(n=12,totalCost=14139.851,outputRows=5,outputHeapSize=127 B,partitions=46)
      ->  ProjectRestrict(n=11,totalCost=13838.958,outputRows=1604125,outputHeapSize=127 B,partitions=46)
        ->  GroupBy(n=10,totalCost=1459.609,outputRows=1604125,outputHeapSize=39.081 MB,partitions=46)
          ->  ProjectRestrict(n=9,totalCost=662.35,outputRows=435344,outputHeapSize=39.081 MB,partitions=46)
            ->  MergeSortJoin(n=8,totalCost=1459.609,outputRows=1604125,outputHeapSize=39.081 MB,partitions=46,preds=[(ExistsFlatSubquery-0-1.L_ORDERKEY[7:1] = O_ORDERKEY[7:2])])
              ->  ProjectRestrict(n=7,totalCost=662.35,outputRows=435344,outputHeapSize=39.081 MB,partitions=46)
                ->  IndexScan[O_DATE_PRI_KEY_IDX(1921)](n=6,totalCost=662.35,scannedRows=495000,outputRows=435344,outputHeapSize=39.081 MB,partitions=46,baseTable=ORDERS(1808),preds=[(O_ORDERDATE[5:1] >= 1993-07-01),(O_ORDERDATE[5:1] < dataTypeServices: DATE )])
              ->  ProjectRestrict(n=5,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=46)
                ->  Distinct(n=4,totalCost=247.507,outputRows=1498948,outputHeapSize=23.587 MB,partitions=1)
                  ->  ProjectRestrict(n=3,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=46)
                    ->  ProjectRestrict(n=2,totalCost=11385.304,outputRows=1980401,outputHeapSize=31.163 MB,partitions=46,preds=[(L_COMMITDATE[0:2] < L_RECEIPTDATE[0:3])])
                      ->  TableScan[LINEITEM(1792)](n=1,totalCost=11286.284,scannedRows=6001215,outputRows=6001215,outputHeapSize=31.163 MB,partitions=46)
