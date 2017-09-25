---
title: CURRENT_ROLE built-in SQL function
summary: Built-in SQL function that returns the authorization identifier of the current role.
keywords: current role
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_currentrole.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_ROLE   {#BuiltInFcns.CurrentRole}

`CURRENT_ROLE` returns the authorization identifier of the current role.
If there is no current role, it returns `NULL`.

This function returns a string of up to `258` characters. This is twice
the length of an identifier `(128*2) + 2`, to allow for quoting.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_ROLE
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES CURRENT_ROLE;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE_ROLE`](sqlref_statements_createrole.html) statement
* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [`SET ROLE`](sqlref_statements_setrole.html) statement
* [`SYSROLES`](sqlref_systables_sysroles.html) system table

</div>
</section>

