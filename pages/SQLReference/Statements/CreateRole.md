---
title: CREATE ROLE statement
summary: Creates SQL roles
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createrole.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE ROLE

The `CREATE ROLE` statement allows you to create an SQL role. Only the
database owner can create a role.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE ROLE <a href="sqlref_identifiers_types.html#RoleName">roleName</a></pre>

</div>
<div class="paramList" markdown="1">
roleName
{: .paramName}

The name of an SQL role.
{: .paramDefnFirst}

</div>
## Using

Before you issue a `CREATE ROLE` statement, verify that the
*derby.database.sqlAuthorization* property is set to `TRUE`. The
*derby.database.sqlAuthorization* property enables SQL authorization
mode.

You cannot create a role name if there is already a user by that name.
An attempt to create a role name that conflicts with an existing user
name raises the *SQLException* X0Y68. If user names are not controlled
by the database owner (or administrator), it may be a good idea to use a
naming convention for roles to reduce the possibility of collision with
user names.

Splice Machine tries to avoid name collision between user names and role
names, but this is not always possible, because Splice Machine has a
pluggable authorization architecture. For example, an externally defined
user may exist who has never yet connected to the database, created any
schema objects, or been granted any privileges. If Splice Machine knows
about a user name, it will forbid creating a role with that name.
Correspondingly, a user who has the same name as a role will not be
allowed to connect. Splice Machine built-in users are checked for
collision when a role is created.

A role name cannot start with the prefix `SYS` (after case
normalization). The purpose of this restriction is to reserve a name
space for system-defined roles at a later point. Use of the prefix `SYS`
raises the *SQLException* 4293A.

You cannot create a role with the name `PUBLIC` (after case
normalization). `PUBLIC` is a reserved authorization identifier. An
attempt to create a role with the name `PUBLIC` raises *SQLException*
4251B.

## Examples

### Creating a Role

Here's a simple example of creating a role:
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE ROLE statsEditor_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
### Examples of Invalid Role Names

Here are several examples of attempts to create a role using names that
are reserved and cannot be used as role names. Each of these generates
an error:
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE ROLE public;
    splice> CREATE ROLE "PUBLIC";
    splice> CREATE ROLE sysrole;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [RoleName](sqlref_identifiers_types.html#RoleName)
* [`SET ROLE`](sqlref_statements_setrole.html) statement
* [`SYSROLES`](sqlref_systables_sysroles.html) system table

</div>
</section>
