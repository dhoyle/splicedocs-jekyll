---
title: SYSCS_UTIL.SYSCS_MODIFY_PASSWORD built-in system procedure
summary: Built-in system procedure that is called by a user to change that user's own password.
keywords: change password, modify password, modify_password
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_modifypassword.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_MODIFY_PASSWORD

The `SYSCS_UTIL.SYSCS_MODIFY_PASSWORD` system procedure is called by a
user to change that user's own password.

This procedure is used in conjunction with NATIVE authentication.

The `derby.authentication.native.passwordLifetimeMillis` property sets
the password expiration time, and the
`derby.authentication.native.passwordLifetimeThreshold` property sets
the time when a user is warned that the password will expire.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_MODIFY_PASSWORD(IN password VARCHAR(32672))
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
password
{: .paramName}

A case-sensitive password.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

Any user can execute this procedure.

As of this writing, your administrator must grant a user execute
permission on this procedure before that user can successfully modify
his or her password.
{: .noteWorkaround}

## JDBC example

<div class="preWrapperWide" markdown="1">
    CallableStatement cs = conn.prepareCall(
      "CALL SYSCS_UTIL.SYSCS_MODIFY_PASSWORD('baseball!')");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

The following example sets the current user's password to `baseball!`:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_MODIFY_PASSWORD('baseball!');
    Statement executed
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_RESET_PASSWORD`](sqlref_sysprocs_resetpassword.html)

</div>
</section>

