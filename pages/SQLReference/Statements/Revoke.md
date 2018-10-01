---
title: REVOKE statement
summary: Revokes privileges for specific user(s) or role(s) to perform actions on database objects.
keywords: revoking privileges
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_revoke.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# REVOKE

Use the `REVOKE` statement to remove privileges from a specific user or
role, or from all users, to perform actions on database objects. You can
also use the `REVOKE` statement to revoke a role from a user, from
`PUBLIC`, or from another role.

The syntax that you use for the `REVOKE` statement depends on whether
you are revoking privileges to a schema object or revoking a role.

## Syntax for SCHEMA

<div class="fcnWrapperWide"><pre class="FcnSyntax">
REVOKE <a href="#PrivilegeTypes">privilege-type</a>
   ON SCHEMA schema
   FROM <a href="#AboutGrantees">grantees</a></pre>

</div>
<div class="paramList" markdown="1">
privilege-type
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
   DELETE
 | INSERT
 | MODIFY
 | REFERENCES [( column-identifier {, column-identifier}* )]
 | SELECT [( column-identifier {, column-identifier}* )]
 | TRIGGER
 | UPDATE [( column-identifier {, column-identifier}* )]</pre>

</div>
{: .paramDefnFirst}


See the [Privilege Types](#PrivilegeTypes) section below for more
information.
{: .paramDefn}

<div class="noteEnterprise" markdown="1">
Column-level privileges are available only with a Splice Machine Enterprise
license.

You cannot grant or revoke privileges at the `column-identifier` level
with the Community version of Splice Machine.

To obtain a license for the Splice Machine Enterprise Edition, <span
class="noteEnterpriseNote">please [Contact Splice Machine Sales][1]{:
target="_blank"} today.</span>
</div>

schema-Name
{: .paramName}

The name of the schemafor which you are revoking access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) for whom you are revoking access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>
## Syntax for Tables

<div class="fcnWrapperWide"><pre class="FcnSyntax">
REVOKE <a href="#PrivilegeTypes">privilege-type</a>
   ON [ TABLE ] <a href="sqlref_identifiers_types.html#TableName">table-Name</a>
   FROM <a href="#AboutGrantees">grantees</a></pre>

</div>

<div class="paramList" markdown="1">
privilege-type
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
      DELETE
    | INSERT
    | REFERENCES [( column-identifier {, column-identifier}* )]
    | SELECT [( column-identifier {, column-identifier}* )]
    | TRIGGER
    | UPDATE [( column-identifier {, column-identifier}* )]
{: .FcnSyntax xml:space="preserve"}
</div>

See the [Privilege Types](#PrivilegeTypes) section below for more
information.
{: .paramDefn}

<div class="noteEnterprise" markdown="1">
Column-level privileges are available only with a Splice Machine Enterprise
license.

You cannot grant or revoke privileges at the `column-identifier` level
with the Community version of Splice Machine.

To obtain a license for the Splice Machine Enterprise Edition, <span
class="noteEnterpriseNote">please [Contact Splice Machine Sales][1]{:
target="_blank"} today.</span>
</div>

table-Name
{: .paramName}

The name of the table for which you are revoking access.
{: .paramDefnFirst}

view-Name
{: .paramName}

The name of the view for which you are revoking access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) for whom you are revoking access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>
## Syntax for Routines

<div class="fcnWrapperWide" markdown="1">
    REVOKE EXECUTE ON { FUNCTION | PROCEDURE }
        {function-name | procedure-name}
     FROM grantees RESTRICT
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
function-name  \|  procedure-name
{: .paramName}

The name of the function or procedure for which you are revoking access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) for whom you are revoking access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

RESTRICT
{: .paramName}

You **must** use this clause when revoking access for routines.
{: .paramDefnFirst}

The `RESTRICT` clause specifies that the `EXECUTE` privilege cannot be
revoked if the specified routine is used in a view, trigger, or
constraint, and the privilege is being revoked from the owner of the
view, trigger, or constraint.
{: .paramDefn}

</div>
## Syntax for Sequences

<div class="fcnWrapperWide" markdown="1">
    REVOKE USAGE ON SEQUENCE sequence-name}
     FROM grantees
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
sequence-name
{: .paramName}

The name of the sequence for which you are revoking access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) for whom you are revoking access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>

<div class="fcnWrapperWide"><pre class="FcnSyntax">
REVOKE USAGE
   ON TYPE <a href="sqlref_identifiers_intro.html">SQL Identifier</a>
   FROM grantees RESTRICT</pre>

