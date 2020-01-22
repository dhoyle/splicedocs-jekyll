---
title: Database-as-Service Product Release Notes
summary: Splice Machine Database-as-Service Product Release Notes
keywords: release notes, on-premise
toc: false
product: all
sidebar: home_sidebar
permalink: releasenotes_dbaas.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Release Notes for the Splice Machine Database-as-a-Service Product

This topic includes any release notes that are specific to the Splice Machine *Database-as-Service* product, in these sections:

* [Current Release Notes](#release-notes)
* [Features Not Yet Available](#features-not-yet-available)
* [Current Limitations](#current-limitations)
* [Important Notes](#important-notes)
* [Major Updates in Previous Releases](#prev-release)

## Current Release Notes  {#release-notes}

The current AWS and Azure versions of our Splice Machine Database-as-a-Service product are running _release  {{splvar_dbaas_DBVersion}}_ of the Splice Machine database.

These are the major updates in the current version, which was released on {{splvar_cloud_CloudReleaseDate}}:

<table class="oddEven">
    <col width="140px" />
    <col />
    <tbody>
        <tr>
            <td><em>Kubernetes</em></td>
            <td>Splice Machine includes support for Kubernetes, which is a portable, extensible platform for managing containerized workloads and services. Kubernetes makes it easier to scale cluster hardwared to match application requirements, automates common tasks, and provides robust error handling and recovery.</td>
        </tr>
        <tr>
            <td><em>Jupyter Notebooks</em></td>
            <td>Splice Machine now uses Jupyter notebooks instead of Zeppelin notebooks. Your cluster includes a fully integrated implementation of Jupyter notebooks, allowing data scientists to work with familiar tools.</td>
        </tr>
        <tr>
            <td><em>ML Manager</em></td>
            <td>The beta version of the Splice Machine ML Manager is now included at no additional cost; ML Manager provides an interface for training, running, tracking, and deploying machine learning models.</td>
        </tr>
        <tr>
            <td><em>NSDS 2.0</em></td>
            <td>Version 2.0 of the Splice Machine Native Spark DataSource (NSDS) streams DataFrames across the Kubernetes container/network boundary to Splice Machine, offering a high throughput solution; this is implemented behind the screen in Kafka.</td>
        </tr>
        <tr>
            <td><em>Application Server Queues</em></td>
            <td>Workload Management and Isolation is added with Splice Machine Application Server Queues, which allow you to specify resource management for specific queries, and to track server and role levels.</td>
        </tr>
        <tr>
            <td><em>Replication</em></td>
            <td>Asynchronous, Active/Passive Replication allows you to define a master cluster and follower cluster, which is automatically kept in synch with the master. Reads are allowed in either cluster, while only the master cluster supports writes.</td>
        </tr>
        <tr>
            <td><em>Point-in-Time queries</em></td>
            <td>Point-in-Time queries can query data as it existed at some point in the past.</td>
        </tr>
        <tr>
            <td><em>Schema Restrict</em></td>
            <td>Schema Restrict extends our security capabilities such that only authorized users can access system tables.</td>
        </tr>
        <tr>
            <td><em>Log Redaction</em></td>
            <td>Log Redaction allows you to define log masks for automatic redaction in system log files.</td>
        </tr>
        <tr>
            <td><em>Extended SQL Coverage</em></td>
            <td><p>SQL Coverage has been extended to facilitate migration from alternative databases such as DB2, including:</p>
                <ul>
                    <li><code>FULL OUTER JOIN</code>.</li>
                    <li><code>ALTER TABLE</code> now supports self-referencing foreign keys.</li>
                    <li>Microsecond timestamps.</li>
                    <li>Trigger enhancements, including support for <code>SIGNAL, NO CASCADE,</code> search conditions, and multiple statements per trigger.</li>
                    <li>Alternative syntax extensions, e.g. SYNONYM and ALIAS can be used interchangeably.</li>
                    <li>DB2 error code compatibility mode.</li>
                    <li>DB2 system table metadatga compatibility.</li>
                    <li>DB2 expression indexing compatibility.</li>
                    <li>DB2 text manipulation compatibility.</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>


## Features Not Yet Available {#features-not-yet-available}

These features are not yet available, but will be very soon:

* VPC Settings are not yet enabled but will be in a near future release.
* You currently cannot cancel queries that are running through Jupyter or JDBC tools; you can use the Spark User Interface to cancel Spark queries.


## Current Limitations {#current-limitations}

These limitations exist in this release, and will be removed in the near future:

* On a JDBC connection, individual queries or actions will time out after one hour; you can run long-running queries within a Jupyter notebook.

## Important Notes {#important-notes}

These are important notes about issues you need to be aware of when using our Database Service:

* The timestamps displayed in Jupyter will be different than the timestamps you see in the Splice Machine Spark User Interface, depending upon your time zone.

## Major Updates in Previous Releases  {#prev-release}

The following table summarizes the major updates in the previous release of the Splice Machine Database-as-a-Service product:

<table>
    <col width="145px"/>
    <col />
    <thead>
        <tr>
            <th>Category</th>
            <th>Note</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2"><em>New Features</em></td>
            <td>Dedicated HDFS is now available.</td>
        </tr>
        <tr>
            <td>Slider added for Notebook Spark.</td>
        </tr>
        <tr>
            <td rowspan="3"><em>Bug Fixes</em></td>
            <td>The display of the memory graph is fixed.</td>
        </tr>
        <tr>
            <td>The display of the CPU graph is fixed.</td>
        </tr>
        <tr>
            <td>An issue with exporting to S3 has been fixed.</td>
        </tr>
    </tbody>
</table>

</div>
</section>
