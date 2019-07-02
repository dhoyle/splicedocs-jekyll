---
title: Getting Started with Query Optimization
summary: Getting Started with Query Optimization
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: gettingstarted_optimizing.html
folder: GettingStarted
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Getting Started with Query Optimization

This topic helps you to get started with

This notebook introduces a number of options you can employ to help generate the lowest cost plan and best performance for your queries, in these sections:

* Collecting Statistics
* Performing Major Compactions
* Creating Primary Keys and Indexes
* Joining Tables
* Selecting a Join Strategy

Tuning for performance is a critical topic for any database, and is especially true for Splice Machine because its distributed, dual-engine architecture may influence performance in ways unexpected by experienced database users. Splice Machine uses a cost-based optimizer, which means that the database determines different plans (ways it can run) for a query. The optimizer estimates the *cost* of each possible plan, and chooses the lowest-cost option.

## Collecting Statistics

The first query tuning commands you should learn about are the statistics collection commands:

* `ANALYZE TABLE` collects statistics for a specific table
* `ANALYZE SCHEMA` collects statistics for all tables in a schema.

Collecting statistics drastically improves the estimation of costs that the optimizer relies on to find the best plan.

Let's take a look at the impact of running statistics on our import test table from the *Importing Data* Notebook. You can most easily understand this by viewing the output from the `EXPLAIN` command. First, we'll click the  <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> *Run* button in the next paragraph to display the execution plan for our unoptimized query:

explain select * from admin.import_example a, admin.import_example b
where a.i = 100

### The Importance of Statistics

You'll notice that the row counts are way off! That's because we have __not__ run statistics yet. When statistics have not been run, the optimizer makes an estimate, but row counts will be rough approximations.

Let's collect some statistics by analyzing our table, and then we'll rerun the `explain`. When you click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, you'll see that the row counts and costs are accurate.

<p class="noteNote">Splice Machine recommends collecting statistics after initial loading of data into a table, and recollecting them if you've made significant changes to a table. Running the <code>analyze</code> command can take a bit of time, depending on the size of the table.</p>

analyze table admin.import_example;

explain select * from admin.import_example a, admin.import_example b
where a.i = 100

## Major Compactions

Splice Machine stores its data in HBase HFiles. HBase is good at handling the creation of HFiles as needed; however, it's important to be aware that HBase does perform asynchronous maintenance tasks to keep HFile working as efficiently as possible:

* HBase kicks off *Minor compactions* as a minor HFiles housekeeping task.
* HBase triggers *Major compactions* less frequently; these do much more housekeeping.

If you've just imported a lot of data (say 10M rows or so), it may be worth your while to manually trigger a major compaction using Splice Machine's  `PERFORM_MAJOR_COMPACTION_ON_TABLE` command. Click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, which triggers a major compaction of your `import_example` table.

<p class="noteIcon">Though major compactions can take some time to complete, they are worth doing for large tables that are used in a lot of analytic queries.</p>


call SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE('ADMIN','IMPORT_EXAMPLE')

## Creating Primary Keys and Indexes

Splice Machine, like other databases, supports the creation of primary keys and indexes; in Splice Machine:

* The primary key becomes the key for the HBase table.
* An index is another HBase table whose key consists of the columns in the index.
* Compound (multi-column) primary keys and indexes are supported.

<p class="noteIcon">As with all databases that support indexes, an improperly used index can actually <strong>slow down</strong> a query. This is especially true with Splice Machine because it is a distributed system, which means that there may be a significant cost to looking up the non-indexed information in a query. This is why you may see Splice Machine intentionally <strong>NOT</strong> use an index when one is available.</p>

Let's run through some quick examples. Click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, which creates an example table; this should take only a minute or two.

set schema admin;

create table index_example (i int primary key, j int);
insert into index_example values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
insert into index_example select i+10,j+10 from index_example;
insert into index_example select i+20,j+20 from index_example;
insert into index_example select i+40,j+40 from index_example;
insert into index_example select i+80,j+80 from index_example;
insert into index_example select i+160,j+160 from index_example;
insert into index_example select i+320,j+320 from index_example;
insert into index_example select i+640,j+640 from index_example;
insert into index_example select i+1280,j+1280 from index_example;
insert into index_example select i+2560,j+2560 from index_example;
insert into index_example select i+6000,j+6000 from index_example;
insert into index_example select i+12000,j+12000 from index_example;
insert into index_example select i+24000,j+24000 from index_example;
insert into index_example select i+48000,j+48000 from index_example;
insert into index_example select i+96000,j+96000 from index_example;
insert into index_example select i+200000,j+200000 from index_example;
insert into index_example select i+400000,j+400000 from index_example;
insert into index_example select i+800000,j+800000 from index_example;

analyze table admin.index_example



As you can see from the results of the above operation, we now have:

* about 1.3 million rows of data
* a primary key on `i`

Click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> in the next paragraph  to do lookups on `i`. You'll see that the primary key will find the record for us quickly:


select * from admin.index_example where i = 300000


That query should have come back almost immediately. But what happens if we query on `j`?

select * from admin.index_example where j = 300000

### Adding an Index

You probably noticed this query required more time to complete; this is because there was no key to go straight to the record. Now, let's add an index on `j`:

create index ij on admin.index_example (j)

If you rerun the previous `j` query, it now runs quickly.  This is because the optimizer considered both plan options available to it (with and without an index), found a lower cost for the plan using the index, and executed that plan.

This is where `EXPLAIN` can be quite useful as well: you can discover if an index is being used or not. Click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> in the next paragraph to run the `explain`:


