---
title: SYSTABLES system table
summary: System table that describes the tables and views within the current database.
keywords: Tables table, view table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_systables.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTABLES System Table

The `SYSTABLES` table describes the tables and views within the current
database.

The following table shows the contents of the `SYSTABLES` system table.

<table>
                <caption>SYSTABLES system table</caption>
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
                        <td><code>TABLEID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td>NO</td>
                        <td>Unique identifier for table or view</td>
                    </tr>
                    <tr>
                        <td><code>TABLENAME</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td>NO</td>
                        <td>Table or view name</td>
                    </tr>
                    <tr>
                        <td><code>TABLETYPE</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td>NO</td>
                        <td>
                            <p class="noSpaceAbove">Possible values are:</p>
                            <ul>
                                <li><code>'S'</code> (system table)</li>
                                <li> <code>'T'</code> (user table)</li>
                                <li> <code>'A'</code> (synonym)</li>
                                <li> <code>'V'</code> (view)</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>SCHEMAID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td>NO</td>
                        <td>Schema ID for the table or view</td>
                    </tr>
                    <tr>
                        <td><code>LOCKGRANULARITY</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td>NO</td>
                        <td>
                            <p class="noSpaceAbove">Lock granularity for the table:</p>
                            <ul>
                                <li> <code>'T'</code> (table level
					locking)</li>
                                <li><code>'R'</code> (row level locking, the default)</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>VERSION</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td>YES</td>
                        <td>Version ID.</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>

