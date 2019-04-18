---
title: CURRENT_USER built-in SQL function
summary: Built-in SQL function that returns the authorization identifier of the user who created the SQL session
keywords: current user, authorization id
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_currentuser.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_USER

When used outside stored routines, `CURRENT_USER`, &nbsp;[`USER`](sqlref_builtinfcns_user.html), and &nbsp;[`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) all return the
authorization identifier of the user who created the SQL session.

`SESSION_USER` also always returns this value when used within stored
routines.

If used within a stored routine created with `EXTERNAL SECURITY
DEFINER`, however, `CURRENT_USER` and &nbsp;
[`USER`](sqlref_builtinfcns_user.html) return the authorization
identifier of the user that owns the schema of the routine. This is
usually the creating user, although the database owner could be the
creator as well.

For information about definer's and invoker's rights, see &nbsp;[`CREATE
FUNCTION` statement](sqlref_statements_createfunction.html).

Each of these functions returns a string of up to 128 characters.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_USER
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES CURRENT_USER;
    1
    --------------------------------------------------------------------
    SPLICE

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`USER`](sqlref_builtinfcns_user.html) function
* [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) function
* [`CREATE_FUNCTION`](sqlref_statements_createfunction.html) statement
* [`CREATE_PROCEDURE`](sqlref_statements_createprocedure.html) statement

</div>
</section>
