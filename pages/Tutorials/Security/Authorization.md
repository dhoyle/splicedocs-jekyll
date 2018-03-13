---
title: Splice Machine Authentication and Authorization
summary: Describes how to configure and manage user authentication and user authorization, in two main sections
keywords: authorizing, authenticating, roles, managing roles, native authentication, grant, set role, users, create user, create role, drop role, cascade
toc: false
product: all
sidebar: tutorials_sidebar
permalink: developers_fundamentals_auth.html
folder: Tutorials/Security
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Authorization and Roles

This topic describes Splice Machine *user authorization*, which is how
Splice Machine authorizes which operations can be performed by which
users.

The on-premise version of Splice Machine offers several different
authentication mechanisms for your database, as described in the
[Configuring Splice Machine
Authentication](onprem_install_configureauth.html) topic.
Native authentication is the default mechanism.
{: .noteNote}

With our built-in native authentication mechanism, the user that
requests a connection must provide a valid name and password, which
Splice Machine verifies against the repository of users defined for the
system. After Splice Machine authenticates the user as valid, user
authorization determines what operations the user can perform on the
database to which the user is requesting a connection.

## Managing Users

Splice manages users with standard system procedures:

* You can create a user with the
 &nbsp;[`SYSCS_UTIL.SYSCS_CREATE_USER`](sqlref_builtinfcns_user.html)
  procedure:
  <div class="preWrapperWide" markdown="1">
      splice> call syscs_util.syscs_create_user('username', 'password');
  {: .AppCommand xml:space="preserve"}

  </div>

* You can drop a user with the
 &nbsp;[`SYSCS_UTIL.SYSCS_DROP_USER`](sqlref_builtinfcns_user.html)
  procedure:
  <div class="preWrapperWide" markdown="1">
      splice> call syscs_util.syscs_drop_user('username');
  {: .AppCommand xml:space="preserve"}

  </div>

## Managing Roles

When standard authorization mode is enabled, object owners can use roles
to administer privileges. Roles are useful for administering privileges
when a database has many users. Role-based authorization allows an
administrator to grant privileges to anyone holding certain roles, which
is less tedious and error-prone than administrating those privileges to
a large set of users.

### The Database Owner

The *database owner* is `splice`. Only the database owner can create,
grant, revoke, and drop roles. However, object owners can grant and
revoke privileges for those objects to and from roles, as well as to and
from individual users and to `PUBLIC` (all users).

If authentication and SQL authorization are both enabled, only the
database owner can perform these actions on the database:

* start it up
* shut it down
* perform a full upgrade

If authentication is not enabled, and no user is supplied, the database
owner defaults to `SPLICE`, which is also the name of the default
schema.

The database owner log-in information for Splice Machine is configured
when your database software is installed. If you're using our database
as a service, there is no default userId or password; if you're using
our on-premise database, the default userID is `splice`, and the default
password is `admin`.

### Creating and Using Roles

The database owner can use the &nbsp;[`GRANT`](sqlref_statements_grant.html)
statement to grant a role to one or more users, to `PUBLIC`, or to
another role. Roles can be contained within other roles and can inherit
privileges from roles that they contain.

### Setting Roles

When a user first connects to Splice Machine, no role is set, and the
[`SET ROLE`](sqlref_statements_setrole.html) statement to set the
current role for that session. The role can be any role that has been
granted to the session's current user or to `PUBLIC`.

To unset the current role, you can call `SET ROLE` with an argument of
`NONE`. At any time during a session, there is always a current user,
but there is a current role only if `SET ROLE` has been called with an
argument other than `NONE`. If a current role is not set, the session
has only the privileges granted to the user directly or to `PUBLIC`.

### Roles in Stored Procedures and Functions

Within stored procedures and functions that contain SQL, the current
role depends on whether the routine executes with invoker's rights or
with definer's rights, as specified by the `EXTERNAL SECURITY` clause in
the &nbsp;[`CREATE PROCEDURE`](sqlref_statements_createprocedure.html)
statements. During execution, the current user and current role are kept
on an authorization stack which is pushed during a stored routine call.

* Within routines that execute with invoker's rights, the following
  applies: initially, inside a nested connection, the current role is
  set to that of the calling context. So is the current user. Such
  routines may set any role granted to the invoker or to `PUBLIC`.
* Within routines that execute with definer's rights, the following
  applies: initially, inside a nested connection, the current role is
  `NULL`, and the current user is that of the definer. Such routines may
  set any role granted to the definer or to `PUBLIC`.

Upon return from the stored procedure or function, the authorization
stack is popped, so the current role of the calling context is not
affected by any setting of the role inside the called procedure or
function. If the stored procedure opens more than one nested connection,
these all share the same (stacked) current role (and user) state. Any
dynamic result set passed out of a stored procedure sees the current
role (or user) of the nested context.

### Dropping Roles

Only the database owner can drop a role. To drop a role, use the &nbsp;[`DROP
ROLE`](sqlref_statements_droprole.html) statement. Dropping a role
effectively revokes all grants of this role to users and other roles.

## Granting Privileges

Use the &nbsp;[`GRANT`](sqlref_statements_grant.html) statement to grant
privileges on schemas, tables and routines to a role or to a user.

Note that when you grant privileges to a role, you are implicitly
granting those same privileges to all roles that contain that role.

## Revoking Privileges

Use the &nbsp;[`REVOKE`](sqlref_statements_revoke.html) statement to revoke
privileges on schemas, tables and routines.

When a privilege is revoked from a user:

* That session can no longer keep the role, not can it take on that role
  unless the role is also granted to `PUBLIC`.
* If that role is the current role of an existing session, the current
  privileges of the session lose any extra privileges obtained through
  setting that role.

The default revoke behavior is `CASCADE`, which means that all
persistent objects (constraints and views, views and triggers) that rely
on a dropped role are dropped. Although there may be other ways of
fulfilling that privilege at the time of the revoke, any dependent
objects are still dropped. Any prepared statement that is potentially
affected will be checked again on the next execute. A result set that
depends on a role will remain open even if that role is revoked from a
user.

## See Also

* [Configuring Splice Machine
  Authentication](onprem_install_configureauth.html)
* [`CREATE FUNCTION`](sqlref_statements_createfunction.html)
* [`CREATE PROCEDURE`](sqlref_statements_createprocedure.html)
* [`CREATE ROLE`](sqlref_statements_createrole.html)
* [`CURRENT_ROLE`](sqlref_builtinfcns_currentrole.html)
* [`DROP ROLE`](sqlref_statements_droprole.html)
* [`GRANT`](sqlref_statements_grant.html)
* [`REVOKE`](sqlref_statements_revoke.html)
* [`SET ROLE`](sqlref_statements_setrole.html)
* [`SYSCS_UTIL.SYSCS_CREATE_USER`](sqlref_builtinfcns_user.html)
* [`SYSCS_UTIL.SYSCS_DROP_USER`](sqlref_builtinfcns_user.html)

</div>
</section>
