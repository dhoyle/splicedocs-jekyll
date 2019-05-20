---
title: Introduction to the Splice Machine Developer's Guide
summary: An introduction to the developer documentation for Splice Machine
keywords: developers
toc: false
product: all
sidebar: home_sidebar
permalink: developers_intro.html
folder: DeveloperTopics
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.guide_heading = "Developer's Guide" %}
# Splice Machine Developer's Guide

This chapter describes how to do development work with your Splice
Machine Database. It contains how-to topics and tutorials, and is divided into these sections:

* [Database Fundamentals](#Fundamentals)
* [External Data](#ExtData)
* [Functions and Stored Procedures](#StoredProcs)
* [Indexing](#Indexing)
* [On-Premise-DB Developer Topics](#OnPremOnly)
* [Splice\*Plus (PL/SQL)](#SplicePlus)
* [Tuning and Debugging](#Tuning)
* [Streaming Data](#Streaming)
* [Using the Database Console](#Console)

You'll find complete documentation for some major features in our [Best Practices Guide](bestpractices_intro.html), including [Ingesting Data](bestpractices_ingest_overview.html), [On-Premise Maintenance](bestpractices_onprem_updating.html), and [Using the Native Spark DataSource](bestpractices_sparkadapter_intro.html).
{: .noteIcon}

## Database Fundamentals {#Fundamentals}
This section contains topics that contain in-depth information about fundamental aspects of working with Splice Machine:

* [Running Transactions](developers_fundamentals_transactions.html)
* [Working with Date and Time Values](developers_fundamentals_dates.html)
* [Using Database Triggers](developers_fundamentals_triggers.html)
* [Using Foreign Keys](developers_fundamentals_foreignkeys.html)
* [Using Window Functions](developers_fundamentals_windowfcns.html)
* [Using Temporary Tables](developers_fundamentals_temptables.html)

## External Data {#ExtData}
This section contains information about accessing and working with data stored in external table and files:

* [Using External Tables](developers_fundamentals_externaltables.html)
* [Using the Virtual Table Interface](developers_fundamentals_vti.html)

## Functions and Stored Procedures {#StoredProcs}
This section contains information about creating and using stored procedures and functions with Splice Machine, in these topics:

* [Writing Functions and Stored Procedures](developers_fcnsandprocs_writing.html)
* [Storing/Updating Functions and Procs](developers_fcnsandprocs_storing.html)
* [Stored Procedure Examples](developers_fcnsandprocs_examples.html)

## Indexing {#Indexing}
This section contains topics related to indexing in your database:

* [Indexing Large Tables](#tutorials_indexing_largeindex.html)

## On-Premise-DB Developer Topics {#OnPremOnly}
This section contains fundamental developer topics that apply only to the Splice Machine On-Premise Database product:

* [Using HCatalog](developers_fundamentals_hcatalog.html)
* [Using HAProxy with Splice Machine](developers_fundamentals_haproxy.html)
* [Using MapReduce](developers_fundamentals_mapreduce.html)
* [Working with HBase](developers_fundamentals_hbase.html)
* [Using Zeppelin with our On-Premise Database](developers_fundamentals_zeppelin.html)

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
