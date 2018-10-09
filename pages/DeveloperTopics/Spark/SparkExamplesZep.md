---
title: Using our Spark Adapter with Zeppelin
summary: Using the Splice Machine Spark Adapter in Zeppelin
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: developers_sidebar
permalink: developers_spark_zeppelin.html
folder: DeveloperTopics/Spark
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using the Spark Adapter in Zeppelin Notebooks {#zepexamples}

This topic shows you how to use the Spark Adapter in an Apache Zeppelin notebook. We use the `%spark` and `%splicemachine` Zeppelin interpreters to create a simple Splice Machine database table, and then access and modify that table, in these steps:

* [Set up the Spark Adapter](#setup)
* [Create a Table in Your Database](#createtable)
* [Populate the Table](#populatetable)
* [Perform Table Operations](#performops)

We have posted a [blog article](https://www.splicemachine.com/the-splice-machine-native-spark-datasource) on our website walks that you through this Zeppelin notebook example in greater detail.

## Set Up the Splice Machine Adapter {#setup}

Before you can use the Spark Adapter, you need to create a `SpliceMachineContext` that specifies the URL to use to connect to your database. For example:

```
%spark
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._

val JDBC_URL = "jdbc:splice://XXXX:1527/splicedb;user=YourUserId;password=YourPassword"
val SpliceContext = new SplicemachineContext(JDBC_URL)</pre>
```
{: .Example}

There are two JDBC options that are specific to Spark Adapter connections:
XXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  information about the Spark Adapter options you can specify in the

## Create and Populate a Table in Your Database {#createtable}

Let's create a table in our Splice Machine database.
```
%splicemachine
drop table if exists carsTbl;
create table carsTbl ( number int primary key, make varchar(20), model varchar(20) );
```
{: .Example}

## Use a DataFrame to Populate the Table {#populatetable}

Next we'll create and populate a Spark DataFrame with some data:
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

Then we use the Splice Machine Spark Adapter to insert that data into our database table:
```
%spark
SpliceContext.insert(carsDF, "SPLICE.CARSTBL")
```
{: .Example}

## Perform Table Operations {#performops}

Now we can use the Spark Adapter to directly interact with the table using Spark, as shown in the following examples.

#### Select Data from the Table Using Spark:
```
%spark
SpliceContext.df("SELECT * FROM SPLICE.CARSTBL").show()
```
{: .Example}


#### Update Data in the Table Using Spark:
```
%spark
val updateCarsDF = Seq(
   (1, "Toyota", "Rav 4 XLE"),
   (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
SpliceContext.update(updateCarsDF, "SPLICE.CARSTBL")
```
{: .Example}

#### Delete Data From the Table Using Spark:
```
%spark
val deleteCarsDF = Seq(
   (1, "Toyota", "Rav 4 XLE"),
   (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
SpliceContext.delete(deleteCarsDF, "SPLICE.CARSTBL")
```
{: .Example}

#### Drop the Table Using Spark:
```
%spark
if (SpliceContext.tableExists("SPLICE.CARSTBL")) {
   SpliceContext.dropTable("SPLICE.CARSTBL") }
```
{: .Example}

## See Also
* [Spark Adapter Methods](developers_spark_methods.html)
* [Using Spark Submit](developers_spark_submit.html)
* [Walkthrough of using the Native DataSource in Zeppelin](https://www.splicemachine.com/the-splice-machine-native-spark-datasource)

</div>
</section>
