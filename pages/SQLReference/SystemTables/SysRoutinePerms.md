---
title: SYSROUTINEPERMS system table
summary: System table that stores the permissions that have been granted to routines.
keywords: routine permissions table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysroutineperms.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSROUTINEPERMS System Table

The `SYSROUTINEPERMS` table stores the permissions that have been
granted to routines. It belongs to the `SYS` schema.

Each routine `EXECUTE` permission is specified in a row in the
`SYSROUTINEPERMS` table. The keys for the `SYSROUTINEPERMS` table are:

* Primary key (`GRANTEE, ALIASID, GRANTOR`)
* Unique key (`ROUTINEPERMSID`)
* Foreign key (`ALIASID` references `SYS.SYSALIASES`)

The following table shows the contents of the `SYS.SYSROUTINEPERMS` system
table.

<table>
    <caption>SYSROUTINEPERMS system table</caption>
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
            <td><code> ROUTINEPERMSID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Used by the dependency manager to track the dependency of a view, trigger, or constraint on the routine level permissions</td>
        </tr>
        <tr>
            <td><code>GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user or role to which the privilege is granted</td>
        </tr>
        <tr>
            <td><code>GRANTOR</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user who granted the privilege. Privileges can be granted only by the object owner.</td>
        </tr>
        <tr>
            <td><code>ALIASID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">The ID of the object of the required permission.</p>
                <p> If <code>PERMTYPE</code>=<code>'E'</code>, the <code>ALIASID</code> is a reference to the <code>SYS.SYSALIASES</code> table.</p>
                <p> Otherwise, the <code>ALIASID</code> is a reference to the <code>SYS.SYSTABLES</code> table.</p>
            </td>
        </tr>
        <tr>
            <td><code>GRANTOPTION</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>GRANTEE</code> is the owner of the routine. Valid values are <code>'Y'</code> and <code>'N'</code>.</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding [`SYSVW.SYSROUTINEPERMSVIEW` system view](sqlref_sysviews_sysroutinepermsview.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSROUTINEPERMS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the [`SYSVW.SYSROUTINEPERMSVIEW` system view](sqlref_sysviews_sysroutinepermsview.html) instead.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSROUTINEPERMS;
```
{: .Example}


</div>
</section>
