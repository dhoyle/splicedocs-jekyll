---
title: SYSPERMSVIEW System View
summary: System view that describes the usage permissions for sequence generators and user-defined types
keywords: system view, sequences
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_syspermsview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSPERMSVIEW System View

The `SYSPERMSVIEW` table view describes the usage permissions for sequence generators and user-defined types. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSPERMSVIEW`
system view.

<table>
    <caption>SYSPERMSVIEW system view</caption>
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
            <td><code>UUID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The unique ID of the permission. This is the primary key.</td>
        </tr>
        <tr>
            <td><code>OBJECTTYPE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">The kind of object receiving the permission. The only valid values are:</p>
                <ul>
                    <li> <code>'SEQUENCE'</code></li>
                    <li> <code>'TYPE'</code></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>OBJECTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">The <code>UUID</code> of the object receiving the permission.</p>
                <p>For sequence generators, the only valid values are <code>SEQUENCEIDs</code> in the <code>SYS.SYSSEQUENCES</code> table. </p>
                <p>For user-defined types, the only valid values are <code>ALIASIDs</code> in the <code>SYS.SYSALIASES</code> table if the <code>SYSALIASES</code> ow describes a user-defined type.</p>
            </td>
        </tr>
        <tr>
            <td><code>PERMISSION</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The type of the permission. The only valid value is <code>'USAGE'</code>.</td>
        </tr>
        <tr>
            <td><code>GRANTOR</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user who granted the privilege. Privileges can be granted only by the object owner.</td>
        </tr>
        <tr>
            <td><code>GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization ID of the user or role to which the privilege was granted</td>
        </tr>
        <tr>
            <td><code>ISGRANTABLE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">If the <code>GRANTEE</code> is the owner of the sequence generator or user-defined type, this value is <code>'Y'</code>.</p>
                <p> If the <code>GRANTEE</code> is not the owner of the sequence generator or user-defined type, this value is  <code>'N'</code>.</p>
            </td>
        </tr>
        <tr>
            <td><code>OBJECTNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The name of the object</td>
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

This is a view on the system table, [`SYS.SYSPERMS`](sqlref_systables_sysperms.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSPERMS;
```
{: .Example}

If you see the table description, you have access. If you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the view instead.

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSPERMSVIEW;
```
{: .Example}

</div>
</section>
