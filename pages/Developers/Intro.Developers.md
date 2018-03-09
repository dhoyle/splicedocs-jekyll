---
title: Introduction to the Splice Machine Developer's Guide
summary: An introduction to the developer documentation for Splice Machine
keywords: developers
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_intro.html
folder: Developers
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Developer's Guide" %}
# Splice Machine Developer's Guide

This chapter describes how to do development work with your Splice
Machine Database. It is divided into these sections:

* [Developer Fundamentals](#Fundamentals)
* [Functions and Stored Procedures](#StoredProcs)
* [Tuning and Debugging] (#Tuning)

## Developer Fundamentals {#Fundamentals}
This section contains topics that contain in-depth information about fundamental aspects of working with Splice Machine:

*[Running Transactions](developers_fundamentals_transactions.html)
*[Working with Date and Time Values](developers_fundamentals_dates.html)
*[Using Database Triggers](developers_fundamentals_triggers.html)
*[Using Foreign Keys](developers_fundamentals_foreignkeys.html)
*[Using Window Functions](developers_fundamentals_windowfcns.html)
*[Using Temporary Tables](developers_fundamentals_temptables.html)
*[Using Spark Libraries](developers_fundamentals_sparklibs.html)
*[Using the Virtual Table Interface](developers_fundamentals_vti.html)
*[Using External Tables](developers_fundamentals_externaltables.html)
*[Using HCatalog](developers_fundamentals_hcatalog.html)
*[Connecting Through HAProxy](tutorials_connect_haproxy.html)
*[Using the MapReduce API](developers_fundamentals_mapreduce.html)
*[Working with HBase](developers_fundamentals_hbase.html)

## Functions and Stored Procedures {#StoredProcs}
This section contains information about creating and using stored procedures and functions with Splice Machine, in these topics:

* [Writing Functions and Stored Procedures](developers_fcnsandprocs_writing.html)
* [Storing/Updating Functions and Procs](developers_fcnsandprocs_storing.html)
* [Stored Procedure Examples](developers_fcnsandprocs_examples.html)


## Tuning and Debugging {#Tuning}
This section contains information about tuning the performance of your database, as well as debugging slowdowns, in these topics:

* [Introduction](developers_tuning_intro.html)
* [Optimizing Queries](developers_tuning_queryoptimization.html)
* [Using Statistics](developers_tuning_usingstats.html)
* [Using Explain Plan](developers_tuning_explainplan.html)
* [Explain Plan Examples](developers_tuning_explainplan_examples.html)
* [Logging](developers_tuning_logging.html)
* [Debugging](developers_tuning_debugging.html)
* [Using Snapshots](developers_tuning_snapshots.html)

</div>
</section>
