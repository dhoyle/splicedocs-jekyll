---
title: The Splice Machine In-Memory Engine
summary: A quick overview of the Splice Machine in-memory engine, powered by Apache Spark.
keywords: spark, overview, 'in-memory engine', 'spark overview'
toc: false
product: all
sidebar:  getstarted_sidebar
permalink: notes_sparkoverview.html
folder: Notes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# The Splice Machine In-Memory Engine

This topic provides an overview of the Splice Machine in-memory engine,
which tremendously boosts OLAP (analytical) query performance. Splice
Machine use Apache Spark as our in-memory engine and automatically
detects and directs OLAP queries to that engine.

This topic presents a very brief overview of Spark terminology and
concepts.

If you're not yet familiar with Spark, we recommend visiting the Apache
Spark web site, [spark.apache.org][1]{: target="_blank"}, to learn the
basics, and for links to the official Spark documentation.
{: .noteNote}

## Spark Overview

Apache Spark is an open source computational engine that manages tasks
in a computing cluster. Spark was originally developed at UC Berkeley in
2009, and then open sourced in 2010 as an Apache project. Spark has been
engineered from the ground up for performance, exploiting in-memory
computing and other optimizations to provide powerful analysis on very
large data sets.

Spark provides numerous performance-oriented features, including:

* ability to cache datasets in memory for interactive data analysis
* abstraction
* integration with a host of data sources
* very fast data analysis
* easy to use APIs for operating on large datasets, including numerous
  operators for transforming and manipulating data, in Java, Scala,
  Python, and other languages
* numerous high level libraries, including support for machine learning,
  streaming, and graph processing
* scalability to thousands of nodes

Spark applications consist of a driver program and some number of worker
programs running on cluster nodes. The data sets (RDDs) used by the
application are distributed across the worker nodes.

## Spark Terminology

Splice Machine launches Spark queries on your cluster as Spark *jobs*,
each of which consists of some number of *stages*. Each stage then runs
a number of *tasks*, each of which is a unit of work that is sent to an
*executor*.

The table below contains a brief glossary of the terms you'll see when
using the Splice Machine Database Console:

<table summary="Glossary of Spark terms.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Term</th>
                        <th>Definition</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Action</strong></td>
                        <td>A function that returns a value to the driver after running a computation on an <em>RDD</em>.
Examples include <code>save</code> and <code>collect</code> functions.</td>
                    </tr>
                    <tr>
                        <td><strong>Application</strong></td>
                        <td>
                            <p class="noSpaceAbove">A user program built on Spark. Each application consists of a <em>driver program</em> and a number of <em>executors</em> running on your cluster.</p>
                            <p>An application creates <em>RDDs</em>, transforms those RDDs, and runs <em>actions</em> on them. These result in a directed acyclic graph (DAG) of operations, which is compiled into a set of <em>stages</em>. Each stage consists of a number of <em>tasks</em>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>DAG</strong></td>
                        <td>A <strong>D</strong>irected <strong>A</strong>cyclic <strong>G</strong>raph of the operations to run on an RDD. </td>
                    </tr>
                    <tr>
                        <td><strong>Driver program</strong></td>
                        <td>This is the process that's running the <code>main()</code> function of the application and creating the <code>SparkContext</code> object, which sends jobs to <em>executors</em>.</td>
                    </tr>
                    <tr>
                        <td><strong>Executor</strong></td>
                        <td>A process that is launched (by the driver program) for an <em>application</em> on a <em>worker node</em>. The executor launches <em>tasks</em> and maintains data for them.</td>
                    </tr>
                    <tr>
                        <td><strong>Job</strong></td>
                        <td>A parallel computation consisting of multiple <em>tasks</em> that gets spawned in response to a Spark <em>action</em>.</td>
                    </tr>
                    <tr>
                        <td><strong>Partition</strong></td>
                        <td>A subset of the elements in an <em>RDD</em>. Partitions define the unit of parallelism; Spark processes elements within a partition in sequence and multiple partitions in parallel.</td>
                    </tr>
                    <tr>
                        <td><strong>RDD</strong></td>
                        <td>A <strong>R</strong>esilient <strong>D</strong>istributed <strong>D</strong>ataset. This is the core programming abstraction in Spark, consisting of a fault-tolerant collection of elements that can be operated on in parallel.</td>
                    </tr>
                    <tr>
                        <td><strong>Stage</strong></td>
                        <td>
                            <p>A set of tasks that run in parallel. The stage creates a <em>task</em> for each partition in an <em>RDD</em>, serializes those tasks, and sends those tasks to <em>executors</em>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Task</strong></td>
                        <td>The fundamental unit of work in Spark; each task fetches input, executes operations, and generates output.</td>
                    </tr>
                    <tr>
                        <td><strong>Transformation</strong></td>
                        <td>A function that creates a new <em>RDD</em> from an existing <em>RDD</em>.</td>
                    </tr>
                    <tr>
                        <td><strong>Worker node</strong></td>
                        <td>A cluster node that can run application code.</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [About the Splice Machine Database Console](tutorials_dbconsole_intro.html)
* [User Interface Features of the Splice Machine Database
  Console](tutorials_dbconsole_features.html)
* [Managing Queries with the Console](tutorials_dbconsole_queries.html)
* [Using Spark Libraries with Splice
  Machine](developers_fundamentals_sparklibs.html)
* The Apache Spark web site, [spark.apache.org][1]{: target="_blank"}

 

</div>
</section>



[1]: http://spark.apache.org/
