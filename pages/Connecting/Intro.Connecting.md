---
title: Splice Machine Connecting Guide - Introduction
summary: An introduction to connecting to Splice Machine
keywords: developers
toc: false
product: all
sidebar: home_sidebar
permalink: connecting_intro.html
folder: Connecting
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.guide_heading = "Connecting Guide" %}
# Splice Machine Connecting Guide

This chapter describes how to do development work with your Splice
Machine Database. It contains how-to topics and tutorials, and is divided into these sections:

* [Accessing Data in the Cloud](#Cloud)
* [Connecting Splice Machine with Business Intelligence Tools](#BITools)
* [Connecting to Splice Machine with JDBC](#JDBC)
* [Connecting to Splice Machine with ODBC](#ODBC)
* [Functions and Stored Procedures](#StoredProcs)
* [Developer Fundamentals](#Fundamentals)
* [Indexing](#Indexing)
* [On-Premise-Database Authentication](#OnPremAuth)
* [On-Premise-DB Developer Topics](#OnPremOnly)
* [Securing Your Database](#Security)
* [Splice\*Plus (PL/SQL)](#SplicePlus)
* [Tuning and Debugging](#Tuning)
* [Streaming Data](#Streaming)
* [Using the Database Console](#Console)

You'll find complete documentation for some major features in our [Best Practices Guide](bestpractices_intro.html), including [Ingesting Data](bestpractices_ingest_overview.html), [On-Premise Maintenance](bestpractices_onprem_updating.html), and [Using the Native Spark DataSource](bestpractices_sparkadapter_intro.html).
{: .noteIcon}

## Accessing Data in the Cloud {#Cloud}
This section shows you how to access data that you have stored in the Cloud from Splice Machine, in these topics:

* [Configuring S3 Buckets for Splice Machine Access](developers_cloudconnect_configures3.html)
* [Uploading Data to an S3 Bucket](developers_cloudconnect_uploadtos3.html)

## Connecting Splice Machine with Business Intelligence Tools {#BITools}
This section shows you how to connect specific Business Intelligence tools to your Splice Machine database, including:

* [Connecting Cognos to Splice Machine](tutorials_connect_cognos.html)
* [Connecting DBVisualizer to Splice Machine](tutorials_connect_dbvisualizer.html)
* [Connecting SQuirreL to Splice Machine](tutorials_connect_squirrel.html)
* [Connecting Tableau to Splice Machine](tutorials_connect_tableau.html)

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

## Functions and Stored Procedures {#StoredProcs}
This section contains information about creating and using stored procedures and functions with Splice Machine, in these topics:

* [Writing Functions and Stored Procedures](developers_fcnsandprocs_writing.html)
* [Storing/Updating Functions and Procs](developers_fcnsandprocs_storing.html)
* [Stored Procedure Examples](developers_fcnsandprocs_examples.html)

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

## Indexing {#Indexing}
This section contains topics related to indexing in your database:

* [Indexing Large Tables](#tutorials_indexing_largeindex.html)

## On-Premise-Database Authentication {#OnPremAuth}
This section shows you how to configure authentication for users of the On-Premise-Database version of Splice Machine, in these topics:

* [Using Database Authentication](tutorials_security_authentication.html)
* [Using Native Authentication](tutorials_security_usingnative.html)
* [Using LDAP Authentication](tutorials_security_usingldap.html)
* [Enabling Kerberos Authentication on Your Cluster](tutorials_security_usingkerberos.html)

## On-Premise-DB Developer Topics {#OnPremOnly}
This section contains fundamental developer topics that apply only to the Splice Machine On-Premise Database product:

* [Using HCatalog](developers_fundamentals_hcatalog.html)
* [Using HAProxy with Splice Machine](developers_fundamentals_haproxy.html)
* [Using MapReduce](developers_fundamentals_mapreduce.html)
* [Working with HBase](developers_fundamentals_hbase.html)
* [Using Zeppelin with our On-Premise Database](developers_fundamentals_zeppelin.html)

## Securing Your Database {#Security}
This section shows you how to configure security for use with Splice Machine, in these topics:

* [Securing Connections with SSL/TLS](tutorials_security_ssltls.html)
* [Accessing Splice Machine from Windows on a Kerberized Cluster](tutorials_security_kerberoswin.html)
* [Authorizing Users and Roles](tutorials_security_authorization.html)
* [Summary of Permissions for Users and Roles](tutorials_security_permissions.html)
* [Using Apache Ranger with Splice Machine](tutorials_security_usingranger.html)

## Splice\*Plus (PL/SQL)] {#SplicePlus}
* [Introduction](developers_spliceplus_intro.html)
* [Using Splice*Plus](developers_spliceplus_using.html)
* [The Splice*Plus Language](developers_spliceplus_lang.html)

## Tuning and Debugging {#Tuning}
This section contains information about tuning the performance of your database, as well as debugging slowdowns, in these topics:

* [Optimizing Queries](developers_tuning_queryoptimization.html)
* [Using Statistics](developers_tuning_usingstats.html)
* [Using Explain Plan](developers_tuning_explainplan.html)
* [Explain Plan Examples](developers_tuning_explainplan_examples.html)
* [Logging](developers_tuning_logging.html)
* [Debugging](developers_tuning_debugging.html)
* [Using Snapshots](developers_tuning_snapshots.html)


## Streaming Data {#Streaming}
This section contains topics that show you how to stream data into and out of Splice Machine:

* [Streaming MQTT Data](tutorials_ingest_mqttSpark.html)
* [Integrating Apache Storm with Splice Machine](tutorials_ingest_storm.html)
* [Configuring a Kafka Feed](tutorials_ingest_kafkafeed.html)
* [Creating a Kafka Producer](tutorials_ingest_kafkaproducer.html)

## Using the Database Console {#Console}
Our *Database Console* tutorial walks you through using the Splice Machine database console to monitor queries in real time:

* [Introduction](tutorials_dbconsole_intro.html)
* [Features of the Database Console](tutorials_dbconsole_features.html)
* [Managing Queries](tutorials_dbconsole_queries.html)

</div>
</section>
