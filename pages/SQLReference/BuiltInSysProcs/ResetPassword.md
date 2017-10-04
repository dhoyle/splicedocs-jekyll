---
title: SYSCS_UTIL.SYSCS_RESET_PASSWORD built-in system procedure
summary: Built-in system procedure that resets a password that has expired or has been forgotten.
keywords: reset_password, reset password
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_resetpassword.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_RESET_PASSWORD

The `SYSCS_UTIL.SYSCS_RESET_PASSWORD` system procedure resets a password
for a user whose password has expired or has been forgotten.

This procedure is used in conjunction with NATIVE authentication.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_RESET_PASSWORD(IN userName VARCHAR(128),
    		                 IN password VARCHAR(32672))
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
userName
{: .paramName}

A user name that is case-sensitive if you place the name string in
double quotes. This user name is an authorization identifier..
{: .paramDefnFirst}

password
{: .paramName}

A case-sensitive password.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

Reset the password of a user named FRED:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_RESET_PASSWORD(?, ?)");
      cs.setString(1, "fred");
      cs.setString(2, "temppassword");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
Reset the password of a user named FreD:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_RESET_PASSWORD(?, ?)");
      cs.setString(1, "\"FreD\"");
      cs.setString(2, "temppassword");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

Reset the password of a user named FRED:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_RESET_PASSWORD('fred', 'temppassword');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
Reset the password of a user named MrBaseball:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_RESET_PASSWORD('MrBaseball', 'baseball!');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_MODIFY_PASSWORD`](sqlref_sysprocs_modifypassword.html)

</div>
</section>

