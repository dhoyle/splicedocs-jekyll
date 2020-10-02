---
title: Command Line Syntax
summary: Syntax rules and helpful information for using the Splice Machine CLI.
keywords: cli syntax, splice>
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_using_cli.html
folder: CmdLineReference/Using
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine Command Line Interface

This topic describes how to use the Splice Machine command line interface (CLI).

* The [Command Line Interface](#splice%3E){: .selected}
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
* Our [Scripting Splice Commands](cmdlineref_using_cliscripting.html) tutorial
  describes how to create a script of CLI commands to run a series of
  operations such as loading a number of files into your database

The remainder of this section contains a reference page for each of the
commands.

## Running the Splice Machine CLI

To start the Splice Machine CLI, run the following command in a terminal window.

<div class="preWrapperWide" markdown="1">
    % ./sqlshell.sh
    splice>
{: .ShellCommand xml:space="preserve"}

</div>
When the <span class="AppCommand">splice&gt;</span> command prompt appears, you can enter commands. You must terminate each command with a semicolon. For a complete description of CLI syntax, see [Command Line Syntax](#Syntax).

Splice Machine requires Oracle JDK 1.8, update 60 or higher to run; if you try to start sqlshell.sh on a system that doesn't have the required version of the JDK, you'll see an error message indicating that the connection has been terminated.
{: .noteIcon}

### sqlshell.sh Command Line Options
You can optionally include parameter values when running <span
class="ShellCommand">sqlshell.sh</span> script, to change default
values:

<div class="preWrapper" markdown="1">
    sqlshell.sh [-U url] [-h host] [-p port] [-u user] [-s pass] [-P] [-S]
                [-k principal] [-K keytab] [-w width] [-f script] [-o output] [-q]
{: .ShellCommand xml:space="preserve"}

</div>

<table>
    <col width="20%" />
    <col width="45%" />
    <col width="35%" />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">-U <em>url</em></td>
            <td>The full JDBC <em>U</em>RL for connecting to your Splice Machine database.</td>
            <td class="CodeFont">-U 'jdbc:splice://xyz:1527/splicedb'</td>
        </tr>
        <tr>
            <td class="CodeFont">-h <em>hostname</em></td>
            <td>The <em>h</em>ostname or IP address of the Splice Machine HBase Region Server.</td>
            <td class="CodeFont">-h splicetrial-mycluster.splicemachine.io</td>
        </tr>
        <tr>
            <td class="CodeFont">-p <em>port</em></td>
            <td><p>The <em>p</em>ort on which Splice Machine is listening.</p>
                <p>The default value is 1527.</p>
            </td>
            <td class="CodeFont">-p 10001</td>
        </tr>
        <tr>
            <td class="CodeFont">-u <em>user</em></td>
            <td>Your Splice Machine database <em>u</em>sername.</td>
            <td class="CodeFont">-u myName</td>
        </tr>
        <tr>
            <td class="CodeFont">-s <em>pass</em></td>
            <td>Your Splice Machine database <em>p</em>assword.</td>
            <td class="CodeFont">-s myPswd</td>
        </tr>
        <tr>
            <td class="CodeFont">-P</td>
            <td><p>Tells Splice Machine to <em>P</em>rompt for your password.</p>
                <p class="noteNote">Your keystrokes are obscured when entering your password.</p>
            </td>
            <td class="CodeFont">-P</td>
        </tr>
        <tr>
            <td class="CodeFont">-S</td>
            <td><p>Use basic connection <em>S</em>ecurity (<code>ssl=basic</code>) for connecting to your database.</p>
                <p class="noteNote">You must use this option when using sqlshell.sh with our Database-as-Service product.</p>
            </td>
            <td class="CodeFont">-S</td>
        </tr>
        <tr>
            <td class="CodeFont">-k <em>principal</em></td>
            <td>Your <em>k</em>erberos principal.</td>
            <td class="CodeFont">-k splice</td>
        </tr>
        <tr>
            <td class="CodeFont">-K <em>keytab</em></td>
            <td><p>Your <em>K</em>erberos keytab.</p>
                <p class="noteNote">You must also specify the <code>-k</code> option when specifying this option.</p>
            </td>
            <td class="CodeFont">-K splice.keytab</td>
        </tr>
        <tr>
            <td class="CodeFont">-w <em>width</em></td>
            <td><p>The <em>w</em>idth of output rows in your window.</p>
                <p>The default width is 128.</p>
            </td>
            <td class="CodeFont">-w 200</td>
        </tr>
        <tr>
            <td class="CodeFont">-f scriptFile</td>
            <td><p>The fully-qualified name of the SQL <em>f</em>ile to be executed.</p>
                <p>For more information about running SQL scripts, please see our <a href="cmdlineref_using_cliscripting.html">Scripting Splice Commands] tutorial</a>.</p>
            </td>
            <td class="CodeFont">-f mySqlScript.sql</td>
        </tr>
        <tr>
            <td class="CodeFont">-o outputFile</td>
            <td><p>Redirects the <em>o</em>utput of a script </p>
                <p>This is typically used in conjunction with running a script with the <code>-f</code> option.</p>
            </td>
            <td class="CodeFont">-o /tmp/myscript.out</td>
        </tr>
        <tr>
            <td class="CodeFont">-q</td>
            <td><p>Starts sqlshell in <em>q</em>uiet mode, which suppresses the series of messages that displays when you first start <code>sqlshell.sh</code>.</p>
                <p>This is useful when running a script with the <code>-f</code> option.</p></td>
            <td class="CodeFont">-q</td>
        </tr>
    </tbody>
</table>

## Command Line Output   {#Command}

Output from CLI commands is
displayed in the terminal window. The
[`maximumdisplaywidth`](cmdlineref_maximumdisplaywidth.html) setting
affects how the output is displayed; specifically, it determines if the
content of each column is truncated to fit within the width that you
specify.

When you set
[`maximumdisplaywidth`](cmdlineref_maximumdisplaywidth.html) to `0`, all
output is displayed, without truncation.

## Command Line Syntax   {#Syntax}

This section provides a brief summary of the CLI syntax.

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

    splice> select * from myTable
    > where i > 1;
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
    splice> select * from myTable   -- This selects everything in myTable
    > ;
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
here.](cmdlineref_using_rlwrap.html)

### Show Local Time in the Command Prompt   {#ShowTime}

You can use the <code>prompt clock on</code> command to display the current local time in the splice command prompt. Use the <code>prompt clock off</code> command to redisplay the default splice command prompt.

<div class="preWrapper" markdown="1">

    splice> prompt clock on;
    ELAPSED TIME = 1 milliseconds
    splice 2020-08-28 16:30:04-0400> prompt clock off;
    ELAPSED TIME = 0 milliseconds
    splice>
{: .AppCommand xml:space="preserve"}

</div>

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

</div>
</section>
