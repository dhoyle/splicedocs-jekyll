---
title: Command Line Commands Summary
summary: Summarizes the splice&gt; commands.
keywords: splice>, cli, command reference
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_intro.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Command Line Reference" %}
# Splice Machine Commands Reference

This guide contains reference information for using the Splice Machine command line interpreter, which is also known as the Splice Prompt (<span class="AppCommand">splice&gt;</span>).

The *Using* section of the guide will help you to get started, in the topics:

* [Getting Started with the CLI](cmdlineref_using_getstarted.html) introduces you to using the CLI.
* [Command Line Syntax](cmdlineref_using_cli.html) summarizes command line parameters and syntax.
* [Scripting the CLI](cmdlineref_using_cliscripting.html) shows you how to script a set of commands to submit via the CLI.
* [Using RLWrap with splice>](cmdlineref_using_rlwrap.html) summarizes the RLWrap commands you can use to enhance the CLI.

The remainder of this guide contains a reference topic page for each Splice Machine
command. As shown in the tables below, you can use many of the commands when connected in any way (including JDBC and ODBC) to Splice Machine, while some commands can only be used via our command line interpreter.

## Commands You Can Use with All Connections to a Splice Machine Database   {#splice}

The following table summarizes the commands that you can use them with the `sqlshell` interface in our *On-Premise Database* and *Database-as-Service* products, and also with programs that connect to a Splice Machine database using JDBC or ODBC, including the Zeppelin notebook interface in our Database Service.

<table summary="Command Line Interface - Splice commands">
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
            <td><span class="AppCommand">splice&gt; analyze table myTable;<br />splice&gt; analyze schema myschema;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_autocommit.html">Autocommit</a>
            </td>
            <td>Turns the connection's auto-commit mode on or off.</td>
            <td><span class="AppCommand">splice&gt; autocommit off;</span>
            </td>
        </tr>
         <tr>
             <td class="CodeFont"><a href="cmdlineref_binaryexport.html">Export</a>
             </td>
             <td>Exports query results to binary files.</td>
             <td><span class="AppCommand">splice&gt; EXPORT_BINARY('/my/export/dir', true, 'parquet')
SELECT a,b,sqrt(c) FROM t1 WHERE a > 100;</span>
             </td>
         </tr>
       <tr>
            <td class="CodeFont"><a href="cmdlineref_commit.html">Commit</a>
            </td>
            <td>Commits the currently active transaction and initiates a new transaction.</td>
            <td><span class="AppCommand">splice&gt; commit;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_execute.html">Execute</a>
            </td>
            <td>Executes an SQL prepared statement or SQL command string.</td>
            <td><span class="AppCommand">splice&gt; execute 'insert into myTable(id, val)
values(?,?)' ;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_explainplan.html">Explain</a>
            </td>
            <td>Displays the execution plan for an SQL statement.</td>
            <td><span class="AppCommand">splice&gt; explain select count(*) from si;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_export.html">Export</a>
            </td>
            <td>Exports query results to CSV files.</td>
            <td><span class="AppCommand">splice&gt; EXPORT('/my/export/dir', null, null, null, null, null)
SELECT a,b,sqrt(c) FROM join t2 on t1.a=t2.a;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_prepare.html">Prepare</a>
            </td>
            <td>Creates a prepared statement for use by other commands.</td>
            <td><span class="AppCommand">splice&gt; prepare seeMenu as 'SELECT * FROM menu';</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_releasesavepoint.html">Release Savepoint</a>
            </td>
            <td>Releases a savepoint.</td>
            <td><span class="AppCommand">splice&gt; release savepoint gSavePt1;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_remove.html">Remove</a>
            </td>
            <td>Removes a previously prepared statement.</td>
            <td><span class="AppCommand">splice&gt; remove seeMenu;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_rollback.html">Rollback</a>
            </td>
            <td>Rolls back the currently active transaction and initiates a new transaction.</td>
            <td><span class="AppCommand">splice&gt; rollback;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_rollbacktosavepoint.html">Rollback to Savepoint</a>
            </td>
            <td>Rolls the current transaction back to the specified savepoint.</td>
            <td><span class="AppCommand">splice&gt; rollback to savepoint gSavePt1;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_savepoint.html">Savepoint</a>
            </td>
            <td>Creates a savepoint within the current transaction.</td>
            <td><span class="AppCommand">splice&gt; savepoint gSavePt1;</span>
            </td>
        </tr>
    </tbody>
