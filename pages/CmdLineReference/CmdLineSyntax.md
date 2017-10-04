---
title: Command Line Syntax
summary: Syntax rules and helpful information for using the Splice Machine splice&gt; command line interpreter.
keywords: cli syntax, splice>
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_cmdlinesyntax.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the splice&gt; Command Line Interface

This topic presents information that will help you in using the Splice
Machine <span class="AppCommand">splice&gt;</span> command line
interpreter, in the following sections:

* The [splice&gt; Command Line Interpreter](#splice%3E){: .selected}
  section shows you how to invoke the splice&gt; command line.
* The [Command Line Output](#Command){: .selected} section describes how
  you can adjust the appearance of output from the interepreter.
* The [Command Line Syntax](#Syntax){: .selected} section summarizes the
  syntax of commands, including capitalization and case-sensitivity
  rules, as well as various special characters you can use in your
  commands. It also shows you how to include comments in your command
  lines and how to run a file of SQL commands.
* The [Example Command Lines](#ExampleCommands){: .selected} section
  shows several examples of command lines.
* The [Scripting Splice Commands](tutorials_cli_scripting.html) tutorial
  describes how to create a script of <span
  class="AppCommand">splice&gt;</span> commands to run a series of
  operations like loading a number of files into your database

The remainder of this section contains a reference page for each of the
command line commands.

## splice&gt; Command Line Interpreter

To run the Splice Machine command line interpreter, run the <span
class="ShellCommand">sqlshell.sh</span> script in your terminal window.

<div class="preWrapperWide" markdown="1">
    % ./sqlshell.sh
    splice>
{: .ShellCommand xml:space="preserve"}

</div>
When the interpreter prompts you with <span
class="AppCommand">splice&gt;</span>, you can enter commands, ending
each with a semicolon. For a complete description of <span
class="AppCommand">splice&gt;</span> syntax, see the next section in
this topic, [Command Line Syntax](#Syntax){: .selected},

Note that you can optionally specify a file of sql commands that the
interpreter will run using the `-f` parameter; after running those
commands, the interpreter exits. For example:

<div class="preWrapper" markdown="1">
    ./sqlshell.sh -f /home/mydir/sql/test.sql
{: .ShellCommand xml:space="preserve"}

</div>
You can optionally include parameter values when running <span
class="ShellCommand">sqlshell.sh</span> script, to change default
values. Here's the syntax:

<div class="preWrapper" markdown="1">
    sqlshell.sh [-h host] [-p port ] [-u username] [-s password] [-f commandsFile
{: .ShellCommand xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
-host
{: .paramName}

The hostname or IP address of your Splice Machine HBase RegionServer.
{: .paramDefnFirst}

The default value is `localhost`.
{: .paramDefn}

-port
{: .paramName}

The port on which Splice Machine is listening for your connection.
{: .paramDefnFirst}

The default value is `1527`.
{: .paramDefn}

-username
{: .paramName}

The user name for your Splice Machine database.
{: .paramDefnFirst}

The default value is `splice`.
{: .paramDefn}

-password
{: .paramName}

The password for your Splice Machine database.
{: .paramDefnFirst}

The default value is `admin`.
{: .paramDefn}

-f [fileName]
{: .paramName}

The name of a file with SQL commands in it: `sqlshell` starts up the
<span class="AppCommand">splice&gt;</span> command line interpreter,
runs the commands in the file, and then exits. For example:
{: .paramDefnFirst}

<div class="preWrapperWide" markdown="1">
    $ ./sqlshell.sh -f /home/mydir/sql/test.sql

     ========= rlwrap detected and enabled.  Use up and down arrow keys to scroll through command line history. ========

    Running Splice Machine SQL shell
    For help: "splice> help;"
    SPLICE* - 	jdbc:splice://10.1.1.111:1527/splicedb
    * = current connection
    splice> elapsedtime on;
    splice> select count(*) from CUST_EMAIL;
    1
    --------------------
    0

    1 row selected
    ELAPSED TIME = 6399 milliseconds
    splice>
    $
{: .ShellCommand xml:space="preserve"}

</div>
The `test.sql` file used in the above example contains the following
commands:

<div class="preWrapperWide" markdown="1">
    elapsedtime on;
    select count(*) from CUST_EMAIL;
{: .ShellCommand xml:space="preserve"}

</div>
</div>
## Command Line Output   {#Command}

Output from <span class="AppCommand">splice&gt;</span> commands is
displayed in your terminal window. The
[`maximumdisplaywidth`](cmdlineref_maximumdisplaywidth.html) setting
affects how the output is displayed; specifically, it determines if the
content of each column is truncated to fit within the width that you
specify.

When you set
[`maximumdisplaywidth`](cmdlineref_maximumdisplaywidth.html) to `0`, all
output is displayed, without truncation.

## Command Line Syntax   {#Syntax}

This section briefly summarizes the syntax of command lines you can
enter in Zeppelin notebooks and in response to the <span
class="AppCommand">splice&gt;</span> prompt, including these
subsections:

* [Finishing and submitting command lines](#Finish){: .selected}
* [Capitalization and case sensitivity rules](#Capitali){: .selected}
* [Special character usage](#Special){: .selected}
* [Running multi-line commands](#Multiline){: .selected}
* [Running commands from a file](#RunFromFile){: .selected}
* [Including comments in your command lines](#Comments){: .selected}
* [Using rlWrap on the command line](#Using){: .selected}

### Finish Commands with a Semicolon   {#Finish}

The command line interface allows you to enter multi-line commands, and
waits for a non-escaped semicolon (`;`) character to signal the end of
the command.

A command is not executed until you enter the semicolon character and
press the `Return` or `Enter` key.

### Capitalization and Case Sensitivity Rules   {#Capitali}

Certain identifiers and keywords are case sensitive:

<table summary="Summary of case sensitivity in the splice&gt; command line syntax.">
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Identifier</th>
                        <th>Case Sensitive?</th>
                        <th>Notes and Example</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="ItalicFont">
                            <p>SQL keywords</p>
                        </td>
                        <td>Not case sensitive</td>
                        <td>These are all equivalent: <span class="Example">SELECT, Select, select, SeLeCt</span>.</td>
                    </tr>
                    <tr>
                        <td><em>ANSI SQL identifiers</em></td>
                        <td>Not case sensitive</td>
                        <td>These are not case sensitive unless they are delimited.</td>
                    </tr>
                    <tr>
                        <td><em>Java-style identifiers</em></td>
                        <td>Always case sensitive</td>
                        <td>
                            <p>These are NOT equivalent: <span class="Example">my_name, My_Name</span>.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
### Special Characters You Can Use   {#Special}

The following table describes the special characters you can use in
commands:

<table summary="Summary of special character usage in splice&gt; command line syntax.">
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Purpose</th>
                        <th>Character(s) to use</th>
                        <th>Notes and example</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>To delimit special identifiers</em></td>
                        <td>Double quotation marks (<code>"</code>)</td>
                        <td>Special identifiers are  also known as <em>delimited identifiers</em>.</td>
                    </tr>
                    <tr>
                        <td><em>To delimit character strings</em></td>
                        <td>Single quotation marks (<code>'</code>)</td>
                        <td> </td>
                    </tr>
                    <tr>
                        <td><em>To escape a single quote or apostrophe within a character string</em></td>
                        <td>Single quotation mark ( (<code>'</code>)</td>
                        <td>
                            <p class="noSpaceAbove">Since single quotation marks are used to delimit strings, you must escape any single quotation marks you want included in the string itself. </p>
                            <p>Use the single quotation mark itself as the escape character, which means that you enter two single quotation marks within a character string to include one single quotation mark. </p>
                            <p>Example: <span class="Example">'This string includes ''my quoted string'' within it.'</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>To escape a double quote</em></td>
                        <td><em>Not needed </em>
                        </td>
                        <td>You can simply include a double quotation mark in your command lines.</td>
                    </tr>
                    <tr>
                        <td><em>To specify a wild card within a Select expression</em></td>
                        <td>The asterisk (<code>*</code>) character</td>
                        <td>
                            <p class="noSpaceAbove">This is the SQL metasymbol for selecting all matching entries.</p>
                            <p>Example: <span class="Example">SELECT * FROM MyTable;</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>To specify a wild card sequence in a string with the <code>LIKE</code> operator</em></td>
                        <td>The percentage (<code>%</code>) character</td>
                        <td>Example: <span class="Example">SELECT * FROM MyTable WHERE Name LIKE 'Ga%';</span></td>
                    </tr>
                    <tr>
                        <td><em>To specify a single wild card character in a string with the <code>LIKE</code> operator</em></td>
                        <td>The underline (<code>_</code>) character</td>
                        <td>Example: <span class="Example">SELECT * FROM MyTable WHERE Name LIKE '%Er_n%';</span></td>
                    </tr>
                    <tr>
                        <td><em>To begin a single-line comment</em></td>
                        <td>Two dashes (<code>--</code>)</td>
                        <td>
                            <p class="noSpaceAbove"><span class="Example"> -- the following selects everything in my table:</span>
                                <br /><span class="Example">SELECT * FROM MyTable;</span>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>To bracket a multi-line comment</em></td>
                        <td><code>/*</code> and <code>*/</code></td>
                        <td>
                            <p class="noSpaceAbove">All text between the comment start <code>/*</code> and the comment end <code>*/</code> is ignored.</p><pre class="ExampleCell" xml:space="preserve">/* the following selects everything in my table,
   which we'll then display on the screen */
SELECT * FROM MyTable;</pre>
                        </td>
                    </tr>
                </tbody>
            </table>
### Entering Multi-line Commands   {#pages}

When using the command line (the <span
class="AppCommand">splice&gt;</span> prompt), you must end each SQL
statement with a semicolon (`;`). For example:

<div class="preWrapper" markdown="1">

    splice> select * from myTable;
{: .AppCommand}

</div>
You can extend SQL statements across multiple lines, as long as you end
the last line with a semicolon. Note that the `splice>` command line
interface prompts you with a fresh <span class="AppCommand">&gt;</span>
at the beginning of each line. For example:

<div class="preWrapper" markdown="1">

    splice> select * from myTable> where i > 1;
{: .AppCommand xml:space="preserve"}

</div>
### Running SQL Statements From a File   {#RunFromFile}

You can also create a file that contains a collection of SQL statements,
and then use the `run `command to run those statements. For example:

<div class="preWrapper" markdown="1">
    splice> run 'path/to/file.sql';
{: .AppCommand}

</div>
### Including Comments   {#Comments}

You can include comments on the command line or in a SQL statement file
by prefacing the command with two dashes (`--`). Any text following the
dashes is ignored by the SQL parser. For example:

<div class="preWrapperWide" markdown="1">
    splice> select * from myTable   -- This selects everything in myTable;
{: .AppCommand xml:space="preserve"}

</div>
### Misaligned Quotes

If you mistakenly enter a command line that has misaligned quotation
symbols, the interpreter can seem unresponsive. The solution is to add
the missing quotation mark(s), followed by a semicolon, and resubmit the
line. It won't work as expected, but it will enable you to keep working.

### Using rlWrap on the Command Line   {#Using}

rlWrap is a Unix utility that Splice Machine encourages you to use: it
allows you to scroll through your command line history, reuse and alter
lines, and more. We've included a [synopsis of it
here.](tutorials_cli_rlwrap.html)

## Example Command Lines   {#ExampleCommands}

Here are several example command lines:

<table summary="Example command lines">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Operation</th>
                        <th>Command Example</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Display a list of all tables and their schemas</td>
                        <td><span class="AppCommand">splice&gt; show tables;</span>
                        </td>
                    </tr>
                    <tr>
                        <td>Display the columns and attributes of a table</td>
                        <td><span class="AppCommand">splice&gt; describe tableA;</span>
                        </td>
                    </tr>
                    <tr>
                        <td>Limit the number of rows returned from a select statement</td>
                        <td><span class="AppCommand">splice&gt; select * from tableA { limit 10 };</span>
                        </td>
                    </tr>
                    <tr>
                        <td>Print a current time stamp</td>
                        <td><span class="AppCommand">splice&gt; values current_timestamp;</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p class="noteNote">Remember that you must end your command lines with the semicolon (<code>;</code>) character, which submits the command line to the interpreter.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
## Scripting splice&gt; Commands

You can use the Splice Machine Command Line Interface (<span
class="AppCommand">splice&gt;</span>) to interactively run database
commands. This topic describes how to create a script of <span
class="AppCommand">splice&gt;</span> commands to run a series of
operations, such as loading a number of files into your database. To
script a series of <span class="AppCommand">splice&gt;</span> commands,
you need to create:

* an SQL commands file containing the SQL statements you want executed
* an SQL file to connect to the database and invoke the SQL commands
  file
* a shell script using Bash (`/bin/bash`)

Follow these steps to create your script:

<div class="opsStepsList" markdown="1">
1.  Create a file of SQL commands:
    {: .topLevel}

    First, create a file that contains the SQL commands you want to run
    against your Splice Machine database. For this example, we'll create
    a file named `create-my-tables.sql` that creates a table in the
    database:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        create table customers (
           CUSTOMER_ID BIGINT,
           FIRST_NAME VARCHAR(30),
           LAST_NAME VARCHAR(30)
        );
    {: .Example xml:space="preserve"}

    </div>

2.  Create an SQL file to connect to the database and invoke the
    commands file
    {: .topLevel}

    We need a separate SQL file named `my_load_datascript.sql`that
    connects to your database and then invokes the file of SQL commands
    we just created.
    {: .indentLevel1}

    The `connect` command in this file must run before running the file
    of SQL statements.
    {: .noteNote}

    Here we name the first SQL file, and define it to run the SQL
    statements file named `create-my-tables.sql:`
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
           --First connect to the database
        connect 'jdbc:splice://<regionServer>:1527/splicedb';

           --Next run your sql file
        run '/users/yourname/create-my-tables.sql';

        show tables;
        quit;
    {: .Example xml:space="preserve" style="font-weight: normal;"}

    </div>
    {: .indentLevel1}

    If you are running Splice Machine on a cluster, connect from a
    machine that is NOT running an HBase RegionServer and specify the IP
    address of a <span class="HighlightedCode">regionServer</span> node,
    e.g. <span class="AppCommand">10.1.1.110</span>. If you're using the
    standalone version of Splice Machine, specify <span
    class="HighlightedCode">localhost</span> instead.
    {: .indentLevel1}

3.  Create a shell script to run your SQL connect file
    {: .topLevel}

    We now create a shell script named `load_datascript.sh` to run the
    `my_load_datascript.sql` file:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        #!/bin/bash

        export CLASSPATH=<FULL_PATH_TO_SPLICEMACHINE_JAR_FILE>
        java -Djdbc.drivers=com.splicemachine.db.jdbc.ClientDriver -Dij.outfile=my_load_datascript.out com.splicemachine.db.tools.ij < my_load_datascript.sql
    {: .Example xml:space="preserve" style="font-weight: normal;"}

    </div>

    The first line of this script must set the `CLASSPATH` to the
    location of your Splice Machine jar file. The second line runs the
    ij command, specifying its output file (`my_load_datascript.out`)
    and its SQL commands input file, which is the
    `my_load_datascript_sql` file that we created in the previous step.
    {: .indentLevel1}

4.  Make your shell script executable
    {: .topLevel}

    We need to make the shell script executable with the chmod shell
    command:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">

        chmod +x load_datascript.sh
    {: .ShellCommand xml:space="preserve"}

    </div>

5.  Use nohup to run the script
    {: .topLevel}

    The <span class="ShellCommand">nohup</span> utility allows you to
    run a script file in the background, which means that it will
    continue running if you log out, disconnect from a remote machine,
    or lose your network connection.
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">

        nohup ./load_datascript.sh > ./load_datascript.out 2>&1 &
    {: .ShellCommand xml:space="preserve"}

    </div>

    Here's the syntax for the `nohup` utility:
    {: .indentLevel1}

    <div class="fcnWrapperWide" markdown="1">

        nohup ./command-name.sh > ./command-name.out 2>&1 &
    {: .FcnSyntax xml:space="preserve"}

    </div>

    <div class="paramList" markdown="1">
    command-name.sh
    {: .paramName}

    The name of the shell script or a command name.
    {: .paramDefnFirst}

    command-name.out
    {: .paramName}

    The name of the file to capture any output written to `stdout`.
    {: .paramDefnFirst}

    2&gt;&amp;1
    {: .paramName}

    This causes `stderr` (file descriptor `2`) to be written to `stdout`
    (file descriptor `1`); this means that all output will be captured
    in `command-name.out`.
    {: .paramDefnFirst}

    &amp;
    {: .paramName}

    The <span class="ShellCommand">nohup</span> utility does not
    automatically run its command in the background, so we add the `&`
    to do
    {: .paramDefnFirst}

    </div>
{: .boldFont}

</div>
</div>
</section>
