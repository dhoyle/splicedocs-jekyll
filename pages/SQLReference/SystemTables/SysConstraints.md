---
title: SYSCONSTRAINTS system table
summary: System table that describes the information common to all types of constraints within the current database.
keywords: constraints table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysconstraints.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCONSTRAINTS System Table

The `SYSCONSTRAINTS` table describes the information common to all types
of constraints within the current database (currently, this includes
primary key, unique, and check constraints).

{% include splice_snippets/systablenote.md %}

The following table shows the contents of the `SYSCONSTRAINTS` system
table.

<table>
                <caption>SYSCONSTRAINTS system table</caption>
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
                        <td><code>TABLEID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>Identifier for table (join with <code>SYSTABLES.TABLEID</code>)</td>
                    </tr>
                    <tr>
                        <td><code>CONSTRAINTNAME</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td><code>NO</code></td>
                        <td>Constraint name (internally generated if not specified by user)</td>
                    </tr>
                    <tr>
                        <td><code>TYPE</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td><code>NO</code></td>
                        <td>
                            <p class="noSpaceAbove">Possible values:</p>
                            <ul>
                                <li><code>'P'</code> for primary key)</li>
                                <li> <code>'U'</code> for unique)</li>
                                <li><code>'C'</code>
for check)</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>SCHEMAID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>Identifier for schema that the constraint belongs to (join with <code>SYSSCHEMAS.SCHEMAID</code>)</td>
                    </tr>
                    <tr>
                        <td><code>STATE</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td><code>NO</code></td>
                        <td>
                            <p class="noSpaceAbove">Possible values:</p>
                            <ul>
                                <li><code>'E'</code> for enabled</li>
                                <li><code>'D'</code> for disabled</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>REFERENCECOUNT</code></td>
                        <td><code>INTEGER</code></td>
                        <td><code>10</code></td>
                        <td><code>NO</code></td>
                        <td>The count of the number of foreign key constraints that reference this constraint; this number can be greater than zero only or <code>PRIMARY KEY</code> and <code>UNIQUE</code> constraints</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>
