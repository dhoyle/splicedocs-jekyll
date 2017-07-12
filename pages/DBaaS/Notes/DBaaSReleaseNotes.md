---
title: Release Notes for our Database-as-Service Alpha Release
summary: Current release notes for the Splice Machine Database-as-Service product
sidebar:  dbaas_sidebar
toc: false
product: all
permalink: dbaas_notes_release.html
folder: DBaaS/Notes
---
# Release Notes: Alpha Release of Splice Machine Database-as-Service

Our new Database-as-Service product is now in alpha release. Although this software is functional, there are still some significant issues being worked out, as with all Alpha software. This page summarizes the current limitations and workarounds, in the following sections:

* [Cluster Creation and Uptime](#cluster-creation-and-uptime)

* [Connection Issues](#connection-issues)

* [Functionality Limitations](#functionality-limitations)

## Cluster Creation and Uptime

Here are the limitations and considerations you should be aware of when creating a new cluster:
*  When you create your cluster(s), use these size restrictions for now:
   * Set the slider to 4 OLTP Splice Units
   * Set the slider to 4 OLAP Splice Units
   * Keep internal storage capacity to below 1TB
   * Cluster names should be kept to 20 characters or less

* VPC setup information is currently being ignored.

* Reconfiguration and resizing of clusters is not currently available; if you need a larger or smaller cluster, you will need to create a new one from your Dashboard.

* Your new cluster will typically become available in less than 30 minutes; you'll receive an email notification containing connection details from us when it is ready.
<div class="noteIcon">If you don't receive an email within 1 hour of creating your cluster, please contact us.</div>

* If your Notebook link is not working when you receive your *Cluster Ready* email, try again in 5-10 minutes.

* We are currently only supported cluster uptime Monday-Friday 9am-5pm PDT.

* Splice Machine may bring down your clusters at the end of the week, in order to update the software. All scheduled outages will be posted to your Dashboard.

  If this happens, your cluster may be lost and you'll need to recreate it and repopulate your data.

## Connection Issues

This section contains information about connecting to your database:

* To log into your Notebook or to connect via JDBC, use these credentials:

  <table><tbody>
  <tr><td>Administrative user ID</td><td><span class="CodeFont">splice</span></td></tr>
  <tr><td>Password</td><td><span class="CodeFont">admin</span></td></tr>
  </tbody></table>

* If your cluster has been idle for some time, your first query submission might result in a *lost connection* message. Just resubmit the query and it should work correctly

* The DB Console will not display until you perform at least one query/action that invokes Spark. You can invoke Spark by issuing a query that includes the <span class="CodeFont">useSpark</span> hint; for example:

  <div class="preWrapperWide"><pre class="Example">
  select count(\*) from sys.systables --splice-properties useSpark=true
  </pre></div>

* You must use the <span class="CodeFont">%splicemachine</span> interpreter in your notebook when running Splice Machine SQL queries in a paragraph. For example:

  <div class="preWrapperWide"><pre class="Example">
  %splicemachine
  select count(\*) from sys.systables --splice-properties useSpark=true
  </pre></div>

* Your initial link from the DB Console will redirect you to an “HTTP" page that will fail.  Change the HTTP to HTTPS and resubmit that URL, and you will get to the Spark pages.  Other possible redirects on this page will also require this.

* For external JDBC access, download the JDBC driver at …….

## Functionality Limitations
* A single query or SQL statement will time out if it takes more than 1 hour; upon timeout, you may see a <span class="CodeFont">SQLNonTransientConnectionException</span> message displayed.

* The graphs in the UI are still under development and may not accurately reflect cluster activity.

* Backups are not currently being performed.

* The *LogDetails* tab is currently non-functional.

* The cost of your cluster displayed in your dashboard may be too high.
