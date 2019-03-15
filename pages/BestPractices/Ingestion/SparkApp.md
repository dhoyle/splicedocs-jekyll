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

<strong>+++++++++++++ WE NEED A SIMPLER EXAMPLE, HOPEFULLY IN PYTHON +++++++++++++</strong>

This section presents a discussion of and sample code for a standalone programs submitted with `spark-submit` that use the Splice Machine Native Spark DataSource to ingest data into a table.

There are two aspects to getting your Spark program to run with spark-submit; you need to:

1. Write the code for your program
2. Modify any configuration options in our spark-submit.sh script

The sections below include the code for both aspect.

### Example: Import CSV with Spark-Submit Program  {#importcode}

Here's a sample Spark program in Java for importing a CSV file into a Splice Machine database table:

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

        if(args.length < 10) {
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
        final boolean bulkImport = args[9].compareToIgnoreCase("true")==0?true:false;

        String inKbrPrincipal = System.getProperty("spark.yarn.principal");
        String inKbrKeytab = System.getProperty("spark.yarn.keytab");

        ClassLoader cl = ClassLoader.getSystemClassLoader();

        URL[] urls = ((URLClassLoader)cl).getURLs();

        for(URL url: urls){
            System.out.println(url.getFile());
        }
        UserGroupInformation ugi = UserGroupInformation.getCurrentUser();
        System.out.println("Logged in as " + ugi);
        System.out.println("Has credentials " + ugi.hasKerberosCredentials());
        System.out.println("credentials " + ugi.getCredentials());

        System.out.println(inKbrPrincipal);
        System.out.println(inKbrKeytab);


        doWork(inTargetTable, inTargetSchema, inHostName, inHostPort, inUserName, inUserPassword, inKbrPrincipal, inKbrKeytab, inHDFSHostName, inHDFSPort, inCSVFilePath, bulkImport);
    }

    private static void doWork(String inTargetTable, String inTargetSchema, String inHostName, String inHostPort, String inUserName, String inUserPassword, String inKbrPrincipal, String inKbrKeytab, String inHDFSHostName, String inHDFSPort, String inCSVFilePath, boolean bulkImport) throws IOException, InterruptedException {

        // Construct schema for the table
        StructType schema = new StructType(new StructField [] {
                new StructField("L_ORDERKEY",DataTypes.LongType, false, Metadata.empty()),
                new StructField("L_PARTKEY",DataTypes.IntegerType, false, Metadata.empty()),
                new StructField("L_SUPPKEY",DataTypes.IntegerType, false, Metadata.empty()),
                new StructField("L_LINENUMBER",DataTypes.IntegerType, false, Metadata.empty()),
                new StructField("L_QUANTITY",DataTypes.DoubleType, true, Metadata.empty()),
                new StructField("L_EXTENDEDPRICE",DataTypes.DoubleType, true, Metadata.empty()),
                new StructField("L_DISCOUNT",DataTypes.DoubleType, true, Metadata.empty()),
                new StructField("L_TAX",DataTypes.DoubleType, true, Metadata.empty()),
                new StructField("L_RETURNFLAG",DataTypes.StringType, true, Metadata.empty()),
                new StructField("L_LINESTATUS",DataTypes.StringType, true, Metadata.empty()),
                new StructField("L_SHIPDATE",DataTypes.DateType, true, Metadata.empty()),
                new StructField("L_COMMITDATE",DataTypes.DateType, true, Metadata.empty()),
                new StructField("L_RECEIPTDATE",DataTypes.DateType, true, Metadata.empty()),
                new StructField("L_SHIPINSTRUCT",DataTypes.StringType, true, Metadata.empty()),
                new StructField("L_SHIPMODE",DataTypes.StringType, true, Metadata.empty()),
                new StructField("L_COMMENT",DataTypes.StringType, true, Metadata.empty())
        });

        // Create SparkContext and pass to splice
        SparkConf conf = new SparkConf();
        SparkSession spark = SparkSession.builder().appName("Ingest").config(conf).getOrCreate();
        SpliceSpark.setContext(spark.sparkContext());

        // Construct a connection string
        String dbUrl = "jdbc:splice://" + inHostName + ":" + inHostPort + "/splicedb;user=" + inUserName + ";" + "password=" + inUserPassword;

        // Create a SplicemachineContext based on the provided DB connection
        SplicemachineContext splicemachineContext = new SplicemachineContext(dbUrl);

        // Set target table name and schema name
        String SPLICE_TABLE_ITEM = inTargetSchema + "." + inTargetTable;

        // Create a DataFrame from a specified file
        Dataset<Row> df = spark.read().format("com.databricks.spark.csv").option("delimiter", "|").schema(schema)
                .load("hdfs://" + inHDFSHostName + ":" + inHDFSPort + inCSVFilePath);

        if (bulkImport) {
            // bulk import data to the table
            scala.collection.mutable.Map bulkImportOptions = new scala.collection.mutable.HashMap();
            bulkImportOptions.put("useSpark","true");
            bulkImportOptions.put("skipSampling", "true");
            bulkImportOptions.put("bulkImportDirectory", "/hbase/load");
            bulkImportOptions.put("statusDirectory", "/BAD");
            splicemachineContext.bulkImportHFile(df, SPLICE_TABLE_ITEM, bulkImportOptions);
        }
        else {
            df = df.repartition(df.toJavaRDD().getNumPartitions());
            // sample data, split the table and import data
            splicemachineContext.insert(df, SPLICE_TABLE_ITEM, 0.00001);
        }

        String sql = "select * from " + SPLICE_TABLE_ITEM;
        Dataset ds = splicemachineContext.internalDf(sql);
        ds.printSchema();
        System.out.println("row count = " + ds.count());
    }
}
```
{: .Example}

#### Spark Submit Shell Script  {#importscript}

<strong>+++++++++++++ WE NEED TO HIGHLIGHT/EXPLAIN WHAT PARTS OF THIS  CUSTOMER MUST UPDATE +++++++++++++</strong>

Here's the `spark-submit` shell script for submitting the above sample import program:

```
#!/bin/bash
export SPARK_KAFKA_VERSION=0.10

