---
title: Getting Started with the Command Line Interpreter
summary: Getting Started with the Command Line Interpreter
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: gettingstarted_cmdline.html
folder: GettingStarted
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Getting Started With the splice&gt; Command Line Interface

The <span class="AppCommand">splice&gt;</span> command line interpreter
is an easy way to interact with your Splice Machine database. This topic
introduces <span class="AppCommand">splice&gt;</span> and some of the
more common commands you'll use.

Our [Command Line Reference](cmdlineref_intro.html) contains additional information about command line syntax and commands, and includes examples of each available command.

This topic show you the basics of working with the <span
class="AppCommand">splice&gt;</span> command line interpreter, in these
sections:

* [Starting splice&gt;](#Starting)
* [Basic Syntax Rules](#Basic)
* [Connecting to a Database](#Connecti)
* [Displaying Database Objects](#Viewing4)
* [Basic DDL and DML Statements](#Basic2)

## Starting splice&gt;   {#Starting}

To launch the <span class="AppCommand">splice&gt;</span> command line
interpreter, follow these steps:

<div class="opsStepsList" markdown="1">
1.  Open a terminal window

2.  Navigate to your splicemachine directory

    ```
    cd ~/splicemachine    #Use the correct path for your Splice Machine installation
    ```
    {: .ShellCommand}

3.  Start splice&gt;

    ```
    ./sqlshell.sh    #Use the correct path for your Splice Machine installation
    ```
    {: .ShellCommand}

4.  The command line interpreter starts:

    ```
    Running Splice Machine SQL ShellFor help: "Splice> help;"SPLICE** = current connectionsplice>
    ```
    {: .AppCommand}

    `SPLICE` is the name of the default connection, which becomes the
    current connection when you start the interpreter.

</div>

## Basic Syntax Rules   {#Basic}

When using the command line (the <span
class="AppCommand">splice&gt;</span> prompt), you must end each SQL
statement with a semicolon (`;`). For example:

```
splice> select * from myTable;
```
{: .AppCommand}

You can extend SQL statements across multiple lines, as long as you end
the last line with a semicolon. Note that the `splice>` command line
interface prompts you with a fresh <span class="AppCommand">&gt;</span>
at the beginning of each line. For example:

```
splice> select * from myTable> where i > 1;
```
{: .AppCommand}

The *[Command Line Syntax](cmdlineref_using_cli.html)* topic contains a complete syntax reference for <span
class="AppCommand">splice&gt;</span>.

## Connecting to a Database   {#Connecti}

When you start splice&gt;, you are automatically connected to your
default database. You can connect to other databases with the
[`connect`](cmdlineref_connect.html) command:

```
connect 'jdbc:splice://srv55:1527/splicedb;user=YourUserId;password=YourPassword' AS DEMO;
```
{: .AppCommand}

### Anatomy of a Connection String

The [Command Line Syntax](cmdlineref_using_cli.html) describes the full set of command line options. The following table summarizes the options in the above example:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Examples</th>
            <th>Component</th>
            <th>Comments</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>jdbc:splice:</code></td>
            <td>Connection driver name</td>
            <td> </td>
        </tr>
        <tr>
            <td class="CodeFont">
                <p>srv55:1527</p>
                <p>localhost:1527</p>
            </td>
            <td>Server Name:Port</td>
            <td><span class="AppCommand">splice&gt;</span> listens on port <code>1527</code></td>
        </tr>
        <tr>
            <td><code>splicedb</code></td>
            <td>Database name</td>
            <td>The name of the database you're connecting to on the server.</td>
        </tr>
        <tr>
            <td><code>user=YourUserId;password=YourPassword</code></td>
            <td>Connection parameters</td>
            <td>Any required connection parameters, such as userId and password.</td>
        </tr>
        <tr>
            <td><code>AS DEMO</code></td>
            <td>Optional connection identifier</td>
            <td>
                <p>The name that you want associated with this connection.</p>
                <p>If you don't supply a name, Splice Machine assigns one for your; for example: <code>CONNECTION1</code>.</p>
            </td>
        </tr>
    </tbody>
</table>

### Working with Connections

You can connect to multiple database in Splice Machine, though you can only work with the *current connection* database. Here are commands you can use to work with database connections:


#### View currently available connections:

```
splice> show connections;
DEMO     - jdbc:splice://srv55:1527/splicedb
SPLICE*  - jdbc:splice://localhost:1527/splicedb
* = current connection
```
{: .Example}

#### Open a new connection:

```
splice> SET CONNECTION DEMO;
splice> show connections;
DEMO*    - jdbc:splice://srv55:1527/splicedb
SPLICE   - jdbc:splice://localhost:1527/splicedb
* = current connection
```
{: .Example}

#### Close a connection:
You can use the &nbsp;[`disconnect`](cmdlineref_disconnect.html) command to
close a connection:

```
splice> Disconnect DEMO;
splice> show Connections;
SPLICE  - jdbc:splice://localhost:1527/splicedb
No current connection
```
{: .Example}

#### Make a named connection the current connection:

```
splice> connect myDatabase;
splice> show connections;
SPLICE*  - jdbc:splice://localhost:1527/myDatabase
* = current connection
```
{: .Example}

#### Disconnect from all connections:

```
splice> disconnect all;
splice> show connections;
No connections available
```
{: .Example}

## Working with Schemas

Here are commands you can use to work with the schemas in your database:

#### Display schemas:

```
splice> show schemas;
TABLE_SCHEM
------------------------------
NULLID
SPLICE
SQLJ
SYS
SYSCAT
SYSCS_DIAG
SYSCS_UTIL
SYSFUN
SYSIBM
SYSPROC
SYSSTAT
11 rows selected
```
{: .Example}


#### Display the current schema:

```
```
{: .Example}

#### Set the current schema:

```
splice> values(current schema);
1
------------------------------
SPLICE
1 row selected
```
{: .Example}


#### Change the current schema:

```
splice> set schema mySchema;
0 rows inserted/updated/deleted
splice> values(current schema);
1
------------------------------
MYSCHEMA
```
{: .Example}


## Working with Tables

Here are commands you can use to work with the schemas in your database:


#### Display all available tables in all schemas:

```
splice> SHOW TABLES;
TABLE_SCHEM  |TABLE_NAME            |CONGLOM_ID|REMARKS
--------------------------------------------------------
SYS          |SYSALIASES            |256       |
SYS          |SYSBACKUP             |992       |
SYS          |SYSBACKUPITEMS        |1104      |
SYS          |SYSCHECKS             |336       |
SYS          |SYSCOLPERMS           |608       |
SYS          |SYSCOLUMNS            |80        |
SYS          |SYSCOLUMNSTATS        |1264      |
SYS          |SYSCONGLOMERATES      |48        |
SYS          |SYSCONSTRAINTS        |304       |
SYS          |SYSDEPENDS            |368       |
SYS          |SYSFILES              |288       |
SYS          |SYSFOREIGNKEYS        |272       |
SYS          |SYSKEYS               |240       |
SYS          |SYSPERMS              |912       |
SYS          |SYSPHYSICALSTATS      |1280      |
SYS          |SYSPRIMARYKEYS        |320       |
SYS          |SYSROLES              |816       |
SYS          |SYSROUTINEPERMS       |656       |
SYS          |SYSSCHEMAPERMS        |1328      |
SYS          |SYSSCHEMAS            |32        |
SYS          |SYSSEQUENCES          |864       |
SYS          |SYSSTATEMENTS         |384       |
SYS          |SYSTABLEPERMS         |592       |
SYS          |SYSTABLES             |64        |
SYS          |SYSTABLESTATS         |1296      |
SYS          |SYSTRIGGERS           |576       |
SYS          |SYSUSERS              |928       |
SYS          |SYSVIEWS              |352       |
SYSIBM       |SYSDUMMY1             |1312      |
SPLICE       |CUSTOMERS             |1568      |
SPLICE       |T_DETAIL              |1552      |
SPLICE       |T_HEADER              |1536      |

34 rows selected
{: .AppCommand xml:space="preserve"}

```
{: .Example}


#### Display tables in a specific schema:

```
splice> show tables in SPLICE;
TABLE_SCHEM  |TABLE_NAME            |CONGLOM_ID|REMARKS
--------------------------------------------------------
SPLICE       |CUSTOMERS             |1568      |
SPLICE       |T_DETAIL              |1552      |
SPLICE       |T_HEADER              |1536      |

3 rows selected
```
{: .Example}


#### Describe the structure of a table:

```
splice> describe T_DETAIL;
COLUMN_NAME                 |TYPE_NAME|DEC |NUM |COLUM |COLUMN_DEF|CHAR_OCTE |IS_NULL
--------------------------------------------------------------------------------------------------
TRANSACTION_HEADER_KEY      |BIGINT   |0   |10  |19    |NULL      |NULL      |NO
TRANSACTION_DETAIL_KEY      |BIGINT   |0   |10  |19    |NULL      |NULL      |NO
CUSTOMER_MASTER_ID          |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
TRANSACTION_DT              |DATE     |0   |10  |10    |NULL      |NULL      |NO
ORIGINAL_SKU_CATEGORY_ID    |INTEGER  |0   |10  |10    |NULL      |NULL      |YES

5 rows selected
```
{: .Example}


## Displaying Indexes

Here are commands you can use to display indexes.


#### Display all of the indexes in a schema:

```
splice> show indexes in SPLICE;
TABLE_NAME    |INDEX_NAME    |COLUMN_NAME         |ORDINAL&|NON_UNIQUE|TYPE |ASC&|CONGLOM_NO
---------------------------------------------------------------------------------------------
T_DETAIL      |TDIDX1        |ORIGINAL_SKU_CATEGO&|1       |true      |BTREE|A   |1585
T_DETAIL      |TDIDX1        |TRANSACTION_DT      |2       |true      |BTREE|A   |1585
T_DETAIL      |TDIDX1        |CUSTOMER_MASTER_ID  |3       |true      |BTREE|A   |1585
T_HEADER      |THIDX2        |CUSTOMER_MASTER_ID  |1       |true      |BTREE|A   |1601
T_HEADER      |THIDX2        |TRANSACTION_DT      |2       |true      |BTREE|A   |1601

5 rows selected
{: .AppCommand xml:space="preserve"}
```
{: .Example}


#### Display the indexes defined for a specific table:

```
splice> show indexes FROM T_DETAIL;
TABLE_NAME    |INDEX_NAME    |COLUMN_NAME         |ORDINAL&|NON_UNIQUE|TYPE |ASC&|CONGLOM_NO
---------------------------------------------------------------------------------------------
T_DETAIL      |TDIDX1        |ORIGINAL_SKU_CATEGO&|1       |true      |BTREE|A   |1585
T_DETAIL      |TDIDX1        |TRANSACTION_DT      |2       |true      |BTREE|A   |1585
T_DETAIL      |TDIDX1        |CUSTOMER_MASTER_ID  |3       |true      |BTREE|A   |1585

3 rows selected

```
{: .Example}

## Displaying Views   {#Views}

Here are commands for displaying views.


#### Display all views in the database:

```
splice> show views;
TABLE_SCHEM    |TABLE_NAME            |CONGLOM_ID|REMARKS
-----------------------------------------------------------
SYS            |SYSCOLUMNSTATISTICS   |NULL      |
SYS            |SYSTABLESTATISTICS    |NULL      |

2 rows selected
```
{: .Example}


#### Display the views in a schema:

```
splice> show views in SPLICE;
TABLE_SCHEM    |TABLE_NAME            |CONGLOM_ID|REMARKS
-----------------------------------------------------------
SPLICE         |V1                    |NULL      |
----------------------------------------------------------

1 row selected
```
{: .Example}


## Displaying Stored Procedures and Functions   {#Stored}

You can use these commands to display the procedures and functions that are defined in your database.


#### Display the functions defined in a schema:

```
splice> show functions in SPLICE;
FUNCTION_SCHEM|FUNCTION_NAME               |REMARKS
-------------------------------------------------------------------------
SPLICE        |TO_DEGREES                  |java.lang.Math.toDegrees
1 row selected
```
{: .Example}

#### Display the stored function in a schema:

```
splice> show procedures in SQLJ;
PROCEDURE_SCHEM     |PROCEDURE_NAME    |REMARKS
----------------------------------------------------------
SQLJ                |INSTALL_JAR       |com.splicemachine.db.catalog.SystemProcedures.INSTALL_JAR
SQLJ                |REMOVE_JAR        |com.splicemachine.db.catalog.SystemProcedures.REMOVE_JAR
SQLJ                |REPLACE_JAR       |com.splicemachine.db.catalog.SystemProcedures.REPLACE_JAR

3 rows selected
```
{: .Example}


## Basic DDL and DML Statements   {#Basic2}

This section introduces the basics of running SQL Data Definition
Language (*DDL*) and Data Manipulation Language (*DML*) statements from
<span class="AppCommand">splice&gt;</span>.

### CREATE Statements   {#CREATESta}

SQL uses `CREATE` statements to create objects such as
[tables](sqlref_statements_createtable.html). Here are some examples:

#### Creating schemas:

```
splice> create schema myschema1;
0 rows inserted/updated/deleted
splice> create schema myschema2;
0 rows inserted/updated/deleted
splice> show schemas;
TABLE_SCHEM
------------------------------
MYSCHEMA1
MYSCHEMA2
NULLID
SPLICE
SQLJ
SYS
SYSCAT
SYSCS_DIAG
SYSCS_UTIL
SYSFUN
SYSIBM
SYSPROC
SYSSTAT

13 rows selected
```
{: .Example}


#### Creating Tables:

```
splice> SET SCHEMA MySchema1;
0 rows inserted/updated/deleted
splice> CREATE TABLE myTable ( myNum int, myName VARCHAR(64) );
0 rows inserted/updated/deleted
splice> CREATE TABLE Players(
    ID           SMALLINT NOT NULL PRIMARY KEY,
    Team         VARCHAR(64) NOT NULL,
    Name         VARCHAR(64) NOT NULL,
    Position     CHAR(2),
    DisplayName  VARCHAR(24),
    BirthDate    DATE
    );
0 rows inserted/updated/deleted
splice> SHOW TABLES IN MySchema1;
TABLE_SCHEM  |TABLE_NAME            |CONGLOM_ID|REMARKS
--------------------------------------------------------
MYSCHEMA1    |MYTABLE               |1616      |
MYSCHEMA1    |PLAYERS               |1632      |
2 rows selected
```
{: .Example}

#### Creating Functions
```
splice>CREATE FUNCTION SIN (DATA DOUBLE)
   RETURNS DOUBLE
   EXTERNAL NAME 'java.lang.Math.sin'
   LANGUAGE JAVA PARAMETER STYLE JAVA;
0 rows inserted/updated/deleted
```
{: .Example}

#### Creating Views

```
splice> CREATE VIEW PlayerAges (Player, Team, Age)
   AS SELECT DisplayName, Team,
      INT( (Now - Birthdate) / 365.25) AS Age
      FROM Players;
0 rows inserted/updated/deleted
```
{: .Example}


### DROP Statements

SQL uses `DROP` statements to delete objects such as
[tables](sqlref_statements_droptable.html). For example:


#### Dropping a schema:

```
splice> DROP schema MySchema2 restrict;
0 rows inserted/updated/deleted
```
{: .Example}


#### Dropping a table:

```
splice> DROP TABLE myTable;
0 rows inserted/updated/deleted
```
{: .Example}

See the *[DROP Statements](sqlref_statements_dropstatements.html)*
section in our *SQL Reference Manual* for more information.

## Inserting Data

Once you've created a table, you can use
[`INSERT`](sqlref_statements_insert.html) statements to insert records
into that table; for example:

```
splice> INSERT INTO Players
   VALUES( 99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991');
1 row inserted/updated/deleted

splice> INSERT INTO Players
   VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
          (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
          (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');
3 rows inserted/updated/deleted
```
{: .Example}

## Selecting Data

You can use [`SELECT`](sqlref_expressions_select.html) statements to select specific
records or portions of records. This section contains several simple
examples of selecting data.


#### Select a single column from all records in a table:

```
splice> select NAME from Players;
NAME
----------------------------------------------------------------
Earl Hastings
Lester Johns
Joe Bojangles

3 rows selected
```
{: .Example}


#### Select all columns from all records in a table:

```
splice> select * from Players;
ID    |TEAM   |NAME           |POS&|DISPLAYNAME    |BIRTHDATE
---------------------------------------------------------------
27    |Cards  |Earl Hastings  |OF  |Speedy Earl    |1982-04-22
73    |Giants |Lester Johns   |P   |Big John       |1984-06-09
99    |Giants |Joe Bojangles  |C   |Little Joey    |1991-07-11

3 rows selected
```
{: .Example}


#### Use a where clause to select certain records:

```
splice> select * from Players WHERE Team='Cards';
ID    |TEAM   |NAME           |POS&|DISPLAYNAME    |BIRTHDATE
---------------------------------------------------------------
27    |Cards  |Earl Hastings  |OF  |Speedy Earl    |1982-04-22
1 row selected
```
{: .Example}


#### Count the records in a table:

```
splice> select count(*) from Players;
-----------------------
31 rows selected
```
{: .Example}

</div>
</section>
