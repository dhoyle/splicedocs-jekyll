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

The `SYSBACKUP` table maintains information about each database backup.
You can query this table to find the ID of and details about a backup
that was run at a specific time.

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
                        <td>
                            <p><code>YES</code> for incremental backups, <code>NO</code> for full backups</p>
                            <p><strong>NOTE:</strong> Incremental backups are not yet available.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>INCREMENTAL_PARENT_BACKUP_ID</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>
                            <p class="noSpaceAbove">For an incremental backup, this is the  <code>BACKUP_ID</code> of the previous backup on which this incremental backup is based.</p>
                            <p>For full backups, this is <code>-1</code>.</p>
                            <p><strong>NOTE:</strong> Incremental backups are not yet available.</p>
                        </td>
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
</div>
</section>

