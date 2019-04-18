---
title: Splice Machine System Permissions Tables
summary: Summarizes the Splice Machine system tables that store information about permissions.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_permissionsintro.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Permissions Tables

This section contains the reference documentation for the Splice Machine
SQL System Tables containing information about permissions.

Since the system tables belong to the `SYS` schema, you must preface any
inquiries involving these tables with the `SYS.` prefix.
{: .noteNote}

The Permissions System Tables are:

<table summary="Summary table with links to and descriptions of system permissions tables">
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
                        <td class="CodeFont"><a href="sqlref_systables_syscolperms.html">SYSCOLPERMS</a>
                        </td>
                        <td>Stores the column permissions that have been
		granted but not revoked.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysperms.html">SYSPERMS</a>
                        </td>
                        <td>Describes the usage permissions for
		sequence generators and user-defined types.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysroutineperms.html">SYSROUTINEPERMS</a>
                        </td>
                        <td>Stores the permissions that have been
		granted to routines.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_systableperms.html">SYSTABLEPERMS</a>
                        </td>
                        <td>Stores the table permissions that have
		been granted but not revoked.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