TargetTable=LINEITEM
TargetSchema=TPCH
RSHostName=srv096
SpliceConnectPort=1527
UserName=user5
UserPassword=splice
KrbPrincipal=user5@SPLICEMACHINE.COLO
KrbKeytab=/tmp/user5.keytab
HdfsHostName=srv091
HdfsPort=8020
CsvFilePath=/TPCH/1/lineitem

spark2-submit --conf "spark.dynamicAllocation.enabled=false" \
--conf "spark.streaming.stopGracefullyOnShutdown=true" \
--conf "spark.streaming.kafka.maxRatePerPartition=500" \
--conf "spark.streaming.kafka.consumer.cache.enabled=false" \
--conf "spark.streaming.concurrentJobs=1" \
--conf "spark.task.maxFailures=2" \
--conf "spark.driver.memory=4g" \
--conf "spark.driver.cores=1" \
--conf "spark.kryoserializer.buffer=1024" \
--conf "spark.kryoserializer.buffer.max=2047" \
--conf "spark.io.compression.codec=org.apache.spark.io.SnappyCompressionCodec" \
--conf "spark.driver.extraJavaOptions=-Djava.security.krb5.conf=/etc/krb5.conf -Dspark.yarn.principal=user5@SPLICEMACHINE.COLO -Dspark.yarn.keytab=/tmp/user5.keytab -Dlog4j.configuration=log4j-spark.properties -XX:+UseCompressedOops -XX:+UseG1GC -XX:+PrintFlagsFinal -XX:+PrintReferenceGC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintAdaptiveSizePolicy -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:InitiatingHeapOccupancyPercent=35 -XX:ConcGCThreads=12" \
--conf "spark.executor.extraJavaOptions=-Djava.security.krb5.conf=krb5.conf -Dlog4j.configuration=log4j-spark.properties -XX:+UseCompressedOops -XX:+UseG1GC -XX:+PrintFlagsFinal -XX:+PrintReferenceGC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintAdaptiveSizePolicy -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:InitiatingHeapOccupancyPercent=35 -XX:ConcGCThreads=12" \
--conf "spark.executor.extraClassPath=/etc/hadoop/conf/:/etc/hbase/conf/:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*" \
--conf "spark.driver.extraClassPath=/etc/hadoop/conf/:/etc/hbase/conf/:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*" \
--files "/etc/spark/conf/log4j.properties,/etc/krb5.conf"  \
--keytab "/tmp/user5.keytab"  \
--principal "user5@SPLICEMACHINE.COLO" \
--name "Ingest" \
--jars "splicemachine-cdh5.12.2-2.2.0.cloudera2_2.11-2.5.0.1845-SNAPSHOT.jar" \
--class com.splicemachine.example.Main \
--master yarn --deploy-mode cluster --num-executors 10 --executor-memory 10G --executor-cores 4 target/example-1.0-SNAPSHOT.jar \
$TargetTable $TargetSchema $RSHostName $SpliceConnectPort $UserName $UserPassword $HdfsHostName $HdfsPort $CsvFilePath true
```
{: .Example}

</div>
</section>
