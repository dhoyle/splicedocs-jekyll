---
title: SYSTABLES system table
summary: System table that describes the tables and views within the current database.
keywords: Tables table, view table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_systables.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTABLES System Table

The `SYSTABLES` table describes the tables and views within the current
database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSTABLES` system table.

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
                    <li><code>'T'</code> (user table)</li>
                    <li><code>'A'</code> (synonym)</li>
                    <li><code>'V'</code> (view)</li>
                    <li><code>'E'</code> (external table)</li>
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

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding [`SYSVW.SYSTABLESVIEW` system view](sqlref_sysviews_systablesview.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSTABLES;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the [`SYSVW.SYSTABLESVIEW` system view](sqlref_sysviews_systablesview.html) instead.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSTABLES;
```
{: .Example}

</div>
</section>
