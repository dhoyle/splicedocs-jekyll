---
title: Using Splice*Plus
toc: false
keywords:
product: all
summary: 
sidebar: developers_sidebar
permalink: developers_spliceplus_using.html
folder: Developers/SplicePlus
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Splice*Plus

Splice Machine PL/SQL extends Splice Machine SQL with a procedural
language you can use to perform operations that you would otherwise
write as SQL queries. Splice Machine PL/SQL provides the same
functionality as Oracle PL/SQL, with a few notable exceptions, which are
detailed in the [Splice Machine PL/SQL Compared to Oracle
PL/SQL](#SplicePl) section below.

<span class="AppCommand">Splice*Plus</span> is an interactive, command
line utility program that provides an interpreter for running
PL/SQL programs interactively. You can run PL/SQL programs stored in
text files, or you can use your keyboard to enter PL/SQL statements and
blocks, similarly to the way you use the <span
class="AppCommand">splice&gt;</span> prompt to run SQL commands.

If you are already familiar with PL/SQL from using it with Oracle or
another database, Splice Machine PL/SQL is almost exactly the same. The
PL/SQL topic in this section calls out any differences you need to know
about between this implementation of PL/SQL and other implementations.
{: .noteImportant}

## Hello World in PL/SQL

Here's a basic PL/SQL version of "Hello World:"

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

## Invoking Splice*Plus

*Splice*Plus* is automatically installed for you when you install
Splice Machine. To run a PL/SQL program that you have stored in a text
file, invoke <span class="AppCommand">spliceplus</span> and specify on
the command line that it should take its input from that file:

    % spliceplus < helloworld.sql
{: .ShellCommand}

You'll see your code loaded in and executed, and any results will
display on your screen. For example:

<div class="preWrapper" markdown="1">
    % spliceplus < helloworld.sqlSource file is hellowworld.sqlExecuting:DECLARE
       message  varchar2(20):= 'Hello, World!';
    BEGIN
       dbms_output.put_line(message);EXCEPTION   dbms_output.put_line('Uh-oh; something went wrong');
    END;Hello, World!%
{: .ShellCommand}

</div>
To invoke the Splice*Plus interactive environment, open a terminal
window and enter the following command line:

    % spliceplus
{: .ShellCommand}

You'll see

<div class="preWrapper" markdown="1">
    % spliceplussplice*plus>
{: .ShellCommand}

</div>
You can enter SQL statements to execute, or you can enter a block of
PL/SQL code. When you want to run PL/SQL code, simply enter a `/` on a
line by itself, and <span class="AppCommand">splice*plus</span> will
execute the block and display the results.

## Creating, Editing, and Managing Your Splice*Plus programs

* Basics of creating a program within the interpreter and externally.
* Basics of editing an existing program.
* Managing programs stored in your database

## Debugging Your Splice*Plus Programs

Tools to help debugging

</div>
</section>

