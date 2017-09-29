---
title: MQTT Spark Streaming with Splice Machine
summary: A tutorial showing you how to put messages on an MQTT queue, how to consume those messages using Spark Streaming, and how to save those messages to Splice Machine using a VTI.
keywords: VTI, MQTT, streaming
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_mqttSpark.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Streaming MQTT Spark Data

This topic walks you through using MQTT Spark streaming with
Splice Machine. MQTT is a lightweight, publish-subscribe messaging
protocol designed for connecting remotely when a small footprint is
required. MQTT is frequently used for data collection with the Internet
of Things (IoT).

The example code in this tutorial uses [Mosquitto][1]{:
target="_blank"}, which is an open source message broker that implements
the MQTT. This tutorial uses a cluster managed by MapR; if you're using
different platform management software, you'll need to make a few
adjustments in how the code is deployed on your cluster.

All of the code used in this tutorial is available in our [GitHub
community repository][2]{: target="_blank"}.
{: .noteNote}

{% if site.incl_notpdf %}
<div markdown="1">
You can complete this tutorial by [watching a short video](#Watch) or by
[following the written directions](#Written) below.

## Watch the Video   {#Watch}

The following video shows you how to:

* put messages on an MQTT queue
* consume those messages using Spark streaming
* save those messages to Splice Machine with a virtual table (VTI)

<div class="centered" markdown="1">
<iframe class="youtube-player_0"
src="https://www.youtube.com/embed/Nt2J2khM0Xw?" frameborder="0"
allowfullscreen="1" width="560px" height="315px"></iframe>

</div>
</div>
{% endif %}
## Written Walk Through   {#Written}

This section walks you through the same sequence of steps as the video,
in these sections:

* [Deploying the Tutorial Code](#Deployin) walks you through downloading
  and deploying the sample code.
* [About the Sample Code](#About) describes the high-level methods in
  each class.
* [About the Sample Code Scripts](#About2) describes the scripts used to
  deploy and execute the sample code.

### Deploying the Tutorial Code   {#Deployin}

Follow these steps to deploy the tutorial code:

<div class="opsStepsList" markdown="1">
1.  Download the code from our [GitHub community repository.][3]{:
    target="_blank"}
    {: .topLevel}

    Pull the code from our git repository:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        https://github.com/splicemachine/splice-community-sample-code/tree/master/tutorial-mqtt-spark-streaming
    {: .Plain}

    </div>

2.  Compile and package the code:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        mvn clean compile package
    {: .ShellCommand}

    </div>

3.  Copy three JAR files to each server:
    {: .topLevel}

    Copy these three files:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        ./target/splice-tutorial-mqtt-2.0.jarspark-streaming-mqtt_2.10-1.6.1.jarorg.eclipse.paho.client.mqttv3-1.1.0.jar
    {: .Plain}

    </div>

    to this directory on each server:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
         /opt/splice/default/lib
    {: .Plain}

    </div>

4.  Restart Hbase
    {: .topLevel}

5.  Create the target table in splice machine:
    {: .topLevel}

    Run this script to create the table:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
         create-tables.sql
    {: .Plain}

    </div>

6.  Start Mosquitto:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo su /usr/sbin/mosquitto -d -c /etc/mosquitto/mosquitto.conf > /var/log/mosquitto.log 2>&1
    {: .ShellCommand}

    </div>

7.  Start the Spark streaming script:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -su mapr ./run-mqtt-spark-streaming.sh tcp://srv61:1883 /testing 10
    {: .ShellCommand}

    </div>

    The first parameter (`tcp://srv61:1883`) is the MQTT broker, the
    second (`/testing`) is the topic name, and the third (`10`) is the
    number of seconds each stream should run.
    {: .indentLevel1}

8.  Start putting messages on the queue:
    {: .topLevel}

    Here's a java program that is set up to put messages on the queue:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        java -cp /opt/splice/default/lib/splice-tutorial-mqtt-2.0-SNAPSHOT.jar:/opt/splice/default/lib/org.eclipse.paho.client.mqttv3-1.1.0.jar com.splicemachine.tutorials.sparkstreaming.mqtt.MQTTPublisher tcp://localhost:1883 /testing 1000 R1
    {: .ShellCommand}

    </div>

    The first parameter (`tcp://localhost:1883`) is the MQTT broker, the
    second (`/testing`) is the topic name, the third (`1000`) is the
    number of iterations to execute, and the fourth parameter (`R1`) is
    a prefix for this run.
    {: .indentLevel1}

    The source code for this utility program is in a different GitHub
    project than the rest of this code. You'll find it in the
   &nbsp;[`tutorial-kafka-producer`][4]{: target="_blank"} Github project.
    {: .noteNote}
{: .boldFont}

</div>
### About the Sample Code   {#About}

This section describes the main class methods used in this MQTT example
code; here's a summary of the classes:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Java Class</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="#MQTTPubl">MQTTPublisher</a>
            </td>
            <td>Puts csv messages on an MQTT queue.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#SparkStr">SparkStreamingMQTT</a>
            </td>
            <td>The Spark streaming job that reads messages from the MQTT queue.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#SaveRDD">SaveRDD</a>
            </td>
            <td>Inserts the data into Splice Machine using the <code>RFIDMessageVTI</code> class.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#RFIDMess2">RFIDMessageVTI</a>
            </td>
            <td>A virtual table interface for parsing an <code>RFIDMessage</code>.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="#RFIDMess">RFIDMessage</a>
            </td>
            <td>Java object (a POJO) for converting from a csv string to an object to a database entry.</td>
        </tr>
    </tbody>
</table>
#### MQTTPublisher   {#MQTTPubl}

This class puts CSV messages on an MQTT queue. The function of most
interest in MQTTPublisher.java is `DoDemo`, which controls our sample
program:

<div class="preWrapperWide" markdown="1">
    public void doDemo() {
       try {
            long startTime = System.currentTimeMillis();
            client = new MqttClient(broker, clientId);
            client.connect();
            MqttMessage message = new MqttMessage();
            for (int i=0; inumMessages; i++) {
                // Build a csv string
                message.setPayload( prefix + "Asset" + i ", Location" + i + "," + new Timestamp((new Date()).getTime())).getBytes());
                client.publish(topicName, message);
                if (i % 1000 == 0) {
                    System.out.println("records:" + i + " duration=" + (System.currentTimeMillis() - startTime));
                    startTime = System.currentTimeMillis();
                }
            client.disconnect();
        } catch (MqttException e) {
            e.printStackTrace();
        }
    }
{: .Example}

</div>
`DoDemo` does a little initialization, then starts putting messages out
on the queue. Our sample program is set up to loop until it creates
`numMessages` messages; after every 1000 messages, it displays a status
message that helps us determine how much time is going to put messages
on the queue, and how much to take them off the queue.

`DoDemo` builds a csv record (line) for each message, setting an
asset ID, a location ID, and a timestamp in the `payload` of the
message. It them publishes that message to the topic `topicName`.

#### SparkStreamingMQTT   {#SparkStr}

Once the messages are on the queue, our `SparkStreamingMQTT` class
object reads them from the queue and inserts them into our database. The
main method in this class is `processMQTT`:

<div class="preWrapperWide" markdown="1">
    public void processMQTT(final String broker, final String topic, final int numSeconds) {

        LOG.info("************ SparkStreamingMQTTOutside.processMQTT start");

        // Create the spark application and set the name to MQTT
        SparkConf sparkConf = new SparkConf().setAppName("MQTT");

        // Create the spark streaming context with a 'numSeconds' second batch size
        jssc = new JavaStreamingContext(sparkConf, Durations.seconds(numSeconds));
        jssc.checkpoint(checkpointDirectory);

        LOG.info("************ SparkStreamingMQTTOutside.processMQTT about to read the MQTTUtils.createStream");
        //2. MQTTUtils to collect MQTT messages
        JavaReceiverInputDStreamString> messages = MQTTUtils.createStream(jssc, broker, topic);

        LOG.info("************ SparkStreamingMQTTOutside.processMQTT about to do foreachRDD");
        //process the messages on the queue and save them to the database
        messages.foreachRDD(new SaveRDD());

        LOG.info("************ SparkStreamingMQTTOutside.processMQTT prior to context.strt");
        // Start the context
        jssc.start();
        jssc.awaitTermination();
    }
{: .Example}

</div>
The `processMQTT` method takes three parameters:
{: .spaceAbove}

<div class="paramList" markdown="1">
broker
{: .paramName}

The URL of the MQTT broker.
{: .paramDefnFirst}

topic
{: .paramName}

The MQTT topic name.
{: .paramDefnFirst}

numSeconds
{: .paramName}

The number of seconds at which streaming data will be divided into
batches.
{: .paramDefnFirst}

</div>
The `processMQTT` method processes the messages on the queue and saves
them by calling the `SaveMDD` class.
{: .spaceAbove}

#### SaveRDD   {#SaveRDD}

The `SaveRDD` class is an example of a Spark streaming function that
uses our virtual table interface (VTI) to insert data into your Splice
Machine database. This function checks for messages in the stream, and
if there any, it creates a connection your database and uses a prepared
statement to insert the messages into the database.

<div class="preWrapperWide" markdown="1">
    /**
     * This is an example of spark streaming function that
     * inserts data into Splice Machine using a VTI.
     *
     * @author Erin Driggers
     */

    public class SaveRDD implements FunctionJavaRDDString>, Void>, Externalizable {

        private static final Logger LOG = Logger.getLogger(SaveRDD.class);

        @Override
        public Void call(JavaRDDString> rddRFIDMessages) throws Exception {
            LOG.debug("About to read results:");
            if (rddRFIDMessages != null '& rddRFIDMessages.count() > 0) {
                LOG.debug("Data to process:");
                //Convert to list
                ListString> rfidMessages = rddRFIDMessages.collect();
                int numRcds = rfidMessages.size();

                if (numRcds > 0) {
                    try {
                        Connection con = DriverManager.getConnection("jdbc:splice://localhost:1527/splicedb;user=splice;password=admin");

                        //Syntax for using a class instance in a VTI, this could also be a table function
                        String vtiStatement = "INSERT INTO IOT.RFID "
                                + "select s.* from new com.splicemachine.tutorials.sparkstreaming.mqtt.RFIDMessageVTI(?) s ("
                                + RFIDMessage.getTableDefinition() + ")";
                        PreparedStatement ps = con.prepareStatement(vtiStatement);
                        ps.setObject(1, rfidMessages);
                        ps.execute();
                    } catch (Exception e) {
                        //It is important to catch the exceptions as log messages because it is difficult
                        //to trace what is happening otherwise
                        LOG.error("Exception saving MQTT records to the database" + e.getMessage(), e);
                    } finally {
                        LOG.info("Complete insert into IOT.RFID");
                    }
                }
            }
            return null;
        }
{: .Example}

</div>
The heart of this function is the statement that creates the prepared
statement, using a VTI class instance:
{: .spaceAbove}

<div class="preWrapperWide" markdown="1">
    String vtiStatement = "INSERT INTO IOT.RFID "     + "select s.* from new     com.splicemachine.tutorials.sparkstreaming.mqtt.RFIDMessageVTI(?) s ("
        + RFIDMessage.getTableDefinition() + ")";
    PreparedStatement ps = con.prepareStatement(vtiStatement);
{: .Plain}

</div>
Note that the statement references both our `RFIDMessage` and
`RFIDMessageVTI` classes, which are described below.

#### RFIDMessageVTI   {#RFIDMess2}

The `RFIDMessageVTI` class implements an example of a virtual table
interface that reads in a list of strings that are in CSV format,
converts that into an `RFIDMessage` object, and returns the resultant
list in a format that is compatible with Splice Machine.

This class features an override of the `getDataSet` method, which loops
through each CSV record from the input stream and converts it into an
`RFIDMessage` object that is added onto a list of message items:

<div class="preWrapperWide" markdown="1">
    @Override
    public DataSetLocatedRow> getDataSet(SpliceOperation op, DataSetProcessor dsp, ExecRow execRow) throws StandardException {
        operationContext = dsp.createOperationContext(op);

        //Create an arraylist to store the key / value pairs
        ArrayListLocatedRow> items = new ArrayListLocatedRow>();

        try {

            int numRcds = this.records == null ? 0 : this.records.size();

            if (numRcds > 0) {

                LOG.info("Records to process:" + numRcds);
                //Loop through each record convert to a SensorObject
                //and then set the values
                for (String csvString : records) {
                    CsvBeanReader beanReader = new CsvBeanReader(new StringReader(csvString), CsvPreference.STANDARD_PREFERENCE);
                    RFIDMessage msg = beanReader.read(RFIDMessage.class, header, processors);
                    items.add(new LocatedRow(msg.getRow()));
                }
            }
        } catch (Exception e) {
            LOG.error("Exception processing RFIDMessageVTI", e);
        } finally {
            operationContext.popScope();
        }
        return new ControlDataSet>(items);
    }
{: .Example}

</div>
For more information about using our virtual table interface, see [Using
the Splice Machine Virtual Table
Interface.](developers_fundamentals_vti.html)
{: .noteIcon}

#### RFIDMessage   {#RFIDMess}

The `RFIDMessage` class creates a simple Java object (a POJO) that
represents an RFID message; we use this to convert an incoming
CSV-formatted message into an object. This class includes getters and
setters for each of the object properties, plus the `getTableDefinition`
and `getRow` methods:

<div class="preWrapperWide" markdown="1">
    /**
     * Used by the VTI to build a Splice Machine compatible resultset
     *
     * @return
     * @throws SQLException
     * @throws StandardException
     */
    public ValueRow getRow() throws SQLException, StandardException {
        ValueRow valueRow = new ValueRow(5);
        valueRow.setColumn(1, new SQLVarchar(this.getAssetNumber()));
        valueRow.setColumn(2, new SQLVarchar(this.getAssetDescription()));
        valueRow.setColumn(3, new SQLTimestamp(this.getRecordedTime()));
        valueRow.setColumn(4, new SQLVarchar(this.getAssetType()));
        valueRow.setColumn(5, new SQLVarchar(this.getAssetLocation()));
        return valueRow;
    }

    /**
     * Table definition to use when using a VTI that is an instance of a class
     *
     * @return
     */
    public static String getTableDefinition() {
        return "ASSET_NUMBER varchar(50), "
        + "ASSET_DESCRIPTION varchar(100), "
        + "RECORDED_TIME TIMESTAMP, "
        + "ASSET_TYPE VARCHAR(50), "
        + "ASSET_LOCATION VARCHAR(50) ";
    }
{: .Example}

</div>
The `getTableDefinition` method is a string description of the table
into which you're inserting records; this pretty much replicates the
specification you would use in an SQL `CREATE_TABLE` statement.

The `getRow` method creates a data row with the appropriate number of
columns, uses property getters to set the value of each column, and
returns the row as a `resultset` that is compatible with Splice Machine.

### About the Sample Code Scripts   {#About2}

These are also two scripts that we use with this tutorial:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Class</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>/ddl/create-tables.sql</code></td>
            <td>A simple SQL script that you can use to have Splice Machine create the table into which RFID messages are stored.</td>
        </tr>
        <tr>
            <td><code>/scripts/run-mqtt-spark-streaming.sh</code></td>
            <td>Starts the Spark streaming job.</td>
        </tr>
    </tbody>
</table>
</div>
</section>



[1]: https://mosquitto.org/
[2]: https://github.com/splicemachine/splice-community-sample-code
[3]: https://github.com/splicemachine/splice-community-sample-code/tree/master/tutorial-mqtt-spark-streaming
[4]: https://github.com/splicemachine/splice-community-sample-code/tree/master/tutorial-kafka-producer
