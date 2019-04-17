---
title: Introduction
summary: A list of the topics in this documentation that apply only to our database-as-a-service; these topics do not apply to our on-premise product product.
keywords: home, welcome, dbaas, Service, paas
sidebar:  getstarted_sidebar
toc: false
product: all
permalink: dbaas_about.html
folder: DBaaS
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# About the Splice Machine Database Service

With the *Splice Machine Cloud Manager*, configuring a new cluster is as
easy as using a few sliders to set compute units for OLTP and OLAP
processing, allocate storage, and schedule backup frequency and
retention. Splice Machine does the rest. You can seamlessly scale out
from gigabytes to petabytes of data when needs or data volumes change,
and the same configurator adds or subtracts resources dynamically. You
pay only for what you use. You can then:

* Power your applications on a scale-out, ANSI SQL database
* Power apps with simultaneous OLAP & OLTP workloads
* Ingest millions of records and process thousands of transactions in
  nanoseconds
* Elastically scale resources as needed
* We’ve got you covered – availability, backups, monitoring and alerts

## Service Configuration

You only need to understand a few key concepts to configure your
service:

* A <span class="ConsoleLink">Splice Unit</span> is a measure of
  processing work; one unit currently translates (approximately) to 2
  virtual CPUs and 16 GB of memory. When you provision a new Splice
  Machine cluster, you can select the number of Splice Units you want to
  use for OLAP and OLTP workloads. The minimum number of Splice Units
  required for your cluster changes when you update the amount of data
  you want to access or the amount processing power you want to use.
* The space allocated for your <span class="ConsoleLink">Internal
  Dataset</span>, which is data that you're storing within your
  database. Note that as this size increases, the number of Splice Units
  required (especially OLTP Splice Units) can also increase.
* The space allocated for your <span class="ConsoleLink">External
  Dataset</span>, which is data stored externally that you can access
  from your database using features such as external tables and VTI.
  Note that as this size increases, the number of OLAP Splice Units
  required can also increase.

Use our [Database-Service documentation](dbaas_intro.html) to quickly
walk through provisioning your database cluster, loading your data, and
querying your data in notebooks, all in less than an hour. Once you're
ready, our documentation offers:

## Available Tools

In addition to easy connectivity with almost any Business Intelligence
tool, Splice Machine includes:

* An integrated *Zeppelin Notebook* interface. Zeppelin notebooks are
  like text documents, but with code that can be executed and of which
  the output can be rendered as tables, reports and beautiful graphs.
  This enables you to prepare and run SQL DDL and DML, stored
  procedures, Java, Scala, and Python and Spark-SQL programs with Splice
  Machine data. Splice Machine comes pre-configured with a set of
  notebooks to get started, load data and see examples of the work that
  can be done with the RDBMS.
* Our JDBC and ODBC drivers allow you to connect third-party business
  intelligence tools to your database.
* You can also take advantage of machine learning, streaming, and other
  services that you can access from our predesigned notebooks, your own
  notebooks, or code written by your developers.

## Learn More

Our documentation provides:

* Complete descriptions of our [Cloud Manager
  dashboard](dbaas_cm_intro.html)
* Numerous [Tutorials](tutorials_intro.html) about connecting with other
  tools, using various programming languages with Splice Machine,
  ingesting data efficiently, and so on.
* An introduction to [Using Zeppelin with Splice
  Machine](dbaas_zep_intro.html)
* A wealth of [Developer's Guide information](developers_intro.html) and
  our [SQL Reference Manual](sqlref_intro.html)

You can visit our company web site to learn about what our
[Cloud-Managed Database-as-Service
(DBaaS)]({{splvar_location_DBaaSStartLink}}){: target="_blank"} can do
for your company.

</div>
</section>

