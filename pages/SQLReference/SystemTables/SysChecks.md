---
title: SYSCHECKS system table
summary: System table that describes the check constraints within the current database.
keywords: constraint checks table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syschecks.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCHECKS System Table

The `SYSCHECKS` table describes the check constraints within the current
database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSCHECKS` system table.

<table>
    <caption>SYSCHECKS system table</caption>
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
            <td>Unique identifier for the constraint</td>
        </tr>
        <tr>
            <td><code>CHECKDEFINITION</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>32,700</code></td>
            <td><code>NO</code></td>
            <td>Text of check constraint definition</td>
        </tr>
        <tr>
            <td><code>REFERENCEDCOLUMNS</code></td>
            <td><code>com.splicemachine.db.<br />catalog.ReferencedColumns</code></td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td><p>Description of the columns referenced by the check constraint</p>
                <p>This class is not part of the public API.</p></td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to system tables is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSCHECKS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message that the table doesn't exist, you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSCHECKS;
```
{: .Example}

</div>
</section>
