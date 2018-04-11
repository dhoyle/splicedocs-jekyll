---
title: Splice Machine System Tables
summary: Summarizes the Splice Machine system tables
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_intro.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# System Tables

This section contains the reference documentation for the Splice Machine
SQL Statements, in the following subsections:

* [Database Backups Tables](sqlref_systables_backupsintro.html)
* [Database Objects Information
  Tables](sqlref_systables_dbobjectsintro.html)
* [Database Permissions Tables](sqlref_systables_permissionsintro.html)
* [Database Statistics Tables](sqlref_sysprocs_statisticsintro.html)
* [System Information Tables](sqlref_systables_sysinfointro.html)

Since the system tables belong to the `SYS` schema, you must preface any
inquiries involving these tables with the `SYS.` prefix.

You can use the Java `java.sql.DatabaseMetaData` class to learn more
about these tables.
{: .noteNote}

<div markdown="1">
## Database Backups Tables

{% include splice_snippets/onpremonlytopic.md %}
These are the System Tables with backups information:

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
                        <tr>
                            <td class="CodeFont"><a href="sqlref_systables_sysbackupjobs.html">SYSBACKUPJOBS</a>
                            </td>
                            <td>Information about all backup jobs that have been created for the database.</td>
                        </tr>
                    </tbody>
                </table>
</div>
## Database Objects Tables

These are the System Tables with information about database objects:

<table summary="Summary table with links to and descriptions of system database object tables">
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
                        <td class="CodeFont"><a href="sqlref_systables_sysaliases.html">SYSALIASES</a>
                        </td>
                        <td>Describes the procedures, functions, and
		user-defined types in the database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_syschecks.html">SYSCHECKS</a>
                        </td>
                        <td>Describes the check constraints within
		the current database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_syscolumns.html">SYSCOLUMNS</a>
                        </td>
                        <td>Describes the columns within all tables in the
		current database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysconstraints.html">SYSCONSTRAINTS</a>
                        </td>
                        <td>Describes the information common to all
types of constraints within the current database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysdepends.html">SYSDEPENDS</a>
                        </td>
                        <td>Stores the dependency relationships between
		persistent objects in the database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="developers_fundamentals_foreignkeys.html">SYSFOREIGNKEYS</a>
                        </td>
                        <td>Describes the information specific to
		foreign key constraints in the current database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_syskeys.html">SYSKEYS</a>
                        </td>
                        <td>Describes the specific information for primary key and unique constraints within the current database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysroles.html">SYSROLES</a>
                        </td>
                        <td>Stores the roles in the database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysschemas.html">SYSSCHEMAS</a>
                        </td>
                        <td>Describes the schemas within the current
		database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_syssequences.html">SYSSEQUENCES</a>
                        </td>
                        <td>Describes the sequence generators in the
		database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysschemas.html">SYSSNAPSHOTS</a>
                        </td>
                        <td>Stores metadata for a Splice Machine snapshot.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_systables.html">SYSTABLES</a>
                        </td>
                        <td>Describes the tables and views within the current
		database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_systriggers.html">SYSTRIGGERS</a>
                        </td>
                        <td>Describes the triggers defined for the database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_systables_sysviews.html">SYSVIEWS</a>
                        </td>
                        <td>Describes the view definitions within the current
		database.</td>
                    </tr>
                </tbody>
            </table>
## Database Permissions Tables

These are the System Tables with database permissions information:

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
## Database Statistics Tables

These are the System Tables and Views with database statistics information:

<table summary="Summary table with links to and descriptions of system statistics tables/views">
    <col />
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
            <td>Statistics gathered for each column in each table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_systablestats.html">SYSTABLESTATISTICS</a>
            </td>
            <td>Describes the statistics for each table within the current
database.</td>
        </tr>
    </tbody>
</table>
## System Information Tables

These are the System Tables with system information:

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
