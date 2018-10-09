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





## Using Spark Submit with Scala {#sparksubmit}

In this section, we'll use `scala` to create a simple Splice Machine database table, and then access and modify that table.


XXXXXXXXXXxx







### Setting Up the Splice Machine Adapter
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

### Creating a Table in Your Splice Machine Database
Now we'll use the Adapter to create a new table in our database, in 5 steps.

#### 1. Remove pre-existing table if necessary:
First, since we run this code frequently, we'll remove any  pre-existing version of our table from our database:
<div class="preWrapperWide" markdown="1"><pre>
    // Specify a table name
var spliceMachineTableName = "spark_Splice Machine_tbl"
if (SpliceContext.tableExists(Splice MachineTableName)) {
    SpliceContext.dropTable(Splice MachineTableName) }
}</pre>
{: .Example}
</div>

#### 2. Define a schema
Next we'll define the schema for our new table:
<div class="preWrapperWide" markdown="1"><pre>
val spliceMachineTableSchema = StructType(
        //  col name   type    nullable?
   StructField("id", IntegerType , false) ::
   StructField("make" , StringType, true ) ::
   StructField("model", StringType , true ) :: Nil)</pre>
{: .Example}
</div>

#### 3. Define the Primary Key
Let's make the ID column our primary key:
<div class="preWrapperWide" markdown="1"><pre>
val spliceMachinePrimaryKey = Seq("id")</pre>
{: .Example}
</div>

#### 4. Specify any Additional Options
We can specify any added options for our new table:
<div class="preWrapperWide" markdown="1"><pre>
val spliceMachineTableOptions = new CreateTableOptions()
Splice MachineTableOptions.setRangePartitionColumns(List("name").asJava).setNumReplicas(3)</pre>
{: .Example}
</div>

#### 5. Create the Table
And now we can use the `createTable` method to create our Splice Machine table:
<div class="preWrapperWide" markdown="1"><pre>
SpliceContext.createTable(
    Splice MachineTableName, Splice MachineTableSchema, Splice MachinePrimaryKey, Splice MachineTableOptions)</pre>
{: .Example}
</div>

### Inserting Data into the Table
Now we'll use the following 4 steps to insert data into our database.

#### 1. Import required functionality
<div class="preMarkerWide" markdown="1"><pre>
import sqlContext.implicits._</pre>
{: .Example}
</div>

#### 2. Create an RDD containing table data

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


#### 3. Convert the RDD into a DataFrame
<div class="preMarkerWide" markdown="1"><pre>
val carsDF = carsRDD.toDF()

    // Define Splice Machine options used by various operations
val Splice MachineOptions: Map[String, String] = Map(
    "Splice Machine.table"  -> Splice MachineTableName,
    "Splice Machine.master" -> Splice MachineMasters )</pre>
{: .Example}
</div>

#### 4. Insert Data into Splice Machine table
Now we'll insert the contents of the DataFrame into our table:
<div class="preMarkerWide" markdown="1"><pre>
SpliceContext.insertRows(customersDF, Splice MachineTableName)</pre>
{: .Example}
</div>

### Selecting Data from Our Table
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

### Updating Data in the Table
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

### Deleting Data
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

### Dropping a Table
As you've already seen, it's easy to drop a table from your database:
<div class="preWrapperWide" markdown="1"><pre>
    // Specify a table name
var Splice MachineTableName = "spark_Splice Machine_tbl"
if (SpliceContext.tableExists(Splice MachineTableName)) {
    SpliceContext.dropTable(Splice MachineTableName) }</pre>
{: .Example}
</div>


## Examples of Using the Spark Adapter in Zeppelin Notebooks {#zepexamples}

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
* [Using the Spark Adapter](developers_spark_adapter.html)
* [Spark Adapter Methods](developers_spark_methods.html)
* [Using Our Spark Adapter with Zeppelin](developers_spark_zeppelin.html)


</div>
</section>
