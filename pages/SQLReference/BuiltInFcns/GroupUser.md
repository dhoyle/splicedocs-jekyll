---
title: GROUP_USER built-in SQL function
summary: Built-in SQL function that returns the groups to which the current user belongs
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_groupuser.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# GROUP_USER

When used outside stored routines, `GROUP_USER` returns the
names of the groups to which the current user belongs.

If used within a stored routine created with `EXTERNAL SECURITY
DEFINER`, however, `GROUP_USER` returns the groups to which the user who owns the schema of the routine belongs;
this is usually the creating user, although the database owner could be the creator as well.

This function returns a string of up to 32672 characters.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    GROUP_USER
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES GROUP_USER;
    1
    --------------------------------------------------------------------
    "VIEWERS", "EDITORS"

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`USER`](sqlref_builtinfcns_user.html) function
* [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) function
* [`CURRENT_USER`](sqlref_builtinfcns_groupuser.html) function
* [`CREATE_FUNCTION`](sqlref_statements_createfunction.html) statement
* [`CREATE_PROCEDURE`](sqlref_statements_createprocedure.html) statement

</div>
</section>
