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
    <col width="20%" />
    <col width="25%" />
    <col width="60%" />
    <thead>
        <tr>
            <th>Update</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Kubernetes</em></td>
            <td>Splice Machine includes support for Kubernetes, which is a portable, extensible platform for managing containerized workloads and services. Kubernetes makes it easier to scale cluster hardware to match application requirements, automates common tasks, and provides robust error handling and recovery.</td>
        </tr>
        <tr>
            <td><em>Jupyter Notebooks</em></td>
            <td>Splice Machine now uses Jupyter notebooks instead of Zeppelin notebooks. Your cluster includes a fully integrated implementation of Jupyter notebooks, allowing data scientists to work with familiar tools.</td>
        </tr>
        <tr>
            <td><em>ML Manager</em></td>
            <td>The beta version of the Splice Machine ML Manager is now included at no additional cost; ML Manager provides an interface for training, running, tracking, and deploying machine learning models.</td>
        </tr>
    </tbody>
</table>

### Database New Features and Enhancements

In addition to the enhancements listed above, our database includes a large number of new features and updates, which are summarized in our [Database Release Notes](releasenotes_onprem.html) topic page.

If you're using the Splice Machine Database-as-a-Service produce, you'll find additional enhancements in the [Database Service Release Notes](releasenotes_dbaas.html) topic page.


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
