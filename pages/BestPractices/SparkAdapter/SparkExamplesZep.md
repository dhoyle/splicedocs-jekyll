---
title: Using our Native Spark DataSource with Zeppelin
summary: Using the Splice Machine Native Spark DataSource in Zeppelin
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_sparkadapter_zeppelin.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using the Native Spark DataSource in Zeppelin Notebooks {#zepexamples}

This topic shows you how to use the Native Spark DataSource in an Apache Zeppelin notebook. We use the `%spark` and `%splicemachine` Zeppelin interpreters to create a simple Splice Machine database table, and then access and modify that table, in these steps:

* [Set up the Native Spark DataSource](#setup)
* [Create a Table in Your Database](#createtable)
* [Populate the Table](#populatetable)
* [Perform Table Operations](#performops)

We have posted a [blog article](https://www.splicemachine.com/the-splice-machine-native-spark-datasource) on our website walks that you through this Zeppelin notebook example in greater detail.

## Set Up the Native Spark DataSource {#setup}

Before you can use the Native Spark DataSource, you need to create a `SpliceMachineContext` that specifies the URL to use to connect to your database. For example:

```
%spark
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._

val JDBC_URL = "jdbc:splice://XXXX:1527/splicedb;user=YourUserId;password=YourPassword"
val SpliceContext = new SplicemachineContext(JDBC_URL)</pre>
```
{: .Example}

The Native Spark DataSource has a few special (optional) requirements related to database permissions, which you can configure in your JDBC connection URL; for information, please see the [Accessing Database Objects](bestpractices_sparkadapter_intro.html#access) section in our *Using the Native Spark DataSource* topic.

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

Then we use the Splice Machine Native Spark DataSource to insert that data into our database table:
```
%spark
SpliceContext.insert(carsDF, "SPLICE.CARSTBL")
```
{: .Example}

## Perform Table Operations {#performops}

Now we can use the Native Spark DataSource to directly interact with the table using Spark, as shown in the following examples.

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
* [Native Spark DataSource Methods](bestpractices_sparkadapter_api.html)
* [Using Spark Submit](bestpractices_sparkadapter_submit.html)
* [Walkthrough of using the Native DataSource in Zeppelin](https://www.splicemachine.com/the-splice-machine-native-spark-datasource)

</div>
</section>
