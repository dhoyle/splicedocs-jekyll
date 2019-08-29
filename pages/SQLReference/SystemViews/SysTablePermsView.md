---
title: SYSTABLEPERMSVIEW System View
summary: System table that stores the table permissions that have granted but not revoked.
keywords: tables, permissions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_systablepermsview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTABLEPERMSVIEW System View

The `SYSTABLEPERMSVIEW` table view describes the table permissions that have been granted but not revoked within the current database. It belongs to the `SYSVW` schema.

All of the permissions for one (`GRANTEE, TABLEID, GRANTOR`) combination
are specified in a single row in the `SYSTABLEPERMSVIEW` view. The keys for
the `SYSTABLEPERMSVIEW` view are:

* Primary key (`GRANTEE, TABLEID, GRANTOR`)
* Unique key (`TABLEPERMSID`)
* Foreign key (`TABLEID `references `SYS.SYSTABLES`)


The following table shows the contents of the `SYSVW.SYSTABLEPERMSVIEW`
system view.

<table>
    <caption>SYSTABLEPERMSVIEW system view</caption>
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
            <td><code> TABLEPERMSID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Used by the dependency manager to track the dependency
		of a view, trigger, or constraint on the table level permissions</td>
        </tr>
        <tr>
            <td><code>  GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user or role to which the
		privilege is granted</td>
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
            <td><code>SELECTPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>SELECT</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)</li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code>DELETEPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>DELETE</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code>INSERTPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>INSERT</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code> UPDATEPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>UPDATE</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code>REFERENCESPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>REFERENCE</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code>TRIGGERPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>TRIGGER</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the schema</td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Table name</td>
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

This is a view on the system table, [`SYS.SYSTABLEPERMS`](sqlref_systables_systableperms.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSTABLEPERMS;
```
{: .Example}

If you see the table description, you have access. If you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the view instead.

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSTABLEPERMSVIEW;
```
{: .Example}

</div>
</section>
