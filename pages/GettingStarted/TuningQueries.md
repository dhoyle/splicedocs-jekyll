---
title: Getting Started with Query Tuning
summary: Getting Started with Query Tuning
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: gettingstarted_tuning.html
folder: GettingStarted
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Getting Started with Tuning Your Queries

This briefly introduces a number of options you can employ to help generate the lowest cost plan and best performance for your queries, in these sections:

* Collecting Statistics
* Performing Major Compactions
* Creating Primary Keys and Indexes
* Joining Tables
* Selecting a Join Strategy

Tuning for performance is a critical topic for any database, and is especially true for Splice Machine because its distributed, dual-engine architecture may influence performance in ways unexpected by experienced database users.

Splice Machine uses a cost-based optimizer, which means that the database determines different plans (ways it can run) for a query. The optimizer estimates the *cost* of each possible plan, and chooses the lowest-cost option.

The query tuning tools and techniques introduced here are described in much greater detail in our [Best Practices - Optimizing Your Queries](bestpractices_optimizer_intro.html) chapter.

## Collecting Statistics

The first query tuning commands you should learn about are the statistics collection commands:

* `ANALYZE TABLE` collects statistics for a specific table
* `ANALYZE SCHEMA` collects statistics for all tables in a schema.

Collecting statistics drastically improves the estimation of costs that the optimizer relies on to find the best plan.

When statistics have not been run, the optimizer makes an estimate, but row counts will be rough approximations. After you collect statistics, the row counts are accurate, which allows the optimizer to make accurate cost estimations.

Splice Machine recommends collecting statistics after initial loading of data into a table, and then again after you've made significant changes to a table. Running the `analyze` command can take a bit of time, depending on the size of the table.
{: .noteNote}

## Major Compactions

Splice Machine stores its data in HBase HFiles. HBase is good at handling the creation of HFiles as needed; however, it's important to be aware that HBase does perform asynchronous maintenance tasks to keep HFile working as efficiently as possible:

* HBase kicks off *Minor compactions* as a minor HFiles housekeeping task.
* HBase triggers *Major compactions* less frequently; these do much more housekeeping.

If you've just imported a lot of data (say 10M rows or so), it may be worth your while to manually trigger a major compaction using Splice Machine's  `PERFORM_MAJOR_COMPACTION_ON_TABLE` command. Though major compactions can take some time to complete, they are worth doing for large tables that are used in a lot of analytic queries.

See the [Best Practices - Compacting and Vacuuming](bestpractices_optimizer_compacting.html) topic for more information.

## Creating Primary Keys and Indexes

Splice Machine, like other databases, supports the creation of primary keys and indexes; in Splice Machine:

* The primary key becomes the key for the HBase table.
* An index is another HBase table whose key consists of the columns in the index.
* Compound (multi-column) primary keys and indexes are supported.

As with all databases that support indexes, an improperly used index can actually _slow down_ a query. This is especially true with Splice Machine because it is a distributed system, which means that there may be a significant cost to looking up the non-indexed information in a query. This is why you may see Splice Machine intentionally __NOT__ use an index when one is available.

### Adding Index Hints

You can use a Splice Machine *hint* to force use of an index; for example:

explain select count(i) from index_example --splice-properties index=ij
     where j > 950000

You add Splice Machine __hints__ to your queries by appending a specially formatted *comment*. The different kinds of available hints and the syntax required for them is described in detail later in this class, in the [Using Hints to Improve Performance](bestpractices_optimizer_hints.html) topic.

The *index hint* in the above example  (`--splice-properties index=ij`) is an explicit instruction to the optimizer to use that named index instead of what the Optimizer might have chosen.

## Joining Tables

Few queries are written without joins between tables; let's cover what it means to be on the *right* or *left* side of a join. The following commands create some tables and then run an `EXPLAIN` on a join on those tables:

```
create table join1 (i int);
create table join2 (i int);
create table join3 (i int);
create table join4 (i int);

explain select * from join1 a, join2 b, join3 c, join4 d
where a.i = b.i
and a.i = c.i
and a.i = d.i
```
{: .Example}

For now, we'll ignore costs and join strategies and focus on the __order__ in which tables show up in the plan:

* The first table (`JOIN1`) is the *left-hand side*
* The next table (`JOIN2`) is the *right-hand side*
* Each join needs a left-hand side and a right-hand side, so the first join will be joining tables `JOIN1` and `JOIN2`.
* The __result__ of this join becomes the __NEW__ *left-hand side*, and the next table (in this case `JOIN3`) will be the *right-hand side* for the next join, and so on.

It is important to know which table (or join result) represents the left-hand or right-hand side of the join.

Databases employ different algorithms to efficiently perform a join, depending on the circumstances.  Here are the join strategies Splice Machine employs:

<table>
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

When planning a query with joins, the optimizer will choose the join strategy with the lowest cost.  Its choice however might again influence how you make your own changes (for example, add an index so that a SortMerge becomes a Merge).

For more information about joins and join strategies, see the [Best Practices - Join Strategies](bestpractices_optimizer_joinstrategies.html) topic.


</div>
</section>
