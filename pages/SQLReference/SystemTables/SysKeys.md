---
title: SYSKEYS system table
summary: System table that describes the specific information for primary key and unique constraints within the current database.
keywords: primary keys table, constraints table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syskeys.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSKEYS System Table

The `SYSKEYS` table describes the specific information for primary key
and unique constraints within the current database. It belongs to the `SYS` schema.

Splice Machine generates an index on the table to back up each such
constraint. The index name is the same as `SYSKEYS.CONGLOMERATEID`.

The following table shows the contents of the `SYS.SYSKEYS` system table.

<table>
    <caption>SYSKEYS system table</caption>
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
            <td><code>CONSTRAINTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for constraint</td>
        </tr>
        <tr>
            <td><code>CONGLOMERATEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for backing index</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSKEYS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSKEYS;
```
{: .Example}

</div>
</section>
