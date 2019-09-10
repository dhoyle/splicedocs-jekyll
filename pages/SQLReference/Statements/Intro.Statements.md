---
title: Statements summary
summary: Summarizes all of the SQL statements available in Splice Machine SQL.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_intro.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Statements

This section contains the reference documentation for the Splice Machine
SQL Statements, in the following subsections:

* [Data Definition (DDL) - General Statements](#ddlgeneral)
* [Data Definition (DDL) - Create Statements](#ddlcreate)
* [Data Definition (DDL) - Drop Statements](#ddldrop)
* [Data Manipulation (DML) Statements](#dml)
* [Session Control Statements](#Session)

## Data Definition - General Statements  {#ddlgeneral}

These are the general data definition statements:

<table summary="Summary table with links to and descriptions of general data definition statement topics">
    <col />
    <col />
    <thead>
        <tr>
            <th>Statement</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_altertable.html">ALTER TABLE</a>
            </td>
            <td>Add, deletes, or modifies columns in an existing table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_grant.html">GRANT</a>
            </td>
            <td>Gives privileges to specific user(s) or role(s) to perform actions on database objects.</td>
        </tr>
<!--
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_pintable.html">PIN TABLE</a>
            </td>
            <td>Caches a table in memory for improved performance.</td>
        </tr>
-->
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_renamecolumn.html">RENAME COLUMN</a>
            </td>
            <td>Renames a column in a table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_renameindex.html">RENAME INDEX</a>
            </td>
            <td>Renames an index in the current schema.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_renametable.html">RENAME TABLE</a>
            </td>
            <td>Renames an existing table in a schema.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_revoke.html">REVOKE</a>
            </td>
            <td>Revokes privileges for specific user(s) or role(s) to perform actions on database objects.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_truncatetable.html">TRUNCATE TABLE</a>
            </td>
            <td>Resets a table to its initial empty state.</td>
        </tr>
<!--
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_unpintable.html">UNPIN TABLE</a>
            </td>
            <td>Unpins a pinned (cached) table.</td>
        </tr>
-->
    </tbody>
</table>
## Data Definition (DDL) - CREATE Statements  {#ddlcreate}

These are the statements for creating database objects:

<table summary="Summary table with links to and descriptions of DDL CREATE statement topics">
    <col />
    <col />
    <thead>
        <tr>
            <th>Statement</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createexternaltable.html">CREATE EXTERNAL TABLE</a>
            </td>
            <td>Allows you to query data stored in a flat file as if that data were stored in a Splice Machine table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createfunction.html">CREATE FUNCTION</a>
            </td>
            <td>Creates Java functions that you can then use in expressions. </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createindex.html">CREATE INDEX</a>
            </td>
            <td>Creates an index on a table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createprocedure.html">CREATE PROCEDURE</a>
            </td>
            <td>Creates Java stored
procedures, which you can then call using the <a href="sqlref_statements_callprocedure.html"><code>Call Procedure</code></a> statement.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createrole.html">CREATE ROLE</a>
            </td>
            <td>Creates SQL roles.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createschema.html">CREATE SCHEMA</a>
            </td>
            <td>Creates a schema.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createsequence.html">CREATE SEQUENCE</a>
            </td>
            <td>Creates a sequence generator, which is
a mechanism for generating exact numeric values, one at a time.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createsynonym.html">CREATE SYNONYM</a>
            </td>
            <td> Creates a synonym, which can provide an alternate name
for a table or a view.
</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createtable.html">CREATE TABLE</a>
            </td>
            <td>Creates a new table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createtemptable.html">CREATE TEMPORARY TABLE</a>
            </td>
            <td>Defines a temporary table for the current connection.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createtrigger.html">CREATE TRIGGER</a>
            </td>
            <td>Creates a trigger, which defines a set of actions that are executed when a database event occurs on a specified table</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_createview.html">CREATE VIEW</a>
            </td>
            <td>Creates a view, which is a virtual table formed by a query.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_statements_globaltemptable.html">DECLARE GLOBAL TEMPORARY TABLE</a>
            </td>
            <td>Defines a temporary table for the current connection.</td>
        </tr>
    </tbody>
</table>
## Data Definition (DDL) - DROP Statements  {#ddldrop}

These are the drop statements:

<table summary="Summary table with links to and descriptions of DDL DROP statement topics">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Statement</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropfunction.html">DROP FUNCTION</a>
                        </td>
                        <td>Drops a function from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropindex.html">DROP INDEX</a>
                        </td>
                        <td>Drops an index from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropprocedure.html">DROP PROCEDURE</a>
                        </td>
                        <td>Drops a procedure from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_droprole.html">DROP ROLE</a>
                        </td>
                        <td>Drops a role from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropschema.html">DROP SCHEMA</a>
                        </td>
                        <td>Drops a schema from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropsequence.html">DROP SEQUENCE</a>
                        </td>
                        <td>Drops a sequence from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropsynonym.html">DROP SYNONYM</a>
                        </td>
                        <td>Drops a synonym from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_droptable.html">DROP TABLE</a>
                        </td>
                        <td>Drops a table from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_droptrigger.html">DROP TRIGGER</a>
                        </td>
                        <td>Drops a trigger from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropview.html">DROP VIEW</a>
                        </td>
                        <td>Drops a view from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_dropfunction.html">DROP FUNCTION</a>
                        </td>
                        <td>Drops a function from a database.</td>
                    </tr>
                </tbody>
            </table>
## Data Manipulation (DML) Statements  {#dml}

These are the data manipulation statements:

<table summary="Summary table with links to and descriptions of DML statement topics">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Statement</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_callprocedure.html">CALL PROCEDURE</a>
                        </td>
                        <td>Calls a stored procedure.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_delete.html">DELETE</a>
                        </td>
                        <td>Deletes records from a table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_insert.html">INSERT</a>
                        </td>
                        <td>Inserts records into a table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_expressions_select.html">SELECT</a>
                        </td>
                        <td>Selects records.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_update.html">UPDATE TABLE</a>
                        </td>
                        <td>Updates values in a table.</td>
                    </tr>
                </tbody>
            </table>
## Session Control Statements   {#Session}

These are the session control statements:

<table summary="Summary table with links to and descriptions of session control statement topics">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Statement</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_setrole.html">SET ROLE</a>
                        </td>
                        <td>Sets the current role for the current SQL context of a session.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_statements_setschema.html">SET SCHEMA</a>
                        </td>
                        <td>Sets the default schema for a connection's session.</td>
                    </tr>
                </tbody>
            </table>
{% include splice_snippets/githublink.html %}
</div>
</section>
