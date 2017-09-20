---
title: Release Notes for our Database-as-Service
summary: Current release notes for the Splice Machine Database-as-Service product
keywords: release notes, dbaas, paas, service
sidebar:  dbaas_sidebar
toc: false
product: all
permalink: dbaas_info_release.html
folder: DBaaS/Info
---

# Release Notes: Splice Machine Database-as-Service

{% include splice_snippets/dbaasonlytopic.html %}

{::options parse_block_html="true" /}
<div data-swiftype-index="true">

This page summarizes the current limitations and workarounds of our Database-as-Service  product, in the following sections:

* [Features Not Yet Available](#features-not-yet-available)

* [Current Limitations](#current-limitations)

* [Important Notes](#important-notes)

## Features Not Yet Available

These features are not yet available, but will be very soon:

* TLS is not yet enabled for JDBC connections.

* VPC Settings are not yet enabled but will be in a near future release.

* You currently cannot cancel queries that are running through Zeppelin or JDBC tools; you can use the Spark User Interface to cancel Spark queries.


## Current Limitations

These limitations exist in the current release, and will be removed in the near future:

* Currently, all clusters are being created in the us-east-1 region. We will add support for more regions in the near future.

* On a JDBC connection, individual queries or actions will time out after one hour; you can run long-running queries within a Zeppelin notebook.

* Updating of CPU, Memory, and Disk usage graphs for clusters is currently limited: the updates are happening only intermittently.


## Important Notes

These are important notes about issues you need to be aware of when using our Database Service:

* The timestamps displayed in Zeppelin will be different than the timestamps you see in the Splice Machine Spark User Interface, depending upon your time zone.

* Although Splice Machine backs up your database regularly, it does not back up your Zeppelin Notebook changes; please export your Notebooks regularly if you make changes.

</div>
