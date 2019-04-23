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
and unique constraints within the current database.

Splice Machine generates an index on the table to back up each such
constraint. The index name is the same as `SYSKEYS.CONGLOMERATEID`.

The following table shows the contents of the `SYSKEYS` system table.

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
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>