</div>
<div class="paramList" markdown="1">
[schema-name.] SQL Identifier
{: .paramName}

The user-defined type (UDT) name is composed of an optional *schemaName*
and a *SQL Identifier*. If a *schemaName* is not provided, the current
schema is the default schema. If a qualified UDT name is specified, the
schema name cannot begin with `SYS`.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) for whom you are revoking access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

RESTRICT
{: .paramName}

You **must** use this clause when revoking access for user-defined
types.
{: .paramDefnFirst}

The `RESTRICT` clause specifies that the `EXECUTE` privilege cannot be
revoked if the specified UDT is used in a view, trigger, or constraint,
and the privilege is being revoked from the owner of the view, trigger,
or constraint.
{: .paramDefn}

</div>
## Syntax for Roles

<div class="fcnWrapperWide"><pre class="FcnSyntax">
REVOKE <a href="sqlref_identifiers_types.html#RoleName">roleName</a>
    { <a href="sqlref_identifiers_types.html#RoleName">roleName</a> }*
   FROM grantees</pre>


</div>
<div class="paramList" markdown="1">
roleName
{: .paramName}

The name to the role(s) for which you are revoking access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) for whom you are revoking access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>
Only the database owner can revoke a role.

## About Grantees   {#AboutGrantees}

A grantee can be one or more specific users or groups, one or more specific roles,
or all users (`PUBLIC`). Either the object owner or the database owner
can grant privileges to a user or to a role.

<div class="noteNote" markdown="1">
When using an LDAP Group name in a `GRANT` or `REVOKE` statement: if the group name contains characters other than alphanumerics or the underscore character (<span class="HighlightedCode">A-Z, a-z, 0-9, _</span>), you must:

* Enclose the group name in double quotes
* Convert all alphabetic characters in the group name to uppercase.

For example, if you are granting rights to an LDAP Group with name <span class="Example">This-is-my-LDAP-Group</span>, you would use a statement like this:
   ```
   GRANT SELECT ON TABLE Salaries TO "THIS-IS-MY-LDAP-GROUP";
   ```
   {: .Example}
</div>

Only the database owner can grant a role to a user or to another role.

Here's the syntax:

<div class="fcnWrapperWide" markdown="1">
    {     roleName | PUBLIC }
     [, { roleName | PUBLIC } ] *
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
AuthorizationIdentifier
{: .paramName}

An expression.
{: .paramDefnFirst}

roleName
{: .paramName}

The name of the role.
{: .paramDefnFirst}

Either the object owner or the database owner can grant privileges to a
user or to a role. Only the database owner can grant a role to a user or
to another role.
{: .paramDefn}

`PUBLIC`
{: .paramName}

Use the keyword `PUBLIC` to specify all users.
{: .paramDefnFirst}

When `PUBLIC` is specified, the privileges or roles affect all current
and future users.
{: .paramDefn}

The privileges granted to `PUBLIC` and to individual users or roles are
independent privileges. For example, a `SELECT` privilege on table `t`
is granted to both `PUBLIC` and to the authorization ID `harry`. If the
`SELECT` privilege is later revoked from the authorization ID `harry`,
Harry will still be able to access the table `t` through the `PUBLIC`
privilege..
{: .paramDefn}

</div>
## Privilege Types   {#PrivilegeTypes}

