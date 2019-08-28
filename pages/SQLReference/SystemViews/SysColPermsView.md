---
title: SYSCOLPERMSVIEW System View
summary: System view that describes column permissions.
keywords: columns, permissions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_syscolpermsview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCOLPERMSVIEW System View

The `SYSCOLPERMSVIEW` table view describes the column permissions that have been granted but not revoked within the current database. It belongs to the `SYSVW` schema.

All of the permissions for one (`GRANTEE, TABLEID, TYPE, GRANTOR`)
combination are specified in a single row in the `SYSCOLPERMSVIEW` view.
The keys for the `SYSCOLPERMSVIEW` view are:

* Primary key (`GRANTEE, TABLEID, TYPE, GRANTOR`)
* Unique key (`COLPERMSID`)
* Foreign key (`TABLEID` references `SYS.SYSTABLES`)

The following table shows the contents of the `SYSVW.SYSCOLPERMSVIEW`
system view.

<table>
    <caption>SYSCOLPERMSVIEW system view</caption>
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
            <td>Used by the dependency manager to track the dependency of a view, trigger, or constraint on the column level permissions</td>
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
            <td>The authorization ID of the user who granted the privilege. Privileges can be granted only by the object owner</td>
        </tr>
        <tr>
            <td><code>TABLEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The unique identifier for the table on which the permissions have been granted</td>
        </tr>
        <tr>
            <td><code>TYPE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td><p>If the privilege is non-grantable, the valid values are:</p>
                <ul>
                    <li><code>'s'</code> for <code>SELECT</code></li>
                    <li><code>'u'</code> for <code>UPDATE</code></li>
                    <li><code>'r'</code> for <code>REFERENCES</code></li>
                </ul>
                <p>If the privilege is grantable, the valid values are:</p>
                <ul>
                    <li><code>'S'</code> for <code>SELECT</code></li>
                    <li><code>'U'</code> for <code>UPDATE</code></li>
                    <li><code>'R'</code> for <code>REFERENCES</code></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>COLUMNS</code></td>
            <td><code>org.apache.Splice Machine.<br />iapi.services.io.<br />FormatableBitSet</code></td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td><p>A list of columns to which the privilege applies</p>
                <p>This class is not part of the public API.</p></td>
        </tr>
        <tr>
            <td><code>TABLENAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The name of the table.</td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The unique identifier for the schema on which the permissions have been granted</td>
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

This is a view on the system table, [`SYS.SYSCOLPERMS`](sqlref_systables_syscolperms.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSCOLPERMS;
```
{: .Example}

If you see the table description, you have access. If you see a message that the table doesn't exist, you don't have access to the table; use the view instead.

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSCOLPERMSVIEW;
```
{: .Example}

{% include splice_snippets/systableaccessnote.md %}


</div>
</section>
