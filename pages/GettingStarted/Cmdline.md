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
* [Command Summaries](#commands)


You can run arbitrary SQL from the <span class="AppCommand">splice&gt;</span> command line along with the commands documented in this topic. Simply enter the SQL directly on the command line, add a semicolon at the end, and press the Enter/Return key.
{: .noteIcon}

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

3.  Start <span class="AppCommand">splice&gt;</span>

    ```
    ./sqlshell.sh    #Use the correct path for your Splice Machine installation
    ```
    {: .ShellCommand}

4.  The command line interpreter starts:

    ```
     ========= rlwrap detected and enabled.  Use up and down arrow keys to scroll through command line history. ========

    Running Splice Machine SQL shell
    For help: "splice> help;"

    SPLICE* - 	jdbc:splice://localhost:1527/splicedb
    * = current connection
    ```
    {: .Example}

    As you can see in the above message, you can enter the `help` command to see a list of commands, and the default connection, `SPLICE`, is the current connection when you start the interpreter. Note that `rlwrap` is an optional command line wrapper that adds history and editing to your <span class="AppCommand">splice&gt;</span> experience.

</div>

### Run a Simple Command

To get started with the command line interpeter, run a `SHOW VIEWS` command at the `splice>` prompt. This displays all of the system views defined in the `SYSVW` schema:

```
splice> SHOW VIEWS in SYSVW;
TABLE_SCHEM         |TABLE_NAME                       |CONGLOM_ID|REMARKS
-------------------------------------------------------------------------------------------------------
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
```
{: .Example}

## Basic Syntax Rules   {#Basic}

When using the command line (the <span class="AppCommand">splice&gt;</span> prompt), you must end each SQL
statement with a semicolon (`;`). For example:

```
splice> select * from myTable;
```
{: .Example}

You can extend commands and SQL statements across multiple lines: if you press Enter/Return on a line doesn't end with a semicolon, <span class="AppCommand">splice&gt;</span> will automatically display a <span class="AppCommand">&gt;</span> on the new line to prompt you for more input.  For example:

```
splice> select * from myTable
> where i > 1;
```
{: .Example}

The *[Command Line Syntax](cmdlineref_using_cli.html)* topic in our *Command Line Reference* contains a complete syntax reference for <span class="AppCommand">splice&gt;</span>.

## Connecting to a Database   {#Connecti}

When you start <span class="AppCommand">splice&gt;</span>, you are automatically connected to your
default database. You can connect to other databases with the &nbsp;&nbsp;
[`connect`](cmdlineref_connect.html) command:

```
connect 'jdbc:splice://srv55:1527/splicedb;user=YourUserId;password=YourPassword' AS DEMO;
```
{: .Example}

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

## Commands Summary  {#commands}

The remainder of this topic summarizes the commands that are available to use in the <span class="AppCommand">splice&gt;</span> command line interpreter. Each of the following sections contains a table summarizing the commands available for a specific command category:

* [Connecting to Databases](#cmd_connect)
* [Displaying Database Information](#cmd_display)
* [Miscellaneous Commands](#cmd_misc)
* [Running Commands and Statements](#cmd_statements)
* [Statistics and Query Plans](#cmd_statistics)
* [Transactions](#cmd_transactions)

The command name in each table entry links to the *Command Line Reference* page for that command.
{: .noteNote}

### Connecting to Databases  {#cmd_connect}

The table below summarizes the commands available to work with database connections:

<table class="oddEven" summary="Database Connection Commands">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Command</th>
            <th>Description</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_connect.html">Connect</a>
            </td>
            <td>Connect to a database via its URL.</td>
            <td><span class="Example">splice&gt; connect 'jdbc:splice://xyz:1527/splicedb';</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_disconnect.html">Disconnect</a>
            </td>
            <td>Disconnects from a database.</td>
            <td><span class="Example">splice&gt; disconnect sample1;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_setconnection.html">Set Connection</a>
            </td>
            <td>Allows you to specify which connection is the current connection.</td>
            <td><span class="Example">splice&gt; set connection sample1;</span>
            </td>
        </tr>
    </tbody>
</table>


### Displaying Database Information  {#cmd_display}

The table below summarizes the commands available to display database information:

<table class="oddEven" summary="Commands to Display Database Information">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Command</th>
            <th>Description</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showconnections.html">Show Connections</a>
            </td>
            <td>Displays information about active connections and database objects.</td>
            <td><span class="Example">splice&gt; show connections;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showcreatetable.html">Show Create Table</a>
            </td>
            <td>Displays the DDL used with the <code>create table</code> statement to create a specified table.</td>
            <td><span class="Example">splice&gt; show create table players;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showfunctions.html">Show Functions</a>
            </td>
            <td>Displays information about functions defined in the database or in a schema.</td>
            <td><span class="Example">splice&gt; show functions in splice;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showindexes.html">Show Indexes</a>
            </td>
            <td>Displays information about the indexes defined on a table, a database, or a schema.</td>
            <td><span class="Example">splice&gt; show indexes from mytable;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showprimarykeys.html">Show Primary Keys</a>
            </td>
            <td>Displays information about the primary keys in a table.</td>
            <td><span class="Example">splice&gt; show primarykeys from mySchema.myTable;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showprocedures.html">Show Procedures</a>
            </td>
            <td>Displays information about active connections and database objects.</td>
            <td><span class="Example">splice&gt; show procedures in syscs_util;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showroles.html">Show Roles</a>
            </td>
            <td>Displays information about all of the roles defined in the database.</td>
            <td><span class="Example">splice&gt; show roles;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showschemas.html">Show Schemas</a>
            </td>
            <td>Displays information about the schemas in the current connection.</td>
            <td><span class="Example">splice&gt; show schemas;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showsynonyms.html">Show Synonyms</a>
            </td>
            <td>Displays information about the synonyms that have been created in a database or schema.</td>
            <td><span class="Example">splice&gt; show synonyms;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showtables.html">Show Tables</a>
            </td>
            <td>Displays information about all of the tables in a database or schema.</td>
            <td><span class="Example">splice&gt; show tables in SPLICE;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showviews.html">Show Views</a>
            </td>
            <td>Displays information about all of the active views in a schema.</td>
            <td><span class="Example">splice&gt; show views in SPLICE;</span>
            </td>
        </tr>
    </tbody>
</table>

### Miscellaneous Commands  {#cmd_misc}

The table below summarizes the miscellaneous commands:

<table class="oddEven" summary="Miscellaneous Commands">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Command</th>
            <th>Description</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_elapsedtime.html">Elapsedtime</a>
            </td>
            <td>Enables or disables display of elapsed time for command execution.</td>
            <td><span class="Example">splice&gt; elapsedtime on;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_exit.html">Exit</a>
            </td>
            <td>Causes the command line interface to exit.</td>
            <td><span class="Example">splice&gt; exit;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_help.html">Help</a>
            </td>
            <td>Displays a list of the available commands.</td>
            <td><span class="Example">splice&gt; help;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_maximumdisplaywidth.html">MaximumDisplayWidth</a>
            </td>
            <td>Sets the maximum displayed width for each column of results displayed by the command line interpreter.</td>
            <td><span class="Example">splice&gt; maximumdisplaywidth 30;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_setsessionproperty.html">Set Session_Property</a>
            </td>
            <td>Allows you to specify default hint values for certain query hints.</td>
            <td><span class="Example">splice&gt; set session_property useSpark=true;</span>
            </td>
        </tr>
    </tbody>
</table>


### Running Commands and Statements  {#cmd_statements}

The table below summarizes the commands available to run prepared statements and SQL script files:

<table class="oddEven" summary="Commands for Running Queries and Statements">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Command</th>
            <th>Description</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_execute.html">Execute</a>
            </td>
            <td>Executes an SQL prepared statement or SQL command string.</td>
            <td><span class="Example">splice&gt; execute 'insert into myTable(id, val)
values(?,?)' ;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_export.html">Export</a>
            </td>
            <td>Exports query results to CSV files.</td>
            <td><span class="Example">splice&gt; EXPORT('/my/export/dir', null, null, null, null, null)
SELECT a,b,sqrt(c) FROM join t2 on t1.a=t2.a;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_exportbinary.html">Export_Binary</a>
            </td>
            <td>Exports query results to binary files.</td>
            <td><span class="Example">splice&gt; EXPORT_BINARY('/my/export/dir', true, 'parquet')
SELECT a,b,sqrt(c) FROM t1 WHERE a > 100;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_run.html">Run</a>
            </td>
            <td>Runs commands from a file.</td>
            <td><span class="Example">splice&gt; run myCmdFile;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_prepare.html">Prepare</a>
            </td>
            <td>Creates a prepared statement for use by other commands.</td>
            <td><span class="Example">splice&gt; prepare seeMenu as 'SELECT * FROM menu';</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_remove.html">Remove</a>
            </td>
            <td>Removes a previously prepared statement.</td>
            <td><span class="Example">splice&gt; remove seeMenu;</span>
            </td>
        </tr>
    </tbody>
</table>


### Statistics and Query Plans  {#cmd_statistics}

The table below summarizes the commands available for working with database statistics and analyzing query execution plans:

<table class="oddEven" summary="Statistics and Query Performance Commands">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Command</th>
            <th>Description</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_analyze.html">Analyze</a>
            </td>
            <td>Collects statistics for a table or schema.</td>
            <td><span class="Example">splice&gt; analyze table myTable;<br />splice&gt; analyze schema myschema;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_explainplan.html">Explain</a>
            </td>
            <td>Displays the execution plan for an SQL statement.</td>
            <td><span class="Example">splice&gt; explain select count(*) from si;</span>
            </td>
        </tr>
    </tbody>
</table>


### Transactions  {#cmd_transactions}

The table below summarizes the commands available for working with database transactions:

<table class="oddEven" summary="Transaction Commands">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Command</th>
            <th>Description</th>
            <th>Usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_autocommit.html">Autocommit</a>
            </td>
            <td>Turns the connection's auto-commit mode on or off.</td>
            <td><span class="Example">splice&gt; autocommit off;</span>
            </td>
        </tr>
       <tr>
            <td class="CodeFont"><a href="cmdlineref_commit.html">Commit</a>
            </td>
            <td>Commits the currently active transaction and initiates a new transaction.</td>
            <td><span class="Example">splice&gt; commit;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_releasesavepoint.html">Release Savepoint</a>
            </td>
            <td>Releases a savepoint.</td>
            <td><span class="Example">splice&gt; release savepoint gSavePt1;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_rollback.html">Rollback</a>
            </td>
            <td>Rolls back the currently active transaction and initiates a new transaction.</td>
            <td><span class="Example">splice&gt; rollback;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_rollbacktosavepoint.html">Rollback to Savepoint</a>
            </td>
            <td>Rolls the current transaction back to the specified savepoint.</td>
            <td><span class="Example">splice&gt; rollback to savepoint gSavePt1;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_savepoint.html">Savepoint</a>
            </td>
            <td>Creates a savepoint within the current transaction.</td>
            <td><span class="Example">splice&gt; savepoint gSavePt1;</span>
            </td>
        </tr>
    </tbody>
</table>

</div>
</section>
