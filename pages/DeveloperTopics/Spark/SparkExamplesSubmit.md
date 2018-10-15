---
title: Using Spark Submit
summary: Examples of using Spark Submit.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: developers_sidebar
permalink: developers_spark_submit.html
folder: DeveloperTopics/Spark
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Example of Using the Splice Machine Native Spark DataSource

This topic walks you through creating and running a program that uses the Splice Machine Native Spark DataSource API, which means that the program is a Spark application that can interact directly with your Splice Machine database, without data having to move *over a wire*.

This example is a simple streaming app that produces rows from a Kafka producer, consumes data using Kafka Spark streaming, and then uses the Native Spark DataSource to insert batches of data into a Splice Machine database. This topic describes the app and how to run it in these sections:

* [Assemble the Pieces](#assemble)
* [Start Kafka Server and Register the Topic](#kafkaserver)
* [Compile and Run the App](#runapp)
* [Source Code](#sourcecode)


## Assemble the Pieces  {#assemble}

To run this sample app, you need to download and prepare for running the app as follows:

<div class="opsStepsList" markdown="1">
1.  Download Kafka from the [Apache web site](https://kafka.apache.org/downloads).

2.  Untar the Kafka tarball into your `home_dir`.

3.  Download the Native Spark DataSource API jar file to your current directory from  our Nexus repository:
       http://repository.splicemachine.com/nexus/content/groups/public/com/splicemachine

    Select the folder version that matches the version of Splice Machine installed on your cluster. For example, <span class="Highlighted">NEED HELP WITH EXPLAINING WHICH TO DOWNLOAD</span>.

4.  Copy the *Spark Streaming Kafka* jar in `SPARK2_HOME` to your current directory. For example, if you're using Cloudera, copy the `spark-streaming-kafka-0-10_2.11-2.2.0.cloudera1.jar` file.

5.  If you're running on a Kerberized cluster, find and copy the *hbase user keytab* file:
    * Search for the latest `hbase-MASTER` directory; on Cloudera, you can use: `sudo /var/run/cloudera-scm-agent/process/`.
    * You'll find the `hbase.keytab` file in that directory.
    * Copy the `hbase.keytab` file in that directory to a directory that the application can access.
</div>


## Start Kafka Server and Register the Topic  {#kafkaserver}
Since this app uses Kafka, you need to start the Kafka server. You can start the server in a separate window, or you can start it with the `nohup` command and keep it running in the backgroun:

```
$ bin/kafka-server-start.sh  config/server.properties
```

You also need to register the topic we're using with Kafka. To register the topic named `test-k`, use this command:
```
$ bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic test-k --partitions 2 --replication-factor 1
```

## Compile and Run the App  {#runapp}
Now use the following steps to compile and run the app:

<div class="opsStepsList" markdown="1">
1.  Navigate to the app folder that contains the `Main.java` app:
    ```
    src/main/java/com/splice/custom/reader
    ```

2.  Compile the app:
    ```
    mvn clean install
    ```
    {: ShellCommand}

3.  Configure the `spark-submit.sh` script, as described below, in the [Configuring the spark-submit.sh Script](#sparksubmitscript) section.

4.  Create a table in your Splice Machine database that matches the schema of our sample app, using the following SQL command line:
    ```
    CREATE TABLE TEST_TABLE (COL1 CHAR(30), COL2 INTEGER, COL3 BOOLEAN);
    ```
    {: .Example}

5.  Launch the app by running the `spark-submit.sh` script. You can monitor the app on port 8088 of the node to which you're connected.

6.  Use our scripts to stream data:
    * Use the `kafka-producer/run_prod.sh` script to send a batch of rows to the kafka producer
    * You can use the `kafka-producer/stream_rows.sh` script to loop, sending a stream of data every few seconds.
</div>

### Configuring the spark-submit.sh Script  {#sparksubmitscript}
The script supplied by Splice Machine for running an app with our Native Spark DataSource is named `spark-submmit.sh`. You will need to change some or all of the values at the top of this script to run it in your environment and for your app:

<div class="PreWrapper"><pre class="AppCommand">
TargetTable=<span class="HighlightedCode">&lt;tableName&gt;</span>
TargetSchema=<span class="HighlightedCode">&lt;schemaName&gt;</span>
RSHostName=<span class="HighlightedCode">&lt;serverId, e.g. localhost&gt;</span>
SpliceConnectPort=<span class="HighlightedCode">&lt;portId&gt;</span>
UserName=<span class="HighlightedCode">&lt;yourUserName&gt;</span>
UserPassword=<span class="HighlightedCode">&lt;yourPassword&gt;</span>
KafkaBroker=<span class="HighlightedCode">&lt;Kafka Broker ID&gt;</span>
KafkaTopic=<span class="HighlightedCode">&lt;Registered Kafka Topic ID&gt;</span>
KrbPrincipal=<span class="HighlightedCode">&lt;Kerberos Principal&gt;</span>
KrbKeytab=<span class="HighlightedCode">&lt;Kerberos Keytab Location&gt;</span>
</pre></div>

Here's the default code for `spark-submit.sh`:
{: .spaceAbove}

```
#!/bin/bash
export SPARK_KAFKA_VERSION=0.10

TargetTable=TEST_TABLE
TargetSchema=SPLICE
RSHostName=localhost
SpliceConnectPort=1527
UserName=splice
UserPassword=admin
KafkaBroker=stl-colo-srv136
KafkaTopic=test-k
KrbPrincipal=hbase/stl-colo-srv136.splicemachine.colo@SPLICEMACHINE.COLO
KrbKeytab=/tmp/hbase.keytab

spark2-submit --conf "spark.driver.extraJavaOptions=-Dsplice.spark.yarn.principal=hbase/stl-colo-srv136.splicemachine.colo \
-Dsplice.spark.yarn.keytab=/tmp/hbase.keytab \
-Dsplice.spark.enabled=true \
-Dsplice.spark.app.name=SpliceETLApp \
-Dsplice.spark.master=yarn-client \
-Dsplice.spark.logConf=true \
-Dsplice.spark.yarn.maxAppAttempts=1 \
-Dsplice.spark.driver.maxResultSize=3g \
-Dsplice.spark.driver.cores=4 \
-Dsplice.spark.yarn.am.memory=2g \
-Dsplice.spark.dynamicAllocation.enabled=true \
-Dsplice.spark.dynamicAllocation.executorIdleTimeout=30 \
-Dsplice.spark.dynamicAllocation.cachedExecutorIdleTimeout=30 \
-Dsplice.spark.dynamicAllocation.minExecutors=8 \
-Dsplice.spark.dynamicAllocation.maxExecutors=17 \
-Dsplice.spark.memory.fraction=0.6 \
-Dsplice.spark.scheduler.mode=FAIR \
-Dsplice.spark.serializer=org.apache.spark.serializer.KryoSerializer \
-Dsplice.spark.shuffle.service.enabled=true \
-Dsplice.spark.yarn.am.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native \
-Dsplice.spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/etc/spark/conf/log4j.properties \
-Dsplice.spark.driver.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native \
-Dsplice.spark.driver.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.2.0-incubating.jar \
-Dsplice.spark.executor.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native \
-Dsplice.spark.executor.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.2.0-incubating.jar \
-Dsplice.spark.eventLog.enabled=true \
-Dsplice.spark.eventLog.dir=hdfs:///user/spark/spark2ApplicationHistory \
-Dsplice.spark.local.dir=/tmp \
-Dsplice.spark.yarn.jars=/opt/cloudera/parcels/SPLICEMACHINE/lib/* \
-Dsplice.spark.ui.port=4042" \
--conf "spark.dynamicAllocation.enabled=false" \
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
--conf "spark.driver.extraJavaOptions=-Djava.security.krb5.conf=/etc/krb5.conf -Dspark.yarn.principal=hbase/stl-colo-srv136.splicemachine.colo -Dspark.yarn.keytab=/tmp/hbase.keytab -Dlog4j.configuration=log4j-spark.properties -XX:+UseCompressedOops -XX:+UseG1GC -XX:+PrintFlagsFinal -XX:+PrintReferenceGC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintAdaptiveSizePolicy -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:InitiatingHeapOccupancyPercent=35 -XX:ConcGCThreads=12" \
--conf "spark.executor.extraJavaOptions=-Djava.security.krb5.conf=krb5.conf -Dlog4j.configuration=log4j-spark.properties -XX:+UseCompressedOops -XX:+UseG1GC -XX:+PrintFlagsFinal -XX:+PrintReferenceGC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintAdaptiveSizePolicy -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:InitiatingHeapOccupancyPercent=35 -XX:ConcGCThreads=12" \
--conf "spark.executor.extraClassPath=/etc/hadoop/conf/:/etc/hbase/conf/:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*" \
--conf "spark.driver.extraClassPath=/etc/hadoop/conf/:/etc/hbase/conf/:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*" \
--files "/etc/spark/conf/log4j.properties,/etc/krb5.conf"  \
--keytab "/tmp/hbase.keytab"  \
--principal "hbase/stl-colo-srv136.splicemachine.colo" \
--name "DataGen" \
--jars "splicemachine-cdh5.8.3-2.1.0_2.11-2.5.0.1803-SNAPSHOT.jar,spark-streaming-kafka-0-10_2.11-2.2.0.cloudera1.jar" \
--class com.splice.custom.reader.Main \
--master yarn --deploy-mode cluster --num-executors 4 --executor-memory 10G --executor-cores 1 /home/splice/stream-app/target/reader-1.0-SNAPSHOT.jar \
$TargetTable $TargetSchema $RSHostName $SpliceConnectPort $UserName $UserPassword $KafkaBroker $KafkaTopic
```
{: .ShellCommand}

## Source Code  {#sourcecode}
This section contains the source code for our example app, in these components:
* [The App](#theappcode)
* [The Kafka Producer Program](#kafkaproducer)


### The App Code {#theappcode}

Here is the code for our example app; we've left out the long list of imported dependencies, which you can review in the full example code, which is in our Community Source Code repository.

```

public class Main {

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

	String inKbrPrincipal = System.getProperty("spark.yarn.principal");
	String inKbrKeytab = System.getProperty("spark.yarn.keytab");

        ClassLoader cl = ClassLoader.getSystemClassLoader();
        URL[] urls = ((URLClassLoader)cl).getURLs();
        for(URL url: urls){
        	System.out.println(url.getFile());
        }
        UserGroupInformation ugi = UserGroupInformation.getCurrentUser();

        System.out.println("Logged in as: " + ugi);
        System.out.println("Has credentials: " + ugi.hasKerberosCredentials());
        System.out.println("credentials: " + ugi.getCredentials());
        System.out.println("Kafka Broker: " + kafkaBroker);
        System.out.println("Kafka TopicName: " + kafkaTopicName);

        System.out.println(inKbrPrincipal);
        System.out.println(inKbrKeytab);

        // Initalize Kafka config settings
        Properties props = new Properties();
        SparkConf conf = new SparkConf().setAppName("stream");
        JavaStreamingContext jssc = new JavaStreamingContext(conf, Durations.seconds(1));

        Map<String, Object> kafkaParams = new HashMap<>();
        kafkaParams.put("bootstrap.servers", kafkaBroker+":9092");
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


        doWork(inTargetTable, inTargetSchema, inHostName, inHostPort, inUserName, inUserPassword, inKbrPrincipal, inKbrKeytab, resultRDD, jssc);


    }

    private static void doWork(String inTargetTable, String inTargetSchema, String inHostName, String inHostPort, String inUserName, String inUserPassword, String inKbrPrincipal, String inKbrKeytab, JavaPairDStream<String, String> resultRDD, JavaStreamingContext jssc) throws IOException, InterruptedException {

        SparkConf conf = new SparkConf();
        SparkSession spark = SparkSession.builder().appName("Reader").config(conf).getOrCreate();

        // Create Splice's Spark Session
        SpliceSpark.setContext(spark.sparkContext());

        SparkConf sparkConf = spark.sparkContext().getConf();
        String principal = sparkConf.get("spark.yarn.principal");
        String keytab = sparkConf.get("spark.yarn.keytab");
        System.out.println("spark.yarn.principal = " + sparkConf.get("spark.yarn.principal"));
        System.out.println("spark.yarn.keytab = " + sparkConf.get("spark.yarn.keytab"));
        System.out.print("principal: " + inKbrPrincipal);
        System.out.print("keytab: " + inKbrKeytab);

        String dbUrl = "jdbc:splice://" + inHostName + ":" + inHostPort + "/splicedb;user=" + inUserName + ";" + "password=" + inUserPassword;

        // Create a SplicemachineContext based on the provided DB connection
        SplicemachineContext splicemachineContext = new SplicemachineContext(dbUrl);

        // Set target tablename and schemaname
        String SPLICE_TABLE_ITEM = inTargetSchema + "." + inTargetTable;

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
                    return RowFactory.create(r[0], Integer.parseInt(r[1]), Boolean.parseBoolean(r[2]));
                }
          });

          Dataset<Row> ds = spark.createDataFrame(rowJavaRDD, createSchema());
          splicemachineContext.insert(ds, SPLICE_TABLE_ITEM);

        });

        jssc.start();              // Start the computation
        jssc.awaitTermination();   // Wait for the computation to terminate

    }

    // Match the test_table schema
    private static StructType createSchema() {
        List<StructField> fields = new ArrayList<>();
        fields.add(DataTypes.createStructField("COL1", DataTypes.StringType, true));
        fields.add(DataTypes.createStructField("COL2", DataTypes.IntegerType, true));
        fields.add(DataTypes.createStructField("COL3", DataTypes.BooleanType, true));

        StructType schema = DataTypes.createStructType(fields);
        return (schema);
    }

}
```
{: .Example}

### The Kafka Producer Program {#kafkaproducer}

Here is the code for sending messages via Kafka:

```
import java.util.Properties;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class SimpleProducer {

   public static void main(String[] args) throws Exception{

      // Check arguments length value
      if(args.length == 0){
         System.out.println("Enter topic name");
         return;
      }

      //Assign topicName to string variable
      String topicName = args[0].toString();

      // create instance for properties to access producer configs
      Properties props = new Properties();

      //Assign localhost id
      props.put("bootstrap.servers", "localhost:9092,localhost:9093");

      //Set acknowledgements for producer requests.
      props.put("acks", "all");

      //If the request fails, the producer can automatically retry,
      props.put("retries", 0);

      //Specify buffer size in config
      props.put("batch.size", 16384);

      //Reduce the no of requests less than 0
      props.put("linger.ms", 1);

      //The buffer.memory controls the total amount of memory available to the producer for buffering.
      props.put("buffer.memory", 33554432);

      props.put("key.serializer",
         "org.apache.kafka.common.serialization.StringSerializer");

      props.put("value.serializer",
         "org.apache.kafka.common.serialization.StringSerializer");

      Producer<String, String> producer = new KafkaProducer
         <String, String>(props);

      String r1 = "StarWars,75144,true";
      for(int i = 0; i < 500; i++) {
         producer.send(new ProducerRecord<String, String>(topicName, Integer.toString(i), r1));
      }

       System.out.println("Message sent successfully");
       producer.close();
   }
}
```
{: .Example}

## See Also
* [Using the Native Spark DataSource](developers_spark_adapter.html)
* [Native Spark DataSource Methods](developers_spark_methods.html)
* [Using Our Native Spark DataSource with Zeppelin](developers_spark_zeppelin.html)


</div>
</section>
