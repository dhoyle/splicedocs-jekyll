---
title: Identifier Types in Splice Machine SQL
summary: A summary of the different identifier types you can use in Splice Machine SQL
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_identifiers_types.html
folder: SQLReference/Identifiers
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Identifier Types

This topic describes the different types of SQLIdentifiers that are used
in this manual. .

Complete syntax, including information about case sensitivity and
special character usage in SQL Identifier types, is found in the
[SQL Identifier Syntax](sqlref_identifiers_syntax.html) topic in this
section.
{: .noteIcon}

We use a number of different identifier types in the SQL Reference
Manual, all of which are `SQLIdentifiers`. Some can be qualified with
schema, table, or correlation names, as described in the following
table:

<table summary="Splice Machine SQL Identifier types">
                <col />
                <col />
                <tbody>
                    <tr>
                        <th>Topic</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="AuthorizationIdentifier">Authorization Identifier</td>
                        <td>
                            <p>An <code>Authorization Identifier</code> is an <code>SQLIdentifier</code> that represents the name of the user when you specify one in a connection request, otherwise known as a user name. When you connect with a user name, that name becomes the default schema name; if you do not specify a user name in the connect request, the default user name and <code>schemaName</code> is <code>SPLICE</code>.</p>
                            <p>User names can be case-sensitive within the authentication system, but they are always case-insensitive within Splice Machine's authorization system unless they are delimited.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>column-Name</code></td>
                        <td>
                            <p id="ColumnName">A <code>column-Name</code> is a <code>SQLIdentifiers</code> that can be unqualified <code>simple-column-Names</code>. or can be qualified with a <code>table-name</code> or <code>correlation-name</code>.</p>
                            <p>See the <a href="#Note.ColumnName">Column Name Notes</a> section below for information about when a <code>column-Name</code> can or cannot be qualified.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>column-Position</code></td>
                        <td>
                            <p id="ColumnPosition">A <code>column-Position</code> is an integer value that specifies the ordinal position value of the column. The first column is column <code>1</code>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>column-Name-or-Position</code></td>
                        <td>
                            <p id="ColumnNameOrPosn">A <code>column-Name-or-Position</code> is either a <a href="#ColumnName"><code>column-Name</code></a> or <a href="#ColumnPosition"><code>column-Position</code></a> value.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>constraint-Name</code></td>
                        <td>
                            <p>A <code>constraint-Name</code> is a simple <code>SQLIdentifier</code> used to name constraints.</p>
                            <p>You cannot qualify a <code>constraint-Name</code>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>correlation-Name</code></td>
                        <td>
                            <p>A <code>correlation-Name</code> is a simple SQLIdentifier used in a <code>FROM</code> clause as a new name or alias for that table.</p>
                            <p>You cannot qualify a <code>correlation-Name</code>, nor can you use it for a column named in the <code>FOR UPDATE</code> clause,  as described in the <a href="#Note.CorrelationName">Correlation Name Notes</a> section below</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="IndexName">index-Name</td>
                        <td>
                            <p>An <code>index-Name</code> is an SQLIdentifier that can be qualified with a <code>schemaName</code>. </p>
                            <p>If you do not use a qualifying schema name, the default schema is assumed. Note that system table indexes are qualified with the <code>SYS.</code> schema prefix.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="NewTableName">new-Table-Name</td>
                        <td>
                            <p>A <code>new-Table-Name</code> is a simple SQLIdentifier that is used when renaming a table with the <a href="sqlref_statements_renametable.html"><code>RENAME TABLE</code></a> statement.</p>
                            <p>You cannot qualify a new table name with a schema name, because the table already exists in a specific schema.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="RoleName">RoleName</td>
                        <td>
                            <p>A <code>RoleName</code> is a simple <code>SQLIdentifier</code> used to name roles in your database.</p>
                            <p>You cannot qualify a role name.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="SchemaName">schemaName</td>
                        <td>
                            <p>A <code>schemaName</code> is used when qualifying the names of dictionary objects such as tables and indexes.</p>
                            <p>The default user schema is named <code>SPLICE</code> if you do not specify a user name at connection time, <code>SPLICE</code> is assumed as the schema for any unqualified dictionary objects that you reference.</p>
                            <p>Note that you must always qualify references to system tables with the <code>SYS.</code> prefix, e.g. <code>SYS.SYSROLES</code>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="SimpleColumnName">simple-column-Name</td>
                        <td>
                            <p>A <code>simple-column-Name</code> is used to represent a column that is not qualified by a <code>table-Name</code> or <code>correlation-Name</code>, as described in the <a href="#Note.ColumnName">Column Name Notes</a> section below.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="SynonymName">synonym-Name</td>
                        <td>
                            <p>A <code>synonym-Name</code> is an <code>SQLIdentifier</code> used for synonyms.</p>
                            <p>You can optionally be qualify a <code>synonym-Name</code> with a <code>schemaName</code>. If you do not use a qualifying schema name, the default schema is assumed. </p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="TableName">table-Name</td>
                        <td>
                            <p>A <code>table-Name</code> is an <code>SQLIdentifier</code> use to name tables.</p>
                            <p>You can optionally qualify a <code>table-Name</code> with a <code>schemaName</code>. If you do not use a qualifying schema name, the default schema is assumed. Note that system table names are qualified with the <code>SYS.</code> schema prefix.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="TriggerName">triggerName</td>
                        <td>
                            <p>A <code>triggerName</code> is an <code>SQLIdentifier</code> used to name user-defined triggers.</p>
                            <p>You can optionally qualify a <code>triggerName</code> with a <code>schemaName</code>. If you do not use a qualifying schema name, the default schema is assumed.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont" id="ViewName">view-Name</td>
                        <td>
                            <p>A <code>view-Name</code> is an <code>SQLIdentifier</code> used to name views.</p>
                            <p>You can optionally qualify a <code>view-Name</code> with a <code>schemaName</code>. If you do not use a qualifying schema name, the default schema is assumed.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
## Column Name Notes   {#Note.ColumnName}

Column names are either `simple-column-Name` identifiers, which cannot
be qualified, or `column-Name` identifiers that can be qualified with a
`table-Name` or `correlation-Name`. Here's the syntax:

<div class="fcnWrapperWide" markdown="1">
    [ { table-Name | correlation-Name } . ] SQLIdentifier
{: .FcnSyntax}

</div>
In some circumstances, you must use a `simple-column-Name` and cannot
qualify the column name:

* When creating a table ([`CREATE TABLE`
  statement](sqlref_statements_createtable.html)).
* In a column's `correlation-Name` in a
  [`SELECT expression`](sqlref_expressions_select.html)
* In a column's`correlation-Name` in a
  [`TABLE expression`](sqlref_expressions_table.html)

## Correlation Name Notes   {#Note.CorrelationName}

You cannot use a correlation name for columns that are listed in the
`FOR UPDATE` list of a `SELECT`. For example, in the following:

<div class="preWrapperWide" markdown="1">
    SELECT Average AS corrCol1, Homeruns AS corrCol2, Strikeouts   FROM Batting    FOR UPDATE of Average, Strikeouts;
{: .Example}

</div>
* You cannot use `corrColl1` as a correlation name for `Average` because
  `Average` is listed in the `FOR UPDATE` list.
* You can use `corrCol2` as a correlation name for `HomeRuns` because
  the `HomeRuns` column is not in the update list.

</div>
</section>

