---
title: SYSCONGLOMERATES system table
summary: System table that describes the conglomerates within the current database. A conglomerate is a unit of storage that is either a table or an index.
keywords: conglomerates table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysconglomerates.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCONGLOMERATES System Table

The `SYSCONGLOMERATES` table describes the conglomerates within the
current database.  It belongs to the `SYS` schema.

A conglomerate is a unit of storage and is either a
table or an index.

The following table shows the contents of the `SYS.SYSCONGLOMERATES` system
table.

<table>
    <caption>SYSCONGLOMERATES system table</caption>
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
            <td>Schema ID for the conglomerate</td>
        </tr>
        <tr>
            <td><code>TABLEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Identifier for table (join with <code>SYSTABLES.TABLEID</code>)</td>
        </tr>
        <tr>
            <td><code>CONGLOMERATENUMBER</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>NO</code></td>
            <td>Conglomerate ID for the conglomerate (heap or index)</td>
        </tr>
        <tr>
            <td><code>CONGLOMERATENAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>YES</code></td>
            <td>Index name, if conglomerate is an index, otherwise the
		table ID</td>
        </tr>
        <tr>
            <td><code>ISINDEX</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Whether or not conglomerate is an index</td>
        </tr>
        <tr>
            <td><code>DESCRIPTOR</code></td>
            <td><code>org.apache.splicemachine.<br />catalog.IndexDescriptor</code></td>
            <td><code>-1</code></td>
            <td><code>YES</code></td>
            <td><p>System type describing the index</p>
                <p>This class is not part of the public API.</p></td>
        </tr>
        <tr>
            <td><code>ISCONSTRAINT</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>YES</code></td>
            <td>Whether or not the conglomerate is a system-generated index enforcing a constraint</td>
        </tr>
        <tr>
            <td><code>CONGLOMERATEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the conglomerate</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to system tables is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding [`SYSVW.SYSCONGLOMERATEINSCHEMAS` system view](sqlref_sysviews_sysconglomerateinschemas.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSCONGLOMERATES;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message that the table doesn't exist, you don't have access to the table; use the [`SYSVW.SYSCONGLOMERATEINSCHEMAS` system view](sqlref_sysviews_sysconglomerateinschemas.html) instead.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSCONGLOMERATES;
```
{: .Example}


</div>
</section>
