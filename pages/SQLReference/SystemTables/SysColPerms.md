---
title: SYSCOLPERMS system table
summary: System table that stores the column permissions that have been granted but not revoked.
keywords: column permissions table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syscolperms.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCOLPERMS System Table

The `SYSCOLPERMS` table stores the column permissions that have been
granted but not revoked. It belongs to the `SYS` schema.

All of the permissions for one (`GRANTEE, TABLEID, TYPE, GRANTOR`)
combination are specified in a single row in the `SYSCOLPERMS` table.
The keys for the `SYSCOLPERMS` table are:

* Primary key (`GRANTEE, TABLEID, TYPE, GRANTOR`)
* Unique key (`COLPERMSID`)
* Foreign key (`TABLEID` references `SYS.SYSTABLES`)

The following table shows the contents of the `SYS.SYSCOLPERMS` system
table.

<table>
    <caption>SYSCOLPERMS system table</caption>
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
            <td><code>COLPERMSID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Used by the dependency manager to track the dependency
of a view, trigger, or constraint on the column level permissions</td>
        </tr>
        <tr>
            <td><code>GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user or role to which the
privilege was granted</td>
        </tr>
        <tr>
            <td><code>GRANTOR</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user who granted the privilege.
Privileges can be granted only by the object owner</td>
        </tr>
        <tr>
            <td><code>TABLEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The unique identifier for the table on which the permissions
have been granted</td>
        </tr>
        <tr>
            <td><code>TYPE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>If the privilege is non-grantable, the valid values are:
<ul><li><code>'s'</code> for <code>SELECT</code></li><li><code>'u'</code> for <code>UPDATE</code></li><li><code>'r'</code> for <code>REFERENCES</code><br /></li></ul><p>
If the privilege is grantable, the valid values are:
</p><ul><li><code>'S'</code> for <code>SELECT</code></li><li><code>'U'</code> for <code>UPDATE</code></li><li><code>'R'</code> for <code>REFERENCES</code></li></ul></td>
        </tr>
        <tr>
            <td><code>COLUMNS</code></td>
            <td><code>org.apache.Splice Machine.iapi.<br />services.io.FormatableBitSet</code></td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td><p>A list of columns to which the privilege applies</p>
                <p>This class is not part of the public API.</p></td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding&nbsp;&nbsp; [`SYSVW.SYSCOLPERMSVIEW` system view](sqlref_sysviews_syscolpermsview.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSCOLPERMS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the [`SYSVW.SYSCOLPERMSVIEW` system view](sqlref_sysviews_syscolpermsview.html) instead.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSCOLPERMS;
```
{: .Example}

</div>
</section>
