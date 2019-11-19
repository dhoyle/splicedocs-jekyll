---
title: The Splice*Plus Language
toc: false
keywords:
product: all
summary:
sidebar: home_sidebar
permalink: developers_spliceplus_lang.html
folder: DeveloperTopics/SplicePlus
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice*Plus - PL/SQL for Splice Machine

This topic describes Splice Machine's implementation of the
PL/SQL language and *Splice*Plus*, the PL/SQL interpreter for
Splice Machine.

{% include splice_snippets/enterpriseonly_note.md %}
## About PL/SQL   {#About2}

This section provides only the briefest summary of the PL/SQL language;
instead, we recommend that you check the [Oracle documentation
site][1]{: target="_blank"} for their documentation on PL/SQL, or use
one of the many third party books that are available. One excellent
starting point, if you're new to PL/SQL, is this online
tutorial: [www.tutorialspoint.com/plsql][2]{: target="_blank"}.

### PL/SQL Basics

PL/SQL is a procedural programming language that is tightly integrated
with SQL. Which means that you can use PL/SQL to create programs that
perform SQL operations. The syntax of PL/SQL is based on the programming
languages ADA and Pascal,

The basic unit of a PL/SQL operation is the block, which groups together
related declarations and statements. Blocks can be procedures,
functions, or anonymous blocks, which are typically used for the main
body of your programs. The *Hello World* example we showed above is an
example of an anonymous block.

You define a PL/SQL block with a declaration section, a procedural
section, and an exception section.The following is an example of an
anonymous block:

```
<<Main>>
DECLARE
   myNum   number(2); 
   myText  varchar2(12) := 'Hello world';
   myDate  date := SYSDATE;
BEGIN
   SELECT name
      INTO myText
       FROM playerNames
        WHERE ID= 27;
EXCEPTION
   WHEN others THEN
         dbms_output.put_line('Error Message is ' || sqlerrm   );
END;/
```
{: .Example}

Some notes of interest about the basic constructs of PL/SQL:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Construct</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Labels</em></td>
            <td>
                <p>Labels are specified surrounded by double chevrons (<code>&lt;&lt;</code> and <code>&gt;&gt;</code>).</p>
                <p>Labels are optional for anonymous blocks such as the main body of your program.</p>
            </td>
        </tr>
        <tr>
            <td><em>Declarations</em></td>
            <td>
                <p>The declare section of a block is optional; however, you must declare a variable prior to using it.</p>
                <p>The declaration section of an anonymous block begins with the keyword <code>DECLARE</code>.</p>
                <p>Variable declarations can include initial values, which you assign with the PL/SQL assignment operator (<code>:=</code>). If you don't specify an initial value, the variable is initially <code>NULL</code>.</p>
            </td>
        </tr>
        <tr>
            <td><em>Terminators</em></td>
            <td>You must terminate each declaration and statement with a semicolon (<code>;</code>).</td>
        </tr>
        <tr>
            <td><em>Executable part</em></td>
            <td>The executable part of the block begins with the <code>BEGIN</code> keyword and is required.</td>
        </tr>
        <tr>
            <td><em>Exceptions</em></td>
            <td>The <code>exception</code> keyword begins the optional section of the block in which you handle exceptions generated in the executable part.</td>
        </tr>
        <tr>
            <td><em>Nested blocks and variable scope</em></td>
            <td>
                <p>You can nest a block within another block.</p>
                <p>Variable scoping works as you expect: variables declared in outer blocks are accessible to all blocks nested within them (inner blocks), while variables declared in inner blocks are not accessible to the outer blocks. </p>
            </td>
        </tr>
        <tr>
            <td><em>Comments</em></td>
            <td>
                <p>You can add comments in two ways:</p>
                <ul>
                    <li>single-line comments start with the delimiter <code>--</code> (double hyphen)</li>
                    <li>multi-line comments are enclosed by <code>/*</code> and <code>*/</code>.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>/ at end</em></td>
            <td>
                <p>You include a single <code>/</code> on a blank line at the end of a PL/SQL block to tell the PL/SQL interpreter to run the block after loading it. If you leave this out, the interpreter will simply wait after loading your code block.</p>
                <p class="noteNote">If you're creating a program that includes one or more function or procedure definitions (see below), you must include the <code>/</code> after each function or procedure block to have them loaded when you run your program.</p>
            </td>
        </tr>
    </tbody>
