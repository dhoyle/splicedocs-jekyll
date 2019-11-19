---
title: Splice Machine System Views
summary: Summarizes the Splice Machine system views
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_intro.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# System Views

This section contains the reference documentation for the Splice Machine
System Views.

<div class="noteIcon" markdown="1">
System views return a subset of the rows in their corresponding system tables: the rows in a view are limited to the schemas that are visible to the current user. This means that which rows are in a system view varies from user to user.

These schemas are visible to the current user:

* Schemas owned by the current user
* Schemas to which the current user belongs
* Schemas to which user groups in which the current user is a member belongs
* Schemas to which roles granted directly or indirectly to the current user have acess

The database administrator has access to all schemas, and thus all rows in the system tables.

</div>

Since the system views belong to the `SYSVW` schema, you must preface any
inquiries involving these views with the `SYSVW.` prefix.

The following table lists the System Views:

<table summary="Summary table with links to and descriptions of system views">
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
            <td class="CodeFont"><a href="sqlref_sysviews_sysallroles.html">SYSVW.SYSALLROLES</a></td>
            <td>Displays all of the roles that have been granted to the current user, and the user groups to which the current user belongs.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_syscolpermsview.html">SYSVW.SYSCOLPERMSVIEW</a></td>
            <td>Describes the column permissions that have been granted but not revoked in the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_syscolumnstats.html">SYSVW.SYSCOLUMNSTATISTICS</a></td>
            <td>Statistics gathered for each column in each table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_syscolumns.html">SYSVW.SYSCOLUMNSVIEW</a></td>
            <td>Describes the columns within all tables in the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_sysconglomeratesinschemas.html">SYSVW.SYSCONGLOMERATESINSCHEMAS</a>
            </td>
            <td>Describes the conglomerates within the current database. A conglomerate is a unit of storage and is either a table or an index.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_syspermsview.html">SYSVW.SYSPERMSVIEW</a></td>
            <td>Describes the usage permissions for sequence
            generators and user-defined types current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_sysroutinepermsview.html">SYSVW.SYSROUTINEPERMSVIEWS</a></td>
            <td>Describes the permissions that have been granted but not revoked for routines in the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_sysschemapermsview.html">SYSVW.SYSSCHEMAPERMSVIEW</a></td>
            <td>Describes the schema permissions that have been granted but not revoked within the current
            database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_sysschemasview.html">SYSVW.SYSSCHEMASVIEWS</a></td>
            <td>Describes the schemas within the current database to which the current user has access.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_systablepermsview.html">SYSVW.SYSTABLEPERMSVIEW</a></td>
            <td>Describes the table permissions that have been granted but not revoked in the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_systablestats.html">SYSVW.SYSTABLESTATISTICS</a></td>
            <td>Describes the statistics for each table within the current database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysviews_systablesview.html">SYSVW.SYSTABLESVIEW</a></td>
            <td>Describes the tables and views within the current database.</td>
        </tr>
    </tbody>
</table>

</div>
</section>
