---
title: SYSCS_UTIL.SYSCS_CREATE_USER  built-in system procedure

summary: Built-in system procedure that adds a new user account to a database.
keywords: add new user, create_user
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_createuser.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_CREATE_USER

The `SYSCS_UTIL.SYSCS_CREATE_USER` system procedure adds a new user
account to a database.

This procedure creates users for use with NATIVE authentication.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_CREATE_USER(
    		IN userName VARCHAR(128),
    		IN password VARCHAR(32672)
    		)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
userName
{: .paramName}

A user name that is case-sensitive if you place the name string in
double quotes. This user name is an authorization identifier.
{: .paramDefnFirst}

Case sensitivity is very specific with user names: if you specify the
user name in single quotes, e.g. 'Fred', the system automatically
converts it into all Uppercase.
{: .paramDefn}

The user name is only case sensitive if you double-quote it inside of
the single quotes. For example, `'"Fred"'` is a different user name than
`'Fred'`, because `'Fred'` is assumed to be case-insensitive.
{: .noteNote}

password
{: .paramName}

A case-sensitive password.
{: .paramDefnFirst}

</div>
## Results

When you add a new user, a new schema is automatically created with
exactly the same name as the user. For example, here's a sequence of an
administrator adding a new user named `fred` and then verifying that the
schema named `fred` is now active:

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_CREATE_USER('fred', 'fredpassword');
    Statement executed.
    splice> VALUES(CURRENT SCHEMA);
    1
    ------------------------------------------------------------------
    SPLICE

    1 row selected
    splice> SET SCHEMA fred;
    0 rows inserted/updated/deleted
    splice> VALUES(CURRENT SCHEMA);
    1
    ------------------------------------------------------------------
    FRED

    1 row selected
{: .Example xml:space="preserve"}

</div>
When the new user's credentials are used to connect to the database,
his/her default schema will be that new schema. If you want the new user
to have access to data in other schemas, such as the `SPLICE` schema, an
administrator will need to explicitly
[grant](sqlref_statements_grant.html) those access privileges.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

Create a user named FRED:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_CREATE_USER(?, ?)");
      cs.setString(1, "fred");
      cs.setString(2, "fredpassword");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
Create a user named FreD:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_CREATE_USER(?, ?)");
      cs.setString(1, "\"FreD\"");
      cs.setString(2, "fredpassword");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

Create a user named FRED:

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_CREATE_USER('fred', 'fredpassword');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
Create a (case sensitive) user named `MrBaseball`:

<div class="preWrapper" markdown="1">
    CALL SYSCS_UTIL.SYSCS_CREATE_USER('MrBaseball', 'pinchhitter')
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_DROP_USER`](sqlref_builtinfcns_user.html) built-in
  system procedure

</div>
</section>
