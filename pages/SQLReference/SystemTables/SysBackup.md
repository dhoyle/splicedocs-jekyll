---
title: SYSBACKUP system table
summary: System table that stores information about each run of a backup job for the database.
keywords: backup jobs table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysbackup.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSBACKUP System Table

The `SYSBACKUP` table maintains information about each database backup. It belongs to the `SYS` schema.

You can query this table to find the ID of and details about a backup
that was run at a specific time.

The following table shows the contents of the `SYS.SYSBACKUP` system table.

<table>
    <caption>SYSBACKUP system table</caption>
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
            <td>The backup ID</td>
        </tr>
        <tr>
            <td><code>BEGIN_TIMESTAMP </code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>The start time of the backup</td>
        </tr>
        <tr>
            <td><code>END_TIMESTAMP </code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>YES</code></td>
            <td>The end time of the backup</td>
        </tr>
        <tr>
            <td><code>STATUS</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>10</code></td>
            <td><code>NO</code></td>
            <td>The status of the backup</td>
        </tr>
        <tr>
            <td><code>FILESYSTEM </code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32642</code></td>
            <td><code>NO</code></td>
            <td>The backup destination directory</td>
        </tr>
        <tr>
            <td><code>SCOPE </code></td>
            <td><code>VARCHAR</code></td>
            <td><code>10</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">The scope of the backup: database, schemas, tables, etc. The current allowable values are:</p>
                <ul>
                    <li><code>D</code> for the entire database</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>INCREMENTAL_BACKUP</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td><code>YES</code> for incremental backups, <code>NO</code> for full backups</td>
        </tr>
        <tr>
            <td><code>INCREMENTAL_PARENT_BACKUP_ID</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>For an incremental backup, this is the  <code>BACKUP_ID</code> of the previous backup on which this incremental backup is based. For full backups, this is <code>-1</code>.</td>
        </tr>
        <tr>
            <td><code>BACKUP_ITEM</code></td>
            <td><code>INTEGER</code></td>
            <td><code>10</code></td>
            <td><code>YES</code></td>
            <td>The number of tables that were backed up.</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSBACKUP;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSBACKUP;
```
{: .Example}

</div>
</section>
