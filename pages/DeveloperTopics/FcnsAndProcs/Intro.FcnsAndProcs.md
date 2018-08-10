---
title: Introduction to Splice Machine Functions and Procedures
summary: Overview of writing and using functions and stored procedures in Splice Machine
keywords: stored procedure, user-defined function, udf, create stored procedure, create function
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fcnsandprocs_intro.html
folder: DeveloperTopics/FcnsAndProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Functions and Stored Procedures

This topic provides an overview of writing and using functions and
stored procedures in Splice Machine.

## About User-Defined Functions

You can create user-defined database functions that can be evaluated in
SQL statements; these functions can be invoked where most other built-in
functions are allowed, including within SQL expressions and `SELECT`
statements. Functions must be deterministic, and cannot be used to make
changes to the database.

You can create two kinds of functions:

* Scalar functions, which always return a single value (or `NULL`),
* Table functions, which return a table.

When you invoke a function within a `SELECT` statement, it is applied to
each retrieved row. For example:

<div class="preWrapper" markdown="1">
    SELECT ID, Salary, MyAdjustSalaryFcn(Salary) FROM SPLICEBBALL.Salaries;
{: .Example}

</div>
This `SELECT` will execute the `MyAdjustSalaryFcn` to the `Salary` value
for each player in the table.

## About Stored Procedures

You can group a set of SQL commands together with variable and logic
into a stored procedure, which is a subroutine that is stored in your
database's data dictionary. Unlike user-defined functions, a stored
procedure is not an expression and can only be invoked using the `CALL`
statement. Stored procedures allow you to modify the database and return
`Result Sets` or nothing at all.

Stored procedures can be used for situations where a complex set of SQL
statements are required to process something, and that process is used
by various applications; creating a stored procedure increases
performance efficiency. They are typically used for:

* checking business rules and validating data before performing actions
* performing significant processing of data with the inputs to the
  procedure

## Comparison of Functions and Stored Procedures

Here's a comparison of Splice Machine functions and stored procedures:

<table summary="Tables comparing stored procedures and database functions.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Database Function</th>
                        <th>Stored Procedure</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <p class="noSpaceAbove">A Splice Machine database function:</p>
                            <ul>
                                <li>must be written as a public static method in a Java public class</li>
                                <li>is executed in exactly the same manner as are public static methods in Java</li>
                                <li>can have multiple input parameters</li>
                                <li>always returns a single value (which can be null)</li>
                                <li>cannot modify data in the database</li>
                            </ul>
                        </td>
                        <td>
                            <p class="noSpaceAbove">Splice Machine stored procedures can:</p>
                            <ul>
                                <li> return result sets or return nothing at all</li>
                                <li>issue <code>update</code>, <code>insert</code>, and <code>delete</code> statements</li>
                                <li>perform DDL statements such as <code>create</code> and <code>drop</code></li>
                                <li>consolidate and centralize code</li>
                                <li>reduce network traffic and increase execution speed</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>Can be used in <code>SELECT</code> statements.</td>
                        <td>
                            <p class="noSpaceAbove">Cannot be used in in <code>SELECT</code> statements.</p>
                            <p>Must be invoked using a <code>CALL</code> statement.</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>Create with the <a href="sqlref_statements_createfunction.html"><code>CREATE FUNCTION</code></a> statement, which is described in our SQL Reference book.</p>
                            <p>You can find an example in the <a href="developers_fcnsandprocs_examples.html">Function and Stored Procedure Examples</a> topic in this section.</p>
                        </td>
                        <td>
                            <p>Create with the <a href="sqlref_statements_createprocedure.html"><code>CREATE PROCEDURE</code></a> statement, which is described in our SQL Reference book.</p>
                            <p>You can find an example in the <a href="developers_fcnsandprocs_examples.html">Function and Stored Procedure Examples</a> topic in this section.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
## Operations in Which You Can Use Functions and Stored Procedures

The following table provides a list of the differences between functions
and stored procedures with regard to when and where they can be used:

<table summary="Table comparing which operations can be used in functions and stored procedures.">
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Operation</th>
                        <th>Functions</th>
                        <th>Stored Procedures</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Execute in an SQL Statement</em>
                        </td>
                        <td>Yes</td>
                        <td>No</td>
                    </tr>
                    <tr>
                        <td><em>Execute in a Trigger</em>
                        </td>
                        <td>Yes</td>
                        <td>Triggers that execute before an operation (<em>before triggers</em>) cannot modify SQL data.</td>
                    </tr>
                    <tr>
                        <td><em>Process <code>OUT / INOUT</code> Parameters</em>
                        </td>
                        <td>No</td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>Return <code>Resultset(s)</code></em>
                        </td>
                        <td>No</td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>Execute SQL <code>Select</code></em>
                        </td>
                        <td>Yes</td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>Execute SQL <code>Update/Insert/Delete</code></em>
                        </td>
                        <td>No</td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>Execute DDL (<code>Create/Drop</code>)</em>
                        </td>
                        <td>No</td>
                        <td>Yes</td>
                    </tr>
                </tbody>
            </table>
## Viewing Functions and Stored Procedures

You can use the &nbsp;[`show functions`](cmdlineref_showfunctions.html) and
[`show procedures`](cmdlineref_showprocedures.html) commands in the
<span class="AppCommand">splice&gt;</span> command line interface to
display the functions and stored procedures available in your database:

<table summary="Table showing the output of the show functions and show procedures commands.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Command</th>
                        <th>Output</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><span class="AppCommand">splice&gt; show functions;</span>
                        </td>
                        <td>All functions defined in your database</td>
                    </tr>
                    <tr>
                        <td><span class="AppCommand">splice&gt; show functions in SYSCS_UTIL;</span>
                        </td>
                        <td>All functions in the <code>SYSCS_UTIL</code> schema in your database</td>
                    </tr>
                    <tr>
                        <td><span class="AppCommand">splice&gt; show procedures;</span>
                        </td>
                        <td>All stored procedures defined in your database</td>
                    </tr>
                    <tr>
                        <td><span class="AppCommand">splice&gt; show procedures in SYSCS_UTIL;</span>
                        </td>
                        <td>All stored procedures in the <code>SYSCS_UTIL</code> schema in your database</td>
                    </tr>
                </tbody>
            </table>
## Writing and Deploying Functions and Stored Procedures

The remainder of this section presents information about and examples of
writing functions and stored procedures for use with Splice Machine, in
these topics:

* [Writing Functions and Stored
  Procedures](developers_fcnsandprocs_writing.html) shows you the steps
  required to write functions stored procedures and add them to your
  Splice Machine database.
* [Storing and Updating Functions and Stored
  Procedures](developers_fcnsandprocs_storing.html) tells you how to
  store new JAR files, replace JAR files, and remove JAR files in your
  Splice Machine database.
* [Examples of Splice Machine Functions and Stored
  Procedures](developers_fcnsandprocs_examples.html) provides you with
  examples of functions and stored procedures.

## See Also

* [`CREATE FUNCTION`](sqlref_statements_createfunction.html)
* [`CREATE PROCEDURE`](sqlref_statements_createprocedure.html) 

</div>
</section>