<table summary="Privilege types">
    <col />
    <col />
    <thead>
        <tr>
            <th>Privilege Type</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ALL PRIVILEGES</code></td>
            <td>To revoke all of the privileges to the user or role for the specified table. You can also revoke one or more table privileges by specifying a privilege-list.</td>
        </tr>
        <tr>
            <td><code>DELETE</code></td>
            <td>To revoke permission to delete rows from the specified table.</td>
        </tr>
        <tr>
            <td><code>INSERT</code></td>
            <td>To revoke permission to insert rows into the specified table.</td>
        </tr>
        <tr>
            <td><code>MODIFY</code></td>
            <td><p>To revoke permission to modify the schema itself.</p>
                <p class="noteNote">Revoking schema modification privilege does not imply revocation of other permissions; use <code>ALL PRIVILEGES</code> to revoke all permissions.</p>
            </td>
        </tr>
        <tr>
            <td><code>REFERENCES</code></td>
            <td>To revoke permission to create a foreign key reference to the specified table. If a column list is  specified with the <code>REFERENCES</code> privilege, the permission is valid on only the foreign key reference to the specified columns.</td>
        </tr>
        <tr>
            <td><code>SELECT</code></td>
            <td>To revoke permission to perform <a href="sqlref_expressions_select.html">SelectExpressions</a> on a table or view. If a column list is specified with the <code>SELECT</code> privilege, the permission is valid on only those columns. If no column list is specified, then the privilege is valid on all of the columns in the table.<p>For queries that do not select a specific column from the tables involved in a <code>SELECT</code> statement or <em>SelectExpression</em> (for example, queries that use <code>COUNT(*)</code>), the user must have at least one column-level <code>SELECT</code> privilege or table-level <code>SELECT</code> privilege.</p></td>
        </tr>
        <tr>
            <td><code>TRIGGER</code></td>
            <td>To revoke permission to create a trigger on the specified table.</td>
        </tr>
        <tr>
            <td><code>UPDATE</code></td>
            <td>To revoke permission to use the <a href="sqlref_clauses_where.html"><code>WHERE</code></a> clause, you must have the <code>SELECT</code> privilege on the columns in the row that you want to update.</td>
        </tr>
    </tbody>
</table>

## Usage Notes

The following types of privileges can be revoked:

* Delete data from a specific table.

* Insert data into a specific table.

* Create a foreign key reference to the named table or to a subset of
  columns from a table.

* Select data from a table, view, or a subset of columns in a table.
* Create a trigger on a table.

* Update data in a table or in a subset of columns in a table.

* Run a specified routine (function or procedure).

* Use a user-defined type.

Before you issue a `REVOKE` statement, check that the
`derby.database.sqlAuthorization` property is set to `true`. The
`derby.database.sqlAuthorization` property enables the SQL Authorization
mode.

You can revoke privileges on an object if you are the owner of the
object or the database owner. See the `CREATE` statement for the
database object that you want To revoke privileges on for more
information.

You can revoke privileges for an object if you are the owner of the
object or the database owner.

## Prepared statements and open result sets

Checking for privileges happens at statement execution time, so prepared
statements are still usable after a revoke action. If sufficient
privileges are still available for the session, prepared statements will
be executed, and for queries, a result set will be returned.

Once a result set has been returned to the application (by executing a
prepared statement or by direct execution), it will remain accessible
even if privileges or roles are revoked in a way that would cause
another execution of the same statement to fail.

## Cascading object dependencies

For views, triggers, and constraints, if the privilege on which the
object depends on is revoked, the object is automatically dropped.
Splice Machine does not try to determine if you have other privileges
that can replace the privileges that are being revoked.

## Limitations

The following limitations apply to the REVOKE statement:

<div class="paramList" markdown="1">
Table-level privileges
{: .paramName}

All of the table-level privilege types for a specified grantee and table
ID are stored in one row in the `SYSTABLEPERMS` system table. For
example, when `user2` is granted the `SELECT` and `DELETE` privileges on
table `user1.t1`, a row is added to the `SYSTABLEPERMS` table. The
`GRANTEE` field contains `user2` and the `TABLEID` contains `user1.t1`.
The `SELECTPRIV` and `DELETEPRIV` fields are set to Y. The remaining
privilege type fields are set to N.
{: .paramDefnFirst}

When a grantee creates an object that relies on one of the privilege
types, Splice Machine engine tracks the dependency of the object on the
specific row in the `SYSTABLEPERMS` table. For example, `user2` creates
the view `v1` by using the statement `SELECT * FROM user1.t1`, the
dependency manager tracks the dependency of view `v1` on the row in
`SYSTABLEPERMS` for `GRANTEE`(`user2`), `TABLEID`(`user1.t1`).

The dependency manager knows only that the view is dependent on a
privilege type in that specific row, but does not track exactly which
privilege type the view is dependent on.

When a `REVOKE` statement for a table-level privilege is issued for a
grantee and table ID, all of the objects that are dependent on the
grantee and table ID are dropped. For example, if `user1` revokes the
`DELETE` privilege on table `t1` from `user2`, the row in
`SYSTABLEPERMS` for `GRANTEE`(`user2`), `TABLEID`(`user1.t1`) is
modified by the `REVOKE` statement. The dependency manager sends a
revoke invalidation message to the view `user2.v1` and the view is
dropped even though the view is not dependent on the `DELETE` privilege
for `GRANTEE`(`user2`), `TABLEID`(`user1.t1`).

Column-level privileges
{: .paramName}

