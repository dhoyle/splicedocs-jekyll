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
This topic helps you to quickly become productive with your new Splice Machine database by introducing you to some of the major features you'll be using.

The information on this page assumes that you already have Splice Machine installed; if not, please follow the [installation instructions for your platform](onprem_install_intro.html).
{: .noteIcon}

To get started with Splice Machine, we recommend following these simple steps:

1. [Use our command line interpreter (`splice>`)](#cmdline) to talk directly to your database.
2. [Familiarize yourself with Splice SQL](#splicesql)
3. [Investigate our Developer Topics and Tutorials](#devtopics)
4. [Explore our Developer Tutorials](#devtutorials)
5. [Learn About Product-Specific Features](#prodspecific)
6. [Optimize Your Use of This Documentation](#usingdocs)


## 1. Use our Command Line Interpreter {#cmdline}
You can invoke the `splice>` command line interpreter in your terminal window by navigating to the `splicemachine` directory on your machine and issuing this command:

```
./sqlshell.sh
```
{: .Example}

If you're connected to a running instance of Splice Machine, you'll see something like this (please ignore any `WARNING` messages):

```
Running Splice Machine SQL shell
For help: "splice> help;"
[INFO] Scanning for projects...
[WARNING]
[WARNING] Some problems were encountered while building the effective model for com.splicemachine:splice_machine:jar:2.5.0.1823-SNAPSHOT
[WARNING] 'dependencies.dependency.(groupId:artifactId:type:classifier)' must be unique: commons-codec:commons-codec:jar -> duplicate declaration of version 1.10 @ com.splicemachine:splice_machine:[unknown-version], /Users/garyh/git/Splice/spliceengine/splice_machine/pom.xml, line 146, column 21
[WARNING]
[WARNING] It is highly recommended to fix these problems because they threaten the stability of your build.
[WARNING]
[WARNING] For this reason, future Maven versions might no longer support building such malformed projects.
[WARNING]
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building splice_machine 2.5.0.1823-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- exec-maven-plugin:1.4.0:java (default-cli) @ splice_machine ---
SPLICE* - 	jdbc:splice://localhost:1527/splicedb
* = current connection
```
{: .Example}

### Run a SHOW Command
As a first command, try running a simple `SHOW TABLES` command; since you've not yet created any of your own tables, we'll display the tables defined in the `SYS` (system) schema:

```
splice> SHOW TABLES in SYS;
TABLE_SCHEM         |TABLE_NAME                                        |CONGLOM_ID|REMARKS
-------------------------------------------------------------------------------------------
SYS                 |SYSALIASES                                        |352       |
SYS                 |SYSBACKUP                                         |928       |
SYS                 |SYSBACKUPITEMS                                    |1168      |
SYS                 |SYSCHECKS                                         |384       |
SYS                 |SYSCOLPERMS                                       |640       |
SYS                 |SYSCOLUMNS                                        |80        |
SYS                 |SYSCOLUMNSTATS                                    |1232      |
SYS                 |SYSCONGLOMERATES                                  |48        |
SYS                 |SYSCONSTRAINTS                                    |288       |
SYS                 |SYSDEPENDS                                        |256       |
SYS                 |SYSFILES                                          |240       |
SYS                 |SYSFOREIGNKEYS                                    |368       |
SYS                 |SYSKEYS                                           |272       |
SYS                 |SYSPERMS                                          |880       |
SYS                 |SYSPHYSICALSTATS                                  |1248      |
SYS                 |SYSPRIMARYKEYS                                    |320       |
SYS                 |SYSROLES                                          |800       |
SYS                 |SYSROUTINEPERMS                                   |720       |
SYS                 |SYSSCHEMAPERMS                                    |1328      |
SYS                 |SYSSCHEMAS                                        |32        |
SYS                 |SYSSEQUENCES                                      |864       |
SYS                 |SYSSNAPSHOTS                                      |1360      |
SYS                 |SYSSTATEMENTS                                     |336       |
SYS                 |SYSTABLEPERMS                                     |624       |
SYS                 |SYSTABLES                                         |64        |
SYS                 |SYSTABLESTATS                                     |1264      |
SYS                 |SYSTOKENS                                         |1408      |
SYS                 |SYSTRIGGERS                                       |528       |
SYS                 |SYSUSERS                                          |896       |
SYS                 |SYSVIEWS                                          |304       |

32 rows selected
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
TABLE_SCHEM         |TABLE_NAME                                        |CONGLOM_ID|REMARKS
------------------------------------------------------------------------------------------
SPLICE              |MYFIRSTTBL                                        |1616      |

1 row selected
```
{: .Example}

### Run a DML Command
Let's run a DML (Data Manipulation Language) command to insert some data into the table:

```
splice> INSERT INTO myFirstTbl VALUES ( 1, 'John Doe', 'San Francisco, CA, USA');
0 rows inserted/updated/deleted
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

## 2. Familiarize Yourself with Splice SQL {#splicesql}
Our [SQL Reference Manual](sqlref_intro.html) specifies all of the SQL commands available for use with `splice>` and via programmatic connections. The manual is organized into syntactic categories, including:

* [SQL functions](sqlref_builtinfcns_intro.html)
* [Clauses](sqlref_clauses_intro.html)
* [Data Types](sqlref_datatypes_intro.html)
* [Expressions](sqlref_expressions_intro.html)
* [Join Operators](sqlref_joinops_intro.html)
* [Statements](sqlref_statements_intro.html)
* [System Tables](sqlref_systables_intro.html)
* [Built-in System Procedures and Functions](sqlref_sysprocs_intro.html)

Of particular interest is the [*Built-in System Procedures and Functions*](sqlref_sysprocs_intro.html) section, which describes procedures and functions developed by Splice Machine that add significant functionality to your database. There are a large number of these procedures, which you can use for a wide variety of purposes. You invoke these built-in system procedures with the `CALL` statement. For example, calling this procedure performs an [incremental backup](sqlref_sysprocs_backupdb.html):

```
splice> CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE( 'hdfs:///home/backup', 'incremental' );
Statement executed.
```
{: .Example}


## 3. Investigate our Developer Topics {#devtopics}
Our [Developer Topics and Tutorials](developers_intro.html) and [Best Practices](bestpractices_intro.html) Guides contain topics that are useful to database developers, most of which involve using basic SQL functionality and/or built-in system procedures. These topics are organized into multiple sections, including these:
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
            <td class="ItalicFont"><a href="developers_fcnsandprocs_intro.html">Functions and Stored Procedures</a></td>
            <td>Describes how to create, modify, and store functions and stored procedures.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="bestpractices_optimizer_intro.html">Best Practices - Optimizer</a></td>
            <td>Helps you to optimize your database queries.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="developers_cloudconnect_intro.html">Accessing Data in the Cloud</a></td>
            <td>Shows you how to access and upload data on Amazon AWS S3.</td>
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
            <td class="ItalicFont"><a href="bestpractices_sparkadapter_intro.html">Using the Native Spark DataSource</a></td>
            <td>Describes how to use the Splice Machine Native Spark DataSource.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="developers_spliceplus_intro.html">Splice\*Plus (PL/SQL)</a></td>
            <td>Describes Splice*Plus, our implementation of PL/SQL.</td>
        </tr>
    </tbody>
</table>

## 4. Explore our Developer Tutorials and Best Practices {#devtutorials}

Our [Developer Tutorials](developers_intro.html) and [Best Practices](bestpractices_intro.html) Guides include deep dives into more complex developer topics, such as:

<table>
    <col  width="28%" />
    <col />
    <thead>
        <tr>
            <th>Section</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont"><a href="tutorials_security_intro.html">Securing Your Database</a></td>
            <td>Includes sections on securing your JDBC connections, authentication methods, and authorization of users and roles.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="bestpractices_ingest_overview.html">Importing Data</a></td>
            <td>Compares and walks you through the different ways to import data into your database, and includes detailed examples.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="tutorials_dbconsole_intro.html">Using the Database Console</a></td>
            <td>Introduces the *Splice Machine Database Console,* which is a browser-based tool that you can use to monitor database queries on your cluster in real time.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="tutorials_connectjdbc_intro.html">Connecting via JDBC</a> and <a href="tutorials_connectodbc_intro.html">Connecting via ODBC</a></td>
            <td>Include examples in different programming languages that show you how to programmatically connect to your database.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="tutorials_biconnect_intro.html">Connecting BI Tools</a></td>
            <td>Walks you through connecting specific *Business Intelligence* tools to your database.</td>
        </tr>
    </tbody>
</table>

## 5. Learn About Product-Specific Features {#prodspecific}
If you're using our *On-Premise product*, our [On-Premise Database Guide](onprem_intro.html) contains product-specific sections, including [Requirements](onprem_info_requirements.html), [Installation](onprem_install_intro.html), and [Administration](onprem_admin_intro.html).

If you're using our *Database-as-a-Service* product, you'll find our [Database-as-Service Guide](dbaas_intro.html) invaluable for finding your way around the user interface and learning about using the integrated *Apache Zeppelin* notebooks interface.

## 6. Optimize Your Use of This Documentation {#usingdocs}
If you need any help with getting the most out of this documentation system, please see the [Using our Documentation](notes_usingdocs.html) topic.

</div>
</section>
