---
title: Getting Started with Splice Machine
summary: Getting Started
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: gettingstarted_intro.html
folder: GettingStarted
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.guide_heading = "Getting Started" %}
# Getting Started with Splice Machine

Splice Machine is a scale-out SQL RDBMS, Data Warehouse, and Machine Learning Platform in one, seamlessly integrating analytics and AI into your mission-critical applications.

Splice Machine offers a self-paced training and certification program in addition to our documentation. This program is meant for users and implementers of the Splice Machine platform, and covers administration, design, development and machine learning.  To learn more about the program, visit the <a href="https://www.splicemachine.com/get-started/splice-machine-accelerate/" target="_blank">Splice Machine Accelerate</a> page of our company web site.
{: .noteIcon}

The other topics in this chapter provide the information you need to get started with using Splice Machine:

* [Getting Started: Using the Command Line Interpreter](gettingstarted_cmdline.html)
* [Getting Started: Loading Data and Running Queries](gettingstarted_loadandrun.html)
* [Getting Started: Tuning Your Queries](gettingstarted_tuning.html)
* [Getting Started: Using Splice Machine Documentation](gettingstarted_usingdocs.html)

### Hybrid Transactional and Analytical Processing  {#hybrid}

Splice Machine has a unique *Dual Engine* architecture that it uses to provide outstanding performance for concurrent transactional (OLTP) and analytical (OLAP) workloads. The SQL parser and cost-based optimizer analyze an incoming query and then determine the best execution plan based on query type, data sizes, available indexes and more. Based on that analysis, Splice Machine either:

* Deploys HBase for OLTP-type lookups, inserts and short range scans
* Uses Spark for lightning-fast in-memory processing of analytical workloads

Our Dual Engine architecture gives you the best of multiple worlds in a hybrid database: the performance, scale-out, and resilience of HBase, the in-memory analytics performance of Spark, and the performance of a cost-based optimizer.

### ANSI SQL Coverage  {#ansi}

