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
# Using Spark Submit
In this topic, we'll use `scala` to create a simple Splice Machine database table, and then access and modify that table.

This topic is currently being revamped; the new version will be available before the end of October, 2018.
{: .noteIcon}

## Setting Up the Splice Machine Adapter
You instantiate and object of the SplicemachineContext class to work with the Splice Machine Adapter. Here's some typical code:
<div class="preWrapperWide" markdown="1"><pre>
    // Create a Spark and SQL context
val sc = new SparkContext(sparkConf)
val sqlContext = new SQLContext(sc)
SpliceSpark.setcontext(sc)      // make the context available to Splice Machine

    // Create an instance of a SplicemachineContext and select/display table contents
val dbUrl = "jdbc:splice://myhost:1527/splicedb;user=myUserName;password=myPswd"
val SpliceContext = new SplicemachineContext(dbUrl)
splicemachineContext.df("SELECT * FROM sys.systables").show()

</pre>
{: .Example}
</div>

The SplicemachineContext object support two constructor methods:

````
   SpliceContext = new SplicemachineContext(jdbcUrl: String)
````
{: .FcnSyntax}

and

````
   SpliceContext = new SplicemachineContext(options: Map[String, String]
````
{: .FcnSyntax}

The available `options` are listed in the next section.
{: .spaceAbove}

## Creating a Table in Your Splice Machine Database
Now we'll use the Adapter to create a new table in our database, in 5 steps.

### 1. Remove pre-existing table if necessary:
First, since we run this code frequently, we'll remove any  pre-existing version of our table from our database:
<div class="preWrapperWide" markdown="1"><pre>
    // Specify a table name
var spliceMachineTableName = "spark_Splice Machine_tbl"
if (SpliceContext.tableExists(Splice MachineTableName)) {
    SpliceContext.dropTable(Splice MachineTableName) }
}</pre>
{: .Example}
</div>

### 2. Define a schema
Next we'll define the schema for our new table:
<div class="preWrapperWide" markdown="1"><pre>
val spliceMachineTableSchema = StructType(
        //  col name   type    nullable?
   StructField("id", IntegerType , false) ::
   StructField("make" , StringType, true ) ::
   StructField("model", StringType , true ) :: Nil)</pre>
{: .Example}
</div>

### 3. Define the Primary Key
Let's make the ID column our primary key:
<div class="preWrapperWide" markdown="1"><pre>
val spliceMachinePrimaryKey = Seq("id")</pre>
{: .Example}
</div>

### 4. Specify any Additional Options
We can specify any added options for our new table:
<div class="preWrapperWide" markdown="1"><pre>
val spliceMachineTableOptions = new CreateTableOptions()
Splice MachineTableOptions.setRangePartitionColumns(List("name").asJava).setNumReplicas(3)</pre>
{: .Example}
</div>

### 5. Create the Table
And now we can use the `createTable` method to create our Splice Machine table:
<div class="preWrapperWide" markdown="1"><pre>
SpliceContext.createTable(
    Splice MachineTableName, Splice MachineTableSchema, Splice MachinePrimaryKey, Splice MachineTableOptions)</pre>
{: .Example}
</div>

## Inserting Data into the Table
Now we'll use the following 4 steps to insert data into our database.

### 1. Import required functionality
<div class="preMarkerWide" markdown="1"><pre>
import sqlContext.implicits._</pre>
{: .Example}
</div>

### 2. Create an RDD containing table data

<div class="preMarkerWide" markdown="1"><pre>
    // Define our case class *outside* our main method
case class Car(id:Int, make:String, model:String)

    // Define a list of cars based  on the Car class
val cars = Array(
   Car(1, "Toyota", "Camry"),
   Car(2, "Honda", "Accord"),
   Car(3, "Subaru", "Impreza"),
   Car(4, "Chevy", "Volt") )

    // Transform our list into an RDD
val carsRDD = sc.parallelize(cars)</pre>
{: .Example}
</div>


### 3. Convert the RDD into a DataFrame
<div class="preMarkerWide" markdown="1"><pre>
val carsDF = carsRDD.toDF()

    // Define Splice Machine options used by various operations
val Splice MachineOptions: Map[String, String] = Map(
    "Splice Machine.table"  -> Splice MachineTableName,
    "Splice Machine.master" -> Splice MachineMasters )</pre>
{: .Example}
</div>

### 4. Insert Data into Splice Machine table
Now we'll insert the contents of the DataFrame into our table:
<div class="preMarkerWide" markdown="1"><pre>
SpliceContext.insertRows(customersDF, Splice MachineTableName)</pre>
{: .Example}
</div>

## Selecting Data from Our Table
You can select data from a database table:
<div class="preMarkerWide" markdown="1"><pre>
sqlContext.read.options(Splice MachineOptions).Splice Machine.show
+----+---------+-------------+
|  id|make     |model        |
+----+---------+-------------+
|   1|Toyota   |Camry        |
|   2|Honda    |Accord       |
|   3|Subaru   |Impreza      |
|   4|Chevy    |Volt         |
+----+---------+-------------+</pre>
{: .Example}
</div>

## Updating Data in the Table
You can update existing data in a table:
<div class="preMarkerWide" markdown="1"><pre>
    // Create a DataFrame of updated rows
val modifiedCars    = Array(Car(4, "Chevy", "Bolt"))
val modifiedCarsRDD = sc.parallelize(modifiedCars)
val modifiedCarsDF  = modifiedCarsRDD.toDF()

    // Call update with our new and changed customers DataFrame
SpliceContext.updateRows(modifiedCarsDF, Splice MachineTableName)</pre>
{: .Example}
</div>

## Deleting Data
You can delete rows from a table:
<div class="preMarkerWide" markdown="1"><pre>
    // Let’s register our cars dataframe as a temporary table so we
    // refer to it in Spark SQL
carsDF.registerTempTable("cars")

    // Filter and create a keys-only DataFrame to be deleted from our table
val deleteKeysDF = sqlContext.sql("select car from cars where make='Subaru'")

    // Delete the rows from our Splice Machine table
SpliceContext.deleteRows(deleteKeysDF, Splice MachineTableName)</pre>
{: .Example}
</div>

## Dropping a Table
As you've already seen, it's easy to drop a table from your database:
<div class="preWrapperWide" markdown="1"><pre>
    // Specify a table name
var Splice MachineTableName = "spark_Splice Machine_tbl"
if (SpliceContext.tableExists(Splice MachineTableName)) {
    SpliceContext.dropTable(Splice MachineTableName) }</pre>
{: .Example}
</div>


## See Also
* [Using the Native Spark DataSource](developers_spark_adapter.html)
* [Native Spark DataSource Methods](developers_spark_methods.html)
* [Using Our Native Spark DataSource with Zeppelin](developers_spark_zeppelin.html)


</div>
</section>
