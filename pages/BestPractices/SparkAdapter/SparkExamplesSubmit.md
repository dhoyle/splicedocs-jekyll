---
title: Running Apps with the Native Spark DataSource
summary: Examples of using the Splice Machine Native Spark DataSource.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_sparkadapter_submit.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Running Apps with the Native Spark DataSource
This topic shows you how to submit a job to the Splice Machine Native Spark DataSource in two ways:

* [Using the Native Spark DataSource Interactively with Spark Shell](#interactive)
* [Submitting an App With Spark Submit](#sparksubmit)

## Using the Native Spark DataSource Interactively with Spark Shell  {#interactive}
This section provides examples of using the interactive Spark Shell with the Splice Machine Native Spark DataSource, in these subsections:

* [Using Spark Shell on a HDP cluster](#sparkshellhdp)
* [Using Spark Shell on a CDH cluster](#sparkshellcdh)
* [Example Program](#simpleexample1)


### Using Spark Shell on a HDP cluster  {#sparkshellhdp}
This command starts the Spark Shell on a Hortonworks cluster for use with the Splice Machine Native DataSource:

```
spark-shell \
--conf "spark.dynamicAllocation.enabled=false" \
--conf "spark.task.maxFailures=2" \
--conf "spark.driver.memory=4g" \
--conf "spark.driver.cores=1" \
--conf "spark.kryoserializer.buffer=4m" \
--conf "spark.kryoserializer.buffer.max=100m" \
--conf "spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator" \
--conf "spark.io.compression.codec=org.apache.spark.io.SnappyCompressionCodec" \
--conf "spark.executor.extraClassPath=/etc/hbase/2.6.3.0-235/0:/var/lib/splicemachine/*:/usr/hdp/2.6.3.0-235/spark2/jars/*:/usr/hdp/2.6.3.0-235/hbase/lib/*" \
--conf "spark.driver.extraClassPath=/etc/hbase/2.6.3.0-235/0:/var/lib/splicemachine/*:/usr/hdp/2.6.3.0-235/spark2/jars/*:/usr/hdp/2.6.3.0-235/hbase/lib/*" \
--conf "spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator" \
--jars "/var/lib/splicemachine/splicemachine-hdp2.6.3-2.2.0.2.6.3.0-235_2.11-2.7.0.1836-SNAPSHOT.jar" \
--master yarn
```
{: .ShellCommand}

### Using Spark Shell on a CDH cluster  {#sparkshellcdh}

This command starts the Spark Shell on a Cloudera cluster for use with the Splice Machine Native DataSource:

```
spark2-shell
    --conf "spark.dynamicAllocation.enabled=false"
    --conf "spark.task.maxFailures=2"
    --conf "spark.driver.memory=4g"
    --conf "spark.driver.cores=1"
    --conf "spark.kryoserializer.buffer=4m"
    --conf "spark.kryoserializer.buffer.max=100m"
    --conf "spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator"
    --conf "spark.io.compression.codec=org.apache.spark.io.SnappyCompressionCodec"
    --conf "spark.executor.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*"
    --conf "spark.driver.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/SPLICEMACHINE/lib/*:/opt/cloudera/parcels/SPARK2/lib/spark2/jars/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/*"
    --conf "spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator"
    --jars "./sparksplice.jar"
    --master yarn
```
{: .ShellCommand}

### Example Program  {#simpleexample1}

Here's a example of an interactive Spark Shell session that uses our Native DataSource to access a Splice Machine database:

```
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._
import com.splicemachine.derby.impl.SpliceSpark
SpliceSpark.setContext(sc)
val spliceJDBC = "jdbc:splice://SPLICESERVERHOST:1527/splicedb;user=<yourUserId>;password=<yourPassword>"
val SpliceContext = new SplicemachineContext(spliceJDBC)
val ds = SpliceContext.df("select * from splice.test")
ds.count
ds.show
```
{: .Example}

## Submitting an App With Spark Submit  {#sparksubmit}
You can run your compiled apps with the Native Spark DataSource with our `spark-submit.sh` script.

### Configuring the spark-submit.sh Script  {#sparksubmitscript}

You need to change some of the values at the top of this script to configure it for your environment and your app; these values typically need to be modified:

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

### The spark-submit.sh Script
Here's an example of the `spark-submit.sh` script

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


## See Also
* [Using the Native Spark DataSource](bestpractices_sparkadapter_intro.html)
* [Native Spark DataSource Methods](bestpractices_sparkadapter_api.html)
* [Using Our Native Spark DataSource with Zeppelin](bestpractices_sparkadapter_submit.html)


</div>
</section>
