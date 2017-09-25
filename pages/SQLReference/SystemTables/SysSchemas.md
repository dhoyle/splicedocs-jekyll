---
title: SYSSCHEMAS system table
summary: System table that describes the schemas within the current database.
keywords: schemas table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_sysschemas.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSCHEMAS System Table   {#SystemTables.SysSchemas}

The `SYSSCHEMAS` table describes the schemas within the current
database.

The following table shows the contents of the `SYSSCHEMAS` system table.

<table>
                <caption>SYSSCHEMAS system table</caption>
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
                        <td><code>SCHEMAID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>Unique identifier for the schema</td>
                    </tr>
                    <tr>
                        <td><code>SCHEMANAME</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td><code>NO</code></td>
                        <td>Schema name</td>
                    </tr>
                    <tr>
                        <td><code> AUTHORIZATIONID</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td><code>NO</code></td>
                        <td>The authorization identifier of the owner of the schema</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>

