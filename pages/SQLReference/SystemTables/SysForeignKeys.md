---
title: SYSFOREIGNKEYS system table
summary: System table that describes the information specific to foreign key constraints in the current database.
keywords: foreign keys table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysforeignkeys.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSFOREIGNKEYS System Table

The `SYSFOREIGNKEYS` table describes the information specific to foreign
key constraints in the current database.

Splice Machine generates a backing index for each foreign key
constraint. The name of this index is the same as
`SYSFOREIGNKEYS.CONGLOMERATEID`.

The following table shows the contents of the `SYSFOREIGNKEYS` system
table.

<table>
                <caption>SYSFOREIGNKEYS system table</caption>
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
                        <td>Unique identifier for the foreign key constraint (join with <code>SYSCONSTRAINTS.CONSTRAINTID</code>)</td>
                    </tr>
                    <tr>
                        <td><code>CONGLOMERATEID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>Unique identifier for index backing up the foreign key constraint (join with <code>SYSCONGLOMERATES.CONGLOMERATEID</code>)</td>
                    </tr>
                    <tr>
                        <td><code>KEYCONSTRAINTID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>Unique identifier for the primary key or unique constraint referenced by this foreign key <code>SYSKEYS.CONSTRAINTID</code> or <code>SYSCONSTRAINTS.CONSTRAINTID</code>)</td>
                    </tr>
                    <tr>
                        <td><code>DELETERULE</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td><code>NO</code></td>
                        <td>
                            <p class="noSpaceAbove">Possible values:</p>
                            <p><code>'R'</code> for <code>NO ACTION</code> (default)</p>
                            <p><code>'S'</code> for <code>RESTRICT</code></p>
                            <p> <code>'C'</code> for <code>CASCADE</code></p>
                            <p><code>'U'</code> for <code>SET NULL</code></p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>UPDATERULE</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td><code>NO</code></td>
                        <td>
                            <p class="noSpaceAbove">Possible values:</p>
                            <p><code>'R'</code> for <code>NO ACTION</code> (default)</p>
                            <p><code>'S'</code> for <code>RESTRICT</code></p>
                        </td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

