---
title: Getting Started
summary: Getting started with Splice Machine
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: getstarted.html
folder: /
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.guide_heading = "About Splice Machine" %}

# Getting Started with Splice Machine
This page will help you to quickly become productive with your new Splice Machine database by introducing you to some of the major features you'll be using, and linking you to other top-level topics of interest.

The information on this page assumes that you already have Splice Machine installed; if not, please follow the [installation instructions for your platform](onprem_install_intro.html).
{: .noteIcon}

To get started with Splice Machine, we recommend following these simple steps:

1. [Get Acquainted with our documentation](#usingdocs).
2. [Use our command line interpreter (`splice>`)](#cmdline) to talk directly to your database.
3. [Familiarize yourself with Splice SQL](#splicesql).
4. [Review our Best Practices](#bestpractices).
5. [Investigate our Developer Topics](#devtopics).
6. [See how to connect your database](#connecting).
7. [Learn about Product-Specific Features](#prodspecific).


## 1. Get Acquainted with Our Documentation   {#usingdocs}
The Splice Machine documentation is a large set of topic pages, organized into the following main categories:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Category</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">About Splice Machine</td>
            <td>General information about Splice Machine, including release notes, license information, and related topics.</td>
        </tr>
        <tr>
            <td class="ItalicFont">DB-as-Service Product Info</td>
            <td>A guide to using our cloud-based, database-as-service product.</td>
        </tr>
        <tr>
            <td class="ItalicFont">On-Premise Product Info</td>
            <td>Requirements, installation, and maintainence information for customers using our on-premise database product.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Best Practices Guide</td>
            <td>Our best practices guides for topic areas such as ingesting data, using the Native Spark DataSource, and optimizing query performance.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Connecting to Splice Machine</td>
            <td>Topics that show you how to programmatically connect to your database with JDBC and ODBC, and information about connecting third party business intelligence software with your dateabase.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Developers Guide</td>
            <td>Topics of interest to database developers and programmers.</td>
        </tr>
        <tr>
            <td class="ItalicFont">splice&gt; Command Line Reference</td>
            <td>The reference manual for using the splice&gt; command line interface.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Splice Machine ML Manager</td>
            <td>How to use the ML Manager, which is our machine learning platform that's integrated with your database.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Security Guide</td>
            <td>Information about using authorization and authentication with your database.</td>
        </tr>
        <tr>
            <td class="ItalicFont">SQL Reference Manual</td>
            <td>The reference manual for the Splice Machine implementation of the SQL language.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Splice Machine Database Tools</td>
            <td>Describes tools provided by Splice Machine to help you examine and integrate your databases.</td>
        </tr>
    </tbody>
</table>

If you need any help with getting the most out of this documentation system, please see the [Using our Documentation](notes_usingdocs.html) topic.


## 2. Use our Command Line Interpreter {#cmdline}
You can invoke the `splice>` command line interpreter in your terminal window by navigating to the `splicemachine` directory on your machine and issuing this command:

```
./sqlshell.sh
```
{: .Example}

If you're connected to a running instance of Splice Machine, you'll see something like this (please ignore any `WARNING` messages):

```
========= rlwrap detected and enabled.  Use up and down arrow keys to scroll through command line history. ========

Running Splice Machine SQL shell
For help: "splice> help;"
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building splice_machine 2.7.0.1921-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- exec-maven-plugin:1.4.0:java (default-cli) @ splice_machine ---
SPLICE* - 	jdbc:splice://localhost:1527/splicedb
* = current connection
splice>
```
{: .Example}

### Run a SHOW Command
As a first command, try running a simple `SHOW TABLES` command; since you've not yet created any of your own tables, we'll display the tables defined in the `SYS` (system) schema:

```
splice> SHOW TABLES in SYS;
TABLE_SCHEM         |TABLE_NAME                           |CONGLOM_ID|REMARKS
------------------------------------------------------------------------------
SYS                 |SYSALIASES                           |256       |
SYS                 |SYSBACKUP                            |896       |
SYS                 |SYSBACKUPITEMS                       |880       |
SYS                 |SYSCHECKS                            |288       |
SYS                 |SYSCOLPERMS                          |736       |
SYS                 |SYSCOLUMNS                           |80        |
SYS                 |SYSCOLUMNSTATS                       |1184      |
SYS                 |SYSCONGLOMERATES                     |64        |
SYS                 |SYSCONSTRAINTS                       |352       |
SYS                 |SYSDEPENDS                           |384       |
SYS                 |SYSFILES                             |336       |
SYS                 |SYSFOREIGNKEYS                       |320       |
SYS                 |SYSKEYS                              |240       |
SYS                 |SYSPERMS                             |912       |
SYS                 |SYSPHYSICALSTATS                     |1248      |
SYS                 |SYSPRIMARYKEYS                       |368       |
SYS                 |SYSROLES                             |768       |
SYS                 |SYSROUTINEPERMS                      |752       |
SYS                 |SYSSCHEMAPERMS                       |1280      |
SYS                 |SYSSCHEMAS                           |32        |
SYS                 |SYSSEQUENCES                         |864       |
SYS                 |SYSSNAPSHOTS                         |1296      |
SYS                 |SYSSOURCECODE                        |1328      |
SYS                 |SYSSTATEMENTS                        |272       |
SYS                 |SYSTABLEPERMS                        |640       |
SYS                 |SYSTABLES                            |48        |
SYS                 |SYSTABLESTATS                        |1312      |
SYS                 |SYSTOKENS                            |1424      |
SYS                 |SYSTRIGGERS                          |624       |
SYS                 |SYSUSERS                             |848       |
SYS                 |SYSVIEWS                             |304       |

31 rows selected
```
{: .Example}

### Run a DDL Command
Now let's run a  DDL (Data Definition Language) command to create a table:

```
splice> CREATE TABLE myFirstTbl (id SMALLINT, name VARCHAR(32), location VARCHAR(32));
0 rows inserted/updated/deleted
```
{: .Example}

This table gets created in the default schema, `SPLICE`. We can use the `SHOW` command to verify that our table has been created:
{: .spaceAbove}
```
splice> SHOW TABLES IN SPLICE;
TABLE_SCHEM         |TABLE_NAME                      |CONGLOM_ID|REMARKS
------------------------------------------------------------------------
SPLICE              |MYFIRSTTBL                      |1584      |

1 row selected
```
{: .Example}

### Run a DML Command
Let's run a DML (Data Manipulation Language) command to insert some data into the table:

```
splice> INSERT INTO myFirstTbl VALUES ( 1, 'John Doe', 'San Francisco, CA, USA');
1 row inserted/updated/deleted
```
{: .Example}
And then examine our table with a `SELECT` statement:
{: .spaceAbove}

```
splice> SELECT * FROM myFirstTbl;
ID    |NAME                            |LOCATION
------------------------------------------------------------------------
1     |John Doe                        |San Francisco, CA, USA USA

1 row selected
```
{: .Example}

### Key Things to Know About the Command Line Interpreter
A few key things to remember when using the command line:

* Our [Command Line Reference](cmdlineref_intro.html) includes complete information about available commands and syntax.
* Installing the `rlWrap` command line wrapper adds editing, history, and autocompletion to `splice>` and is highly recommended. See [RlWrap Commands Synopsis](cmdlineref_using_rlwrap.html) for more information.
* In general, commands are case-insensitive.
* You __must__ terminate each command with a semicolon (`;`) character.
* You can extend SQL statements across multiple lines, as long as you end
the last line with a semicolon. Note that the `splice>` command line
interface prompts you with a fresh <span class="AppCommand">&gt;</span>
at the beginning of each line. For example:

  ```
    splice> select * from myTable
    > where i > 1;
  ```
  {: .Example}

## 3. Familiarize Yourself with Splice SQL {#splicesql}
Our [SQL Reference Manual](sqlref_intro.html) specifies all of the SQL commands available for use with `splice>` and via programmatic connections. The manual is organized into syntactic categories, including:

* [SQL functions](sqlref_builtinfcns_intro.html)
* [Clauses](sqlref_clauses_intro.html)
* [Data Types](sqlref_datatypes_intro.html)
* [Expressions](sqlref_expressions_intro.html)
* [Join Operators](sqlref_joinops_intro.html)
* [Queries](sqlref_queries_intro.html)
* [Statements](sqlref_statements_intro.html)
* [System Procedures and Functions](sqlref_sysprocs_intro.html)
* [System Tables](sqlref_systables_intro.html)

Of particular interest is the [*Built-in System Procedures and Functions*](sqlref_sysprocs_intro.html) section, which describes procedures and functions developed by Splice Machine that add significant functionality to your database. There are a large number of these procedures, which you can use for a wide variety of purposes. You invoke these built-in system procedures with the `CALL` statement. For example, the following procedure call performs an [incremental backup](sqlref_sysprocs_backupdb.html):

```
splice> CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE( 'hdfs:///home/backup', 'incremental' );
Statement executed.
```
{: .Example}


## 4. Review our Best Practices  {#bestpractices}

To get the most out of Splice Machine, you should review the content in the [Best Practices](bestpractices_intro.html) section of our documentation. The ever-growing list of topics currently includes:

* [Ingesting Data](bestpractices_ingest_overview.html) walks you through the different approaches and techniques for importing data into your database from other sources.
* [The Native Spark DataSource](bestpractices_sparkadapter_intro.html) introduces you to the Splice Machine Native Spark DataSource, which allows you to directly connect Spark DataFrames with your database tables, bypassing the need to use a serial connection. We provide examples of using this tremendous performance-boosting technology in your Spark apps and in Zeppelin notebooks.
* [Optimizing Query Performance](bestpractices_optimizer_intro.html) shows you different tools and techniques for examining and improving the performance of your database queries.

## 5. Investigate our Developer Topics {#devtopics}
The [Developer Topics](developers_intro.html) section of our documentation contain topics that are useful to database developers. Most of these topic involve using basic SQL functionality and/or built-in system procedures.

These topics are organized into multiple sections, including these:
<table>
    <col width="28%" />
    <col />
    <thead>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont"><a href="developers_fundamentals_intro.html">Fundamentals</a></td>
            <td>Contains a number of topics that show you how to use fundamental development tools and techniques with Splice Machine, including topics such as running transactions, using triggers, foreign keys, virtual tables, and external tables.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="developers_fundamentals_externaltables.html">External Data</a></td>
            <td>Describes how to use external tables and the Virtual Table Interface (VTI).</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="developers_fcnsandprocs_intro.html">Functions and Stored Procedures</a></td>
            <td>Describes how to create, modify, and store functions and stored procedures.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="developers_spliceplus_intro.html">Splice*Plus (PL/SQL)</a></td>
            <td>Describes the Splice Machine PL/SQL interpreter.</td>
        </tr>
            <td class="ItalicFont"><a href="bestpractices_sparkadapter_intro.html">Using the Native Spark DataSource</a></td>
            <td>Describes how to use the Splice Machine Native Spark DataSource.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="developers_spliceplus_intro.html">Splice\*Plus (PL/SQL)</a></td>
            <td>Describes Splice*Plus, our implementation of PL/SQL.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="tutorials_dbconsole_intro.html">Database Console Guide</a></td>
            <td>Describes the Splice Machine Database Console, which is a browser-based tool for monitoring queries on your cluster in real time.</td>
        </tr>
    </tbody>
</table>

## 6. See How to Connect Your Database  {#connecting}

To find out how to connect third-party Business Intelligence tools with your database, or to see how to connect programmatically to your database with our JDBC and ODBC connectors, check out the *Connecting to Splice Machine* documentation, which includes topics such as:

<table>
    <col width="28%" />
    <col />
    <thead>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont"><a href="tutorials_biconnect_intro.html">Connecting BI Tools to Splice Machine</a></td>
            <td>Provides examples of connecting specific tools, such as *Cognos, DBVisualizer, SQuirrel, and Tableau* to your database.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="tutorials_connectjdbc_intro.html">Connecting with JDBC</a></td>
            <td>Provides examples of using various programming languages to connect with your database, including Java, Ruby, Python, and Scala.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="tutorials_connectodbc_intro.html">Connecting with ODBC</a></td>
            <td>Walks you through installing and using our ODBC driver.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="attunity_export_mysql.html">Using Attunity Replicate</a></td>
            <td>Shows you how to use Attunity to export data from other databases and import that data into your Splice Machine database.</td>
        </tr>
        </tr>
    </tbody>
</table>

## 7. Learn About Product-Specific Features {#prodspecific}

For information specific to your Splice Machine product:

* Our [On-Premise Database Guide](onprem_intro.html) contains product-specific sections, including [Requirements](onprem_info_requirements.html), [Installation](onprem_install_intro.html), and [Administration](onprem_admin_intro.html) information.
* Our  [Database-as-Service Guide](dbaas_intro.html) guides you through the user interface of our cloud-based product, including the cluster creation interface.


</div>
</section>
