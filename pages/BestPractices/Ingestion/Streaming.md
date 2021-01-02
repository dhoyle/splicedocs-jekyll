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
This topic describes how to use Spark streaming to ingest real-time data from Internet-connected devices into a Splice Machine table using `spark-submit`. This topic includes the following sections:

* [About Ingesting Streaming Data](#streaming)
* [Using the Native Spark DataSource to Ingest Streaming Data](#streamsubmitnsds)
* [Using the Structured Streaming Data Sink to Ingest Streaming Data](#streamsubmitssds)

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html).

## About Ingesting Streaming Data  {#streaming}

Internet of Things (IoT) applications must continuously ingest data, process that data, make decisions, and then act. This decision-making pattern typically starts with an ingestion phase of streaming raw data from the edge to a storage medium, then data engineers and data scientists iteratively manipulate the data to get it into a form that can be used downstream by learning, planning, and operational systems.

You can use two methods to ingest streaming data into Splice Machine.

* Native Spark DataSource (NSDS) – NSDS allows you to operate directly with Spark RDDs (for insert/update/delete/select) for Spark Streaming. The RDDs are basically microbatches for processing.  

* Structured Streaming Data Sink (SSDS) – The Structured Streaming Data Sink takes streaming one step further by applying SQL DataFrame queries or the Scala DataSet API.

## Using the Native Spark DataSource to Ingest Streaming Data  {#streamsubmitnsds}

The application documented in this section shows you how to ingest streams of IoT data into Splice Machine tables. This application streams weather data from a public weather data source into a Splice Machine table that you can then use for any purpose, such as a Machine Learning application that needs to consider weather forecasts to predict critical timing of shipments.

This sample application sets up a Kafka producer that streams data from a public weather service and a Kafka consumer that parses the data, transforms it into Spark DataFrames, and then uses the Splice Machine Native Spark DataSource to insert each DataFrame into a Splice Machine database table. This example involves the following steps:

1. [Create a table](#createtable) for the data in your Splice Machine database.
2. [Create a Kafka producer](#createproducer) to stream data.
3. [Review the sample Spark application](#createapp) that uses Kafka to consume the stream and uses the Native Spark DataSource to insert the data into the database table.

The files needed to build and run this application are available here: [`./examples/SparkStreamingSubmit.tar.gz`](./examples/SparkStreamingSubmit.tar.gz)
{: .noteNote}

The input source in this example is simulated.
{: .noteNote}

### 1. Create a table for the data in your Splice Machine database  {#createtable}

Use the following statement to create a table:

```
CREATE TABLE splice.weather (
    id VARCHAR(100),
    location VARCHAR(20),
    temperature DOUBLE,
    humidity DOUBLE,
    tm TIMESTAMP
    );
```
{: .Example}


### 2. Create a Kafka Producer to stream data  {#createproducer}

The following sample code produces a stream of weather data. The fully commented version of this code is available in  [`./examples/SparkStreamingSubmit.tar.gz`](./examples/SparkStreamingSubmit.tar.gz).


Here is the main code for the Kafka producer:

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


        /**
         * Static list of locations
         */
        public static final String[] locations = {
                "Alachua",
                "Baker",
                "Bay",
                "Bradford",
                "Brevard",
                "Broward",
                "Calhoun",
                "Charlotte",
                "Citrus",
                "Clay",
                "Collier",
                "Columbia",
                "Desoto",
                "Dixie",
                "Duval",
                "Escambia",
                "Flagler",
                "Franklin",
                "Gadsden",
                "Gilchrist",
                "Glades",
                "Gulf",
                "Hamilton",
                "Hardee",
                "Hendry",
                "Hernando",
                "Highlands",
                "Hillsborough",
                "Holmes",
                "Indian River",
                "Jackson",
                "Jefferson",
                "Lafayette",
                "Lake",
                "Pinellas",
                "Polk",
                "Putnam",
                "St. Johns",
                "St. Lucie",
                "Santa Rosa",
                "Sarasota",
                "Seminole",
                "Sumter",
                "Suwannee",
                "Taylor",
                "Union",
                "Volusia",
                "Wakulla",
                "Walton",
                "Washington",
                "Lee",
                "Leon",
                "Levy",
                "Liberty",
                "Madison",
                "Manatee",
                "Marion",
                "Martin",
                "Miami-Dade",
                "Monroe",
                "Nassau",
                "Okaloosa",
                "Okeechobee",
                "Orange",
                "Osceola",
                "Palm Beach",
                "Pasco"};
        Random r = new Random();
        DecimalFormat df = new DecimalFormat("#.##");
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
        private String server = null;
        private long totalEvents = 1;
        private String topic = null;

        /**
         * Adds records to a Kafka queue
         *
         * @param args args[0] - Kafka Broker URL
         *             args[1] - Kafka Topic Name
         *             args[2] - Number of messages to add to the queue
         * @throws Exception
         */
        public static void main(String[] args) throws Exception {


            KafkaTopicProducer kp = new KafkaTopicProducer();
            kp.server = args[0];
            kp.topic = args[1];
            kp.totalEvents = Long.parseLong(args[2]);
            kp.generateMessages();

        }

    	class Data{
    		public String ID;
    		public String LOCATION;
    		public Double TEMPERATURE;
    		public Double HUMIDITY;
    		public Timestamp TM;
    	}
```
{: .Example}

The following code sends messages to the Kafka queue:
{: .spaceAbove}

```
    /**
     * Sends messages to the Kafka queue.
     */
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
            Data d = new Data();
            d.ID = id;
            d.LOCATION = getLocation();
            d.TEMPERATURE = getTemperature();
            d.HUMIDITY = getHumidity();
            d.TM = new Timestamp(System.currentTimeMillis());
            System.out.println( "timestamp: " + d.TM );

            producer.send(new ProducerRecord<String, String>(topic, id,
                new com.google.gson.GsonBuilder()
                 .setDateFormat("yyyy-MM-dd HH:mm:ss.S")
                 .create()
                 .toJson(d)
              )
            );
        }
        //Flush and close the queue
        producer.flush();
        producer.close();
        //display the number of messages
        System.out.println("messages pushed:" + nEvents);
    }
```
{: .Example}

And these are the helper functions:
{: .spaceAbove}

```
    /**
     * Get a randomly generated temperature value
     *
     * @return
     */
    public double getTemperature() {
        return 9.0 + (95.5 - 9.0) * r.nextDouble();
    }

    /**
     * Get a randomly generated humidy value
     *
     * @return
     */
    public double getHumidity() {
        return 54.8 + (90.7 - 54.8) * r.nextDouble();
    }

    /**
     * Format the double to 2 decimal places
     *
     * @param dbl
     * @return
     */
    public String formatDouble(double dbl) {
        return df.format(dbl);
    }

    /**
     * Get a randomly generated value for location
     *
     * @return
     */
    public String getLocation() {
        int max = locations.length;
        int randomNum = r.nextInt((max - 0)) + 0;
        return locations[randomNum];
    }

    }
```
{: .Example}

### 3. Review the sample Spark application that consumes the stream and inserts data into the table  {#createapp}

The following sample application consumes the data stream produced by the Kafka producer and inserts it into the Splice Machine database table.

The main body of this application uses Kafka to consume entries in the stream into a Spark RDD and invokes the `doWork` method to process the stream entries. The `doWork` method:

* Creates a Spark session.
* Connects to your Splice Machine database.
* Maps stream entries into a Spark DataFrame.
* Uses the `insert` function of the Splice Machine Native Spark DataSource to insert the data into the table in real-time.

This code is available in [`./examples/SparkStreamingSubmit.tar.gz`](./examples/SparkStreamingSubmit.tar.gz).
{: .noteNote}

These are the package and class import statements in the application:

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

And here is the main Kafka consumer code:
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

And this is the code that moves consumed data into your Splice Machine database:
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


## Running the Application  {#runcode}

1. [Use Spark Submit to run the application](#submitapp).
2. [Run the Kafka Producer to stream data](#runproducer) to start streaming weather data.
3. [Use the table](#usetable).



### 1. Use Spark Submit to run the application  {#submitapp}

Use the provided `spark-submit.sh` script to run the application:

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


Before submitting your Spark application with the `spark-submit.sh` script, you must modify the following highlighted values:
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
            <td>The region server for connecting to your database.</td>
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
            <td>The HDFS path to the .csv file you are importing.</td>
        </tr>
    </tbody>
</table>

### 2. Run the Kafka Producer to stream data {#runproducer}

There are two shell scripts involved in streaming data into the application; both are included in the [`./examples/SparkStreamingSubmit.tar.gz`](./examples/SparkStreamingSubmit.tar.gz) tarball:

* The `runKafkaProducer.sh` script produces a number of events for a specific Kafka stream.
* The `streamToKafka.sh` script invokes the `runKafkaProducer.sh` script a number of times, passing parameters that specify which Kafka stream to use and how many events to produce.

<span class="spliceCheckbox">&#x261B;</span>You run `streamToKafka` to actually start streaming data that the application will produce.

#### The `runKafkaProducer` script
The following `runKafkaProducer.sh` script is packaged into the&nbsp;&nbsp;[`./examples/SparkStreamingSubmit.tar.gz`](./examples/SparkStreamingSubmit.tar.gz) tarball:

<div class="PreWrapper"><pre class="ShellCommand">
#!/usr/bin/env bash

HOST="<span class="HighlightedCode">srv070</span>"
KAFKA_LIB_DIR="<span class="HighlightedCode">/opt/cloudera/parcels/KAFKA/lib/kafka/libs/*</span>"
java -cp target/<span class="HighlightedCode">splice-adapter-kafka-streaming-1.0-SNAPSHOT</span>.jar:${KAFKA_LIB_DIR}\
  <span class="HighlightedCode">com.splicemachine.sample.KafkaTopicProducer</span> \
  ${HOST}:9092 $@</pre>
</div>

You must modify this script for your environment, updating at least some of the values highlighted above, as appropriate.

#### The `streamToKafka` Script

The `streamToKafka.sh` script invokes the `runKafkaProducer.sh` script 2000 times, with each invocation producing 500 events:

<div class="PreWrapper"><pre class="ShellCommand">
#!/bin/bash

for ((cnt = 0; cnt &lt; 2000; cnt++))
do
echo $cnt
sh ./runKafkaProducer.sh weather 500
sleep 2
done</pre>
</div>

### 3. Use the table  {#usetable}

Once the application is running and data is streaming, you can query the table and use the information for other purposes. For example, you could use the weather data to train a machine learning model that predicts how weather will impact delivery dates.

Here is a simple query you can use to verify that the table has been populated:

```
splice> select * from splice.weather;
```
{: .Example}

## Using the Structured Streaming Data Sink to Ingest Streaming Data  {#streamsubmitssds}

The Structured Streaming Data Sink enables you to ingest streaming data using SQL DataFrame queries or the Scala DataSet API.

1. [Set up the Splice Machine Connector for Apache Spark](#sparkconnector).
2. [Use spark-shell to run Spark structured streaming queries](#sparkssds).
3. Review the [Related Information](#sparkssdsinfo).

### 1. Set up the Splice Machine Connector for Apache Spark  {#sparkconnector}

The Splice Machine Connector for Apache Spark™ is an Apache Spark™ connector that enables you to process data in tables in Splice Machine.

The connector supports loading and saving datasets in batch (Spark SQL) and streaming (Spark Structured Streaming) queries.

For more information on setting up and using the Splice Machine Spark connector, see the [Splice Machine Connector for Apache Spark](https://github.com/splicemachine/splice-machine-spark-connector) GitHub page.

### 2. Use spark-shell to run Spark structured streaming queries  {#sparkssds}

The following examples show how to use spark-shell to execute a streaming query over datasets from Apache Kafka (via a [Kafka data source](https://spark.apache.org/docs/latest/structured-streaming-kafka-integration.html)).

Note that in the packages option in the spark-shell command, the spark-sql-kafka package is set to Spark version 2.4.5. Be sure to set it to the Spark version you are using.

```
spark-shell \
  --jars target/scala-2.11/splice-machine-spark-connector-assembly-0.3.0-SNAPSHOT.jar \
  --driver-class-path target/scala-2.11/splice-machine-spark-connector-assembly-0.3.0-SNAPSHOT.jar \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.5
```
{: .Example}

The following example uses topic `t1` with a Kafka broker listening on port 9092. The name of the splice table is `kafka`. This example works in Spark 2.4, which supports the `foreachBatch` function.

```
val values = spark
  .readStream
  .format("kafka")
  .option("subscribe", "t1")
  .option("kafka.bootstrap.servers", ":9092")
  .load
  .select($"value" cast "string")

assert(values.isStreaming)

val user = "splice"
val password = "admin"
val url = s"jdbc:splice://localhost:1527/splicedb;user=$user;password=$password"

val strQuery = values
  .writeStream
  .option("checkpointLocation", "/tmp/splice-checkpointLocation")
  .foreachBatch {
    (batchDF: DataFrame, batchId: Long) =>
        batchDF
          .write
          .format("splice")
          .option("url", url)
          .option("table", "kafka")
          .option("kafkaServers", ":9092")
          .save
  }.start

// After you started the streaming query
// The splice table is constantly updated with new records from Kafka
// Use kafka-console-producer.sh --broker-list :9092 --topic t1 to send records to Kafka

// You can use `sqlshell` of Splice Machine
// Or better query the table using Spark SQL
spark
  .read
  .format("splice")
  .option("url", url)
  .option("table", "kafka")
  .load
  .show

// Stop when you're done
strQuery.stop()
```
{: .Example}

The following example works with Spark 2.0 and higher versions.

```
import org.apache.spark.sql.streaming.Trigger
import org.apache.spark.SparkContext
import com.splicemachine.spark2.splicemachine.SplicemachineContext

val values = spark
  .readStream
  .format("kafka")
  .option("subscribe", "t1")
  .option("kafka.bootstrap.servers", ":9092")
  .load
  .select($"value" cast "string")

assert(values.isStreaming)

val user = "splice"
val password = "admin"
val url = s"jdbc:splice://localhost:1527/splicedb;user=$user;password=$password"

val sq = values
    .writeStream
    .option("checkpointLocation", s"target/checkpointLocation-$tableName-${UUID.randomUUID()}")
    .trigger(Trigger.ProcessingTime(1.second))
    .foreach(
      new ForeachWriter[Row] {
        var spliceCtx: SplicemachineContext = _
        var sparkContext: SparkContext = _

        def open(partitionId: Long, version: Long): Boolean = {
          spliceCtx = new SplicemachineContext(jdbcUrl)
          sparkContext = SparkContext.getOrCreate
          true
        }

        def process(record: Row): Unit =
          spliceCtx.insert(
            sparkContext.parallelize(Seq(record)),
            record.schema,
            table
          )

        def close(errorOrNull: Throwable): Unit = {}
      }
    )
.start()

// Stop when you're done
strQuery.stop()
```
{: .Example}

### Related Information  {#sparkssdsinfo}
* [Splice Machine Connector for Apache Spark](https://github.com/splicemachine/splice-machine-spark-connector)
* [Apache Spark Structured Streaming Programming Guide](https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html)
* [Spark Structured Streaming and Streaming Queries](https://jaceklaskowski.gitbooks.io/spark-structured-streaming/content/spark-structured-streaming.html)


</div>
</section>