</table>

### PL/SQL Procedures and Functions

Your PL/SQL programs can include procedures and functions, which are
types of blocks. Procedures do not return values; each function returns
a single value.

Like anonymous blocks, functions and procedures include:

* An optional declaration section, which does not begin with the
  `DECLARE` keyword
* An executable section
* An optional exception section

The syntax for specifying functions and procedures is:

```
CREATE [OR REPLACE] FUNCTION function_name
   [(parameter_name [IN | OUT | IN OUT] type [, ...])]
   RETURN return_datatype 
   {IS | AS}
BEGIN
   < function_body >
END [function_name];
```
{: .FcnSyntax}

```
CREATE [OR REPLACE] PROCEDURE procedure_name
   [(parameter_name [IN | OUT | IN OUT] type [, ...])]
   {IS | AS}
BEGIN
   < procedure body >
END [procedure_name];
```
{: .FcnSyntax}

As mentioned, you can define your local variables in a procedure or
function just as you do for anonymous blocks; however, the
`DECLARE` keyword is not used. For example:

```
CREATE OR REPLACE FUNCTION
   GetDisplayString( prefixStr IN VARCHAR(50), numVal IN number)   RETURN varchar2(60)
IS
   defaultPrefix varchar2(30) := "The number is: ";
BEGIN   IF (prefixStr = '') THEN      prefixStr := defaultPrefix;   END IF;
   RETURN( prefixStr || numVal );
END;/
```
{: .Example}

#### Nested Functions and Procedures

You can nest blocks, including function and procedure blocks inside
other blocks. Standard scoping rules for variables and named blocks: any
nested (inner) block has access to the definitions available in its
containing block, but outer blocks cannot access definitions in inner
blocks.

For example, here's an anonymous block that declares a function
definition and then uses that function:

```
<<<Main>>
DECLARE   prefix VARCHAR(50);
   FUNCTION GetDisplayString( prefixStr IN VARCHAR(50), numVal IN NUMBER)
      RETURN VARCHAR2(60)
   IS
      defaultPrefix VARCHAR2(30) := "The number is: ";
      negNumException EXCEPTION;
   BEGIN
      IF (prefixStr = '') THEN
         prefixStr := defaultPrefix;
      END IF;
      IF (numVal < 0) THEN
         RAISE 'negativeNum'
      RETURN( prefixStr || numVal );
   EXCEPTION
      WHEN negativeNum THEN
         dbms_output.put_line('Got a negative number!');
   END;
BEGIN
   prefix := "The number you want is: ";
   dbms_output.put_line(GetDisplayString(prefix, 13));
EXCEPTION
   WHEN others THEN
       dbms_output.put_line('Uh-oh; something went wrong');
END;/
{: .Example}
```
{: .Example}

#### Handling Exceptions in PL/SQL

PL/SQL makes exception handling easy. Each block can optionally contain
an exception handling block that can contain any number of
`WHEN` statements. In summary:

* You can raise exceptions by name in your code:

```
  RAISE <exception_name>;
```
{: .FcnSyntax}

* Each block can contain an optional exception section that begins with
  the `exception` keyword.
* The exception section can contain any number of exception handlers,
  each of which is defined in a `WHEN` statement.
* Each `WHEN` statement handles a specific `exception_name`:

```
WHEN <exception_name>;
```
{: .FcnSyntax}

* The exception name `others` is used to define an exception handler
  that handles any exceptions not specifically handled by another
  `WHEN` statement.

## See Also

To learn more about PL/SQL, consider these resources:

* The [Oracle documentation site.][1]{: target="_blank"}
* For PL/SQL beginners, [www.tutorialspoint.com/plsql.][2]{:
  target="_blank"}
* Third party PL/SQL books available at your favorite bookstore or
  online.

</div>
</section>



[1]: http://docs.oracle.com/ "Click to open the top-level Oracle documentation site in another tab or window"
[2]: http://www.tutorialspoint.com/plsql "Click to open a new/tab window on the TutorialsPoint PL/SQL tutorial "
