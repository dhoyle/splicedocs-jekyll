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
SQL System Tables containing statistics information.

Since the system tables belong to the `SYS` schema, you must preface any
inquiries involving these tables with the `SYS.` prefix.
{: .noteNote}

The Statistics System Tables are:

<table summary="Summary table with links to and descriptions of system statistics tables">
                <col />
                <thead>
                    <tr>
                        <th>System Table</th>
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

