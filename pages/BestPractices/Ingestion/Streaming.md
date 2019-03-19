---
title: Ingesting Streaming Data
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_streaming.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Streaming Data
This topic presents two versions of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps: one version that runs in a Zeppelin notebook, and a second version that runs via spark-submit.

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html), in this Best Practices chapter.

## Ingesting Streaming Data  {#streaming}


## Notebook Example of  Spark Streaming
This section presents the Zeppelin version of an example of using Spark streaming to ingest real-time data from Internet-connected devices (IOT) into a Splice Machine table in these steps.

**************** NEED EXAMPLE HERE ******************

## Using the Native Spark DataSource to Ingest Streaming Data  {#streamsubmit}

This section presents a discussion of and sample code for a standalone program submitted with `spark-submit` that uses the Splice Machine Native Spark DataSource to ingest streaming data.

All of the files required to build and run this program are available here: [./examples/SparkStreamingSubmit.tar.gz](./examples/SparkStreamingSubmit.tar.gz)
{: .noteNote}

We show you how to create and run this example in these subsections:

### ReadMe



1) create a table to store data streamed from Kafka
   create table splice.weather(
        id varchar(100),
        location varchar(20),
        temperature float,
        humidity float,
        time timestamp);

2) Create a Kafka topic named "weather"
bin/kafka-topics --describe --zookeeper localhost:2181  --topic weather

3) run streamToKafka.sh to stream data into kafka topic weather.

4) run spark_submit.sh to ingest data from kafka to splice

### The Submit Script

```
#!/bin/bash

TargetTable=WEATHER
TargetSchema=SPLICE
RSHostName=srv075
SpliceConnectPort=1527
UserName=splice
UserPassword=admin
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

### The Kafka Producer Code

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

            String record = id +"," + getLocation() + "," + formatDouble(getTemperature())
+ "," + formatDouble(getHumidity()) + "," + new Timestamp(System.currentTimeMillis()).toString();
            producer.send(new ProducerRecord<String, String>(topic, id, record));
        }
        //Flush and close the queue
        producer.flush();
        producer.close();
        //display the number of messages that aw
        System.out.println("messages pushed:" + nEvents);
    }

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

#### Running the Kafka Producer Code

This is the `runKafkaProducer.sh` script:

```
#!/usr/bin/env bash

###############################################################################
#  this is an example script the will require edits to make it work in any
#  environment.
###############################################################################
HOST="srv070"
KAFKA_LIB_DIR="/opt/cloudera/parcels/KAFKA/lib/kafka/libs/*"
java -cp target/splice-adapter-kafka-streaming-1.0-SNAPSHOT.jar:${KAFKA_LIB_DIR}\
    com.splicemachine.sample.KafkaTopicProducer \
    ${HOST}:9092 $@
```
{: .ShellCommand}

#### Streaming To Kafka

```
This is the `streamToKafka.sh` script:

#!/bin/bash

for ((cnt = 0; cnt < 2000; cnt++))
do
  echo $cnt
  sh ./runKafkaProducer.sh weather 500
  sleep 2
done
```
{: .ShellCommand}

### The Kafka Consumer Code

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

        JavaPairDStream<String, String> resultRDD = stream.mapToPair(record -> new Tuple2<>(record.key(), record.value()));

        doWork(inTargetTable, inTargetSchema, inHostName, inHostPort, inUserName, inUserPassword, resultRDD, jssc);
    }

    private static void doWork(String inTargetTable, String inTargetSchema, String inHostName, String inHostPort, String inUserName, String inUserPassword, JavaPairDStream<String, String> resultRDD, JavaStreamingContext jssc) throws IOException, InterruptedException {

        SparkConf conf = new SparkConf();
        SparkSession spark = SparkSession.builder().appName("Reader").config(conf).getOrCreate();

        // Create Splice's Spark Session
        SpliceSpark.setContext(spark.sparkContext());

        String dbUrl = "jdbc:splice://" + inHostName + ":" + inHostPort + "/splicedb;user=" + inUserName
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
                    return RowFactory.create(r[0], r[1], Double.parseDouble(r[2]), Double.parseDouble(r[3]),Timestamp.valueOf(r[4]));
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

</div>
</section>
