---
title: SYSBACKUPITEMS system table
summary: System table that stores information about the items backed up for each backup job.
keywords: backup items table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysbackupitems.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSBACKUPITEMS System Table

The `SYSBACKUPITEMS` table maintains information about each item
(table) backed up during a backup. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSBACKUPITEMS` system table.

<table>
    <caption>SYSBACKUPITEMS system table</caption>
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
            <td><code>BACKUP_ID </code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>NO</code></td>
            <td>The backup ID.</td>
        </tr>
        <tr>
            <td><code>ITEM</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32642</code></td>
            <td><code>NO</code></td>
            <td>The name of the item.</td>
        </tr>
        <tr>
            <td><code>BEGIN_TIMESTAMP </code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>The start time of backing up this item.</td>
        </tr>
        <tr>
            <td><code>END_TIMESTAMP </code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>YES</code></td>
            <td>The end time of backing up this item.</td>
        </tr>
        <tr>
            <td><code>SNAPSHOT_NAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32642</code></td>
            <td><code>NO</code></td>
            <td>The name of the snapshot associated with this item.</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSBACKUPITEMS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSBACKUPITEMS;
```
{: .Example}

</div>
</section>
