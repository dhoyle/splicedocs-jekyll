---
title: Using Splice*Plus
toc: false
keywords:
product: all
summary:
sidebar: developers_sidebar
permalink: developers_spliceplus_using.html
folder: DeveloperTopics/SplicePlus
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Splice*Plus

Splice*Plus extends Splice Machine SQL with a procedural
language you can use to perform operations that you would otherwise
write as SQL queries.

<span class="AppCommand">Splice*Plus</span> is a command
line utility program that provides an interpreter for running
PL/SQL programs interactively. You can run PL/SQL programs stored in
text files, or you can enter PL/SQL statements and
blocks interactively, similarly to the way you use the <span
class="AppCommand">splice&gt;</span> prompt to run SQL commands.

If you are already familiar with PL/SQL from using it with Oracle or
another database, Splice Machine PL/SQL is almost exactly the same. The
[Splice\*Plus language](developers_spliceplus_lang.html) topic provides a quick review of the
supported language structures, and the [Migrating to Splice\*Plus](developers_spliceplus_migrating.html) topic describes any important differences between Splice*Plus and Oracle's PL/SQL implementations.
{: .noteImportant}

The remainder of this topic includes these sections:

* [Invoking Splice\*Plus](#Invoking) describes how you can invoke Splice\*Plus on the command line
* [The Splice\*Plus Analyzer](#Analyzer)
* [Hello World in PL/SQL](#Hello) presents a simple PL/SQL program
* [Storing PL/SQL Programs in Your Database](#Storing)

## Invoking Splice\*Plus {#Invoking}
*Splice\*Plus* is automatically installed for you when you install
the *Enterprise* version of Splice Machine. You can invoke Splice*Plus to run one or more PL/SQL programs, or you can use it interactively by invoking it without any program files on the command line. The basic syntax is:

<div class="PreWrapper" markdown="1">
    spliceplus [--output outputFile] [cmdlineOptions*] sqlFile*
{: .FcnSyntax}
</div>

For example, this command line runs the PL/SQL program in the file `myExample1.sql`:
{: .spaceAbove}

<div class="PreWrapper" markdown="1">
    spliceplus myExample1.sql
{: .ShellCommand}
</div>

You can add the `--output` option to send any program output to a file; for example:
{: .spaceAbove}

<div class="PreWrapper" markdown="1">
    spliceplus --output myExample1.out myExample1.sql
{: .ShellCommand}
</div>

You can also invoke Splice\*Plus to display help or version information from the command line:
{: .spaceAbove}

<div class="PreWrapper" markdown="1">
    spliceplus --help
    spliceplus --version
{: .ShellCommand}
</div>

### Command Line Options {#cmdlineoptions}

You can specify zero or more of the following options on the Splice*Plus command line, each of which have default values that are applied if the option is not specified on the command line. Here's the syntax:


<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
            <th>Default Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">debugOptions</td>
            <td><p>Specifies debugging options. You can specify any number of these options:</p>
                <ul>
                    <li class="CodeFont">SCRIPT</li>
                    <li class="CodeFont">LOCAL</li>
                    <li class="CodeFont">GLOBAL</li>
                    <li class="CodeFont">OPCODE</li>
                    <li class="CodeFont">FUNCALL</li>
                    <li class="CodeFont">FUNARGS</li>
                    <li class="CodeFont">FUNAST</li>
                    <li class="CodeFont">SQL</li>
                    <li class="CodeFont">SQLDATA</li>
                    <li class="CodeFont">SQLANALYZE</li>
                    <li class="CodeFont">SQLCURSOR</li>
                    <li class="CodeFont">JDBC</li>
                    <li class="CodeFont">JDBCAUTH</li>
                    <li class="CodeFont">DISABLE_PERSISTENCE</li>
                    <li class="CodeFont">PERSISTENCE</li>
                </ul>
            </td>
            <td class="CodeFont">OFF</td>
        </tr>
        <tr>
            <td class="CodeFont">jdbcString</td>
            <td>The JDBC connection string to use, in this form: <code>//hostname:1527/splicedb</code></td>
            <td class="CodeFont">jdbc://localhost:1527/splicedb</td>
        </tr>
        <tr>
            <td class="CodeFont">schemaName</td>
            <td>The name of the database schema to use.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
    </tbody>
</table>

## The Splice\*Plus Analyzer {#Analyzer}
You can use the *spliceplus-analyzer* program to profile which features your PL/SQL file uses; this allows you to analyze which features are supported in Splice\*Plus.

The basic syntax for running the analyzer is:

<div class="PreWrapper" markdown="1">
    spliceplus-analyzer [--output outputFile] [--verbose] sqlFile+
{: .FcnSyntax}
</div>

You can use the `--output` option to save the analyzer output to a CSV file. The `--verbose` option increases the amount of information the analyzer displays.
{: .spaceAbove}

You can also invoke the analyzer to display help or version information from the command line:

<div class="PreWrapper" markdown="1">
    spliceplus-analyzer --help
    spliceplus-analyzer --version
{: .ShellCommand}
</div>

### Analyzer Example
You can analyze the `newtroot.sql` example program with this command line:

<div class="PreWrapper" markdown="1">
    spliceplus-analyzer ./examples/newtroot.sql
{: .ShellCommand}
</div>

You'll see output like this:
{: .spaceAbove}

<div class="PreWrapperWide" markdown="1">
    Analyzing ./examples/newtroot.sql
    Feature count is:
    PlConstruct:ArgumentPositional:Implemented x 3
    PlConstruct:AssignmentStatement:Implemented
    PlConstruct:BlockStatement:Implemented
    PlConstruct:LoopWhile:Implemented
    PlType:SimpleDouble:Implemented x 3
    PlExpression:Add:Implemented
    PlExpression:Constant:Implemented x 4
    PlExpression:Div:Implemented x 2
    PlExpression:Gt:Implemented x 2
    PlExpression:Identifier:Implemented x 5
    PlExpression:LogicalAnd:Implemented
    PlExpression:Lt:Implemented
    PlExpression:Mul:Implemented
    PlExpression:PlsqlFunction:Implemented x 3
    PlExpression:Sub:Implemented
    PlBuiltinFunctionCall:ABS:PartiallyImplemented
    PlBuiltinFunctionCall:DBMS_OUTPUT.PUT_LINE:PartiallyImplemented
    PlUserFunctionCall:CW.ASSERT_TRUE:Implemented
{: .Example}
</div>

## Hello World in PL/SQL {#Hello}

Here's a basic PL/SQL version of "Hello World":

<div class="preWrapperWide" markdown="1">
    DECLARE
       message  varchar2(20):= 'Hello, World!';
    BEGIN
       dbms_output.put_line(message);
    EXCEPTION
       WHEN PROGRAM_ERROR THEN
          dbms_output.put_line('Uh-oh; something went wrong');
    END;
    /
{: .Example}
</div>

The single `/` at the end of the program block is required to tell the
PL/SQL interpreter that it should run the code block; if you leave the
`/` out, the interpreter will simply wait for more input after loading
the block.
{: .noteNote}

## Storing Your PL/SQL Code {#Storing}

All PL/SQL procedures that you create with Splice\*Plus are stored in the SYS.SYSSOURCECODE table in your database.

You can specify that your code should *not* be stored in your database with the `--debug DISABLE_PERSISTENCE` command line option.

</div>
</section>
