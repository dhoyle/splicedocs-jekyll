---
title: Splice Machine Native Spark DataSource Overview
summary: Overview of using the Splice Machine Native Spark DataSource.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_sparkadapter_intro.html
folder: BestPractices/SparkAdapter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine Native Spark DataSource

This topic provides general information about the *Splice Machine Native Spark DataSource* (aka the Splice Machine Spark Adapter), in these subsections:
* [About the Splice Machine Native Spark DataSource](#about)
* [Native Spark DataSource Access to Database Objects](#access)
* [Prerequisites and Permissions for Using the Adapter](#prereq)

The other topics in this section provide additional information about the Native Spark DataSource:

* [Native Spark DataSource Methods](developers_spark_methods.html) provides reference information for the Native Spark DataSource API methods.
* [Native Spark DataSource Examples](developers_spark_submit.html) includes examples that show you how to launch a Spark app with our *Spark Submit* script, and how to use the Spark Adapter interactively, with the *Spark Shell*.
* [Using Our Native Spark DataSource with Zeppelin](developers_spark_zeppelin.html) presents an example of using our Native Spark DataSource in a Zeppelin notebook.

## About the Splice Machine Native Spark DataSource {#about}

The Splice Machine Native Spark DataSource allows you to directly connect Spark DataFrames and Splice Machine database tables. You can efficiently insert, upsert, select, update, and delete data in your Splice Machine tables directly from Spark in a transactionally consistent manner.

To use the adapter in your code, you simply instantiate a `SplicemachineContext` object in your Spark code. You can run Spark applications that interface with your Splice Machine database interactively in the Spark shell or Zeppelin notebooks, or you can launch a Spark app by using our Spark Submit script.

You can craft applications that use Spark and our Native Spark DataSource in Scala, Python, and Java.

## Native Spark DataSource Access to Database Objects {#access}

By default, Native Spark DataSource queries execute in the Spark application, which is highly performant and allows access to almost all Splice Machine features. However, when your Native Spark DataSource application uses our Access Control List (*ACL*) feature, there is a restriction with regard to checking permissions.

The specific problem is that the Native Spark DataSource does not have the ability to check permissions at the view level or column level; instead, it checks permissions on the base table. This means that your Native Spark DataSource application doesn't have access to the table underlying a view or column, it will not have access to that view or column; as a result, a query against the view or colunn fails and throws an exception.

The workaround for this problem is to tell the Native Spark DataSource to [use *internal* access](#useinternal) to the database; this enables view/column permission checking, at a slight cost in performance. With internal access, the adapter runs queries in Splice Machine and temporarily persists data in HDFS while running the query.

The ACL feature is enabled by `splice.authentication.token.enabled = true`.
{: .noteNote}

### Native Spark DataSource JDBC Options {#sparkjdbcopts}
{% include splice_snippets/sparkjdbcopts.md %}

## Prerequisites and Permissions for Using the DataSource {#prereq}

To use the adapter, you must make sure that each user who is going to use the Splice Machine Native Spark DataSource has `execute` permission on the `SYSCS_UTIL.SYSCS_HDFS_OPERATION` system procedure.

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

If you're using the Native Spark DataSource on a Kerberized cluster, you must set this property value in your `hbase-site.xml` settings file:
{: .spaceAbove}
````
splice.authentication.token.enabled=true
````
{: .AppCommand}


## See Also
* [Native Spark DataSource Methods](developers_spark_methods.html)
* [Using Spark Submit](developers_spark_submit.html)
* [Using Our Native Spark DataSource with Zeppelin](developers_spark_zeppelin.html)
* <a href="https://www.splicemachine.com/the-splice-machine-native-spark-datasource" target="_blank">Walkthrough of using the Native Spark DataSource in Zeppelin</a>

</div>
</section>
