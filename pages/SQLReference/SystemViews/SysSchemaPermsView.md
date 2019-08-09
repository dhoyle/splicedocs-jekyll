---
title: SYSSCHEMAPERMSVIEW System View
summary: System view that describes schema permissions.
keywords: schema, permissions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysschemapermsview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSCHEMAPERMSVIEW System View

The `SYSSCHEMAPERMSVIEW` table view describes the schema permissions that have been granted but not revoked within the current database. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSSCHEMAPERMSVIEW`
system view.


<table>
    <caption>SYSSCHEMAPERMS system table</caption>
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
            <td><code>SCHEMAPERMSID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Used by the dependency manager to track the dependency
		of a view, trigger, or constraint on the schema level permissions</td>
        </tr>
        <tr>
            <td><code>GRANTEE</code></td>
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
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The unique identifier for the schema on which the permissions have been granted</td>
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
            <td><code>MODIFYPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>MODIFY</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
        <tr>
            <td><code>ACCESSPRIV</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Specifies if the <code>ACCESSPRIV</code> permission is granted. The valid values are: <ul><li><code>'y'</code> (non-grantable privilege)<br /></li><li><code>'Y'</code> (grantable privilege)<br /></li><li><code>'N'</code> (no privilege)</li></ul></td>
        </tr>
    </tbody>
</table>


## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSSCHEMAPERMSVIEW;
```
{: .Example}

</div>
</section>
