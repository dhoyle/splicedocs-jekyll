---
title: Splice Machine Tutorials
summary: Links to the Splice Machine tutorials
keywords:
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_intro.html
folder: DeveloperTutorials
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Developer Tutorials" %}
# Splice Machine Tutorials

This guide includes tutorials to help you quickly become proficient in
various aspects of using Splice Machine:

* [On-Premise-Database Authentication](#OnPremAuth)
* [Securing Your Database](#Security)
* [Importing Data](#Importing)
* [Using the Database Console](#Console)
* [Streaming Data](#Streaming)
* [Connecting Splice Machine with Business Intelligence Tools](#BITools)

## On-Premise-Database Authentication {#OnPremAuth}
This section shows you how to configure authentication for users of the On-Premise-Database version of Splice Machine, in these topics:

* [Using Database Authentication](tutorials_security_authentication.html)
* [Using Native Authentication](tutorials_security_usingnative.html)
* [Using LDAP Authentication](tutorials_security_usingldap.html)
* [Enabling Kerberos Authentication on Your Cluster](tutorials_security_usingkerberos.html)

## Securing Your Database {#Security}
This section shows you how to configure security for use with Splice Machine, in these topics:

* [Securing Connections with SSL/TLS](tutorials_security_ssltls.html)
* [Accessing Splice Machine from Windows on a Kerberized Cluster](tutorials_security_kerberoswin.html)
* [Authorizing Users and Roles](tutorials_security_authorization.html)
* [Summary of Permissions for Users and Roles](tutorials_security_permissions.html)
* [Using Apache Ranger with Splice Machine](tutorials_security_usingranger.html)

## Importing Data {#Importing}
Our *Importing Data* tutorial walks you through importing data into Splice Machine, in these topics:

* [Overview of Importing Data](tutorials_ingest_importoverview.html)
* [Import Parameters](tutorials_ingest_importparams.html)
* [Handling Import Input Data](tutorials_ingest_importinput.html)
* [Import Error Handling](tutorials_ingest_importerrors.html)
* [Examples of Importing Data](tutorials_ingest_importexamples1.html)
* [Examples of Using Bulk HFile Import](tutorials_ingest_importexampleshfile.html)
* [Example: Importing TPCH Benchmark Data](tutorials_ingest_importexamplestpch.html)

## Using the Database Console {#Console}
Our *Database Console* tutorial walks you through using the Splice Machine database console to monitor queries in real time:

* [Introduction](tutorials_dbconsole_intro.html)
* [Features of the Database Console](tutorials_dbconsole_features.html)
* [Managing Queries](tutorials_dbconsole_queries.html)

## Streaming Data {#Streaming}
This section contains topics that show you how to stream data into and out of Splice Machine:

* [Streaming MQTT Data](tutorials_ingest_mqttSpark.html)
* [Integrating Apache Storm with Splice Machine](tutorials_ingest_storm.html)
* [Configuring a Kafka Feed](tutorials_ingest_kafkafeed.html)
* [Creating a Kafka Producer](tutorials_ingest_kafkaproducer.html)

## Connecting Splice Machine with Business Intelligence Tools {#BITools}
This section shows you how to connect specific Business Intelligence tools to your Splice Machine database, including:

* [Connecting Cognos to Splice Machine](tutorials_connect_cognos.html)
* [Connecting DBVisualizer to Splice Machine](tutorials_connect_dbvisualizer.html)
* [Connecting SQuirreL to Splice Machine](tutorials_connect_squirrel.html)
* [Connecting Tableau to Splice Machine](tutorials_connect_tableau.html)

</div>
</section>
