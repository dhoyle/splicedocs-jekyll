---
title: SYSVIEWS system table
summary: System table that describes the view definitions within the current database.
keywords: view definitions table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysviews.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSVIEWS System Table

The `SYSVIEWS` table describes the view definitions within the current
database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSVIEWS` system table.

<table>
    <caption>SYSVIEWS system table</caption>
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
            <td><code>NO</code></td>
            <td>Unique identifier for the view (join with <code>SYSTABLES.TABLEID</code>)</td>
        </tr>
        <tr>
            <td><code>VIEWDEFINITION</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>32,700</code></td>
            <td><code>NO</code></td>
            <td>Text of view definition</td>
        </tr>
        <tr>
            <td><code>CHECKOPTION</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td><code>'N'</code> (check option not supported yet)</td>
        </tr>
        <tr>
            <td><code>COMPILATIONSCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>ID of the schema containing the view</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to system tables is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSVIEWS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message that the table doesn't exist, you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSVIEWS;
```
{: .Example}

</div>
</section>
