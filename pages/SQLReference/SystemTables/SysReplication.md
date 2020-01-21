---
title: SYSREPLICATION system table
summary: System table that describes database table replication information.
keywords: replication
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysreplication.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSREPLICATION System Table

The `SYSREPLICATION` table describes replication information for a specific database table. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSREPLICATION` system table.

<table>
    <caption>SYSREPLICATION system table</caption>
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
            <td><code>DATABASE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>10</code></td>
            <td><code>NO</code></td>
            <td>The database ID.</td>
        </tr>
        <tr>
            <td><code>SCHEMA</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>YES</code></td>
            <td>The schema name.</td>
        </tr>
        <tr>
            <td><code>TABLE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>YES</code></td>
            <td>The name of the table.</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSREPLICATION;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSREPLICATION;
```
{: .Example}

</div>
</section>
