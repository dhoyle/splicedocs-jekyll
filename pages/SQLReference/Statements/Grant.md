---
title: GRANT statement
summary: Gives privileges to specific user(s) or role(s) to perform actions on database objects.
keywords: granting privileges
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_grant.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# GRANT

Use the `GRANT` statement to give privileges to a specific user or role,
or to all users, to perform actions on database objects. You can also
use the `GRANT` statement to grant a role to a user, to `PUBLIC`, or to
another role.

The syntax that you use for the `GRANT` statement depends on whether you
are granting privileges to a schema object or granting a role, as described in these sections:

* [Syntax for Schemas](#SchemaSyntax)
* [Syntax for Tables](#TableSyntax)
* [Syntax for Roles](#RoleSyntax)
* [Syntax for Routines](#RoutineSyntax)
* [Syntax for Sequences](#SequenceSyntax)
* [Syntax for User-Defined Types](#UserDefinedSyntax)

This topic also contains these sections that help explain the use of the `GRANT` statement:
* [About Grantees](#Grantees)
* [Privilege Types](#Privileges)
* [Usage Notes](#UsageNotes)
* [Examples](#Examples)

## Syntax for Schemas {#SchemaSyntax}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
GRANT ALL PRIVILEGES | schema-privilege {, schema-privilege }*
   ON SCHEMA <a href="sqlref_identifiers_types.html#SchemaName">schema-Name</a>
   TO grantees</pre>

</div>
<div class="paramList" markdown="1">
schema-privilege
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

The name of the schema to which you are granting access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) to whom you are granting access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>
#### NOTES:

* When you drop a schema from your database, all privileges associated
  with the schema are removed.

* Table-level privileges override schema-level privileges.

## Syntax for Tables {#TableSyntax}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
GRANT ALL PRIVILEGES | table-privilege {, table-privilege }*   ON [TABLE] { <a href="sqlref_identifiers_types.html#TableName">tableName</a> }
   TO grantees</pre>

</div>
<div class="paramList" markdown="1">
table-privilege
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

The name of the table to which you are granting access.
{: .paramDefnFirst}

view-Name
{: .paramName}

The name of the view to which you are granting access.
{: .paramDefnFirst}

schema-Name
{: .paramName}

The name of the schema to which you are granting access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) to whom you are granting access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>
#### NOTES:

* When you drop a table from your database, all privileges associated
  with the table are removed.
* Table-level privileges override schema-level privileges.

## Syntax for Roles {#RoleSyntax}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
GRANT <a href="sqlref_identifiers_types.html#RoleName">roleName</a> [ {, <a href="sqlref_identifiers_types.html#RoleName">roleName</a> }* ]  
   TO grantees
   [ [NOT] AS DEFAULT ]</pre>
</div>

<div class="paramList" markdown="1">
roleName
{: .paramName}

The name to the role(s) to which you are granting access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) to whom you are granting access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

[NOT] AS DEFAULT
{: .paramName}

When you grant a role to a user, that role is, by default, applied to the user whenever s/he connects to the database. This is the behavior defined by the optional phrase `AS DEFAULT`.
{: .paramDefnFirst}

If you *do not* want the role granted to the user by default, you *must* specify `NOT AS DEFAULT`; this means that the role will not automatically apply to sessions: you must use the &nbsp;&nbsp;[`SET ROLE` statement](sqlref_statements_setrole.html) to apply a `NOT AS DEFAULT` role in a session.
{: .paramDefn}

</div>
Before you can grant a role to a user or to another role, you must
create the role using the &nbsp;[`CREATE ROLE`
statement](sqlref_statements_createrole.html). Only the database owner
can grant a role.

A role A *contains* another role B if role B is granted to role A, or is
contained in a role C granted to role A. Privileges granted to a
contained role are inherited by the containing roles. So the set of
privileges identified by role A is the union of the privileges granted
to role A and the privileges granted to any contained roles of role A.

## Syntax for Routines {#RoutineSyntax}

<div class="fcnWrapperWide" markdown="1">
    GRANT EXECUTE
       ON { FUNCTION | PROCEDURE } {function-name | procedure-name}
       TO grantees
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
function-name  \|  procedure-name
{: .paramName}

The name of the function or procedure to which you are granting access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) to whom you are granting access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>

## Syntax for Sequences {#SequenceSyntax}

<div class="fcnWrapperWide" markdown="1">
    GRANT USAGE
       ON SEQUENCE sequence-name
       TO grantees
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
sequence-name
{: .paramName}

An SQL_Identifier specifying the name of the sequence to which you are granting access.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) to whom you are granting access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}

</div>

## Syntax for User-defined Types {#UserDefinedSyntax}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
GRANT USAGE
   <a href="sqlref_identifiers_intro.html">SQL Identifier</a>
   TO grantees</pre>

</div>
<div class="paramList" markdown="1">
[schema-name.] SQL Identifier
{: .paramName}

The type name is composed of an optional *schemaName* and a *SQL
Identifier*. If a *schemaName* is not provided, the current schema is
the default schema. If a qualified UDT name is specified, the schema
name cannot begin with `SYS`.
{: .paramDefnFirst}

grantees
{: .paramName}

The user(s) or role(s) to whom you are granting access. See the [About
Grantees](#AboutGrantees) section below for more information.
{: .paramDefnFirst}
</div>

## About Grantees   {#Grantees}

A grantee can be one or more specific users, one or more specific roles,
or all users (`PUBLIC`). Either the object owner or the database owner
can grant privileges to a user or to a role. Only the database owner can
grant a role to a user or to another role.

Here's the syntax:

<div class="fcnWrapperWide"><pre class="FcnSyntax">
{      <a href="sqlref_identifiers_types.html#RoleName">roleName</a> | PUBLIC }
  [, { <a href="sqlref_identifiers_types.html#RoleName">roleName</a> | PUBLIC } ] *</pre>

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
privilege.
{: .paramDefn}

</div>

## Privilege Types   {#Privileges}

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
            <td>
                <p>To grant all of the privileges to the user or role for the specified table. You can also grant one or more table privileges by specifying a privilege-list.</p>
                <p class="noteIcon">Only database and schema owners can use the <code>CREATE TABLE</code> statement, which means that table creation privileges cannot be granted to others, even with  <code>GRANT ALL PRIVILEGES</code>.</p>
            </td>
        </tr>
        <tr>
            <td><code>DELETE</code></td>
            <td>To grant permission to delete rows from the specified table.</td>
        </tr>
        <tr>
            <td><code>INSERT</code></td>
            <td>To grant permission to insert rows into the specified table.</td>
        </tr>
        <tr>
            <td><code>MODIFY</code></td>
            <td><p>Schema-level privilege that grants permission to modify the schema itself.</p>
                <p class="noteNote">Permission to modify the schema does not imply granting of other permissions; use <code>ALL PRIVILEGES</code> to grant all permissions.</p>
            </td>
        </tr>
        <tr>
            <td><code>REFERENCES</code></td>
            <td>To grant permission to create a foreign key reference to the specified table. If a column list is  specified with the <code>REFERENCES</code> privilege, the permission is valid on only the foreign key reference to the specified columns.</td>
        </tr>
        <tr>
            <td><code>SELECT</code></td>
            <td>To grant permission to perform <a href="sqlref_expressions_select.html">SelectExpressions</a> on a table or view. If a column list is specified with the <code>SELECT</code> privilege, the permission is valid on only those columns. If no column list is specified, then the privilege is valid on all of the columns in the table.<p>For queries that do not select a specific column from the tables involved in a <code>SELECT</code> statement or <em>SelectExpression</em> (for example, queries that use <code>COUNT(*)</code>), the user must have at least one column-level <code>SELECT</code> privilege or table-level <code>SELECT</code> privilege.</p></td>
        </tr>
        <tr>
            <td><code>TRIGGER</code></td>
            <td>To grant permission to create a trigger on the specified table.</td>
        </tr>
        <tr>
            <td><code>UPDATE</code></td>
            <td>To grant permission to use the <a href="sqlref_clauses_where.html"><code>WHERE</code></a> clause, you must have the <code>SELECT</code> privilege on the columns in the row that you want to update.</td>
        </tr>
    </tbody>
</table>

## Usage Notes {#UsageNotes}

The following types of privileges can be granted:

* Delete data from a specific table.
* Insert data into a specific table.
* Create a foreign key reference to the named table or to a subset of
  columns from a table.
* Select data from a table, view, or a subset of columns in a table.
* Create a trigger on a table.
* Update data in a table or in a subset of columns in a table.
* Run a specified function or procedure.
* Use a user-defined type.

Before you issue a `GRANT` statement, check that the
`derby.database.sqlAuthorization` property is set to `true`. The
`derby.database.sqlAuthorization` property enables the SQL Authorization
mode.

You can grant privileges on an object if you are the owner of the object
or the database owner. See documentation for the
[`CREATE`](sqlref_statements_createstatements.html) statements for more
information.

## Examples {#Examples}

This section contains examples for:

* Granting Privileges to Users (#UserPrivs)
* Granting Roles to Users (#UserRoles)
* Granting Privileges to Roles (#RolePrivs)

### Granting Privileges to Users {#UserPrivs}

To grant the `SELECT` privilege on the schema `SpliceBBall` to the
authorization IDs `Bill` and `Joan`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT SELECT ON SCHEMA SpliceBBall TO Bill, Joan;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To grant the `SELECT` privilege on table `Salaries` to the authorization
IDs `Bill` and `Joan`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT SELECT ON TABLE Salaries TO Bill, Joan;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To grant the `UPDATE` and `TRIGGER` privileges on table `Salaries` to
the authorization IDs `Joe` and `Anita`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT UPDATE, TRIGGER ON TABLE Salaries TO Joe, Anita;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To grant the `SELECT` privilege on table `Hitting` in the
`Baseball_stats` schema to all users, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT SELECT ON TABLE Baseball_Stats.Hitting to PUBLIC;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To grant the `EXECUTE` privilege on procedure `ComputeValue` to the
authorization ID `george`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT EXECUTE ON PROCEDURE ComputeValue TO george;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
### Granting Roles to Users {#UserRoles}

To grant the role `purchases_reader_role` to the authorization IDs
`george` and `maria`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT purchases_reader_role TO george,maria;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

This grants the role to both users for the current session, and also sets the role as a default role whenever one of the users connects to the database. The *as default* behavior is applied by default, or you can specify it explicitly:

<div class="preWrapper" markdown="1">
    splice> GRANT purchases_reader_role TO george,maria AS DEFAULT;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

To grant the role to `george` only for the current session, use:

<div class="preWrapper" markdown="1">
    splice> GRANT purchases_reader_role TO george NOT AS DEFAULT;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

#### A More Extensive ROLE Example

Let's set up our example. First we'll use create 4 schemas and 4 roles, and we'll grant all priveleges to each role on its respective schema:

<div class="preWrapper" markdown="1">
    splice> CREATE SCHEMA test_schema1;
    0 rows inserted/updated/deleted
    splice> CREATE ROLE test_role1;
    0 rows inserted/updated/deleted
    splice> GRANT ALL PRIVILEGES ON SCHEMA test_schema1 TO test_role1;
    0 rows inserted/updated/deleted

    splice> CREATE SCHEMA test_schema2;
    0 rows inserted/updated/deleted
    splice> CREATE ROLE test_schema2;
    0 rows inserted/updated/deleted
    splice> GRANT ALL PRIVILEGES ON SCHEMA test_schema2 TO test_role2;
    0 rows inserted/updated/deleted

    splice> CREATE SCHEMA test_schema3;
    0 rows inserted/updated/deleted
    splice> CREATE ROLE test_role3;
    0 rows inserted/updated/deleted
    splice> GRANT ALL PRIVILEGES ON SCHEMA test_schema3 TO test_role3;
    0 rows inserted/updated/deleted

    splice> CREATE SCHEMA test_schema4;
    0 rows inserted/updated/deleted
    splice> CREATE ROLE test_role4;
    0 rows inserted/updated/deleted
    splice> GRANT ALL PRIVILEGES ON SCHEMA test_schema4 TO test_role4;
    0 rows inserted/updated/deleted
{: .Example}
</div>

Next we'll create two users so we can demonstrate assigning different roles to different users:

<div class="preWrapper" markdown="1">
    splice> CALL syscs_util.syscs_create_user('user1', 'user1pswd');
    Statement executed;

    splice> CALL syscs_util.syscs_create_user('user2', 'user2pswd');
    Statement executed
{: .Example}
</div>

Now we'll grant the role `test_role1` to all users (the `public` user), and GRANT specific roles to specific users:

<div class="preWrapper" markdown="1">
    splice> GRANT test_role1 TO public AS DEFAULT;
    0 rows inserted/updated/deleted

    splice> GRANT test_role2 TO user1 AS DEFAULT;
    0 rows inserted/updated/deleted

    splice> GRANT test_role3 TO user1;
    0 rows inserted/updated/deleted
{: .Example}
</div>

Now let's CONNECT as `user1` and check our role assignments:
<div class="preWrapper" markdown="1">
    splice> CONNECT 'jdbc:splice://localhost:1527/splicedb;user=user1;password=user1pswd' AS user1_connection;

    splice> VALUES current_user
    1
    ----------------------------------------------------------------------------------------------------------
    USER1

    splice> VALUES current_role;
    1
    ----------------------------------------------------------------------------------------------------------
    "TEST_ROLE2", "TEST_ROLE3", "TEST_ROLE1"
    1 row selected
{: .Example}
</div>

As you can see, when `user1` connects, s/he is granted:
* `TEST_ROLE1` because it is now granted by default to all users (`public`).
* `TEST_ROLE2` and `TEST_ROLE3` because they were granted to `user1` as a default privilege upon connecting.

Now we'll CONNECT as `user2`:
<div class="preWrapper" markdown="1">
    splice> CONNECT 'jdbc:splice://localhost:1527/splicedb;user=user2;password=user2pswd' as user2_connection;

    splice> VALUES current_user
    1
    ----------------------------------------------------------------------------------------------------------
    USER2

    splice> VALUES current_role;
    1
    ----------------------------------------------------------------------------------------------------------
    "TEST_ROLE1"
    1 row selected
{: .Example}
</div>

Note that `user2` is connected with only one role, `TEST_ROLE1` because that role has been GRANTed by default to all users (`public`) and no other roles have been granted to `user2`.

#### Unsetting the AS DEFAULT Role Setting

If you want to GRANT a role to a user just for the current session, you can use the `NOT AS DEFAULT` syntax.

You can use the same syntax to modify an existing role from DEFAULT to non-DEFAULT:
<div class="preWrapper" markdown="1">
    splice> GRANT test_role1 TO public not AS DEFAULT;
    Statement executed;
{: .Example}
</div>

As a result, new public connections will no longer be granted the privileges associated with `test_role1`.

### Granting Privileges to Roles {#RolePrivs}

To grant the `SELECT` privilege on schema `SpliceBBall` to the role
`purchases_reader_role`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT SELECT ON SCHEMA SpliceBBall TO purchases_reader_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To grant the `SELECT` privilege on table `t` to the role
`purchases_reader_role`, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> GRANT SELECT ON TABLE t TO purchases_reader_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE ROLE`](sqlref_statements_createrole.html) statement
* [`CREATE TRIGGER`](sqlref_statements_createtrigger.html) statement
* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
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
