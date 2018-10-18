---
title: Using Compaction and Vacuuming
summary: Describes how compaction and vacuuming are used to improve database performance.
keywords: vacuum, compaction
toc: false
compatible_version: 2.7
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_compaction.html
folder: DeveloperTopics/Spark
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Compaction and Vacuuming

Compaction and vacuum are two mechanisms for clearing the physical space occupied by previously deleted items in your database.

## About Compaction

To understand compaction, you need a basic understanding of how HBase stores information:
* Each HBase table has one or more Regions.
* Each HBase table has one or more column families.
* Each region and column family has a *store* that contains:
  * A buffer, *MemStore*, that holds in-memory modifications until it is flushed to store files. There is one MemStore per region and column family.
  * Store Files, which are also called *HFiles*, that are created when Memstore fills it.

Every time HBase flushes a Memstore, it creates a *new* and *immutable* store file.

When you delete rows (tuples) from your database, Splice Machine marks the rows as deleted, but the physical space continues to be used until the table is compacted. As the physical space fills, reading live data from a table can require extra disk seeks, slowing performance. Compaction manages this problem.

### Minor and Major Compaction
There are two kinds of compaction:

* *Minor compactions* happen automatically and continuously, as needed: HBase initiates this action when a region's space is getting overly full. Minor compactions combine a number of smaller HFiles into one larger HFile; this improves performance by reducing the number of disk reads required to read a row from a table. HBase runs minor compactions when the a store (region and column family) reaches the number of HFiles specified in the `hbase.hstore.compactionThreshold` property value.

* A *Major compaction* actually reads every block of data from the every store file in a Region, and rewrites only the live data to a single store file. This permanently deletes the rows that were previously marked as deleted. HBase runs major compactions on a scheduled interval, which is specified in the `hbase.hregion.majorcompaction` property; the default value for this property in Splice Machine is 7 days. Note that major compactions are very resource intensive and time consuming.

You can also optionally run a major compaction on a schema or table manually:
* You use the [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA`](sqlref_sysprocs_compactschema.html) procedure to run a major compaction on an entire schema. For example, if you've imported an entire database, you should seriously consider running a major compaction on the schema, because loading a lot of data can generate a large number of small store files; a major compaction will result in well-arranged regions that are roughly 50% full, which leaves room for growth and change. 

* You use the [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html) procedure to run a major compaction on a specific table. For example, if you've imported a large dataset into a table or deleted a large number of rows from a table in your database, you may want to compact that table.

## Vacuuming {#vacuum}

When you drop a table from your database, Splice Machine marks the space occupied by the table as *deleted*, but does not actually free the physical space. That space is only reclaimed when you call the `SYSCS_UTIL.VACUUM` system procedure, which does the following:

1. Waits for all previous transactions to complete (and times out if this takes too long).
2. Gets a list of all of the HBase tables in use.
3. Compares that list with a list of objects currently in use in your database, and deletes any HBase tables that are no longer in use in your database.

This is a synchronous operations; when it completes, you'll see the following message:
```
Ready to accept connections.
```
{: .AppCommand}

</div>
</section>
