---
title: SYSSCHEMAS system table
summary: System table that describes the schemas within the current database.
keywords: schemas table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysschemas.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSCHEMAS System Table

The `SYSSCHEMAS` table describes the schemas within the current
database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSSCHEMAS` system table.

<table>
    <caption>SYSSCHEMAS system table</caption>
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Length</th>
            <th>Nullable</th>
            <th>Contents</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the schema</td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Schema name</td>
        </tr>
        <tr>
            <td><code> AUTHORIZATIONID</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization identifier of the owner of the schema</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding&nbsp;&nbsp; [`SYSVW.SYSSCHEMASVIEW` system view](sqlref_sysviews_sysschemasview.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSSCHEMAS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the [`SYSVW.SYSSCHEMASVIEW` system view](sqlref_sysviews_sysschemasview.html) instead.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSSCHEMAS;
```
{: .Example}
</div>
</section>
