---
title: SYSSNAPSHOTS system table
summary: System table that stores metadata for Splice Machine snapshots.
keywords: snapshots metadata table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syssnapshots.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSNAPSHOTS System Table

The `SYSSSNAPSHOTS` table describes the metadata for system snapshots. It belongs to the `SYS` schema.

Table snapshots both the data and indexes for the table.
{: .noteNote}

The following table shows the contents of the `SYS.SYSSNAPSHOTS` system
table.

<table>
    <caption>SYSSNAPSHOTS system table</caption>
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
            <td><code>SNAPSHOTNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The name of the snapshot</td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Schema name</td>
        </tr>
        <tr>
            <td><code>OBJECTNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The name of the table or index</td>
        </tr>
        <tr>
            <td><code>CONGLOMERATENUMBER</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>NO</code></td>
            <td>The conglomerate number of the object</td>
        </tr>
        <tr>
            <td><code>CREATIONTIME</code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>The time at which the snapshot was taken</td>
        </tr>
        <tr>
            <td><code>LASTRESTORETIME</code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>The time at which the snapshot was most recently restored</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSSNAPSHOTS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSSNAPSHOTS;
```
{: .Example}

</div>
</section>
