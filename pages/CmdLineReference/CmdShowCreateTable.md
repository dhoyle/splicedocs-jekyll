---
title: Show Create Table command
summary: Displays the DDL used to create a table.
keywords: procedure, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showcreatetable.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Create Table

The <span class="AppCommand">show create table</span> command displays the DDL used with the `create table`
statement to create a specified table.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW CREATE TABLE schemaName.tableName
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The schema name. If not specified, the current schema is used.
{: .paramDefnFirst}

tableName
{: .paramName}

The table name.
{: .paramDefnFirst}

</div>


### Example

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

show create table players;
DDL
---
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
{: .AppCommand}

### See Also
* The [`SYSCS_UTIL.SHOW_CREATE_TABLE`](sqlref_sysprocs_showcreatetable.html)  built-in system procedure.

</div>
</section>
