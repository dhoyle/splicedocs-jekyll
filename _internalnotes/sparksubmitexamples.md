Here is an example for using spark-shell on HDP2.6.3 cluster:
{code:bash}
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
{code}






Here is an example using spark2-shell on CDH cluster:
{code:bash}
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
{code}

Interactive session in Spark-shell:
{code:scala}
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._
import com.splicemachine.derby.impl.SpliceSpark
SpliceSpark.setContext(sc)
val spliceJDBC = "jdbc:splice://SPLICESERVERHOST:1527/splicedb;user=splice;password=admin"
val SpliceContext = new SplicemachineContext(spliceJDBC)
val ds = SpliceContext.df("select * from splice.test")
ds.count
ds.show
{code}
