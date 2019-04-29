---
title: Splice Machine Native Spark DataSource Overview
summary: Overview of using the Splice Machine Native Spark DataSource.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_sparkadapter_intro.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Overview of the Splice Machine Native Spark DataSource

This topic provides general information about the *Splice Machine Native Spark DataSource* (aka the Splice Machine Spark Adapter), in these subsections:
* [Native Spark DataSource Overview](#about)
* [Connecting with the Native Spark DataSource](#connect)
* [Database Permissions and the Native Spark DataSource](#prereq)
* [Accessing Database Objects with Internal Access](#access)

The other topics in this chapter provide additional information about the Native Spark DataSource:

* [Native Spark DataSource API](bestpractices_sparkadapter_api.html) provides reference information for the Native Spark DataSource API methods.
* [Native Spark DataSource Examples](bestpractices_sparkadapter_submit.html) includes examples that show you how to launch a Spark app with our *Spark Submit* script, and how to use the Native Spark DataSource interactively, with the *Spark Shell*.
* [Using Our Native Spark DataSource with Zeppelin](bestpractices_sparkadapter_submit.html) presents an example of using our Native Spark DataSource in a Zeppelin notebook.

## Native Spark DataSource Overview  {#about}

The Splice Machine Native Spark DataSource, which is also referred to as the *Spark Adapter*, allows you to directly connect Spark DataFrames and Splice Machine database tables. You can efficiently insert, upsert, select, update, and delete data in your Splice Machine tables directly from Spark in a transactionally consistent manner. With the Spark Adapter, transfers of data between Spark and your database are completed without serialization/deserialization, which generates tremendous performance boosts over traditional *over-the-wire* (sequentially over a connection) transfers.

To use the Spark Adapter in your code, you simply instantiate a `SplicemachineContext` object in your Spark code. You can run Spark applications that interface with your Splice Machine database interactively in the Spark shell or Zeppelin notebooks, or you can launch a Spark app by using our Spark Submit script. One use of the Adapter is to ingest data into your Splice Machine database directly from a Spark DataFrame.

The Native DataSource allows data scientists to bypass the limitations of the SQL-based JDBC interface in favor of the more scalable and powerful Spark DataFrame API, making it possible for them to operate on data at scale and ingest real-time streaming data with outstanding performance. You can craft applications that use Spark and our Native Spark DataSource in Scala, Python, and Java. Note that you can use the Native Spark DataSource in the Splice Machine [*ML Manager*](mlmanager_intro.html) and *Zeppelin Notebook* interfaces.

## Why Use the Native DataSource?

The primary reason for using the Native DataSource is that it provides dramatic performance improvements for large scale data operations; this is because the DataSource works directly on native DataFrames and RDDs, thus eliminating the need to serialize data. Spark is optimized to work on DataFrames, which is a distributed collection of data (an RDD) organized into named columns, with a schema that specifies data types, that is designed to support efficiently operating on scalable, massive datasets.

The Splice Machine DataSource is native to Spark, which means that it operates directly on these DataFrames and in the same Spark executors that your programs are using to analyze or transform the data. Instead of accessing, inserting, or manipulating data one record at a time over a serialized connection, you can use the Splice Machine Native Spark DataSource to pull the contents of an entire DataFrame into your database, and to push database query results into a DataFrame.

Splice Machine has observed 100x performance increases compared to using JDBC for operations such as inserting millions of records in a database! For example, a typical web application might use a React frontend with a Node backend that accesses information in a database. When a customer refreshes the app dashboard, the app uses a JDBC connection to query the database, pulling information out one record at a time to populate the screen. The results of each query are serialized (turned into a string of data), then sent over a network connection to the app, and then displayed on the customer’s screen.

When you use the Splice Machine Native Spark DataSource, the contents of the database table are typically sitting in a DataFrame in memory that resides on the same Spark executor that’s performing the query. The query takes place in memory, and there’s no need to serialize or stream the results over a wire. Similarly, when the app sends updates to the database, the data is inserted into the database directly from the DataFrame. As a result, a great deal of overhead is eliminated, and performance gains can be remarkable.

### Leveraging Developer Agility

The Native Spark DataSource provides support for the development tools of the Data Scientists and Data Engineers alike. Data Scientists and Data Engineers typically access Spark contexts to operate on DataFrames. Spark provides a powerful set of transformations and actions to the developer to manipulate large datasets efficiently plus additional libraries for machine learning and streaming.

With Splice Machine’s native Spark DataSource, you can perform transactional database operations directly on DataFrames and receive DataFrames as result sets of arbitrary ANSI-SQL queries. This means that Splice Machine’s full transactional capabilities are available to developers without requiring them to change the way they do data engineering and data science. We’ll see examples of this below.

</div>
</section>
