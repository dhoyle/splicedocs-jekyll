---
title: How to Use the Splice Machine Native Spark DataSource
summary: Using the Splice Machine Native Spark DataSource.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_sparkadapter_using.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# How to Use the Splice Machine Native Spark DataSource

This topic will help you to get started with using the Splice Machine Native Spark DataSource (aka the *Spark Adapter*) in your applications and Zeppelin notebooks, in the following sections:

* [The SplicemachineContext Class](#class)
* [Database Permissions and the Native Spark DataSource](#prereq)
* [Accessing Database Objects with Internal Access](#access)

See the [Native Spark DataSource Overview](bestpractices_sparkadapter_intro.html) topic for an overview of the Native Spark DataSource.

## The SplicemachineContext Class  {#class}

The first thing you need to do when using the Native Spark DataSource is to create an instance of the `SplicemachineContext` class; this is the primary serializable class that you can broadcast in your Spark applications. This class interacts with your Splice Machine cluster in your Spark executors, and provides the methods that you can use to perform operations such as:

* Interfacing with the Splice Machine RDD
* Running inserts, updates, and deletes on your data
* Converting data types between Splice Machine and Spark

### Creating Your Context

Here's a example of creating a context in an interactive Spark Shell session:

```
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._
import com.splicemachine.derby.impl.SpliceSpark
SpliceSpark.setContext(sc)
val spliceJDBC = "jdbc:splice://SPLICESERVERHOST:1527/splicedb;user=<yourUserId>;password=<yourPassword>"
val SpliceContext = new SplicemachineContext(spliceJDBC)
val ds = SpliceContext.df("select * from splice.test")
```
{: .Example }


And here's a similar example from a Zeppelin notebook:

```
%spark
import com.splicemachine.spark.splicemachine._
import com.splicemachine.derby.utils._

val JDBC_URL = "jdbc:splice://:1527/splicedb;user=<yourname>;password=<yourpswd>"
val splicemachineContext = new SplicemachineContext(JDBC_URL)
```
{: .Example }


### Using the Context to Populate a Table

Here's a simple example that illustrates how to populate a Splice Machine table from a Spark DataFrame. This example uses Zepplin.

First we'll create a DataFrame with a little data in it:

```
%spark
val carsDF = Seq(
   (1, "Toyota", "Camry"),
   (2, "Honda", "Accord"),
   (3, "Subaru", "Impreza"),
   (4, "Chevy", "Volt")
).toDF("NUMBER", "MAKE", "MODEL")
```
{: .Example }


Then we'll create a table in our Splice Machine database:

```
%splicemachine
create table mySchema.carsTbl ( number int primary key,
                                make  varchar(20),
                                model varchar(20) );
```
{: .Example }


Now we can insert the contents of our DataFrame directly into the table:

```
%spark
splicemachineContext.insert( carsDF, "mySchema.carsTbl");
```
{: .Example }


Though this simple example contains little data, you can operate on a DataFrame of any size in exactly the same way.

The [Running Apps with the Native Spark DataSource](bestpractices_sparkadapter_submit.html) and [Using our Native Spark DataSource with Zeppelin](bestpractices_sparkadapter_zeppelin.html) topics in this chapter contains example walkthroughs that show you how to use the context object to interact with your Splice Machine database.

## Accessing Database Objects with Internal Access {#access}

By default, Native Spark DataSource queries execute in the Spark application, which is highly performant and allows access to almost all Splice Machine features. However, when your Native Spark DataSource application uses our Access Control List (*ACL*) feature, there is a restriction with regard to checking permissions.

The specific problem is that the Native Spark DataSource does not have the ability to check permissions at the view level or column level; instead, it checks permissions on the base table. This means that if your Native Spark DataSource application doesn't have access to the table underlying a view or column, it will not have access to that view or column; as a result, a query against the view or colunn fails and throws an exception.

The workaround for this problem is to tell the Native Spark DataSource to use *internal* access to the database; this enables view/column permission checking, at a very slight cost in performance. With internal access, the adapter runs queries in Splice Machine and temporarily persists data in HDFS while running the query.

The ACL feature is enabled by setting the property `splice.authentication.token.enabled = true`.
{: .noteNote}


### Context Connection Options  {#connect}

When using the Native Spark DataSource, you can specify some optional properties for the JDBC connection that you're using to access your Splice Machine database. To do so, `Map` those options using a `SpliceJDBCOptions` object, and then create your `SplicemachineContext` with that map. For example:

```
val options = Map(
  JDBCOptions.JDBC_URL -> "jdbc:splice://<jdbcUrlString>",
  SpliceJDBCOptions.JDBC_INTERNAL_QUERIES -> "true"
)

spliceContext  = new SplicemachineContext( options )
```
{: .Example }


The `SpliceJDBCOptions` properties that you can currently specify in the JDBC connect URL are:
{: .spaceAbove}

<table>
    <thead>
        <tr>
            <th>Option</th>
            <th>Default Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">JDBC_INTERNAL_QUERIES</td>
            <td class="CodeFont">false</td>
            <td>A string with value <code>true</code> or <code>false</code>, which indicates whether or not to run queries internally by default.</td>
        </tr>
        <tr>
            <td class="CodeFont">JDBC_TEMP_DIRECTORY</td>
            <td class="CodeFont">/tmp</td>
            <td><p>The path to the temporary directory that you want to use when persisting temporary data from internally executed queries.</p>
                <p class="noteIcon">The user running a query <strong>must have write permission</strong> on this directory, or your connected application may freeze or fail.</p>
            </td>
        </tr>
    </tbody>
</table>

## Database Permissions and the Native Spark DataSource {#prereq}

To use the Splice Native Spark DataSource, a user must have `execute` permission on the following four system procedures:

* `SYSCS_HBASE_OPERATION`
* `SYSCS_HDFS_OPERATION`
* `SYSCS_GET_SPLICE_TOKEN`
* `SYSCS_CANCEL_SPLICE_TOKEN`

These procedures are all Splice Machine system procedures that are used internally to efficiently perform direct HBASE and HDFS operations. They *are not documented* because they are intended only for use by the Splice Machine code itself; however, the Native Spark DataSource uses these procedures, so any user of the Adapter must have permission to execute them.
{: .noteIcon}

Here's an example of granting `execute` permission to these procedures to a user named `myUserName`:

```
splice> grant execute on procedure SYSCS_UTIL.SYSCS_HBASE_OPERATION to myUserName;
0 rows inserted/updated/deleted
splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to myUserName;
0 rows inserted/updated/deleted
splice> grant execute on procedure SYSCS_UTIL.SYSCS_GET_SPLICE_TOKEN to myUserName;
0 rows inserted/updated/deleted
splice> grant execute on procedure SYSCS_UTIL.SYSCS_CANCEL_SPLICE_TOKEN to myUserName;
0 rows inserted/updated/deleted
```
{: .Example }


## Using the Native Spark DataSource with Kerberos

If you're using the Native Spark DataSource on a Kerberized cluster, you must set the following property value in your `hbase-site.xml` settings file:
{: .spaceAbove}
````
splice.authentication.token.enabled=true
````
{: .AppCommand}


</div>
</section>
