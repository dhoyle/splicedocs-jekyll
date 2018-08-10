---
title: Introduction to the Splice Machine Developer's Guide
summary: An introduction to the developer documentation for Splice Machine
keywords: developers
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_intro.html
folder: DeveloperTopics
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Developer's Guide" %}
# Splice Machine Developer's Guide

This chapter describes how to do development work with your Splice
Machine Database. It is divided into these sections:

* [Developer Fundamentals](#Fundamentals)
* [On-Premise Only Fundamentals](#OnPremOnly)
* [Functions and Stored Procedures](#StoredProcs)
* [Tuning and Debugging](#Tuning)
* [Accessing Data in the Cloud](#Cloud)
* [Connecting to Splice Machine with JDBC](#JDBC)
* [Connecting to Splice Machine with ODBC](#ODBC)
* [Spark and Splice Machine](#Spark)
* [Splice\*Plus (PL/SQL)](#SplicePlus)

## Developer Fundamentals {#Fundamentals}
This section contains topics that contain in-depth information about fundamental aspects of working with Splice Machine:

* [Running Transactions](developers_fundamentals_transactions.html)
* [Working with Date and Time Values](developers_fundamentals_dates.html)
* [Using Database Triggers](developers_fundamentals_triggers.html)
* [Using Foreign Keys](developers_fundamentals_foreignkeys.html)
* [Using Window Functions](developers_fundamentals_windowfcns.html)
* [Using Temporary Tables](developers_fundamentals_temptables.html)
* [Using the Virtual Table Interface](developers_fundamentals_vti.html)
* [Using External Tables](developers_fundamentals_externaltables.html)

## On-Premise Only Developer Fundamentals {#OnPremOnly}
This section contains fundamental developer topics that apply only to the Splice Machine On-Premise Database product:

* [Using HCatalog](developers_fundamentals_hcatalog.html)
* [Using HAProxy with Splice Machine](developers_fundamentals_haproxy.html)
* [Using MapReduce](developers_fundamentals_mapreduce.html)
* [Working with HBase](developers_fundamentals_hbase.html)
* [Using Zeppelin with our On-Premise Database](developers_fundamentals_zeppelin.html)


## Functions and Stored Procedures {#StoredProcs}
This section contains information about creating and using stored procedures and functions with Splice Machine, in these topics:

* [Writing Functions and Stored Procedures](developers_fcnsandprocs_writing.html)
* [Storing/Updating Functions and Procs](developers_fcnsandprocs_storing.html)
* [Stored Procedure Examples](developers_fcnsandprocs_examples.html)


## Tuning and Debugging {#Tuning}
This section contains information about tuning the performance of your database, as well as debugging slowdowns, in these topics:

* [Optimizing Queries](developers_tuning_queryoptimization.html)
* [Using Statistics](developers_tuning_usingstats.html)
* [Using Explain Plan](developers_tuning_explainplan.html)
* [Explain Plan Examples](developers_tuning_explainplan_examples.html)
* [Logging](developers_tuning_logging.html)
* [Debugging](developers_tuning_debugging.html)
* [Using Snapshots](developers_tuning_snapshots.html)

## Accessing Data in the Cloud {#Cloud}
This section shows you how to access data that you have stored in the Cloud from Splice Machine, in these topics:

* [Configuring S3 Buckets for Splice Machine Access](tutorials_ingest_configures3.html)
* [Uploading Data to an S3 Bucket](tutorials_ingest_uploadtos3.html)

## Connecting to Splice Machine with JDBC {#JDBC}
This section introduces our JDBC driver and shows you how to connect to Splice Machine via JDBC with various programming languages, including:

* [JDBC Access to Splice Machine with Kerberos](developers_connectjdbc_kerberos.html)
* [Connecting with Java and JDBC](tutorials_connect_java.html)
* [Connecting with JRuby and JDBC](tutorials_connect_jruby.html)
* [Connecting with Jython and JDBC](tutorials_connect_jython.html)
* [Connecting with Scala and JDBC](tutorials_connect_scala.html)
* [Connecting with AngularJS/NodeJS and JDBC](tutorials_connect_angular.html)

## Connecting to Splice Machine with ODBC {#ODBC}
This section introduces our ODBC driver and shows you how to connect to Splice Machine via ODBC with various programming languages, including:

* [Installing our ODBC Driver](tutorials_connect_odbcinstall.html)
* [ODBC Access to Splice Machine with Kerberos](developers_connectodbc_kerberos.html)
* [Connecting with Python and ODBC](tutorials_connect_python.html)
* [Connecting with C and ODBC](tutorials_connect_odbcc.html)

## Spark and Splice Machine  {#Spark}
* [Using our Spark Adapter](developers_spark_adapter.html)
* [Using Spark Libraries](developers_spark_libs.html)

## Splice\*Plus (PL/SQL)] {#SplicePlus}
* [Introduction](developers_spliceplus_intro.html)
* [Using Splice*Plus](developers_spliceplus_using.html)
* [The Splice*Plus Language](developers_spliceplus_lang.html)
* [Migrating PL/SQL to Splice*Plus](developers_spliceplus_migrating.html)

</div>
</section>
