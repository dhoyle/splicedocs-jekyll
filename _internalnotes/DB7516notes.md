Added a new schema level privilege “ACCESS”. A schema will not be visible to a user if he/she does not have the access privilege on this schema.

Turn off public access to system schemas such as sys, sysibm. The access(only access and select privileges) to the system schemas can still be granted like any other schemas by super users.

Gary Hillerson With this feature, show tables/show schemas will only return the rows corresponding to the schemas visible to a user. We need to document what schemas are visible to a user.
All system table s can only be queries if the current user have both access and select privilege on them.




1. Added grouping in built in fcns
2. Added note on every system table page about needing access
3. Added ACCESS privilege for schemas to Grant and Revoke pages
4. Created System Views section of SQL Ref and moved systablestatistics and syscolumnstatistics to there
5. Added SysAllRoles and SysSchemaViews to System Views section of sql ref
6. Updated description of show schemas and show tables commands to say they'll only show for schemas for which the current user has `ACCESS` privileges.


Questions:

1. Right now we tell people to query system tables in a large number of doc pages, including:

    (in Alter Table page)
        If the constraint is unnamed, you can specify the generated `CONSTRAINTNAME` ID that is stored in the  `SYS.SYSCONSTRAINTS` table as a delimited value. You can find the constraint ID by joining `SYS.SYSCONSTRAINTS` with  `SYS.SYSTABLES`.

    (in Backup/Restore):
    Accessing Backup ID in sys tables: we tell people to find the backup id in SYS.SYSBACKUP table, etc

2. There are a number of doc pages that use system table queries as examples. Do we need to add a note on each of these about having access privileges, or do we need to replace all of these examples ?
    (in Explain Plan):
        splice> explain select * from sys.systables t, sys.sysschemas s
            where t.schemaid =s.schemaid;

3. Do we need to have a list of system procedures for which certain privileges are needed?
