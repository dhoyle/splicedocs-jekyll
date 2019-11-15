---
title: Ingesting Data in a Spark App
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_ingest_sparkapp.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Data in a Spark App

The *Splice Machine Native Spark DataSource* allows you to directly insert data into your database from a Spark DataFrame, which provides great performance by eliminating the need to serialize and deserialize the data. You can write Spark programs that take advantage of the Native Spark DataSource, or you can use it in your Zeppelin notebooks.

This topic presents two examples of using the Splice Machine Native Spark DataSource to load data with Spark into a table in your database:

* [Using the Native Spark DataSource to Ingest Data in Zeppelin](#loadzep)
* [Using the Native Spark DataSource with spark-submit to Ingest Data](#loadsubmit)

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html), in this Best Practices chapter.


## Using the Native Spark DataSource to Ingest Data in Zeppelin  {#loadzep}

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

5.  __Verify that All Went Well:__

    ```
    %splicemachine
    select * from mySchema.carsTbl;

    NUMBER      MAKE            MODEL
    1           Toyota          Camry
    2           Honda           Accord
    3           Subaru          Impreza
    4           Chevy           Volt
    ```
    {: .Example}

## Using the Native Spark DataSource with spark-submit to Ingest Data  {#loadsubmit}

This section presents a discussion of and sample code for a standalone program submitted with `spark-submit` that uses the Splice Machine Native Spark DataSource to ingest data into a table.

All of the files required to build and run this program are available here: [./examples/SparkAppSubmit.tar.gz](./examples/SparkAppSubmit.tar.gz)
{: .noteNote}

We show you how to create and run this example in these subsections:

1. [The Submit Script](#submitscript) presents the `spark-submit.sh` script and describes the variables that you need to modify before running the script.
2. [The Example Code](#examplecode) section presents the code for our example program that ingests data using the Splice Machine Native Spark DataSource.
3. [Build and Run the Example Program](#runsubmitexample) walks you through building and running the sample code.


### The Submit Script  {#submitscript}

You can use the supplied `spark-submit.sh` script to run a Spark program. Here's a version of this script:


```
#!/bin/bash
export SPARK_KAFKA_VERSION=0.10

TargetTable=LINEITEM
TargetSchema=TPCH
RSHostName=srv132
SpliceConnectPort=1527
UserName=yourDBUserId
UserPassword=yourDBPassword
HdfsHostName=srv131
HdfsPort=8020
CsvFilePath=/TPCH/1/lineitem

spark2-submit \
--conf "spark.dynamicAllocation.enabled=false" \
--conf "spark.streaming.stopGracefullyOnShutdown=true" \
--conf "spark.streaming.concurrentJobs=1" \
--conf "spark.task.maxFailures=2" \
--conf "spark.driver.memory=4g" \
--conf "spark.driver.cores=1" \
--conf "spark.driver.extraJavaOptions=-verbose:class" \
--conf "spark.executor.extraJavaOptions=-verbose:class" \
--conf "spark.executor.extraClassPath=/etc/hadoop/conf/:/etc/hbase/conf/:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*" \
--conf "spark.driver.extraClassPath=/etc/hadoop/conf/:/etc/hbase/conf/:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*" \
--name "Spark Adapter Ingest" \
--jars "splicemachine-cdh5.12.2-2.2.0.cloudera2_2.11-2.7.0.1908.jar" \
--class com.splicemachine.example.Main \
--master yarn --deploy-mode cluster --num-executors 10 --executor-memory 10G --executor-cores 4 \ target/example-1.0-SNAPSHOT.jar \
$TargetTable $TargetSchema $RSHostName $SpliceConnectPort $UserName $UserPassword $HdfsHostName $HdfsPort $CsvFilePath
```
{: .ShellCommand}

Before submitting your Spark program with this script, you need to modify some of the values (at least the highlighted) at the top of the script; for our sample program, these are the values, which are summarized in the table below:
{: .spaceAbove}

<div class="PreWrapper"><pre class="ShellCommand">
TargetTable=LINEITEM
TargetSchema=TPCH
RSHostName=<span class="HighlightedCode">srv132</span>
SpliceConnectPort=1527
UserName=<span class="HighlightedCode">yourDBUserId</span>
UserPassword=<span class="HighlightedCode">yourDBPassword</span>
HdfsHostName=<span class="HighlightedCode">srv131</span>
HdfsPort=8020
CsvFilePath=<span class="HighlightedCode">/TPCH/1/lineitem</span>
</pre>
</div>

<table>
    <caption class="tblCaption">Table 1: spark-submit script variables</caption>
    <col />
    <col />
    <thead>
        <tr>
            <th>Script Variable</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">TargetTable</td>
            <td>The name of the table in your Splice Machine database into which you are importing data.</td>
        </tr>
        <tr>
            <td class="CodeFont">TargetSchema</td>
            <td>The name of the schema in your database to which the table belongs.</td>
        </tr>
        <tr>
            <td class="CodeFont">RSHostName</td>
            <td>The region server for connecting to your  database.</td>
        </tr>
        <tr>
            <td class="CodeFont">SpliceConnectPort</td>
            <td>The port number for connecting to your database.</td>
        </tr>
        <tr>
            <td class="CodeFont">UserName</td>
            <td>The user name for connecting to your database.</td>
        </tr>
        <tr>
            <td class="CodeFont">UserPassword</td>
            <td>The user password for connecting to your database.</td>
        </tr>
        <tr>
            <td class="CodeFont">HdfsHostName</td>
            <td>The region server for connecting to HDFS.</td>
        </tr>
        <tr>
            <td class="CodeFont">HdfsPort</td>
            <td>The port number for connecting to HDFS.</td>
        </tr>
        <tr>
            <td class="CodeFont">CsvFilePath</td>
            <td>The HDFS path to the CSV file you're importing.</td>
        </tr>
    </tbody>
</table>

### The Example Code  {#examplecode}

This section presents a simple example of ingesting data from a CSV file into a database table with the Splice Machine Native Spark DataSource.

This code does the following:

1.  Configures variables from the parameters in the `spark-submit.sh` script.
2.  Creates a Spark session.
3.  Creates a JDBC URL for connecting to your Splice Machine database.
4.  Creates a Splice Machine Native Spark DataSource context (`splicemachineContext`) with that URL.
5.  Creates a Spark DataFrame from the CSV file that you're importing.
6.  Inserts the data from the DataFrame into your database.

Here's the code:

```
package com.splicemachine.example;

import org.apache.hadoop.security.UserGroupInformation;
import org.apache.spark.SparkConf;
import java.net.URL;
import java.net.URLClassLoader;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.Row;
import java.io.IOException;

import com.splicemachine.derby.impl.SpliceSpark;
import com.splicemachine.spark.splicemachine.*;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;
import org.apache.spark.sql.types.Metadata;
import org.apache.spark.sql.Dataset;


public class Main {

    public static void main(String[] args) throws Exception {

        if(args.length < 9) {
            System.err.println("Incorrect number of params ");
            return;
        }

        final String inTargetTable = args[0];
        final String inTargetSchema = args[1];
        final String inHostName = args[2];
        final String inHostPort = args[3];
        final String inUserName = args[4];
        final String inUserPassword = args[5];
        final String inHDFSHostName = args[6];
        final String inHDFSPort = args[7];
        final String inCSVFilePath = args[8];

        SparkConf conf = new SparkConf();
        SparkSession spark = SparkSession.builder().appName("Ingest").config(conf).getOrCreate();
        SpliceSpark.setContext(spark.sparkContext());

        // Construct a connection string
        String dbUrl = "jdbc:splice://" + inHostName + ":" + inHostPort
                        + "/splicedb;user=" + inUserName
                        + ";" + "password=" + inUserPassword;

        // Create a SplicemachineContext based on the provided DB connection
        SplicemachineContext splicemachineContext = new SplicemachineContext(dbUrl);

        // Set target table name and schema name
        String SPLICE_TABLE_ITEM = inTargetSchema + "." + inTargetTable;

        StructType schema = splicemachineContext.getSchema(SPLICE_TABLE_ITEM);

        // Create a DataFrame from a specified file
        Dataset<Row> df = spark.read().format("com.databricks.spark.csv").option(
                    "delimiter", "|").schema(schema)
                    .load("hdfs://" + inHDFSHostName + ":" + inHDFSPort + inCSVFilePath);

        splicemachineContext = new SplicemachineContext(dbUrl);
        // Import the data
        splicemachineContext.insert(df, SPLICE_TABLE_ITEM);
    }
}
```
{: .Example}


### Build and Run the Example Program  {#runsubmitexample}

You can download, build, and run this example program as follows:

1.  __Click this link to download the example tarball:__ [`./examples/SparkAppSubmit.tar.gz`](./examples/SparkAppSubmit.tar.gz)
2.  __Build the program with this command:__

    ```
    mvn clean install
    ```
    {: .ShellCommand}
3.  __Copy the `lineitem.csv` file to HDFS. For example:__

    ```
    hadoop fs -copyFromLocal lineitem.csv /TPCH/1/lineitem
    ```
    {: .ShellCommand}
4.  __Modify the `spark-submit.sh` script for your environment. The values you may need to modify are at the top of the script:__

    To run this example, make these changes:

    a.  Specify which region server and port to connect to. For example, to run on the standalone version of Splice Machine, you could use:

    ```
    RSHostName=localhost
    SpliceConnectPort=1527
    ```
    {: .ShellCommand}

    b.  Specify the user name and password for the connection. For example:

    ```
    UserName=myUserId
    UserPassword=myPassword
    ```
    {: .ShellCommand}

    c.  Specify the location of the csv file in HDFS. For example:

    ```
    HdfsHostName=srv136
    HdfsPort=8020
    CsvFilePath=/TPCH/1/lineitem/lineitem.csv
    ```
    {: .ShellCommand}
5.  __Connect to your Splice Machine database.__

6.  __Create the `LINEITEM` table in your database:__

    ```
    CREATE TABLE LINEITEM (
      L_ORDERKEY      INTEGER NOT NULL,
      L_PARTKEY       INTEGER NOT NULL,
      L_SUPPKEY       INTEGER NOT NULL,
      L_LINENUMBER    INTEGER NOT NULL,
      L_QUANTITY      DECIMAL(15, 2),
      L_EXTENDEDPRICE DECIMAL(15, 2),
      L_DISCOUNT      DECIMAL(15, 2),
      L_TAX           DECIMAL(15, 2),
      L_RETURNFLAG    CHAR(1),
      L_LINESTATUS    CHAR(1),
      L_SHIPDATE      DATE,
      L_COMMITDATE    DATE,
      L_RECEIPTDATE   DATE,
      L_SHIPINSTRUCT  CHAR(25),
      L_SHIPMODE      CHAR(10),
      L_COMMENT       VARCHAR(44)--,
      PRIMARY KEY (L_ORDERKEY, L_LINENUMBER)
    );
    ```
    {: .Example}
7.  __Run the `spark-submit.sh` script from the command line to import the data from the `lineitem.csv` file into the `LINEITEM` table in your database.__


</div>
</section>
