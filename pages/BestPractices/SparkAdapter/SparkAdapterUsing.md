---
title: How to Use the Splice Machine Native Spark DataSource
summary: Using the Splice Machine Native Spark DataSource.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_sparkadapter_using.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# How to Use the Splice Machine Native Spark DataSource

This topic provides general information about the *Splice Machine Native Spark DataSource* (aka the Splice Machine Spark Adapter), in these subsections:
* [Native Spark DataSource Overview](#about)
* [Connecting with the Native Spark DataSource](#connect)
* [Database Permissions and the Native Spark DataSource](#prereq)
* [Accessing Database Objects with Internal Access](#access)

The other topics in this chapter provide additional information about the Native Spark DataSource:

* [Native Spark DataSource API](bestpractices_sparkadapter_api.html) provides reference information for the Native Spark DataSource API methods.
* [Native Spark DataSource Examples](bestpractices_sparkadapter_submit.html) includes examples that show you how to launch a Spark app with our *Spark Submit* script, and how to use the Native Spark DataSource interactively, with the *Spark Shell*.
* [Using Our Native Spark DataSource with Zeppelin](bestpractices_sparkadapter_submit.html) presents an example of using our Native Spark DataSource in a Zeppelin notebook.

## Native Spark DataSource Overview  {#about}

The Splice Machine Native Spark DataSource, which is also referred to as the *Spark Adapter*, allows you to directly connect Spark DataFrames and Splice Machine database tables. You can efficiently insert, upsert, select, update, and delete data in your Splice Machine tables directly from Spark in a transactionally consistent manner. With the Spark Adapter, transfers of data between Spark and your database are completed without serialization/deserialization, which generates tremendous performance boosts over traditional *over-the-wire* transfers.

To use the adapter in your code, you simply instantiate a `SplicemachineContext` object in your Spark code. You can run Spark applications that interface with your Splice Machine database interactively in the Spark shell or Zeppelin notebooks, or you can launch a Spark app by using our Spark Submit script.

You can craft applications that use Spark and our Native Spark DataSource in Scala, Python, and Java. Note that you can use the Native Spark DataSource in the Splice Machine [*ML Manager*](mlmanager_intro.html) and *Zeppelin Notebook* interfaces.

## Connecting with the Native Spark DataSource  {#connect}

When using the Native Spark DataSource, you can specify some optional properties for the JDBC connection you're using to access your Splice Machine database. To do so, `Map` those options using a `SpliceJDBCOptions` object, and then create your `SplicemachineContext` with that map. For example:

```
val options = Map(
  JDBCOptions.JDBC_URL -> "jdbc:splice://<jdbcUrlString>",
        SpliceJDBCOptions.JDBC_INTERNAL_QUERIES -> "true"
)

spliceContext  = new SplicemachineContext( options )
```
{: .Example}

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


Note that a typical JDBC URL for connecting to a Splice Machine database looks like this:
{: .spaceAbove}

```
jdbc:splice://myhost:1527/splicedb;user=myUserName;password=myPswd
```
{: .Example}


## Database Permissions and the Native Spark DataSource {#prereq}

You must make sure that each user who is going to use the Splice Machine Native Spark DataSource has `execute` permission on the `SYSCS_UTIL.SYSCS_HDFS_OPERATION` system procedure.

   `SYSCS_UTIL.SYSCS_HDFS_OPERATION` is a Splice Machine system procedure that is used internally to efficiently perform direct HDFS operations. This procedure *is not documented* because it is intended only for use by the Splice Machine code itself; however, the Native Spark DataSource uses it, so any user of the Adapter must have permission to execute the `SYSCS_UTIL.SYSCS_HDFS_OPERATION` procedure.
   {: .noteIcon}

   Here's an example of granting `execute` permission for two users:

````
splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to someuser;
0 rows inserted/updated/deleted
splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to anotheruser;
0 rows inserted/updated/deleted
````
{: .Example}

### Additional Property Setting for Kerberos

If you're using the Native Spark DataSource on a Kerberized cluster, you must set the following property value in your `hbase-site.xml` settings file:
{: .spaceAbove}
````
splice.authentication.token.enabled=true
````
{: .AppCommand}


## Accessing Database Objects with Internal Access {#access}

By default, Native Spark DataSource queries execute in the Spark application, which is highly performant and allows access to almost all Splice Machine features. However, when your Native Spark DataSource application uses our Access Control List (*ACL*) feature, there is a restriction with regard to checking permissions.

The specific problem is that the Native Spark DataSource does not have the ability to check permissions at the view level or column level; instead, it checks permissions on the base table. This means that your Native Spark DataSource application doesn't have access to the table underlying a view or column, it will not have access to that view or column; as a result, a query against the view or colunn fails and throws an exception.

The workaround for this problem is to tell the Native Spark DataSource to [use *internal* access](#useinternal) to the database; this enables view/column permission checking, at a slight cost in performance. With internal access, the adapter runs queries in Splice Machine and temporarily persists data in HDFS while running the query.

The ACL feature is enabled by setting the property `splice.authentication.token.enabled = true`.
{: .noteNote}

## See Also

* [Native Spark DataSource Methods](bestpractices_sparkadapter_api.html)
* [Using Spark Submit](bestpractices_sparkadapter_submit.html)
* [Using Our Native Spark DataSource with Zeppelin](bestpractices_sparkadapter_submit.html)
* <a href="https://www.splicemachine.com/the-splice-machine-native-spark-datasource" target="_blank">Walkthrough of using the Native Spark DataSource in Zeppelin</a>

</div>
</section>
