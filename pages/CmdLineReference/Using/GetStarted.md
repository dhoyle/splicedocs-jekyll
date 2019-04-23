---
title: Getting Started with the splice&gt; Command Line Interpreter
summary: An introduction to using our command line interpreter to create and interact with your Splice Machine database.
keywords: CLI, cli, command line interface
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_using_getstarted.html
folder: CmdLineReference/Using
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Getting Started With the splice&gt; Command Line Interface

The <span class="AppCommand">splice&gt;</span> command line interpreter
is an easy way to interact with your Splice Machine database. This topic
introduces <span class="AppCommand">splice&gt;</span> and some of the
more common commands you'll use.

Our [Command Line Reference](cmdlineref_intro.html) contains additional information about command line syntax and commands, and includes examples of each available command.

{% if site.incl_notpdf %}
<div markdown="1">
You can complete this tutorial by [watching a short video](#Watch) or by
[following the written version](#Follow).

## Watch the Video   {#Watch}

The following video shows you how to launch and start using the <span
class="AppCommand">splice&gt;</span> command line interpreter to connect
to and interact with your database.

<div class="centered" markdown="1">
<iframe class="youtube-player_0"
src="https://www.youtube.com/embed/QME4NdjucGU?" frameborder="0"
allowfullscreen="1" width="560px" height="315px"></iframe>

</div>
</div>
{% endif %}
## Follow the Written Version   {#Follow}

This topic walks you through getting started with the <span
class="AppCommand">splice&gt;</span> command line interpreter, in these
sections:

* [Starting splice&gt;](#Starting)
* [Basic Syntax Rules](#Basic)
* [Connecting to a Database](#Connecti)
* [Displaying Database Objects](#Viewing4)
* [Basic DDL and DML Statements](#Basic2)

**NOTE:** Although we focus here on executing command lines with the
splice&gt;, you can also use the command line interface to directly
execute any SQL statement, including the DDL and DML statements that we
introduce in the [last section](#Basic2) of this topic.
{: .notePlain}

### Starting splice&gt;   {#Starting}

To launch the <span class="AppCommand">splice&gt;</span> command line
interpreter, follow these steps:

<div class="opsStepsList" markdown="1">
1.  Open a terminal window
2.  Navigate to your splicemachine directory
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd ~/splicemachine    #Use the correct path for your Splice Machine installation
    {: .ShellCommand}

    </div>

3.  Start splice&gt;
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        ./bin/sqlshell.sh
    {: .ShellCommand}

    </div>

    The full path to this script on Splice Machine standalone
    installations is `./splicemachine/bin/sqlshell.sh`.

4.  The command line interpreter starts:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        Running Splice Machine SQL ShellFor help: "Splice> help;"SPLICE** = current connectionsplice>
    {: .AppCommand}

    </div>

    `SPLICE` is the name of the default connection, which becomes the
    current connection when you start the interpreter.
{: .boldFont}

</div>
#### Restarting splice&gt;

If you are running the standalone version of Splice Machine and your
computer goes to sleep, any live database connections are lost. You'll
need to restart Splice Machine by following these steps:

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Step</th>
                        <th>Command</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Exit <span class="AppCommand">splice&gt;</span></td>
                        <td class="CodeFont"><span class="AppCommand">splice&gt; quit; (exit;)</span>
                        </td>
                    </tr>
                    <tr>
                        <td>Stop Splice Machine processes</td>
                        <td><code>$ ./bin/stop-splice.sh</code></td>
                    </tr>
                    <tr>
                        <td>Restart Splice Machine processes</td>
                        <td><code>$ ./bin/start-splice.sh</code></td>
                    </tr>
                    <tr>
                        <td>Restart <span class="AppCommand">splice&gt;</span></td>
                        <td><code>$ ./bin/sqlshell.sh</code></td>
                    </tr>
                </tbody>
            </table>
### Basic Syntax Rules   {#Basic}

When using the command line (the <span
class="AppCommand">splice&gt;</span> prompt), you must end each SQL
statement with a semicolon (`;`). For example:

<div class="preWrapper" markdown="1">

    splice> select * from myTable;
{: .AppCommand}

</div>
You can extend SQL statements across multiple lines, as long as you end
the last line with a semicolon. Note that the `splice>` command line
interface prompts you with a fresh <span class="AppCommand">&gt;</span>
at the beginning of each line. For example:

<div class="preWrapper" markdown="1">

    splice> select * from myTable> where i > 1;
{: .AppCommand xml:space="preserve"}

</div>
In most cases, the commands you enter are not case sensitive; you can
Certain identifiers and keywords are case sensitive: this means that
these commands are all equivalent:

<div class="preWrapperWide" markdown="1">
    splice> show connections;
    splice> SHOW CONNECTIONS;
    splice> Show Connections;
{: .AppCommand}

</div>
The *[Command Line Syntax](cmdlineref_using_cli.html)* topic
contains a complete syntax reference for <span
class="AppCommand">splice&gt;</span>.

### Connecting to a Database   {#Connecti}

When you start splice&gt;, you are automatically connected to your
default database. You can connect to other databases with the
[`connect`](cmdlineref_connect.html) command:

<div class="preWrapperWide" markdown="1">
    connect 'jdbc:splice://srv55:1527/splicedb;user=YourUserId;password=YourPassword' AS DEMO;
{: .AppCommand}

</div>
#### Anatomy of a Connection String

Here's how to breakdown the connection strings we use to connect to a
database:

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
### Displaying Database Objects   {#Viewing4}

We'll first explore the `show` command, which is available to view
numerous object types in your database, including:
[connections](#Viewing), [schemas](#Viewing2), [tables](#Viewing3),
[indexes](#Indexes), [views](#Views), [procedures](#Stored), and others.

#### Displaying and Changing Connections   {#Viewing}

You can connection to multiple database in Splice Machine; one
connection is designated as the current database; this is the database
with which you're currently working.

To view your current connections, use the &nbsp;[`show
connections`](cmdlineref_showconnections.html) command:

<div class="preWrapperWide" markdown="1">
    splice> show connections;
    DEMO     - jdbc:splice://srv55:1527/splicedb
    SPLICE*  - jdbc:splice://localhost:1527/splicedb
    * = current connection
{: .AppCommand}

</div>
You can use the &nbsp;[`set connection`](cmdlineref_setconnection.html)
command to modify the current connection:

<div class="preWrapperWide" markdown="1">
    splice> SET CONNECTION DEMO;
    splice> show connections;
    DEMO*    - jdbc:splice://srv55:1527/splicedb
    SPLICE   - jdbc:splice://localhost:1527/splicedb
    * = current connection
{: .AppCommand}

</div>
You can use the &nbsp;[`disconnect`](cmdlineref_disconnect.html) command to
close a connection:

<div class="preWrapperWide" markdown="1">
    splice> Disconnect DEMO;
    splice> show Connections;
    SPLICE  - jdbc:splice://localhost:1527/splicedb
    No current connection
{: .AppCommand}

</div>
Notice that there's now no current connection because we've disconnected
the connection named `DEMO`, which had been the current connection. We
can easily resolve this by connecting to a named connection:

<div class="preWrapperWide" markdown="1">
    splice> connect splice;
    splice> show connections;
    SPLICE*  - jdbc:splice://localhost:1527/splicedb
    * = current connection
{: .AppCommand}

</div>
Finally, to disconnect from all connections:

<div class="preWrapperWide" markdown="1">
    splice> disconnect all;
    splice> show connections;
    No connections available
{: .AppCommand}

</div>
#### Displaying Schemas   {#Viewing2}

Use the [show schemas](cmdlineref_showschemas.html) command to display
the schemas that are defined in your currently connected database:

<div class="preWrapperWide" markdown="1">
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
{: .AppCommand xml:space="preserve"}

</div>
The current schema is used as the default value when you issue commands
that optionally take a schema name as a parameter. For example, you can
optionally specify a schema name in the show tables command; if you
don't include a schema name, Splice Machine assumes the current schema
name.

To display the current schema name, use the built-in &nbsp;[`current
schema`](sqlref_builtinfcns_currentschema.html) function:

<div class="preWrapperWide" markdown="1">
    splice> values(current schema);
    1
    ------------------------------
    SPLICE
    1 row selected
{: .AppCommand xml:space="preserve"}

</div>
To change which schema is current, use the SQL [`set
schema`](sqlref_statements_setschema.html) statement:

<div class="preWrapperWide" markdown="1">
    splice> set schema SYS;
    0 rows inserted/updated/deleted
    splice> values(current schema);
    1
    ------------------------------
    SYS

    1 row selected
{: .AppCommand xml:space="preserve"}

</div>
#### Displaying Tables   {#Viewing3}

The &nbsp;[`show tables`](cmdlineref_showtables.html) command displays a list
of all tables in all of the schemas in your database:

<div class="preWrapperWide" markdown="1">
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

</div>
To display the tables in a specific schema (named `SPLICE`):

<div class="preWrapperWide" markdown="1">
    splice> show tables in SPLICE;
    TABLE_SCHEM  |TABLE_NAME            |CONGLOM_ID|REMARKS
    --------------------------------------------------------
    SPLICE       |CUSTOMERS             |1568      |
    SPLICE       |T_DETAIL              |1552      |
    SPLICE       |T_HEADER              |1536      |

    3 rows selected
{: .AppCommand xml:space="preserve"}

</div>
To examine the structure of a specific table, use the
[`DESCRIBE`](cmdlineref_describe.html) command:

<div class="preWrapperWide" markdown="1">
    splice> describe T_DETAIL;
    COLUMN_NAME                 |TYPE_NAME|DEC |NUM |COLUM |COLUMN_DEF|CHAR_OCTE |IS_NULL
    --------------------------------------------------------------------------------------------------
    TRANSACTION_HEADER_KEY      |BIGINT   |0   |10  |19    |NULL      |NULL      |NO
    TRANSACTION_DETAIL_KEY      |BIGINT   |0   |10  |19    |NULL      |NULL      |NO
    CUSTOMER_MASTER_ID          |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
    TRANSACTION_DT              |DATE     |0   |10  |10    |NULL      |NULL      |NO
    ORIGINAL_SKU_CATEGORY_ID    |INTEGER  |0   |10  |10    |NULL      |NULL      |YES

    5 rows selected
{: .AppCommand xml:space="preserve"}

</div>
#### Displaying Indexes   {#Indexes}

You can display all of the indexes in a schema:

<div class="preWrapperWide" markdown="1">
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

</div>
Or you can display the indexes defined for a specific table:

<div class="preWrapperWide" markdown="1">
    splice> show indexes FROM T_DETAIL;
    TABLE_NAME    |INDEX_NAME    |COLUMN_NAME         |ORDINAL&|NON_UNIQUE|TYPE |ASC&|CONGLOM_NO
    ---------------------------------------------------------------------------------------------
    T_DETAIL      |TDIDX1        |ORIGINAL_SKU_CATEGO&|1       |true      |BTREE|A   |1585
    T_DETAIL      |TDIDX1        |TRANSACTION_DT      |2       |true      |BTREE|A   |1585
    T_DETAIL      |TDIDX1        |CUSTOMER_MASTER_ID  |3       |true      |BTREE|A   |1585

    3 rows selected
{: .AppCommand xml:space="preserve"}

Note that we use `IN` to display the indexes in a schema, and `FROM` to
display the indexes in a table.
{: .noteIcon}

</div>
#### Displaying Views   {#Views}

Similarly to indexes, you can use the &nbsp;[`show
views`](cmdlineref_showviews.html) command to display all of the indexes
in your database or in a schema:

<div class="preWrapperWide" markdown="1">
    splice> show views;
    TABLE_SCHEM    |TABLE_NAME            |CONGLOM_ID|REMARKS
    -----------------------------------------------------------
    SYS            |SYSCOLUMNSTATISTICS   |NULL      |
    SYS            |SYSTABLESTATISTICS    |NULL      |

    2 rows selected
    splice> show views in sys;TABLE_SCHEM    |TABLE_NAME            |CONGLOM_ID|REMARKS
    -----------------------------------------------------------
    SYS            |SYSCOLUMNSTATISTICS   |NULL      |
    SYS            |SYSTABLESTATISTICS    |NULL      |

    2 rows selected
{: .AppCommand xml:space="preserve"}

</div>
#### Displaying Stored Procedures and Functions   {#Stored}

You can create *user-defined database functions* that can be evaluated
in SQL statements; these functions can be invoked where most other
built-in functions are allowed, including within SQL expressions and
`SELECT` statement. Functions must be deterministic, and cannot be used
to make changes to the database. You can use the &nbsp;[`show
functions`](cmdlineref_showfunctions.html) command to display which
functions are defined in your database or schema:

<div class="preWrapperWide" markdown="1">

    splice> show functions in splice;
    FUNCTION_SCHEM|FUNCTION_NAME               |REMARKS
    -------------------------------------------------------------------------
    SPLICE        |TO_DEGREES                  |java.lang.Math.toDegrees
    1 row selected
{: .AppCommand xml:space="preserve"}

</div>
You can also group a set of SQL commands together with variable and
logic into a *stored procedure*, which is a subroutine that is stored in
your database's data dictionary. Unlike user-defined functions, a stored
procedure is not an expression and can only be invoked using the `CALL`
statement. Stored procedures allow you to modify the database and return
`Result Sets` or nothing at all. You can use the &nbsp;[`show
procedures`](cmdlineref_showprocedures.html) command to display which
functions are defined in your database or schema:

<div class="preWrapperWide" markdown="1">
    splice> show procedures in SQLJ;
    PROCEDURE_SCHEM     |PROCEDURE_NAME    |REMARKS
    -------------------------------------------------------------------------------------------------
    SQLJ                |INSTALL_JAR       |com.splicemachine.db.catalog.SystemProcedures.INSTALL_JAR
    SQLJ                |REMOVE_JAR        |com.splicemachine.db.catalog.SystemProcedures.REMOVE_JAR
    SQLJ                |REPLACE_JAR       |com.splicemachine.db.catalog.SystemProcedures.REPLACE_JAR

    3 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Basic DDL and DML Statements   {#Basic2}

This section introduces the basics of running SQL Data Definition
Language (*DDL*) and Data Manipulation Language (*DML*) statements from
<span class="AppCommand">splice&gt;</span>.

* [Getting Started With the splice&gt; Command Line
  Interface](#CREATESta)
* [Getting Started With the splice&gt; Command Line
  Interface](#DROPSta)
* [Inserting Data](#INSERTIN)
* [Selecting and Displaying Data](#SELETING)

See the *[DML Statements](sqlref_statements_dmlintro.html)* sections in
our *SQL Reference Manual* for more information.
{: .spaceAbove}

#### CREATE Statements   {#CREATESta}

SQL uses `CREATE` statements to create objects such as
[tables](sqlref_statements_createtable.html). For example:

    splice> CREATE schema MySchema1;
    0 rows inserted/updated/deleted
    splice> create Schema mySchema2;
    0 rows inserted/updated/deleted
    splice> show schemas;
    TABLE_SCHEM
    ------------------------------
    MYSCHEMA1MYSCHEMA2NULLID
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

    splice> describe Players;
    COLUMN_NAME   |TYPE_NAME|DEC&|NUM&|COLUM&|COLUMN_DEF|CHAR_OCTE&|IS_NULL&
    -------------------------------------------------------------------
    ID            |SMALLINT |0   |10  |5     |NULL      |NULL      |NO
    TEAM          |VARCHAR  |NULL|NULL|64    |NULL      |128       |NO
    NAME          |VARCHAR  |NULL|NULL|64    |NULL      |128       |NO
    POSITION      |CHAR     |NULL|NULL|2     |NULL      |4         |YES
    DISPLAYNAME   |VARCHAR  |NULL|NULL|24    |NULL      |48        |YES
    BIRTHDATE     |DATE     |0   |10  |10    |NULL      |NULL      |YES

    6 rows selected
{: .AppCommand}

See the *[CREATE Statements](sqlref_statements_createstatements.html)*
section in our *SQL Reference Manual* for more information.

#### DROP Statements   {#DROPSta}

SQL uses `DROP` statements to delete objects such as
[tables](sqlref_statements_droptable.html). For example:

    splice> DROP schema MySchema2 restrict;0 rows inserted/updated/deleted
{: .AppCommand}

You **must** include the keyword `restrict` when dropping a schema; this
enforces the rule that the schema cannot be deleted from the database if
there are any objects defined in the schema.
{: .notePlain}

    splice> show schemas;
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
    12 rows selected

    splice> DROP TABLE myTable;
    0 rows inserted/updated/deleted
    splice> SHOW TABLES IN MySchema1;
    TABLE_SCHEM  |TABLE_NAME            |CONGLOM_ID|REMARKS
    --------------------------------------------------------
    MYSCHEMA1    |PLAYERS               |1632      |1 row selected
{: .AppCommand}

See the *[DROP Statements](sqlref_statements_dropstatements.html)*
section in our *SQL Reference Manual* for more information.

#### Inserting Data   {#INSERTIN}

Once you've created a table, you can use
[`INSERT`](sqlref_statements_insert.html) statements to insert records
into that table; for example:


    splice> INSERT INTO Players
       VALUES( 99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991');
    1 row inserted/updated/deleted

    splice> INSERT INTO Players
       VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
              (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
              (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');
    3 rows inserted/updated/deleted
{: .AppCommand}

#### Selecting and Displaying Data   {#SELETING}

Now that you have a bit of data in your table, you can use
[`SELECT`](sqlref_expressions_select.html) statements to select specific
records or portions of records. This section contains several simple
examples of selecting data from the `Players` table we created in the
previous section.

You can select a single column from all of the records in a table; for
example:

    splice> select NAME from Players;
    NAME
    ----------------------------------------------------------------
    Earl Hastings
    Lester Johns
    Joe Bojangles

    3 rows selected
{: .AppCommand}

You can select all columns from all of the records in a table; for
example:


    splice> select * from Players;
    ID    |TEAM   |NAME           |POS&|DISPLAYNAME    |BIRTHDATE
    ---------------------------------------------------------------
    27    |Cards  |Earl Hastings  |OF  |Speedy Earl    |1982-04-22
    73    |Giants |Lester Johns   |P   |Big John       |1984-06-09
    99    |Giants |Joe Bojangles  |C   |Little Joey    |1991-07-11

    3 rows selected
{: .AppCommand}

You can also qualify which records to select with a
[`WHERE`](sqlref_clauses_where.html) clause; for example:


    splice> select * from Players WHERE Team='Cards';
    ID    |TEAM   |NAME           |POS&|DISPLAYNAME    |BIRTHDATE
    ---------------------------------------------------------------
    27    |Cards  |Earl Hastings  |OF  |Speedy Earl    |1982-04-22
    1 row selected
{: .AppCommand}

You can easily count the records in a table by using the
[`SELECT`](sqlref_expressions_select.html) statement; for example:


    splice> select count(*) from Players;
    -----------------------
    31 rows selected
{: .AppCommand}

## See Also

* To learn how to script <span
  class="AppCommand">splice&gt;</span> commands, please see the
  [Scripting Splice Machine Commands](cmdlineref_using_cliscripting.html)
  tutorial.
* For more information about the <span
  class="AppCommand">splice&gt;</span> command line interpreter, see
  [the Command Line Reference Manual](cmdlineref_intro.html), which
  includes information about and examples of all supported commands.

</div>
</section>
