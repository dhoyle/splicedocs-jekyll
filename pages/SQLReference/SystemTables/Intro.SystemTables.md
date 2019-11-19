---
title: Splice Machine System Tables
summary: Summarizes the Splice Machine system tables
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_intro.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# System Tables

This section contains the reference documentation for the Splice Machine System Tables:

Since the system tables belong to the `SYS` schema, you must preface any inquiries involving these tables with the `SYS.` prefix.

As of release 2.8 of Splice Machine, `ACCESS` privileges are not granted by default to objects belonging to the `SYS` schema. Your DBA must explicitly grant you access to system tables.
{: .noteIcon}

You can use the Java `java.sql.DatabaseMetaData` class to learn more about these tables.
{: .noteNote}

## Database Backups Tables  {#backups}
The following table lists the System Tables with backups information:

The tables listed in this section apply only to our on-premise database product.
{: .noteIcon}

<table summary="Summary table with links to and descriptions of system tables">
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
            <td class="CodeFont"><a href="sqlref_systables_sysaliases.html">SYS.SYSALIASES</a>
            </td>
            <td>Describes the procedures, functions, and user-defined types in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysbackup.html">SYS.SYSBACKUP</a>
            </td>
            <td>Information about each run of a backup job that has been run for the database. You can query this table to determine status information about a specific backup job.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysbackupitems.html">SYS.SYSBACKUPITEMS</a>
            </td>
            <td>Information about the items backed up for each backup job.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_syschecks.html">SYS.SYSCHECKS</a>
            </td>
            <td>Describes the check constraints within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_syscolperms.html">SYS.SYSCOLPERMS</a>
            </td>
            <td>Stores the column permissions that have been granted but not revoked.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_syscolumns.html">SYS.SYSCOLUMNS</a>
            </td>
            <td>Describes the columns within all tables in the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysconglomerates.html">SYS.SYSCONGLOMERATES</a>
            </td>
            <td>Describes the conglomerates within the current database. A conglomerate is a unit of storage and is either a table or an index.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysconstraints.html">SYS.SYSCONSTRAINTS</a>
            </td>
            <td>Describes the information common to all types of constraints within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysdepends.html">SYS.SYSDEPENDS</a>
            </td>
            <td>Stores the dependency relationships between persistent objects in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysfiles.html">SYS.SYSFILES</a>
            </td>
            <td>Describes jar files stored in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="developers_fundamentals_foreignkeys.html">SYS.SYSFOREIGNKEYS</a>
            </td>
            <td>Describes the information specific to foreign key constraints in the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_syskeys.html">SYS.SYSKEYS</a>
            </td>
            <td>Describes the specific information for primary key and unique constraints within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysperms.html">SYS.SYSPERMS</a>
            </td>
            <td>Describes the usage permissions for sequence generators and user-defined types.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysroles.html">SYS.SYSROLES</a>
            </td>
            <td>Stores the roles in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysroutineperms.html">SYS.SYSROUTINEPERMS</a>
            </td>
            <td>Stores the permissions that have been granted to routines.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysschemas.html">SYS.SYSSCHEMAS</a>
            </td>
            <td>Describes the schemas within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_syssequences.html">SYS.SYSSEQUENCES</a>
            </td>
            <td>Describes the sequence generators in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysschemas.html">SYS.SYSSNAPSHOTS</a>
            </td>
            <td>Stores metadata for a Splice Machine snapshot.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysstatements.html">SYS.SYSSTATEMENTS</a>
            </td>
            <td>Describes the prepared statements in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_systableperms.html">SYS.SYSTABLEPERMS</a>
            </td>
            <td>Stores the table permissions that have been granted but not revoked.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_systables.html">SYS.SYSTABLES</a>
            </td>
            <td>Describes the tables and views within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_systablestats.html">SYS.SYSTABLESTATS</a>
            </td>
            <td>Statistics for tables within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_systriggers.html">SYS.SYSTRIGGERS</a>
            </td>
            <td>Describes the triggers defined for the database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysusers.html">SYS.SYSUSERS</a>
            </td>
            <td>Stores user credentials when NATIVE authentication is enabled.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_systables_sysviews.html">SYS.SYSVIEWS</a>
            </td>
            <td>Describes the view definitions within the current database.</td>
        </tr>
    </tbody>
</table>
</div>
</section>
