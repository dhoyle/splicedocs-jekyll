---
title: SYSROLES system table
summary: System table that stores the roles in the database.
keywords: roles tables
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_sysroles.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSROLES System Table

The `SYSROLES` table stores the roles in the database.

A row in the `SYSROLES` table represents one of the following:

* A role definition (the result of a &nbsp;[`CREATE ROLE`
  statement](sqlref_statements_createrole.html))
* A role grant

The keys for the `SYSROLES` table are:

* Primary key (`GRANTEE, ROLEID, GRANTOR`)
* Unique key (`UUID`)

The following table shows the contents of the `SYSROLES` system table.

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
## See Also

* [About System Tables](sqlref_systables_intro.html)
* [`CURRENT_ROLE`](sqlref_builtinfcns_currentrole.html) function
* [`CREATE_ROLE`](sqlref_statements_createrole.html) statement
* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [`SET ROLE`](sqlref_statements_setrole.html) statement

</div>
</section>

