---
title: DROP ROLE statement
summary: Drops a role from a database.
keywords: dropping a role
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_droprole.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP ROLE

The `DROP ROLE` statement allows you to drop a role from your database.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP ROLE roleName
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
roleName
{: .paramName}

The name of the role that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Usage

Dropping a role has the effect of removing the role from the database
dictionary. This means that no session user can henceforth set that role
(see &nbsp;[`CURRENT_ROLE` function](sqlref_builtinfcns_currentrole.html))
will now have a `NULL CURRENT_ROLE`.

Dropping a role also has the effect of revoking that role from any user
and role it has been granted to. See the &nbsp;[`REVOKE`
statement](sqlref_statements_revoke.html) for information on how
revoking a role may impact any dependent objects.

## Example

<div class="preWrapper" markdown="1">
    splice> DROP ROLE statsEditor_role;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE_ROLE`](sqlref_statements_createrole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [`SET ROLE`](sqlref_statements_setrole.html) statement
* [`SYSROLES`](sqlref_systables_sysroles.html) system table

</div>
</section>

