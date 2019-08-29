---
title: SYSROUTINEPERMSVIEW System View
summary: System view that stores the permissions that have been granted to routines
keywords: routines, permissions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysroutinepermsview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSROUTINEPERMSVIEW System View

The `SYSROUTINEPERMSVIEW` view stores the permissions that have been
granted to routines. It belongs to the `SYS` schema.

Each routine `EXECUTE` permission is specified in a row in the
`SYSROUTINEPERMSVIEW` view.

The following table shows the contents of the `SYS.SYSROUTINEPERMSVIEW` system
view.

<table>
    <tbody>
        <tr>
            <td><code>ROUTINEPERMSID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The unique ID of the permission. This is the primary key.</td>
        </tr>
        <tr>
            <td><code>GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user or role to which the privilege was granted</td>
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
            <td>The routine's alias ID, which points to the alias ID field in the <code>SYS.ALIASES</code> system table.</td>
        </tr>
        <tr>
            <td><code>GRANTOPTION</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>GRANTEE</code> is the owner of the routine. Valid values are <code>'Y'</code> and <code>'N'</code>.</td>
        </tr>
        <tr>
            <td><code>ALIAS</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Alias (in the case of a user-defined type, the name of the user-defined type)</td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Schema name</td>
        </tr>
    </tbody>
</table>
## Usage Note

This is a view on the system table, [`SYS.SYSROUTINEPERMS`](sqlref_systables_sysroutineperms.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSROUTINEPERMS;
```
{: .Example}

If you see the table description, you have access. If you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the view instead.

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSROUTINEPERMSVIEW;
```
{: .Example}

</div>
</section>
