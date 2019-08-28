---
title: SYSDEPENDS system table
summary: System table that stores the dependency relationships between persistent objects in the database.
keywords: dependencies table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysdepends.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSDEPENDS System Table

The `SYSDEPENDS` table stores the dependency relationships between
persistent objects in the database. It belongs to the `SYS` schema.

Persistent objects can be dependents or providers. Dependents are
objects that depend on other objects. Providers are objects that other
objects depend on.

* Dependents are views, constraints, or triggers.
* Providers are tables, conglomerates, constraints, or privileges.

The following table shows the contents of the `SYS.SYSDEPENDS` system table.

<table>
    <caption>SYSDEPENDS system table</caption>
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
            <td><code>DEPENDENTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>A unique identifier for the dependent</td>
        </tr>
        <tr>
            <td><code>DEPENDENTFINDER</code></td>
            <td><code>com.splicemachine.db.<br />catalog.TypeDescriptor</code></td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td>A system type that describes the view, constraint, or trigger that is the dependent</td>
        </tr>
        <tr>
            <td><code>PROVIDERID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>A unique identifier for the provider</td>
        </tr>
        <tr>
            <td><code>PROVIDERFINDER</code></td>
            <td><code>com.splicemachine.db.<br />catalog.TypeDescriptor</code></td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td><p>A system type that describes the table, conglomerate, constraint, and privilege that is the provider</p>
                <p>This class isnot part of the public API.</p></td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to system tables is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSDEPENDS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message that the table doesn't exist, you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSDEPENDS;
```
{: .Example}

</div>
</section>
