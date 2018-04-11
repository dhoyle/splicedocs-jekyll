---
title: Splice Machine System Statistics Tables
summary: Summarizes the Splice Machine system tables that store statistical information.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_statsintro.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Statistics Tables

This section contains the reference documentation for the Splice Machine
SQL System Tables and Views that contain statistics information.

Since the system tables and views belong to the `SYS` schema, you must preface any
inquiries involving these tables/views with the `SYS.` prefix.
{: .noteNote}

The Statistics System Views are:

<table summary="Summary table with links to and descriptions of system statistics tables/views">
    <col />
    <thead>
        <tr>
            <th>System Table/View</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_syscolumnstats.html">SYSCOLUMNSTATISTICS</a>
            </td>
            <td>A view of statistics gathered for each column in each table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_systablestats.html">SYSTABLESTATISTICS</a>
            </td>
            <td>Describes the statistics for each table within the current
database.</td>
        </tr>
    </tbody>
</table>
</div>
</section>
