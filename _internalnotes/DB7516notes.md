## Behavior changes
* Which schemas are visible to a user?

  1. Admin user or user belonging to admin group can see all schemas.
  2. A regular user can see:
     1. schemas owned by the user(or public, or the group user the user belongs to); or
     2. A schemas this user has been granted "access" privilege; or
     3. system schemas that are open to public, currently only the sysvw schema has public access privilege, which holds all the system views.

* What rows in the system tables should be visible to a user?

  1. Admin user or user belonging to admin group can see all rows of a system table.
  2. A regular user can see the rows associated with the schemas that are visible to him/her. For example, given the system table sys.systables, each row represent a table, so only the rows from the schemas that are visible to a user can be seen.

* The access to the system tables by default is now turned off to public, then how can a regular user query the metadata information?

  A regular user can query the metadata information through statement like "show tables", "show schemas" and etc.

  He/she can also query the views in the sysvw schema. For example, `sysvw.sysschemasview` returns the list of schemas visible to the user.

* When a user queries a table in a schema that is not visible to him/her, what would happen?

  Since schema_A is not visible to the user 'allen', an error "ERROR 42Y07: Schema 'SCHEMA_A' does not exist" will be reported instead of something liker "user does not have access privilege on schema_A". This is to prevent user from guessing the existence of a schema he/she cannot see.

  For example,
    ```
    call syscs_util.syscs_create_user('allen', 'allen');
    create schema schema_A;
    create table schema_A.t1 (a1 int, b1 int);
    connect 'jdbc:splice://localhost:1527/splicedb;user=allen;password=allen' as allen_con;
    splice> select * from schema_A.t1;
    ERROR 42Y07: Schema 'SCHEMA_A' does not exist
    ```

* What privileges does a user need to be able to select tables from another schema he/she does not own?
  He/she now needs both access and select privilege on that schema.

## Solution description
* Add an access schema level privilege to indicate whether a schema is visible to a user.

* Turn off public access to system schemas such as sys, sysibm in DataDictionaryImpl.getPermissions(). The access(only access and select privileges) to the system schemas can still be granted like any other schemas by super users.

* Introduce a new system schema `sysvw` whose access and select privileges are granted to the public. It contains the publicly accessible system views.

* Introduce `SpliceGroupUserVTI` to return the list of group users a user belongs to as a table.

* Introduce `SpliceAllRolesVTI` to return the list of roles directly or indirectly granted to a user as a table.

* Introduce two system views: `sysvw.sysallroles` and `sysvw.sysschemaviews`.

  1. sysvw.sysschemaviews returns all the schemas for the admin user or user belonging to the admin group; and for regular user, it returns only the schemas that are visible to him/her, or the group users he/she belongs to, or public.

## Impact

* "values current_user" and "values group_user" now will return the session user and its corresponding group user from the session the statement is originally submitted.

## Pending issues

* Sentry and Ranger are not supported

* -`sysvw.sysschemasview` underneath uses current_user and current groupusers from a language connection context to check the schema visibility. Currently when running under spark, "values current_user" returns "SPLICE" instead of the actual session user who submits the query, this could incorrectly make schemas visible for that user.
