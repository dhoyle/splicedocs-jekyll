---
title: Getting Started with the Splice Machine Command Line Interface
summary: An introduction to using our command line interface to create and interact with your Splice Machine database.
keywords: CLI, cli, command line interface
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_using_getstarted.html
folder: CmdLineReference/Using
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Getting Started With the Splice Machine Command Line Interface

You can use the Splice Machine Command Line Interface (CLI) to interact with your Splice Machine database.

This topic provides a quick introduction the the Splice Machine CLI. The Splice Machine [Command Line Reference](cmdlineref_intro.html) contains additional information about command line syntax and commands, and includes examples of each command.

{% if site.incl_notpdf %}
<div markdown="1">

## Splice Machine CLI Video   {#GettingStartedVideo}

The following video shows you how to launch the Splice Machine CLI and use it to interact with your database.

<div class="centered" markdown="1">
<iframe class="youtube-player_0"
src="https://www.youtube.com/embed/QME4NdjucGU?" frameborder="0"
allowfullscreen="1" width="560px" height="315px"></iframe>

</div>
</div>
{% endif %}

## Getting Started with the Splice Machine CLI   {#GettingStartedGuide}

* [Starting the CLI on Linux or Mac OS X](#StartingCLILinux)
* [Starting the CLI on Windows](#StartingCLIWindows)
* [Basic Syntax Rules](#Basic)
* [Connecting to a Database](#Connecti)
* [Displaying Database Objects](#Viewing4)
* [Basic DDL and DML Statements](#Basic2)


### Starting the CLI on Linux or Mac OS X   {#StartingCLILinux}

Use the following steps to launch the Splice Machine CLI on Linux or Mac OS X:

<div class="opsStepsList" markdown="1">

1.  Open a terminal window.

2.  Navigate to your <code>splicemachine</code> directory.
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd ~/splicemachine   #Use the applicable path for your splicemachine directory
    {: .ShellCommand}

    </div>

3.  Start the Splice Machine CLI.
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        ./bin/sqlshell.sh
    {: .ShellCommand}

    </div>

    The full path to this script on Splice Machine standalone
    installations is `./splicemachine/bin/sqlshell.sh`.

4.  The CLI starts and the `splice>` command prompt appears:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        Running Splice Machine SQL Shell
        For help: "Splice> help;"
        SPLICE** = current connection
        splice>
    {: .AppCommand}

    </div>

    `SPLICE` is the name of the default connection, which becomes the
    current connection when you start the CLI.
{: .boldFont}

</div>

#### Restarting the CLI

If you are running the standalone version of Splice Machine and your
computer goes to sleep, any live database connections are lost. You can use the following commands to restart the Splice Machine CLI:

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
                        <td>Exit the CLI</td>
                        <td><p><code>splice> quit; </code></p>
                        <p>-or-</p>
                        <p><code>splice> exit; </code></p>
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
                        <td>Restart the CLI</td>
                        <td><code>$ ./bin/sqlshell.sh</code></td>
                    </tr>
                </tbody>
            </table>

### Starting the CLI on Windows   {#StartingCLIWindows}

Use the following steps to launch the Splice Machine CLI on Windows:

<div class="opsStepsList" markdown="1">

1.  Checkout and build [Splice Engine](https://github.com/splicemachine/spliceengine) on a machine running Linux or Mac OS X. For example:

    <div class="preWrapper" markdown="1">

        mvn clean package -Pcdh6.3.0,sqlshell -DskipTests
    {: .ShellCommand}

    </div>


2.  Navigate to your <code>spliceengine/assembly/target/sqlshell</code> directory.
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd ~/spliceengine/assembly/target/sqlshell    #Use the applicable path for your spliceengine directory
    {: .ShellCommand}

    </div>


3. Copy the contents of the `spliceengine/assembly/target/sqlshell` directory to the Windows machine. This directory contains the following files:  

    <div class="preWrapperWide" markdown="1">
        /lib/db-tools-ij-3.0.0.1973-SNAPSHOT.jar # (version could be different)
        /lib/db-client-3.0.0.1973-SNAPSHOT.jar   # (version could be different)
        /sqlshell.sh
        /winsqlshell.cmd
    {: .ShellCommand}

    </div>  

    The `sqlshell.sh` file is not required for Windows.

    {: .AppCommand xml:space="preserve"}

    If you have access to Splice Machine parcels, you do not need to install Splice Engine. You can simply download and extract the parcel using an application such as [7-Zip](https://www.7-zip.org/) and copy the files from there.  
    {: .noteIcon}

4. Ensure that the Windows machine has OpenJDK 1.8 installed. You may also need to set the JAVA_HOME environment variable to the OpenJDK 1.8 path.

5. Open the Windows command prompt and navigate to the `sqlshell` folder on the Windows machine. For example:

    <div class="preWrapperWide" markdown="1">

        C:\>cd C:\Splice-test\sqlshell

    {: .ShellCommand}

    </div>

6. Run the `winsqlshell.cmd --help` command to display information about command options:

    <div class="preWrapperWide" markdown="1">

        C:\Splice-test\sqlshell>winsqlshell --help
        Splice Machine SQL client wrapper script
        Usage: winsqlshell.cmd [-U url] [-h host] [-p port] [-u user] [-Q] [-s pass] [-P
        ] [-S] [-k principal] [-K keytab] [-w width] [-f script] [-o output] [-q]
        -U url       full JDBC URL for Splice Machine database
        -h host      IP address or hostname of Splice Machine (HBase RegionServer)
        -p port      Port which Splice Machine is listening on, defaults to 1527
        -u user      username for Splice Machine database
        -Q       Quote the username, e.g. for users with . - or @ in the username. e.g.
        dept-first.last@@company.com
        -s pass      password for Splice Machine database
        -P       prompt for unseen password
        -S       use ssl=basic on connection
        -k principal     kerberos principal (for kerberos)
        -K keytab    kerberos keytab - requires principal
        -w width     output row width. defaults to 128
        -f script    sql file to be executed
        -o output    file for output

    {: .ShellCommand}

    </div>

7. To start the Splice Machine CLI, run the `winsqlshell.cmd` command. The CLI starts and the `splice>` command prompt appears:  
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        C:\Splice-test\sqlshell>winsqlshell
        Running Splice Machine SQL shell
        For help: "splice> help;"
        ERROR 08001: java.net.ConnectException : Error connecting to server localhost on
        port 1527 with message Connection refused: connect.
        splice>

    {: .ShellCommand}

    </div>

    The error message appears because there is no connection to a Splice Machine server. You can use the [`connect`](cmdlineref_connect.html) command to connect to a Splice Machine host.

**NOTES:**

* When starting the Splice Machine CLI with the `winsqlshell.cmd` command, you can use the -h option to specify and connect to a Splice Machine host. You can also specify a user name (-u) and password (-s). For example:

  `C:\Splice-test\sqlshell>winsqlshell.cmd -h <splice-machine-hostname> -u <username> -s <password>`

* You can use pipe SQL syntax with the `winsqlshell.cmd` command to run a SQL query from the Windows command prompt:

  `C:\Splice-test\sqlshell>echo show tables; | winsqlshell.cmd -h <splice-machine-hostname> -u <username> -s <password>`

* In order to use the `-P` password prompt option, the directory that contains the `winsqlshell.cmd` file must be writable by the user. This is because the password prompt script creates a temporary file, which is subsequently deleted.   

{: .notePlain}  

</div>

### Basic Syntax Rules   {#Basic}

When using the Splice Machine CLI, you must end each SQL
statement with a semicolon (`;`). For example:

<div class="preWrapper" markdown="1">

    splice> select * from myTable;
{: .AppCommand}

</div>
You can extend SQL statements across multiple lines, as long as you end
the last line with a semicolon. Note that the CLI prompts you with a fresh <span class="AppCommand">&gt;</span>
at the beginning of each line. For example:

<div class="preWrapper" markdown="1">

    splice> select * from myTable> where i > 1;
{: .AppCommand xml:space="preserve"}

</div>
In most cases, the commands you enter are not case sensitive, but some identifiers and keywords are case sensitive. The following commands are all equivalent:

<div class="preWrapperWide" markdown="1">
    splice> show connections;
    splice> SHOW CONNECTIONS;
    splice> Show Connections;
{: .AppCommand}

</div>

The *[Command Line Syntax](cmdlineref_using_cli.html)* topic
provides a complete syntax reference for the CLI.

### Connecting to a Database   {#Connecti}

When you start the Splice Machine CLI, you are automatically connected to your
default database. You can use the [`connect`](cmdlineref_connect.html) command to connect to other databases:

<div class="preWrapperWide" markdown="1">
    connect 'jdbc:splice://srv55:1527/splicedb;user=YourUserId;password=YourPassword' AS DEMO;
{: .AppCommand}

</div>
#### Anatomy of a Connection String

Here is a breakdown of the the database connection string elements:

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

You can use the `show` command to view
various object types in your database, including
[connections](#Viewing), [schemas](#Viewing2), [tables](#Viewing3),
[indexes](#Indexes), [views](#Views), and [procedures](#Stored).

#### Displaying and Changing Connections   {#Viewing}

You can connect to multiple database in Splice Machine. One
connection is designated as the current database; this is the database
in which you are currently working.

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
Note that there is now no current connection because we have disconnected from
the `DEMO` connection. You can resolve this by connecting to a new named connection:

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
optionally specify a schema name in the show tables command. If you
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
of all tables in all of the schemas in your database, or all of the tables in a specific schema. For example:

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

Similar to indexes, you can use the &nbsp;[`show
views`](cmdlineref_showviews.html) command to display all of the indexes
in your database or in a schema:

<div class="preWrapperWide" markdown="1">

        splice> SHOW VIEWS;
        TABLE_SCHEM         |TABLE_NAME                       |CONGLOM_ID|REMARKS
        -----------------------------------------------------------------------------
        SYSVW               |SYSALLROLES                      |NULL      |
        SYSVW               |SYSCOLPERMSVIEW                  |NULL      |
        SYSVW               |SYSCOLUMNSTATISTICS              |NULL      |
        SYSVW               |SYSCOLUMNSVIEW                   |NULL      |
        SYSVW               |SYSCONGLOMERATEINSCHEMAS         |NULL      |
        SYSVW               |SYSPERMSVIEW                     |NULL      |
        SYSVW               |SYSROUTINEPERMSVIEW              |NULL      |
        SYSVW               |SYSSCHEMAPERMSVIEW               |NULL      |
        SYSVW               |SYSSCHEMASVIEW                   |NULL      |
        SYSVW               |SYSTABLEPERMSVIEW                |NULL      |
        SYSVW               |SYSTABLESTATISTICS               |NULL      |
        SYSVW               |SYSTABLESVIEW                    |NULL      |

        12 rows selected
{: .AppCommand xml:space="preserve"}

</div>
#### Displaying Stored Procedures and Functions   {#Stored}

You can create *user-defined database functions* that can be evaluated
in SQL statements. These functions can be invoked where most other
built-in functions are allowed, including within SQL expressions and
`SELECT` statements. Functions must be deterministic, and cannot be used
to make changes to the database. You can use the &nbsp;[show
functions](cmdlineref_showfunctions.html) command to display which
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
Language (*DDL*) and Data Manipulation Language (*DML*) statements in the Splice Machine CLI.

* [CREATE Statements](#CREATESta)
* [DROP Statements](#DROPSta)
* [Inserting Data](#INSERTIN)
* [Selecting and Displaying Data](#SELETING)

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

#### Inserting Data   {#INSERTIN}

Once you have created a table, you can use
[`INSERT`](sqlref_statements_insert.html) statements to insert records
into the table. For example:


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

Now that you have data in your table, you can use
[`SELECT`](sqlref_expressions_select.html) statements to select specific
records or portions of records. This section contains a few simple
examples of selecting data from the `Players` table we created in the
previous section.

You can select a single column from all of the records in a table. For
example:

    splice> select NAME from Players;
    NAME
    ----------------------------------------------------------------
    Earl Hastings
    Lester Johns
    Joe Bojangles

    3 rows selected
{: .AppCommand}

You can select all columns from all of the records in a table. For
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

You can use the [`SELECT`](sqlref_expressions_select.html) statement to count the records in a table. For example:


    splice> select count(*) from Players;
    -----------------------
    31 rows selected
{: .AppCommand}

## See Also

* To learn how to script Splice Machine CLI commands, see the
  [Scripting Splice Machine Commands](cmdlineref_using_cliscripting.html)
  tutorial.
* For more information about the Splice Machine CLI, see
  [the Command Line Reference Manual](cmdlineref_intro.html).

</div>
</section>
