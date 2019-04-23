---
title: Ingesting Streaming Data
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_ingest_streaming.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Streaming Data
This topic presents an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table via `spark-submit`. This topic includes the following sections:

* [About Ingesting Streaming Data](#streaming)
* [Using the Native Spark DataSource to Ingest Streaming Data](#streamsubmit)
* [Running the App](#runcode)

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html), in this Best Practices chapter.

## About Ingesting Streaming Data  {#streaming}

Internet of Things (IoT) applications need to continously ingest data, process that data, make decisions, and then act. This decision-making pattern typically starts with an ingestion phase of streaming raw data from the edge to a storage medium; then data engineers and data scientists iteratively wrangle the data to get it into a form that can be used downstream by learning, planning, and operational systems.

The application documented in this topic shows you how to ingest streams of IoT data into Splice Machine tables. This app streams weather data from a public weather data source into a Splice Machine table that you can then use for any purpose, such as a Machine Learning application that needs to consider weather forecasts to predict critical timing of shipments.

Our demonstration app sets up a Kafka producer that streams data from a public weather service and a Kafka consumer that parses the data, transforms it into Spark DataFrames, and then uses our Native Spark DataSource to insert each DataFrame into a Splice Machine database table.

## Using the Native Spark DataSource to Ingest Streaming Data  {#streamsubmit}

This section presents a sample Spark application that uses Kafka to both produce and consume a stream of real-time weather data. Coding this example involves these steps and components, each of which is described in a subsection below:

1. [Create a table](#createtable) for the data in your Splice Machine database.
2. [Create a Kafka topic](#createtopic) for the weather data.
3. [Create a Kafka producer](#createproducer) to stream data.
4. [Create a Spark app](#createapp) that uses Kafka to consume the stream and uses the Splice Machine Native Spark DataSource to insert the data into your database table.

All of the files required to build and run this program are available here: [./examples/SparkStreamingSubmit.tar.gz](./examples/SparkStreamingSubmit.tar.gz)
{: .noteNote}

### 1. Create a Table for the Data in Your Splice Machine Database  {#createtable}

Use the following statement in your Splice Machine database to create a table :

```
CREATE TABLE splice.weather (
    id VARCHAR(100),
    location VARCHAR(20),
    temperature FLOAT,
    humidity FLOAT,
    time TIMESTAMP
    );
```
{: .Example}

### 2. Create a Kafka Topic for the Weather Data  {#createtopic}

Create your Kafka topic with a command like this:

```
bin/kafka-topics --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic weather
```

### 3. Create a Kafka Producer to Stream Data  {#createproducer}

This section presents our sample code to produce a stream of weather data. The fully commented version of this code is available in  [./examples/SparkStreamingSubmit.tar.gz](./examples/SparkStreamingSubmit.tar.gz).


Here's the main code for our Kafka producer:

```
package com.splicemachine.sample;

import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class KafkaTopicProducer {

    /*  Static list of locations  */
    public static final String[] locations = {
            "Alachua", "Baker", Bay", Bradford", Brevard", Broward", Calhoun", Charlotte",
            Citrus", Clay", Collier", Columbia", Desoto", Dixie", Duval", Escambia", Flagler",
            Franklin", Gadsden", Gilchrist", Glades", Gulf", Hamilton", Hardee", Hendry",
            Hernando", Highlands", Hillsborough", Holmes", Indian River", Jackson", Jefferson",
            Lafayette", Lake", Pinellas", Polk", Putnam", St. Johns", St. Lucie", Santa Rosa",
            Sarasota", Seminole", Sumter", Suwannee", Taylor", Union", Volusia", Wakulla",
            Walton", Washington", Lee", Leon", Levy", Liberty", Madison", Manatee", Marion",
            Martin", Miami-Dade", Monroe", Nassau", Okaloosa", Okeechobee", Orange", Osceola",
            Palm Beach",  Pasco" };
    Random r = new Random();
    DecimalFormat df = new DecimalFormat("#.##");
    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
    private String server = null;
    private long totalEvents = 1;
    private String topic = null;

    /* Adds records to a Kafka queue */
    public static void main(String[] args) throws Exception {
        KafkaTopicProducer kp = new KafkaTopicProducer();
        kp.server = args[0];
        kp.topic = args[1];
        kp.totalEvents = Long.parseLong(args[2]);
        kp.generateMessages();

    }
```
{: .Example}

Here's the code that sends messages to the Kafka queue:
{: .spaceAbove}

```
    /* Sends messages to the Kafka queue. */
    public void generateMessages() {
        df.setRoundingMode(RoundingMode.CEILING);

        //Define the properties for the Kafka Connection
        Properties props = new Properties();
        props.put("bootstrap.servers", server); //kafka server
        props.put("acks", "all");
        props.put("retries", 0);
        props.put("batch.size", 16384);
        props.put("linger.ms", 1);
        props.put("buffer.memory", 33554432);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");


        //Create a KafkaProducer using the Kafka Connection properties
        KafkaProducer<String, String> producer = new KafkaProducer<>(props);
        long nEvents = 0;

        //Loop through for the number of messages you want to put on the Queue
        for (nEvents = 0; nEvents < totalEvents; nEvents++) {
            String id = "A_" + nEvents;

            String record = id +"," + getLocation() + "," + formatDouble(getTemperature())
                               + "," + formatDouble(getHumidity()) + ","
                               + new Timestamp(System.currentTimeMillis()).toString();
            producer.send(new ProducerRecord<String, String>(topic, id, record));
        }
        //Flush and close the queue
        producer.flush();
        producer.close();
        //display the number of messages that aw
        System.out.println("messages pushed:" + nEvents);
    }
```
{: .Example}

And here are the *helper* functions:
{: .spaceAbove}

```
    /* Get a randomly generated temperature value */
    public double getTemperature() {
        return 9.0 + (95.5 - 9.0) * r.nextDouble();
    }

    /* Get a randomly generated humidy value */
    public double getHumidity() {
        return 54.8 + (90.7 - 54.8) * r.nextDouble();
    }

    /* Format the double to 2 decimal places */
    public String formatDouble(double dbl) {
        return df.format(dbl);
    }

    /* Get a randomly generated value for location */
    public String getLocation() {
        int max = locations.length;
        int randomNum = r.nextInt((max - 0)) + 0;
        return locations[randomNum];
    }

}
```
{: .Example}
<br />

### 4. Create App to Consume the Stream and Insert Data into Your Table  {#createapp}

This section presents our sample app that consumes the data stream produced by our Kafka producer and inserts it into our Splice Machine database table.

The `main` body of this app uses Kafka to consume entries in the stream into a Spark RDD and invokes the `doWork` method to process the stream entries. The `doWork` method:

* creates a Spark session
* connects to your Splice Machine database
* maps stream entries into a Spark DataFrame
* uses the `insert` function of the Splice Machine Native Spark DataSource to insert the data, in real-time, into the table.

This code is available in  [./examples/SparkStreamingSubmit.tar.gz](./examples/SparkStreamingSubmit.tar.gz).
{: .noteNote}

Here are the package and class import statements for the program:

```
package com.splicemachine.sample;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.sql.*;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.Row;
import java.io.IOException;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import com.splicemachine.derby.impl.SpliceSpark;
import com.splicemachine.spark.splicemachine.*;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import java.util.*;
import org.apache.spark.streaming.api.java.*;
import org.apache.spark.streaming.kafka010.*;
import org.apache.spark.streaming.*;
import org.apache.kafka.common.serialization.StringDeserializer;
import scala.Tuple2;
```
{: .Example}

Here's the main Kafka consumer code:
{: .spaceAbove}

```
public class KafkaTopicConsumer {

    public static void main(String[] args) throws Exception {

        if(args.length < 7) {
            System.err.println("Incorrect number of params ");
            return;
        }
        final String inTargetTable = args[0];
        final String inTargetSchema = args[1];
        final String inHostName = args[2];
        final String inHostPort = args[3];
        final String inUserName = args[4];
        final String inUserPassword = args[5];
        final String kafkaBroker = args[6];
        final String kafkaTopicName = args[7];

        // Initalize Kafka config settings
        Properties props = new Properties();
        SparkConf conf = new SparkConf().setAppName("stream");
        JavaStreamingContext jssc = new JavaStreamingContext(conf, Durations.seconds(1));

        Map<String, Object> kafkaParams = new HashMap<>();
        kafkaParams.put("bootstrap.servers", kafkaBroker);
        kafkaParams.put("key.deserializer", StringDeserializer.class);
        kafkaParams.put("value.deserializer", StringDeserializer.class);
        kafkaParams.put("group.id", "test");
        kafkaParams.put("auto.offset.reset", "latest");
        kafkaParams.put("enable.auto.commit", false);
        Collection<String> topics = Arrays.asList(kafkaTopicName);

        JavaInputDStream<ConsumerRecord<String, String>> stream =
                KafkaUtils.createDirectStream(
                        jssc,
                        LocationStrategies.PreferConsistent(),
                        ConsumerStrategies.<String, String>Subscribe(topics, kafkaParams));

        JavaPairDStream<String, String> resultRDD
                    = stream.mapToPair(record -> new Tuple2<>(record.key(), record.value()));

        doWork(inTargetTable, inTargetSchema, inHostName, inHostPort,
               inUserName, inUserPassword, resultRDD, jssc);
    }
```
{: .Example}

And here's the code that moves consumed data into your Splice Machine database:
{: .spaceAbove}

```
    private static void doWork(String inTargetTable, String inTargetSchema,
                              String inHostName, String inHostPort,
                              String inUserName, String inUserPassword,
                              JavaPairDStream<String, String> resultRDD,
                              JavaStreamingContext jssc) throws IOException,
                              InterruptedException {

        SparkConf conf = new SparkConf();
        SparkSession spark = SparkSession.builder().appName("Reader").config(conf).getOrCreate();

        // Create Splice's Spark Session
        SpliceSpark.setContext(spark.sparkContext());

        String dbUrl = "jdbc:splice://" + inHostName + ":" + inHostPort
                + "/splicedb;user=" + inUserName
                + ";" + "password=" + inUserPassword;

        // Create a SplicemachineContext based on the provided DB connection
        SplicemachineContext splicemachineContext = new SplicemachineContext(dbUrl);

        // Set target tablename and schemaname
        String SPLICE_TABLE_ITEM = inTargetSchema + "." + inTargetTable;

        StructType schema = splicemachineContext.getSchema(SPLICE_TABLE_ITEM);
        resultRDD.foreachRDD((RDD, time) -> {
            JavaRDD<String> rdd = RDD.values();

            JavaRDD<Row> rowJavaRDD = rdd.map(new Function<String, String[]>() {
                @Override
                public String[] call(String line) throws Exception {
                    return line.split(",");
                }
            }).map(new Function<String[], Row>() {
                @Override
                public Row call(String[] r) throws Exception {
                    return RowFactory.create(r[0], r[1], Double.parseDouble(r[2]),
                    Double.parseDouble(r[3]),Timestamp.valueOf(r[4]));
                }
            });

            Dataset<Row> ds = spark.createDataFrame(rowJavaRDD, schema);
            splicemachineContext.insert(ds, SPLICE_TABLE_ITEM);

        });

        jssc.start();              // Start the computation
        jssc.awaitTermination();   // Wait for the computation to terminate
    }
}
```
{: .Example}


## Running the App  {#runcode}

To put it all together, you need to start streaming data, consume that data and store it in your database table, and then use the data from the table, as shown in these sections:

1. [Run the Kafka Producer to Stream Data](#runproducer) to start streaming weather data.
2. [Use Spark Submit to Run the App](#submitapp)
3. [Use the Table](#usetable)

### 1. Run the Kafka Producer to Stream Data {#runproducer}

There are actually two shell scripts involved in streaming data into our app; both are included in the [./examples/SparkStreamingSubmit.tar.gz](./examples/SparkStreamingSubmit.tar.gz) tarball:

* The `runKafkaProducer.sh` script produces a number of events for a specific Kafka stream.
* The `streamToKafka.sh` script invokes the `runKafkaProducer.sh` script a number of times, passing parameters that specify which Kafka stream to use and how many events to produce.

<span class="spliceCheckbox">&#x261B;</span>You run `streamToKafka` to actually start streaming data that your app will produce.

#### The `runKafkaProducer` Script
Here's the version of the `runKafkaProducer.sh` script that is packaged into the [./examples/SparkStreamingSubmit.tar.gz](./examples/SparkStreamingSubmit.tar.gz) tarball:

<div class="PreWrapper"><pre class="ShellCommand">
#!/usr/bin/env bash

HOST="<span class="HighlightedCode">srv070</span>"
KAFKA_LIB_DIR="<span class="HighlightedCode">/opt/cloudera/parcels/KAFKA/lib/kafka/libs/*</span>"
java -cp target/<span class="HighlightedCode">splice-adapter-kafka-streaming-1.0-SNAPSHOT</span>.jar:${KAFKA_LIB_DIR}\
  <span class="HighlightedCode">com.splicemachine.sample.KafkaTopicProducer</span> \
  ${HOST}:9092 $@</pre>
</div>

You need to modify this script for your environment, updating at least some of the highlighted values, as appropriate.

#### The `streamToKafka` Script

The version of the `streamToKafka.sh` script in the tarball invokes the `runKafkaProducer.sh` script 2000 times, with each invocation producing 500 events:

<div class="PreWrapper"><pre class="ShellCommand">
#!/bin/bash

for ((cnt = 0; cnt &lt; 2000; cnt++))
do
echo $cnt
sh ./runKafkaProducer.sh weather 500
sleep 2
done</pre>
</div>

### 2. Use Spark Submit to Run the App  {#submitapp}

After you've started streaming data, you can use the supplied `spark-submit.sh` script to run your app. Here's a version of this script:

```
#!/bin/bash

TargetTable=WEATHER
TargetSchema=SPLICE
RSHostName=srv075
SpliceConnectPort=1527
UserName=yourDBUserId
UserPassword=yourDBPassword
KafkaBroker=stl-colo-srv070:9092
KafkaTopic=weather

export SPARK_KAFKA_VERSION=0.10

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
--name "Spark Adapter Test" \
--class com.splicemachine.sample.KafkaTopicConsumer \
--master yarn --deploy-mode cluster --num-executors 12 --executor-memory 8G --executor-cores 4 target/splice-adapter-kafka-streaming-1.0-SNAPSHOT-jar-with-dependencies.jar \
$TargetTable $TargetSchema $RSHostName $SpliceConnectPort $UserName $UserPassword $KafkaBroker $KafkaTopic
```
{: .ShellCommand}


Before submitting your Spark program with this script, you need to modify some of the values (at least the highlighted) at the top of the script; for our sample program, these are the values, which are summarized in the table below:
{: .spaceAbove}

<div class="PreWrapper"><pre class="ShellCommand">
TargetTable=WEATHER
TargetSchema=<span class="HighlightedCode">SPLICE</span>
RSHostName=<span class="HighlightedCode">srv075</span>
SpliceConnectPort=1527
UserName=<span class="HighlightedCode">yourDBUserId</span>
UserPassword=<span class="HighlightedCode">yourDBPassword</span>
KafkaBroker=<span class="HighlightedCode">stl-colo-srv070:9092</span>
KafkaTopic=weather</pre>
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
            <td class="CodeFont">KafkaBroker</td>
            <td>The Kafka broker server.</td>
        </tr>
        <tr>
            <td class="CodeFont">CsvFilePath</td>
            <td>The HDFS path to the CSV file you're importing.</td>
        </tr>
    </tbody>
</table>

### Use the Table  {#usetable}

Once your app is running, you can query your table and use the information as you like; for example, to train a machine learning model that predicts how weather will impact delivery dates.

Here's a simple query you can use to verify that the table has been populated:

```
splice> select * from splice.weather;
```
{: .Example}

</div>
</section>
