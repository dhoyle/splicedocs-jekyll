---
title: Splice Machine System Information Tables
summary: Summarizes the Splice Machine system tables that store information about the database system.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_sysinfointro.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# System Information Tables

This section contains the reference documentation for the Splice Machine
SQL System Tables containing system information.

Since the system tables belong to the `SYS` schema, you must preface any
inquiries involving these tables with the `SYS.` prefix.
{: .noteNote}

The System Information Tables are:

<table summary="Summary table with links to and descriptions of system information tables">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>System Table</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysconglomerates.html">SYSCONGLOMERATES</a>
                        </td>
                        <td>Describes the conglomerates
			within the current database. A conglomerate is a unit of storage and
		is either a table or an index.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysfiles.html">SYSFILES</a>
                        </td>
                        <td>Describes jar files stored in the
		database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysstatements.html">SYSSTATEMENTS</a>
                        </td>
                        <td>Describes the prepared statements in
		the database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysusers.html">SYSUSERS</a>
                        </td>
                        <td>Stores user credentials when NATIVE authentication
is enabled.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

