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
{% assign site.guide_heading = "Splice Machine Connecting Guide" %}
# Splice Machine Connecting Guide

This chapter describes how to do development work with your Splice
Machine Database. It contains how-to topics and tutorials, and is divided into these sections:

* [Accessing Data in the Cloud](#Cloud)
* [Connecting Splice Machine with Business Intelligence Tools](#BITools)
* [Connecting to Splice Machine with JDBC](#JDBC)
* [Connecting to Splice Machine with ODBC](#ODBC)
* [Using Attunity Replicate with Splice Machine](#attunity)

## Accessing Data in the Cloud {#Cloud}
This section shows you how to access data that you have stored in the Cloud from Splice Machine, in these topics:

* [Configuring S3 Buckets for Splice Machine Access](developers_cloudconnect_configures3.html)
* [Uploading Data to an S3 Bucket](developers_cloudconnect_uploadtos3.html)
* [Using Azure WASB, ADLS, and ADLS2 with Splice Machine](developers_cloudconnect_configureazure.html)

## Connecting Splice Machine with Business Intelligence Tools {#BITools}
This section shows you how to connect specific Business Intelligence tools to your Splice Machine database, including:

* [Connecting Cognos to Splice Machine](tutorials_connect_cognos.html)
* [Connecting DBVisualizer to Splice Machine](tutorials_connect_dbvisualizer.html)
* [Connecting SQuirreL to Splice Machine](tutorials_connect_squirrel.html)
* [Connecting Tableau to Splice Machine](tutorials_connect_tableau.html)

## Connecting to Splice Machine with JDBC {#JDBC}
This section introduces our JDBC driver and shows you how to connect to Splice Machine via JDBC with various programming languages, including:

* [Connecting with Java and JDBC](tutorials_connect_java.html)
* [Connecting with JRuby and JDBC](tutorials_connect_jruby.html)
* [Connecting with Jython and JDBC](tutorials_connect_jython.html)
* [Connecting with Python and JDBC](tutorials_connectjdbc_python.html)
* [Connecting with R and JDBC](tutorials_connectjdbc_r.html)
* [Connecting with Scala and JDBC](tutorials_connect_scala.html)
* [Connecting with AngularJS/NodeJS and JDBC](tutorials_connect_angular.html)
* [JDBC Access to Splice Machine with Kerberos](developers_connectjdbc_kerberos.html)

## Connecting to Splice Machine with ODBC {#ODBC}
This section introduces our ODBC driver and shows you how to connect to Splice Machine via ODBC with various programming languages, including:

* [Installing our ODBC Driver](tutorials_connect_odbcinstall.html)
* [ODBC Access to Splice Machine with Kerberos](developers_connectodbc_kerberos.html)
* [Connecting with Python and ODBC](tutorials_connect_python.html)
* [Connecting with C and ODBC](tutorials_connect_odbcc.html)

## Using Attunity Replicate with Splice Machine  {#attunity}
This section walks you through various scenarios using Attunity Replicate to load data from another database into Splice Machine, including:

* [Exporting MySQL to Splice Machine](#attunity_export_mysql.html)
* [Exporting via ODBC to Splice Machine](#attunity_export_odbc.html)

</div>
</section>
