---
title: Ingesting Data in a Spark App
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_sparkapp.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Data in a Spark App

This topic describes how to use the Splice Machine Native Spark DataSource to load data with Spark into a table in your database.

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html), in this Best Practices chapter.


## About the Splice Machine Native Spark DataSource

The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark programs that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

## Notebook Example of Loading Data with the Native Spark DataSource

*********OTHER EXAMPLES IN ZEPP***************

This section presents a simple Zeppelin notebook example, written in Scala, of moving data between a Spark DataFrame and a Splice Machine table:

1.  __Create the context:__

    Using the `%spark` interpreter in Zeppelin, create an instance of the `SplicemachineContext` class; this class interacts with your Splice Machine cluster in your Spark executors, and provides the methods that you can use to perform operations such as directly inserting into your database from a DataFrame:

    ```
    %spark
    import com.splicemachine.spark.splicemachine._
    import com.splicemachine.derby.utils._

    val JDBC_URL = "jdbc:splice://<yourJDBCUrl>:1527/splicedb;user=<yourUserId>;password=<yourPassword>"
    val splicemachineContext = new SplicemachineContext(JDBC_URL)
    ```
    {: .Example}

2.  __Create a DataFrame in Scala and populate it:__

    Again using the `%spark` interpreter in Zeppelin, we create a DataFrame and populate it with a little data:

    ```
    %spark
    val carsDF = Seq(
       (1, "Toyota", "Camry"),
       (2, "Honda", "Accord"),
       (3, "Subaru", "Impreza"),
       (4, "Chevy", "Volt")
    ).toDF("NUMBER", "MAKE", "MODEL")
    ```
    {: .Example}

    Though this DataFrame contains only a very small amount of data, the code in this example can be scaled to DataFrames of any size.
    {: .spaceAbove}

3.  __Create a Table in your Splice Machine Database:__

    Now we'll create a simple table in our database, using the `%splicemachine` interpreter in Zeppelin:

    ```
    %splicemachine
    create table mySchema.carsTbl ( number int primary key,
                                    make  varchar(20),
                                    model varchar(20) );
    ```
    {: .Example}

4.  __Populate the Database Table from the DataFrame:__

    To ingest all of the data in the DataFrame into your database, simply use the `Insert` method of the Splice Machine Native Spark DataSource:

    ```
    %spark
    splicemachineContext.insert( carsDF, "mySchema.carsTbl");
    ```
    {: .Example}

    Ingesting data in this way is extremely performant because it requires no serialization or deserialization and works with any Spark DataFrame. You can also use the Native Spark DataSource to quickly query your database, and to update or delete records.
    {: .noteImportant}



</div>
</section>
