---
title: SYSCS_UTIL.SHOW_CREATE_TABLE built-in system procedure
summary: Built-in system procedure that returns the DDL of a table.
keywords: table, ddl
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_showcreatetable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SHOW_CREATE_TABLE

The `SYSCS_UTIL.SHOW_CREATE_TABLE` system procedure returns the DDL to create a table, in string form.


## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SHOW_CREATE_TABLE( VARCHAR schemaName,
                                  VARCHAR tableName );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the table's schema.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table.
{: .paramDefnFirst}

</div>
## Results

This procedure returns a string representation of the `CREATE TABLE` statement DDL to create the specified table.

## Example


```
splice> CREATE TABLE Players(
    ID           SMALLINT NOT NULL,
    Team         VARCHAR(64) NOT NULL,
    Name         VARCHAR(64) NOT NULL,
    Position     CHAR(2),
    DisplayName  VARCHAR(24),
    BirthDate    DATE
    );
0 rows inserted/updated/deleted

CALL SYSCS_UTIL.SHOW_CREATE_TABLE( 'SPLICE', 'PLAYERS' );
DDL
----------------------------------------------------
CREATE TABLE "SPLICE"."PLAYERS" (
"ID" SMALLINT NOT NULL
,"TEAM" VARCHAR(64) NOT NULL
,"NAME" VARCHAR(64) NOT NULL
,"POSITION" CHAR(2)
,"DISPLAYNAME" VARCHAR(24)
,"BIRTHDATE" DATE
) ;

1 row selected

```
{: .Example}


## See Also

* The [`show create table`](cmdlineref_showcreatetable.html) command uses this procedure to generate its output.


</div>
</section>
