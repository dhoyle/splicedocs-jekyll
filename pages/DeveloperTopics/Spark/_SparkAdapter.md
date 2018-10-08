---
title: Using the Splice Machine Spark Adapter
summary: Overview of using the Splice Machine Spark Adapter.
keywords: spark, adapter, splicemachineContext
toc: false
compatible_version: 2.7
product: all
sidebar: developers_sidebar
permalink: developers_spark_adapter.html
folder: DeveloperTopics/Spark
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine Spark Adapter

This topic provides general information about the Splice Machine Native Spark DataSource (aks *Splice Machine Spark Adapter*), in these subsections:
* [About the Splice Machine Spark Adapter](#about)
* [Prerequisites for Using the Adapter](#prereq)
* [Spark Adapter Access to Database Objects](#access)

The other topics in this section provide additional information about the Spark Adapter:

* [Spark Adapter Methods](developers_spark_methods.html) provides reference information for the Spark Adapter API methods.
* [Using Spark Submit](developers_spark_submit.html) walks you through running a simple application using Spark Submit.
* [Using Our Spark Adapter with Zeppelin](developers_spark_zeppelin.html) presents an example of using our Spark Adapter in a Zeppelin notebook.

This [blog article](https://www.splicemachine.com/the-splice-machine-native-spark-datasource) on our website walks you through the Zeppelin notebook example in greater detail.

## About the Splice Machine Spark Adapter {#about}

The Splice Machine Spark Adapter allows you to directly connect Spark DataFrames and Splice Machine database tables. You can efficiently insert, upsert, select, update, and delete data in your Splice Machine tables directly from Spark in a transactionally consistent manner.

To use the adapter, you simmply instantiate a `SplicemachineContext` object in your Spark code, as described in this documentation section.

## Prerequisites for Using the Adapter {#prereq}

To use the adapter, you must make sure that each user who is going to use the Splice Machine Spark Adapter has `execute` permission on the `SYSCS_UTIL.SYSCS_HDFS_OPERATION` system procedure.

   `SYSCS_UTIL.SYSCS_HDFS_OPERATION` is a Splice Machine system procedure that is used internally to efficiently perform direct HDFS operations. This procedure *is not documented* because it is intended only for use by the Splice Machine code itself; however, the Spark Adapter uses it, so any user of the Adapter must have permission to execute the `SYSCS_UTIL.SYSCS_HDFS_OPERATION` procedure.
   {: .noteIcon}

   Here's an example of granting `execute` permission for two users:
````
splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to someuser;
0 rows inserted/updated/deleted
splice> grant execute on procedure SYSCS_UTIL.SYSCS_HDFS_OPERATION to anotheruser;
0 rows inserted/updated/deleted
````
{: .Example}

If you're using the Spark Adapter on a Kerberized cluster, you must set this property value in your `hbase-site.xml` settings file:
{: .spaceAbove}
````
splice.authentication.token.enabled=true
````
{: .AppCommand}

## Spark Adapter Access to Database Objects {#access}

By default, Spark Adapter queries execute in the Spark application, which is highly performant and allows access to almost all Splice Machine features. However, when your Spark Adapter application uses our Access Control List (*ACL*) feature, there is a restriction with regard to checking permissions.

The specific problem is that the Spark Adapter does not have the ability to check permissions at the view level or column level; instead, it checks permissions on the base table. This means that your Spark Adapter application doesn't have access to the table underlying a view or column, it will not have access to that view or column; as a result, a query against the view or colunn fails and throws an exception.

The workaround for this problem is to tell the Spark Adapter to use *internal* access to the database; this enables view/column permission checking, at a slight cost in performance. With internal access, the adapter runs queries in Splice Machine and temporarily persists data in HDFS while running the query.

The ACL feature is enabled by `splice.authentication.token.enabled = true`.
{: .noteNote}

### Using Internal Execution

You can specify that you want your Spark Adapter application to use internal query execution in two ways:

* You can use the alternative methods [`internalDf`](#df) and [`internalRdd`](#rdd), which use internal execution instead of the standard `df` and `rdd` methods for creating DataFrames and RDDs from your database queries.

* If you are using Spark's `read()` method, you can set the value of the `SpliceJDBCOptions.JDBC_INTERNAL_QUERIES` option to `true`. See the [Spark Adapter JDBC Connection Options](#jdbc) section below for information about JDBC connection string options.


## See Also
* [Spark Adapter Methods](developers_spark_methods.html)
* [Using Spark Submit](developers_spark_submit.html)
* [Using Our Spark Adapter with Zeppelin](developers_spark_zeppelin.html)
* <a href="https://www.splicemachine.com/the-splice-machine-native-spark-datasource" target="_blank">Walkthrough of using the Native DataSource in Zeppelin</a>

</div>
</section>