Only one type of privilege for a specified grantee and table ID are
stored in one row in the `SYSCOLPERMS` system table. For example, when
`user2` is granted the `SELECT` privilege on table `user1.t1` for
columns c12 and c13, a row is added to the `SYSCOLPERMS`. The `GRANTEE`
field contains `user2`, the `TABLEID` contains `user1.t1`, the `TYPE`
field contains `S`, and the `COLUMNS` field contains `c12, c13`.
{: .paramDefnFirst}

When a grantee creates an object that relies on the privilege type and
the subset of columns in a table ID, Splice Machine engine tracks the
dependency of the object on the specific row in the `SYSCOLPERMS` table.
For example, `user2` creates the view `v1` by using the statement
`SELECT c11 FROM user1.t1`, the dependency manager tracks the dependency
of view `v1` on the row in `SYSCOLPERMS` for `GRANTEE`(`user2`),
`TABLEID`(`user1.t1`), `TYPE`(s). The dependency manager knows that the
view is dependent on the `SELECT` privilege type, but does not track
exactly which columns the view is dependent on.

When a `REVOKE` statement for a column-level privilege is issued for a
grantee, table ID, and type, all of the objects that are dependent on
the grantee, table ID, and type are dropped. For example, if `user1`
revokes the `SELECT` privilege on column `c12` on table `user1.t1` from
`user2`, the row in `SYSCOLPERMS` for `GRANTEE`(`user2`), `TABLEID`(`
ser1.t1`), `TYPE`(s) is modified by the `REVOKE` statement. The
dependency manager sends a revoke invalidation message to the view
`user2.v1` and the view is dropped even though the view is not dependent
on the column `c12` for `GRANTEE`(`user2`), `TABLEID`(`user1.t1`),
`TYPE`(s).

Roles
{: .paramName}

Splice Machine tracks any dependencies on the definer's current role for
views and constraints, constraints, and triggers. If privileges were
obtainable only via the current role when the object in question was
defined, that object depends on the current role. The object will be
dropped if the role is revoked from the defining user or from `PUBLIC`,
as the case may be.
{: .paramDefnFirst}

Also, if a contained role of the current role in such cases is revoked,
dependent objects will be dropped. Note that dropping may be too
pessimistic. This is because Splice Machine does not currently make an
attempt to recheck if the necessary privileges are still available in
such cases.
{: .paramDefn}

</div>
## Revoke Examples

### Revoking User Privileges

To revoke the `SELECT` privilege on schema `SpliceBBall` from the
authorization IDs `Bill` and `Joan`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE SELECT ON SCHEMA SpliceBBall FROM Bill, Joan;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To revoke the `SELECT` privilege on table `Salaries` from the
authorization IDs `Bill` and `Joan`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE SELECT ON TABLE Salaries FROM Bill, Joan;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To revoke the `UPDATE` and `TRIGGER` privileges on table `Salaries` from
the authorization IDs `Joe` and `Anita`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE UPDATE, TRIGGER ON TABLE Salaries FROM Joe, Anita;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To revoke the `SELECT` privilege on table `Hitting` in the
`Baseball_stats` schema from all users, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE SELECT ON TABLE Baseball_Stats.Hitting FROM PUBLIC;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To revoke the `EXECUTE` privilege on procedure `ComputeValue` from the
authorization ID `george`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE EXECUTE ON PROCEDURE ComputeValue FROM george;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
### Revoking User Roles

To revoke the role ` purchases_reader_role` from the authorization IDs
`george` and `maria`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE purchases_reader_role FROM george,maria;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
### Revoking Role Privileges

To revoke the `SELECT` privilege on schema `SpliceBBall` from the role
`purchases_reader_role`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE SELECT ON SCHEMA SpliceBBall FROM purchases_reader_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To revoke the `SELECT` privilege on table `t` to the role
`purchases_reader_role`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> REVOKE SELECT ON TABLE t FROM purchases_reader_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE ROLE`](sqlref_statements_createrole.html) statement
* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`RoleName`](sqlref_identifiers_types.html#RoleName)
* [`SET ROLE`](sqlref_statements_setrole.html) statement
* [`SELECT`](sqlref_expressions_select.html) expression
* [`SELECT`](sqlref_expressions_select.html) statement
* [`SYSROLES`](sqlref_systables_sysroles.html) system table
* [`UPDATE`](sqlref_statements_update.html) statement
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>



[1]: http://www.splicemachine.com/company/contact-us/
