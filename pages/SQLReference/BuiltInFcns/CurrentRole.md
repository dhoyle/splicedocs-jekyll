---
title: CURRENT_ROLE built-in SQL function
summary: Built-in SQL function that returns a list of role names for the current user.
keywords: current role
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_currentrole.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_ROLE

`CURRENT_ROLE` returns a list of role names for the current user. If there is no current role, it returns `NULL`.

This function returns a string of up to `32672` characters.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_ROLE
{: .FcnSyntax}

</div>

## Example

```
call syscs_util.syscs_create_user('jdoe', 'jdoe');
create schema test1;
create role admin1;
grant all privileges on schema test1 to admin1;
create schema test2;
create role admin2;
grant all privileges on schema test2 to admin2;
create schema test3;
create role admin3;
grant all privileges on schema test3 to admin3;

grant admin1 to jdoe;
grant admin2 to jdoe;
grant admin3 to jdoe;

connect 'jdbc:splice://localhost:1527 /splicedb;user=jdoe;password=jdoe' as jdoe_con;
splice> values current_role;
1
"ADMIN1", "ADMIN2", "ADMIN3"

1 row selected
```
{: .Example}


## See Also

* [`CREATE_ROLE`](sqlref_statements_createrole.html) statement
* [`DROP_ROLE`](sqlref_statements_droprole.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [`SET ROLE`](sqlref_statements_setrole.html) statement

</div>
</section>