</table>

## Commands You Can Only Use with Our Command Line Interface (`sqlshell.sh`)   {#spliceproducts}

The following table sunmmarizes the commands that you can only use with
the <span class="AppCommand">splice&gt;</span> command line interface (`sqlshell.sh`) in
our *On-Premise Database* and *Database-as-Service* products.

<table summary="Command Line Interface - Splice commands">
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
            <td><span class="AppCommand">splice&gt; connect 'jdbc:splice://xyz:1527/splicedb';</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_describe.html">Describe</a>
            </td>
            <td>Displays a description of a table or view.</td>
            <td><span class="AppCommand">splice&gt; describe myTable;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_disconnect.html">Disconnect</a>
            </td>
            <td>Disconnects from a database.</td>
            <td><span class="AppCommand">splice&gt; disconnect SPLICE;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_elapsedtime.html">Elapsedtime</a>
            </td>
            <td>Enables or disables display of elapsed time for command execution.</td>
            <td><span class="AppCommand">splice&gt; elapsedtime on;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_exit.html">Exit</a>
            </td>
            <td>Causes the command line interface to exit.</td>
            <td><span class="AppCommand">splice&gt; exit;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_help.html">Help</a>
            </td>
            <td>Displays a list of the available commands.</td>
            <td><span class="AppCommand">splice&gt; help;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_maximumdisplaywidth.html">MaximumDisplayWidth</a>
            </td>
            <td>Sets the maximum displayed width for each column of results displayed by the command line interpreter.</td>
            <td><span class="AppCommand">splice&gt; maximumdisplaywidth 30;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_run.html">Run</a>
            </td>
            <td>Runs commands from a file.</td>
            <td><span class="AppCommand">splice&gt; run myCmdFile;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_setconnection.html">Set Connection</a>
            </td>
            <td>Allows you to specify which connection is the current connection</td>
            <td><span class="AppCommand">splice&gt; set connection sample1;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_setsessionproperty.html">Set Session_Property</a>
            </td>
            <td>Allows you to specify default hint values for certain query hints</td>
            <td><span class="AppCommand">splice&gt; set session_property useSpark=true;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showconnections.html">Show Connections</a>
            </td>
            <td>Displays information about active connections and database objects.</td>
            <td><span class="AppCommand">splice&gt; show connections;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showfunctions.html">Show Functions</a>
            </td>
            <td>Displays information about functions defined in the database or in a schema.</td>
            <td><span class="AppCommand">splice&gt; show functions in splice;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showindexes.html">Show Indexes</a>
            </td>
            <td>Displays information about the indexes defined on a table, a database, or a schema.</td>
            <td><span class="AppCommand">splice&gt; show indexes from mytable;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showprimarykeys.html">Show Primary Keys</a>
            </td>
            <td>Displays information about the primary keys in a table.</td>
            <td><span class="AppCommand">splice&gt; show primarykeys from mySchema.myTable;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showprocedures.html">Show Procedures</a>
            </td>
            <td>Displays information about active connections and database objects.</td>
            <td><span class="AppCommand">splice&gt; show procedures in syscs_util;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showroles.html">Show Roles</a>
            </td>
            <td>Displays information about all of the roles defined in the database.</td>
            <td><span class="AppCommand">splice&gt; show roles;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showschemas.html">Show Schemas</a>
            </td>
            <td>Displays information about the schemas in the current connection.</td>
            <td><span class="AppCommand">splice&gt; show schemas;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showsynonyms.html">Show Synonyms</a>
            </td>
            <td>Displays information about the synonyms that have been created in a database or schema.</td>
            <td><span class="AppCommand">splice&gt; show synonyms;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showtables.html">Show Tables</a>
            </td>
            <td>Displays information about all of the tables in a database or schema.</td>
            <td><span class="AppCommand">splice&gt; show tables in SPLICE;</span>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="cmdlineref_showviews.html">Show Views</a>
            </td>
            <td>Displays information about all of the active views in a schema.</td>
            <td><span class="AppCommand">splice&gt; show views in SPLICE;</span>
            </td>
        </tr>
    </tbody>
</table>
</div>
</section>
