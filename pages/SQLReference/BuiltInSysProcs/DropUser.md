---
title: SYSCS_UTIL.SYSCS_DROP_USER built-in system procedure
summary: Built-in system procedure that removes a user account from a database.
keywords: drop user, drop_user
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_dropuser.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_DROP_USER

The `SYSCS_UTIL.SYSCS_DROP_USER` system procedure removes a user account
from a database.

This procedure is used in conjunction with NATIVE authentication..

You are not allowed to remove the user account of the database owner.

If you use this procedure to remove a user account, the schemas and data
objects owned by the user remain in the database and can be accessed
only by the database owner or by other users who have been granted
access to them. If the user is created again, then he or she regains
access to the schemas and data objects.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DROP_USER( IN userName VARCHAR(128) )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
userName
{: .paramName}

A user name that is case-sensitive if you place the name string in
double quotes. This user name is an authorization identifier. If the
user name is that of the database owner, an error is raised.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

Drop a user named FRED:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
     ("CALL SYSCS_UTIL.SYSCS_DROP_USER('fred')");
     cs.execute();
     cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

Drop a user named FreD:

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_DROP_USER('fred');
    Statement executed;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_CREATE_USER`](sqlref_builtinfcns_user.html)

</div>
</section>
