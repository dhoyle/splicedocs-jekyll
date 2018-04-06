---
title: Using the Splice Machine Spark Adapter
summary: Overview and examples of using the Splice Machine Spark Adapter.
keywords: spark, adapter, splicemachineContext
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_sparkadapter.html
folder: Developers/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine Spark Adapter



## About the Splice Machine Spark Adapter

The Splice Machine Spark Adapter allows you to directly connect Spark DataFrames and Splice Machine database tables. You can efficiently insert, upsert, select, update, and delete data in your Splice Machine tables directly from Spark in a transactionally consistent manner. To use the adapter, you simmply instantiate a `SplicemachineContext` object in your Spark code.

## Prerequisites for Using the Adapter

To use the adapter, you must:

1. Make sure that `splice` space has read, write, and create permissions on HBase. For example:
   <div class="preWrapperWide" markdown="1">
       hbase(main):003:0> grant 'someuser', 'RWC', '@splice'
   {: .ShellCommand}
   </div>

2. Make sure that each user who is going to use the Splice Machine Spark Adapter has `execute` permission on the `SYSCS_UTIL.SYSCS_HDFS_OPERATION` system procedure.

   Use this `splice>` command:
   <div class="preWrapperWide" markdown="1">
       splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to someuser;
       0 rows inserted/updated/deleted
       splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to anotheruser;
       0 rows inserted/updated/deleted
   {: .Example}
   </div>

## Examples of Using the Spark Adapter in Zeppelin Notebooks

The examples in this section show how to use the adapter using the `%spark` and `%splicemachine` Zeppelin interpreters in a Zeppelin notebook.

### Creating and Modifying a Splice Machine Table from Spark

This example shows you how to use the Spark Adapter to create a simple Splice Machine database table, and then access and modify that table.


<div class="opsStepsList" markdown="1">
1. Create your adapter object:
   {: .topLevel}
   <div class="preMarkerWide" markdown="1"><pre>
   %spark
   import com.splicemachine.spark.splicemachine._
   import com.splicemachine.derby.utils._

   val JDBC_URL = "jdbc:splice://XXXX:1527/splicedb;user=splice;password=admin"
   val splicemachineContext = new SplicemachineContext(JDBC_URL)</pre>
   {: .Example}
   </div>

2. Create a Spark DataFrame and populate it with some data:
   {: .topLevel}
   <div class="preMarkerWide" markdown="1"><pre>
   %spark
   val carsDF = Seq(
      (1, "Toyota", "Camry"),
      (2, "Honda", "Accord"),
      (3, "Subaru", "Impreza"),
      (4, "Chevy", "Volt")
   ).toDF("NUMBER", "MAKE", "MODEL")</pre>
   {: .Example}
   </div>

3. Create a Splice Machine Database Table
   {: .topLevel}
   <div class="preMarkerWide" markdown="1"><pre>
   %splicemachine
   drop table if exists carsTbl;
   create table carsTbl (number int primary key, make varchar(20), model varchar(20));</pre>
   {: .Example}
   </div>

4. Insert our DataFrame Data into Our Table
   {: .topLevel}
   <div class="preMarkerWide" markdown="1"><pre>
   %spark
   splicemachineContext.insert(carsDF, "SPLICE.CARSTBL")</pre>
   {: .Example}
   </div>

{: .boldFont}
</div>

#### Performing Other Database Operations

It's also easy to directly perform other operations on tables in your Splice Machine database data directly from Spark with the adapter. For example:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Operation</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Selecting Data</td>
            <td><pre class="ExampleCell">%spark
splicemachineContext.df("SELECT * FROM SPLICE.CARSTBL").show()</pre>
            </td>
        </tr>
        <tr>
            <td>Updating Data</td>
            <td><pre class="ExampleCell">%spark
val updateCarsDF = Seq(
   (1, "Toyota", "Rav 4 XLE"),
   (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
splicemachineContext.update(updateCarsDF, "SPLICE.CARSTBL")</pre>
            </td>
        </tr>
        <tr>
            <td>Deleting Data</td>
            <td><pre class="ExampleCell">%spark
val deleteCarsDF = Seq(
   (1, "Toyota", "Rav 4 XLE"),
   (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
splicemachineContext.delete(deleteCarsDF, "SPLICE.CARSTBL")</pre>
            </td>
        </tr>
        <tr>
            <td>Dropping a Table</td>
            <td><pre class="ExampleCell">%spark
if (splicemachineContext.tableExists("SPLICE.CARSTBL"))
   splicemachineContext.dropTable("SPLICE.CARSTBL")</pre>
            </td>
        </tr>
    </tbody>
</table>



## Example of Streaming Data with the Adapter

Suppose you want to stream real-time data that's brokered by Kafka into a database table. All you need to do in your code is:

1. Subscribe to the Kafka feed.
2. Instantiate a Splice Spark Adapter (`SplicemachineContext`) object that connects to your database via JDBC.
3. Use Spark to read the stream and convert it into a DataFrame.
4. Use the `.insert` method of your adapter object to insert the data into your table.

      val kafkaParams = M
BRING IN CODE FROM WEB HERE
We've created a <a href="https://www.splicemachine.com/stream-iot-data-into-applications-easily", target="_blank"> blog article that walks you through such an example, which pulls real-time weather data into a table that can then be used to predict weather impacts on shipments.

</div>
</section>