explain select j from admin.index_example where j = 300000

### When an Index Doesn't Help

You can see that this performs an *IndexScan* (vs. a *TableScan*), and it tells you which index it uses, as well as the usual cost information, etc.

Let's get into a more complicated case where it is __not__ a good idea to use a particular index. In the next paragraph, we start with an `EXPLAIN` on our query:

%splicemachine

explain select count(i) from admin.index_example where j > 950000


### Adding Index Hints

Note that the optimizer chose the plan that uses the actual table, NOT the index; why did it make this choice?

We can learn more about this by using a Splice Machine *hint* to force use of an index; you can see that we use an `index` hint in the next paragraph:


explain select count(i) from admin.index_example --splice-properties index=ij
     where j > 950000

### Learning About Hints

You add Splice Machine __hints__ to your queries by appending a specially formatted *comment*. The different kinds of available hints and the syntax required for them is described in detail later in this class, in the [*Using Explain and Hints*](/#/notebook/2DVFUM14R) notebook.

The *index hint* in the above example  (`--splice-properties index=ij`) is an explicit instruction to the optimizer to use that named index instead of what the Optimizer might have chosen. And the results of using the index are evident in the generated plan, which now uses an `IndexScan` instead of the `TableScan`. We can also see that the total cost (at the top of each plan) is much higher when using the index. Why is that?

### Index Lookup
The reason for this is that the index only contains information for column `J`, and this query calls for information about column `I` as well. This means that we still have to get information from the base table for column I, and we have to do it *many* times.  You can see this in the plan: there is a step, `IndexLookup`, that is part of the plan.  You'll also see the cost jump up on that step, because for every row of where column J matches the criteria that we need to scan (and the optimizer estimates there are more than half a million matches), we have to go back over to the base table to get the information about column `I`.  In distributed architectures like Splice Machine, this can be a very expensive operation.

If you want, you can run these these two queries by removing the `explains`; you'll noticed a significant performance difference between them.

<p class="noteNote">If we change the <code>&gt;</code> to <code>=</code> in the query, things change dramatically. Even though there is still an <code>IndexLookup</code>, it's only called once, so clearly use of the Index vs the Table is a better and faster plan.  Try it and see!</p>

When faced with situations where you have __many__ matching rows however, like our original query, you can address the issue by creating a compound index that includes both `j` and `i` in it:

create index iji on admin.index_example (j, i)



Running the original query will now choose this index, and run faster.

## Joining Tables

Few queries are written without joins between tables.  Shortly we will get into the join strategies Splice Machine employs, but first let's cover what it means to be on the *right* or *left* side of a join.  To begin, we'll click <img class="inline" src="https://doc.splicemachine.com/zeppelin/images/zepPlayIcon.png" alt="Run Zep Paragraph Icon"> to run the next paragraph, which creates some tables and then runs an `EXPLAIN` on a join on those tables:



create table admin.join1 (i int);
create table admin.join2 (i int);
create table admin.join3 (i int);
create table admin.join4 (i int);

explain select * from admin.join1 a, admin.join2 b, admin.join3 c, admin.join4 d
where a.i = b.i
and a.i = c.i
and a.i = d.i


For now, we'll ignore costs and join strategies and focus on the __order__ in which tables show up in the plan we just generated (with our `explain`).  Again, we need to think this through *bottom-up* when examining our plan:

* The bottom-most table (`JOIN1`) is the *left-hand side*
* The next up table (`JOIN2`) is the *right-hand side*
* Each join needs a left-hand side and a right-hand side, so the bottom-most join will be joining tables `JOIN1` and `JOIN2`.
* The __result__ of this bottom-most join becomes the __NEW__ *left-hand side*, and the table above it (in this case `JOIN3`) will be the *right-hand side* for the next join, and so on.

It is important to know which table (or join result) represents the left-hand or right-hand side of the join.


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
            <td>Sorts the data being joined and performs a merge on the results</td>
        </tr>
        <tr>
            <td><code>Merge</code></td>
            <td>Performs a merge, but is not valid unless the data is not pre-sorted (via primary key or index) on the join key</td>
        </tr>
        <tr>
            <td><code>Broadcast</code></td>
            <td>Requires the right-hand-side table to be small (< 1 million rows), so that this table can be copied to all nodes for local joins on each node</td>
        </tr>
        <tr>
            <td><code>NestedLoop</code></td>
            <td>The general-purpose join strategy</td>
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
            <td><p>On queries processing a lot of data, when a Merge or Broadcast is not valid, SortMerge will be used.</p>
                <p>It is slower than Merge and Broadcast, but can be used in more instances.</p>
            </td>
        </tr>
        <tr>
            <td><code>Merge</code></td>
            <td><p>Generally the fastest query to process many rows of data on both the right and left side of the join.</p>
                <p>However the data must be sorted on the join keys on both the right and left sides.</p>
            </td>
        </tr>
        <tr>
            <td><code>Broadcast</code></td>
            <td><p>A very fast join algorithm as long as the <em>right-hand</em> table of the join has 1 million or fewer rows.</p>
            </td>
        </tr>
        <tr>
            <td><code>NestedLoop</code></td>
            <td><p>The fastest join for <em>transaction-type</em> queries (i.e. keyed lookups with few rows on each side of the join).</p>
                <p>If there are many rows on the right and/or left side, this query can be very slow.</p>
            </td>
        </tr>
    </tbody>
</table>

When planning a query with joins, the optimizer will choose the join strategy with the lowest cost.  Its choice however might again influence how you make your own changes (for example, add an index so that a SortMerge becomes a Merge).


</div>
</section>
