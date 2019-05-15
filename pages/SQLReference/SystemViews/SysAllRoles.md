---
title: SYSALLROLES System View
summary: System view that displays all of the roles granted to the current user.
keywords: system roles view
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysallroles.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSALLROLES System View

The `SYSALLROLES` view displays all of the roles granted to the current user. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSALLROLES` system view.

<table>
    <caption>SYSALLROLES system view</caption>
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
            <td>A unique identifier for this role</td>
        </tr>
        <tr>
            <td><code>ROLEID</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The role name, after conversion to case normal form</td>
        </tr>
        <tr>
            <td><code>GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>If the row represents a role grant, this is the authorization
			identifier of a user or role to which this role is granted. If the row
		represents a role definition, this is the database owner's user name.</td>
        </tr>
        <tr>
            <td><code>GRANTOR</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>This is the authorization identifier of the user that granted
			this role. If the row represents a role definition, this is the authorization
			identifier <code>_SYSTEM</code>. If the row represents a role grant, this is the database
			owner's user name (since only the database owner can create and grant roles).
		</td>
        </tr>
        <tr>
            <td><code>WITHADMINOPTION</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">A role definition is modelled as a grant from <code>_SYSTEM</code> to the
			database owner, so if the row represents a role definition, the value is always
			<code>'Y'</code>. </p>
                <p>This means that the creator (the database owner) is always allowed
			to grant the newly created role. Currently roles cannot be granted <code>WITH ADMIN
			OPTION</code>, so if the row represents a role grant, the value is always
		<code>'N'</code>.</p>
            </td>
        </tr>
        <tr>
            <td><code>ISDEF</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>If the row represents a role definition, this value is
		<code>'Y'</code>. If the row represents a role grant, the value is <code>'N'</code>.</td>
        </tr>
    </tbody>
</table>

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSALLROLES;
```
{: .Example}


## See Also

* [About System Tables](sqlref_systables_intro.html)
* [`SYSTABLESTATISTICS`](sqlref_systables_systablestats.html)

</div>
</section>



[1]: https://datasketches.github.io/
