---
title: SET ROLE statement
summary: Sets the current role for the current SQL context of a session.
keywords: setting the current role
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_setrole.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SET ROLE

The `SET ROLE` statement allows you to set the current role for the
current SQL context of a session.

You can set a role only if the current user has been granted the role,
or if the role has been granted to `PUBLIC`.

The `SET ROLE` statement is not transactional; a rollback does not undo
the effect of setting a role. If a transaction is in progress, an
attempt to set a role results in an error.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
SET ROLE { <a href="sqlref_identifiers_types.html#RoleName">roleName</a> | 'string-constant' | ? | NONE }</pre>

</div>
<div class="paramList" markdown="1">
roleName
{: .paramName}

The role you want set as the current role.
{: .paramDefnFirst}

You can specify a *roleName* of `NONE` to unset the current role.
{: .paramDefn}

If you specify the role as a string constant or as a dynamic parameter
specification (`?`), any leading and trailing blanks are trimmed from
the string before attempting to use the remaining (sub)string as a
*roleName*. The dynamic parameter specification can be used in prepared
statements, so the `SET ROLE` statement can be prepared once and then
executed with different role values. You cannot specify `NONE` as a
dynamic parameter.
{: .paramDefn}

</div>
## Usage Notes

Setting a role identifies a set of privileges that is a union of the
following:

* The privileges granted to that role
* The union of privileges of roles contained in that role (for a
  definition of role containment, see "Syntax for roles" in &nbsp;[`GRANT`
  statement](sqlref_statements_grant.html))

In a session, the *current privileges* define what the session is
allowed to access. The *current privileges* are the union of the
following:

* The privileges granted to the current user
* The privileges granted to `PUBLIC`
* The privileges identified by the current role, if set

You can find the available role names in the
[`SYS.SYSROLES`](sqlref_systables_sysroles.html) system table.
{: .noteNote}

## SQL Example

This examples set the role of the current user to `reader_role`:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SET ROLE reader_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## JDBC Example

This examples set the role of the current user to `reader_role`:
{: .body}

<div class="preWrapperWide" markdown="1">

    stmt.execute("SET ROLE admin");      -- case normal form: ADMIN
    stmt.execute("SET ROLE \"admin\"");  -- case normal form: admin
    stmt.execute("SET ROLE none");       -- special case

    PreparedStatement ps = conn.prepareStatement("SET ROLE ?");
    ps.setString(1, "  admin ");         -- on execute: case normal form: ADMIN
    ps.setString(1, "\"admin\"");        -- on execute: case normal form: admin
    ps.setString(1, "none");             -- on execute: syntax error
    ps.setString(1, "\"none\"");         -- on execute: case normal form: none
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE ROLE`](sqlref_statements_createrole.html) statement
* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [RoleName](sqlref_identifiers_types.html#RoleName)
* [`SET ROLE`](#) statement
* [`SELECT`](sqlref_expressions_select.html) expression
* [`SELECT`](sqlref_expressions_select.html) statement
* [`SYSROLES`](sqlref_systables_sysroles.html) system table
* [`UPDATE`](sqlref_statements_update.html) statement
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>
