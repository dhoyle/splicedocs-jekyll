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
`SYSROUTINEPERMSVIEW` view. The keys for the `SYSROUTINEPERMSVIEW` view are:

* Primary key (`GRANTEE, ALIASID, GRANTOR`)
* Unique key (`ROUTINEPERMSID`)
* Foreign key (`ALIASID` references `SYS.SYSALIASES`)

The following table shows the contents of the `SYS.SYSROUTINEPERMSVIEW` system
view.

<table>
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
    </tbody>
</table>

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSROUTINEPERMSVIEW;
```
{: .Example}

</div>
</section>
