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
    </tbody>
</table>

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSTABLEPERMSVIEW;
```
{: .Example}

</div>
</section>
