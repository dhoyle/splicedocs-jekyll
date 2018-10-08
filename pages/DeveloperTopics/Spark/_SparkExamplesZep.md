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

## Using the Spark Adapter in Zeppelin Notebooks {#zepexamples}

This example in this section shows you how to use the Spark Adapter in an Apache Zeppelin notebook. We use the `%spark` and `%splicemachine` Zeppelin interpreters to create a simple Splice Machine database table, and then access and modify that table.

### Setting Up the Splice Machine Adapter
<div class="preMarkerWide" markdown="1"><pre>
%spark
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._

val JDBC_URL = "jdbc:splice://XXXX:1527/splicedb;user=YourUserId;password=YourPassword"
val SpliceContext = new SplicemachineContext(JDBC_URL)</pre>
{: .Example}
</div>

### Creating a Table in Your Splice Machine Database

#### 1. Remove pre-existing table if necessary:
<div class="preMarkerWide" markdown="1"><pre>
%splicemachine
create table carsTbl (number int primary key, make varchar(20), model varchar(20));</pre>
{: .Example}
</div>

#### 2. Create our Database Table
<div class="preMarkerWide" markdown="1"><pre>
%splicemachine
create table carsTbl (number int primary key, make varchar(20), model varchar(20));</pre>
{: .Example}
</div>

### Inserting Data into Our Table

First we'll create a Spark DataFrame and populate it with some data:
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

And then we'll insert that data into our Splice Machine table:
<div class="preMarkerWide" markdown="1"><pre>
%spark
SpliceContext.insert(carsDF, "SPLICE.CARSTBL")</pre>
{: .Example}
</div>

### Selecting Data
<div class="preMarkerWide" markdown="1"><pre>
%spark
SpliceContext.df("SELECT * FROM SPLICE.CARSTBL").show()</pre>
{: .Example}
</div>

### Updating Data
<div class="preMarkerWide" markdown="1"><pre>
%spark
val updateCarsDF = Seq(
    (1, "Toyota", "Rav 4 XLE"),
    (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
SpliceContext.update(updateCarsDF, "SPLICE.CARSTBL")</pre>
{: .Example}
</div>

### Deleting Data
<div class="preMarkerWide" markdown="1"><pre>
%spark
val deleteCarsDF = Seq(
    (1, "Toyota", "Rav 4 XLE"),
    (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
SpliceContext.delete(deleteCarsDF, "SPLICE.CARSTBL")</pre>
{: .Example}
</div>

### Dropping a Table
<div class="preMarkerWide" markdown="1"><pre>
%spark
if (SpliceContext.tableExists("SPLICE.CARSTBL")) {
    SpliceContext.dropTable("SPLICE.CARSTBL") }</pre>
{: .Example}
</div>

## See Also
* [Spark Adapter Methods](developers_spark_methods.html)
* [Using Spark Submit](developers_spark_submit.html)
* [Walkthrough of using the Native DataSource in Zeppelin](https://www.splicemachine.com/the-splice-machine-native-spark-datasource)

</div>
</section>
