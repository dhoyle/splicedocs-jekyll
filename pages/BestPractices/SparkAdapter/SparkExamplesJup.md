---
title: Using our Native Spark DataSource with Jupyter
summary: Using the Splice Machine Native Spark DataSource in Jupyter
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_sparkadapter_jupyter.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using the Native Spark DataSource in Jupyter Notebooks {#zepexamples}

This topic shows you how to use the Native Spark DataSource in a Jupyter notebook. We use the Python kernel and `%%sql` magic to create a simple Splice Machine database table, and then access and modify that table, in these steps:

* [1. Set up the Native Spark DataSource](#setup)
* [2. Create a Table in Your Database](#createtable)
* [3. Populate the Table](#populatetable)
* [4. Perform Table Operations](#performops)

## 1. Set Up the Native Spark DataSource {#setup}

Before you can use the Native Spark DataSource, you need to create a `SplicemachineContext` object, specifying the URL to use to connect to your database. For example:

```
%spark
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._

val JDBC_URL = "jdbc:splice://XXXX:1527/splicedb;user=YourUserId;password=YourPassword"
val SpliceContext = new SplicemachineContext(JDBC_URL)</pre>
```
{: .Example}

The Native Spark DataSource has a few special (optional) requirements related to database permissions, which you can configure in your JDBC connection URL; for information, please see the [Accessing Database Objects](bestpractices_sparkadapter_using.html#access) section in the *Using the Native Spark DataSource* topic in this chapter.

## 2. Create and Populate a Table in Your Database {#createtable}

Now let's create a simple table in our Splice Machine database:

```
%splicemachine
drop table if exists carsTbl;
create table carsTbl ( number int primary key, make varchar(20), model varchar(20) );
```
{: .Example}

## 3. Use a DataFrame to Populate the Table {#populatetable}

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

## 4. Perform Table Operations {#performops}

Now we can use the Native Spark DataSource to directly interact with our database table using Spark, as shown in the following basic table operations examples:

* [Selecting Data From the Table](#selectdata)
* [Updating Data In the Table](#updatedata)
* [Deleting Data From the Table](#deletedata)
* [Dropping the Table](#droptable)

This section provides simple examples of using the Native Spark DataSource to perform several simple database operations; for a complete list of operations available from the DataSource, see the [Native Spark DataSource API](bestpractices_sparkadapter_api.html) topic in this chapter.
{: .noteNote}

### Select Data from the Table  {#selectdata}

You can use Spark with the Adapter to select data from your table just as you would with the `splice>` command line interface:

```
%spark
SpliceContext.df("SELECT * FROM SPLICE.CARSTBL").show()
```
{: .Example}


### Update Data in the Table  {#updatedata}

You can use Spark with the Adapter to update data in your table just as you would with the `splice>` command line interface:

```
%spark
val updateCarsDF = Seq(
   (1, "Toyota", "Rav 4 XLE"),
   (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
SpliceContext.update(updateCarsDF, "SPLICE.CARSTBL")
```
{: .Example}

### Delete Data From the Table  {#deletedata}

You can also use Spark with the Adapter to delete data from your table just as you would with the `splice>` command line interface:

```
%spark
val deleteCarsDF = Seq(
   (1, "Toyota", "Rav 4 XLE"),
   (4, "Honda", "Accord Hybrid")
).toDF("NUMBER", "MAKE", "MODEL")
SpliceContext.delete(deleteCarsDF, "SPLICE.CARSTBL")
```
{: .Example}

### Drop the Table  {#droptable}

And you can use Spark with the Adapter to drop your table just as you would with the `splice>` command line interface:

```
%spark
if (SpliceContext.tableExists("SPLICE.CARSTBL")) {
   SpliceContext.dropTable("SPLICE.CARSTBL") }
```
{: .Example}

## See Also
* [Native Spark DataSource Methods](bestpractices_sparkadapter_api.html)
* [Using Spark Submit](bestpractices_sparkadapter_submit.html)

</div>
</section>