Unlike other Big Data systems, Splice Machine supports full [ANSI SQL-2003](https://doc.splicemachine.com/sqlref_sqlsummary.html); here's a quick summary of our coverage:

<table  summary="Summary of SQL features available in Splice Machine.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Feature</th>
            <th>Examples</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Aggregation functions</em></td>
            <td><code>AVG, COUNT, MAX, MIN, STDDEV_POP, STDDEV_SAMP, SUM</code></td>
        </tr>
        <tr>
            <td><em>Conditional functions</em></td>
            <td><code>CASE, searched CASE</code></td>
        </tr>
        <tr>
            <td><em>Data Types</em></td>
            <td><code>INTEGER, REAL, CHARACTER, DATE, BOOLEAN, BIGINT</code></td>
        </tr>
        <tr>
            <td><em>DDL</em></td>
            <td><code>CREATE TABLE, CREATE&nbsp;SCHEMA, CREATE&nbsp;INDEX, ALTER&nbsp;TABLE, DELETE, UPDATE</code></td>
        </tr>
        <tr>
            <td><em>DML</em></td>
            <td><code>INSERT, DELETE, UPDATE, SELECT</code></td>
        </tr>
        <tr>
            <td><em>Isolation Levels</em></td>
            <td>Snapshot isolation</td>
        </tr>
        <tr>
            <td><em>Joins</em></td>
            <td><code>INNER&nbsp;JOIN, LEFT&nbsp;OUTER&nbsp;JOIN, RIGHT&nbsp;OUTER&nbsp;JOIN</code></td>
        </tr>
        <tr>
            <td><em>Predicates</em></td>
            <td><code>IN, BETWEEN, LIKE, EXISTS</code></td>
        </tr>
        <tr>
            <td><em>Privileges</em></td>
            <td>Privileges for <code>SELECT, DELETE, INSERT, EXECUTE</code></td>
        </tr>
        <tr>
            <td><em>Query Specification</em></td>
            <td><code>SELECT&nbsp;DISTINCT, GROUP&nbsp;BY, HAVING</code></td>
        </tr>
        <tr>
            <td><em>SET&nbsp;functions</em></td>
            <td><code>UNION, ABS, MOD, ALL, CHECK</code></td>
        </tr>
        <tr>
            <td><em>String functions</em></td>
            <td><code>CHAR, Concatenation (||), INSTR, LCASE&nbsp;(LOWER), LENGTH,<br>LTRIM, REGEXP_LIKE, REPLACE, RTRIM, SUBSTR, UCASE&nbsp;(UPPER), VARCHAR</code></td>
        </tr>
        <tr>
            <td><em>Sub-queries</em></td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><em>Transactions</em></td>
            <td><code>COMMIT, ROLLBACK</code></td>
        </tr>
        <tr>
            <td><em>Triggers</em></td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><em>User-defined functions (UDFs)</em></td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><em>Views</em></td>
            <td>Including grouped views</td>
        </tr>
        <tr>
            <td><em>Window functions</em></td>
            <td><code>AVG, COUNT, DENSE_RANK, FIRST_VALUE, LAG, LAST_VALUE, LEAD, MAX, MIN, RANK, ROW_NUMBER, STDDEV_POP, STDDEV_SAMP, SUM</code></td>
        </tr>
    </tbody>
</table>

### Architecture Overview  {#architecture}

The following diagram is a high-level representation of the architecture of Splice Machine:

<img class="indentedTightSpacing" src="images/spliceArch1.png" alt="Overview diagram of the Splice Machine architecture">

### Technology Stack Overview  {#techstack}

Splice Machine is built on open-sourced, proven, distributed database technology, including HBase/Hadoop and Spark.

#### HBase/Hadoop  {#internalstorage}

The persistent, durable storage of operational data in Splice Machine resides in the Apache HBase key-value store. HBase:

* is a non-relational (NoSQL) database that runs on top of HDFS
* provides real-time read/write access to large datasets
* scales linearly to handle huge data sets with billions of rows and millions of columns
* is stored row-based and sorted by a primary key to deliver 1ms-10ms lookup speeds and short-range scans

HBase uses the Hadoop Distributed File System (HDFS) for reliable and replicated storage. HBase/HDFS provides auto-sharding and failover technology for scaling database tables across multiple servers. It is the only technology proven to scale to dozens of petabytes on commodity servers.

#### Spark In-Memory Computation Engine

Splice Machine uses Spark for analytical processing.

Apache Spark is a fast and general-purpose cluster computing system. It provides high-level APIs in Java, Scala, Python and R, and an optimized engine that supports a general execution graph on sets of data.

Spark has very efficient in-memory processing that can spill to disk (instead of dropping the query) if the query processing exceeds available memory. Spark is also unique in its resilience to node failures, which may occur in a commodity cluster. Other in-memory technologies will drop all queries associated with a failed node, while Spark uses ancestry (as opposed to replicating data) to regenerate its in-memory Resilient Distributed Datasets (RDDs) on another node.

The main abstraction Spark provides is a resilient distributed dataset (RDD), which is a collection of elements partitioned across the nodes of the cluster that can be operated on in parallel. RDDs are created by starting with a file in the Hadoop file system (or any other Hadoop-supported file system), or an existing Scala collection in the driver program, and transforming it. Users may also ask Spark to persist an RDD in memory, allowing it to be reused efficiently across parallel operations. Finally, RDDs automatically recover from node failures.

Spark is optimized to work on DataFrames, which are the main structure used by Spark. A DataFrame is a distributed collection of data (an RDD) organized into named columns, with a schema that specifies data types, that is designed to support efficiently operating on scalable, massive datasets.

##### Spark RDD Operations

RDDs support two types of operations:

* *Transformations* create new datasets from existing ones; for example, `map` is a transformation that passes each dataset element through a function and returns a new RDD representing the results.
* *Actions* return a value to the driver program after running a computation on the dataset; for example, `reduce` is an action that aggregates all the elements of the RDD using some function and returns the final result to the driver program (although there is also a parallel `reduceByKey` that returns a distributed dataset).

All transformations in Spark are lazy, in that they do not compute their results right away. Instead, they just remember the transformations applied to some base dataset such as a file. The transformations are only computed when an action requires a result to be returned to the driver program. This design enables Spark to run more efficiently. For example, we can realize that a dataset created through `map` will be used in a `reduce` and return only the result of the `reduce` to the driver, rather than the larger mapped dataset.

##### Spark Acceleration

Splice Machine accelerates generation of Spark RDDs by reading HBase HFiles in HDFS and augmenting that with any changes in Memstore that have not been flushed to HFiles. Splice Machine then uses the RDDs and Spark operators to distribute processing across Spark Workers.

#### Resource Isolation

Splice Machine isolates the resources allocated to HBase and Spark from each other, so each can progress independent of the workload of the other. Combined with the MVCC locking mechanism, this ensures that the performance level of transactional workloads can remain high, even if large reports or analytic processes are running.

### Internal Storage Using HBase

Splice Machine uses HBase to internally store data. HBase is modeled after Google Big Table, which is a large, distributed associative map stored as a Log-Structured Merge Tree. In HBase:

* Users store data rows in labelled tables.
* Each data row has a sortable key and an aribtrary number of columns.
*
HBase is often misunderstood because many call it a column-oriented datastore. This just means columns are grouped in separately separately stored column families. But all data is still ordered by row.

An HBase cluster has a service known as the *HBase Master* that coordinates the HBase Cluster and is responsible for administrative operations.

Splice Machine also uses ZooKeeper, which is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services on a cluster.

The following diagram shows how HBase operates in Splice Machine:

<img class="splice" class="indentedTightSpacing" src="https://s3.amazonaws.com/splice-examples/images/tutorials/hbases_storage_architecture2.png" alt="Diagram depicting Splice Machine use of HBase">


#### Region Servers and Regions

HBase auto-shards the data in a table across *Region Servers*:

* Each region server has a set of *Regions*.
* Each region is a set of rows sorted by a primary key.

When a region server fails to respond, HBase makes its regions accessible on other region servers. HBase is resilient to both region server failures and failure of Hadoop Data Nodes.

#### HBase Data Storage

HBase writes data to an in-memory store, called *memstore*. Once this memstore reaches a certain size, it is flushed to disk into a *store file*; everything is also written immediately to a log file for durability.

The store files created on disk are immutable. Sometimes the store files are merged together, this is done by a process called *compaction*. Store files are on the Hadoop Distributed File System (<em>HDFS</em>) and are replicated for fault-tolerance.


</div>
</section>
