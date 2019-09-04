---
title: SYSSOURCECODE system table
summary: System table that stores Splice*Plus procedures.
keywords: Prepared statements table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syssourcecode.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSOURCECODE System Table

The `SYSSOURCECODE` table contains the Splice*Plus procedures that you've stored. It belongs to the `SYS` schema.

The table contains one row per stored prepared statement.

The following table shows the contents of the `SYS.SYSSOURCECODE` system
table.

<table>
    <caption>SYSSOURCECODE system table</caption>
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
            <td><code>SCHEMA_NAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Name of the use who owns the code object.</td>
        </tr>
        <tr>
            <td><code>OBJECT_NAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Name of the code object.</td>
        </tr>
        <tr>
            <td><code>OBJECT_TYPE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32</code></td>
            <td><code>NO</code></td>
            <td>The user-defined type of the code object; for example: 'Function'.</td>
        </tr>
        <tr>
            <td><code>OBJECT_FORM</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The user-defined format of the source text; for example: 'Java8@UTF8'.</td>
        </tr>
        <tr>
            <td><code>DEFINER_NAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The name of the user saving the code object.</td>
        </tr>
        <tr>
            <td><code>SOURCE_CODE</code></td>
            <td><code>BLOB</code></td>
            <td><code>64MB</code></td>
            <td><code>NO</code></td>
            <td><p>The source text for the code object.</p>
                <p>Set this column to <code>NULL</code> to request deletion of this object.</p>
            </td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSSOURCECODE;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example and Restrictions

Here's an example of using this table:

```
SELECT * FROM SYS.SYSSOURCECODE;
```
{: .Example}

</div>
</section>
