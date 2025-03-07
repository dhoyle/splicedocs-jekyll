---
title: USER built-in SQL function
summary: Built-in SQL function that returns the authorization ID of the user who created the SQL session
keywords: authorization ID, user id, session user
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_user.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# USER

When used outside stored routines, &nbsp;[`CURRENT_USER`](sqlref_builtinfcns_currentuser.html), &nbsp;`USER`, and  &nbsp; [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) all return the
authorization identifier of the user who created the SQL session.

`SESSION_USER` also always returns this value when used within stored
routines.

If used within a stored routine created with `EXTERNAL SECURITY
DEFINER`, however, `CURRENT_USER` and `USER` return the authorization
identifier of the user that owns the schema of the routine. This is
usually the creating user, although the database owner could be the
creator as well.

For information about definer's and invoker's rights, see &nbsp;[`CREATE
FUNCTION` statement](sqlref_statements_createfunction.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    USER
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES USER;
    1
    ---------------------------------
    SPLICE
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_USER`](sqlref_builtinfcns_currentuser.html) function
* [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) function
* [`CREATE_FUNCTION`](sqlref_statements_createfunction.html) statement
* [`CREATE_PROCEDURE`](sqlref_statements_createprocedure.html) statement

</div>
</section>
