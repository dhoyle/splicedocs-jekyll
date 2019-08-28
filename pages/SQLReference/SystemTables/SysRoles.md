---
title: SYSROLES system table
summary: System table that stores the roles in the database.
keywords: roles tables
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysroles.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSROLES System Table

The `SYSROLES` table stores the roles in the database. It belongs to the `SYS` schema.

A row in the `SYSROLES` table represents one of the following:

* A role definition (the result of a &nbsp;[`CREATE ROLE`
  statement](sqlref_statements_createrole.html)
* A role grant

The keys for the `SYSROLES` table are:

* Primary key (`GRANTEE, ROLEID, GRANTOR`)
* Unique key (`UUID`)

The following table shows the contents of the `SYS.SYSROLES` system table.

<table>
    <caption>SYSROLES system table</caption>
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
            <td><code> UUID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>A unique identifier for this role</td>
        </tr>
        <tr>
            <td><code> ROLEID</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The role name, after conversion to case normal form</td>
        </tr>
        <tr>
            <td><code> GRANTEE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>If the row represents a role grant, this is the authorization
			identifier of a user or role to which this role is granted. If the row
		represents a role definition, this is the database owner's user name.</td>
        </tr>
        <tr>
            <td><code> GRANTOR</code></td>
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
            <td><code> ISDEF</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>If the row represents a role definition, this value is
		<code>'Y'</code>. If the row represents a role grant, the value is <code>'N'</code>.</td>
        </tr>
    </tbody>
</table>


## Usage Restrictions

Access to system tables is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding [`SYSVW.SYSALLROLES` system view](sqlref_sysviews_sysallroles.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSROLES;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message that the table doesn't exist, you don't have access to the table; use the [`SYSVW.SYSALLROLES` system view](sqlref_sysviews_sysallroles.html) instead.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSROLES;
```
{: .Example}


</div>
</section>
