---
title: Database-as-Service Product Release Notes
summary: Splice Machine Database-as-Service Product Release Notes
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_dbaas.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Release Notes for the Splice Machine Database-as-a-Service Product

{% include splice_snippets/dbaasonlytopic.md %}
This topic includes any release notes that are specific to the Splice Machine *Database-as-Service* product, in these sections:

* [Features Not Yet Available](#features-not-yet-available)
* [Current Limitations](#current-limitations)
* [Important Notes](#important-notes)


## Features Not Yet Available {#features-not-yet-available}

These features are not yet available, but will be very soon:

* VPC Settings are not yet enabled but will be in a near future release.
* You currently cannot cancel queries that are running through Zeppelin or JDBC tools; you can use the Spark User Interface to cancel Spark queries.


## Current Limitations {#current-limitations}

These limitations exist in this release, and will be removed in the near future:

* On a JDBC connection, individual queries or actions will time out after one hour; you can run long-running queries within a Zeppelin notebook.

## Important Notes {#important-notes}

These are important notes about issues you need to be aware of when using our Database Service:

* The timestamps displayed in Zeppelin will be different than the timestamps you see in the Splice Machine Spark User Interface, depending upon your time zone.

</div>
</section>
