---
title: Splice Machine System Backups Tables
summary: Summarizes the Splice Machine system tables that store information about backups
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_backupsintro.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Backup Tables

This section contains the reference documentation for the Splice Machine
SQL System Tables containing information about backups.

Since the system tables belong to the `SYS` schema, you must preface any
inquiries involving these tables with the `SYS.` prefix.
{: .noteNote}

The Backup System Tables are:

<table summary="Summary table with links to and descriptions of system backup tables">
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
                        <td class="CodeFont"><a href="sqlref_systables_sysbackup.html">SYSBACKUP</a>
                        </td>
                        <td>Information about each run of a backup job that has been run for the database. You can query this table to determine status information about a specific backup job.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysbackupitems.html">SYSBACKUPITEMS</a>
                        </td>
                        <td>Information about the items backed up for each backup job.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>
