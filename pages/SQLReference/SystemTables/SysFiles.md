---
title: SYSFILES system table
summary: System table that describes jar files stored in the database.
keywords: files table, jar files table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysfiles.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSFILES System Table

The `SYSFILES` table describes jar files stored in the database.  It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSFILES` system table.

<table>
        <caption>SYSFILES system table</caption>
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
                <td><code>FILEID</code></td>
                <td><code>CHAR</code></td>
                <td><code>36</code></td>
                <td><code>NO</code></td>
                <td>Unique identifier for the jar file</td>
            </tr>
            <tr>
                <td><code>SCHEMAID</code></td>
                <td><code>CHAR</code></td>
                <td><code>36</code></td>
                <td><code>NO</code></td>
                <td>ID of the jar file's schema (join with <code>SYSSCHEMAS.SCHEMAID</code>)</td>
            </tr>
            <tr>
                <td><code>FILENAME</code></td>
                <td><code>VARCHAR</code></td>
                <td><code>128</code></td>
                <td><code>NO</code></td>
                <td>SQL name of the jar file</td>
            </tr>
            <tr>
                <td><code>GENERATIONID</code></td>
                <td><code>BIGINT</code></td>
                <td><code>19</code></td>
                <td><code>NO</code></td>
                <td>Generation number for the file. When jar files are replaced, their generation identifiers are changed.</td>
            </tr>
        </tbody>
    </table>

## Usage Example and Restrictions

Here's an example of using this table:

```
SELECT * FROM SYS.SYSFILES;
```
{: .Example}

{% include splice_snippets/systableaccessnote.md %}

</div>
</section>
