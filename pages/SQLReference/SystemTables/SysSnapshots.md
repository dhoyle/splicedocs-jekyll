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

The `SYSSSNAPSHOTS` table describes the metadata for system snapshots.

{% include splice_snippets/systablenote.md %}

The following table shows the contents of the `SYSSNAPSHOTS` system
table.

Table snapshots both the data and indexes for the table.
{: .noteNote}

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
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>
