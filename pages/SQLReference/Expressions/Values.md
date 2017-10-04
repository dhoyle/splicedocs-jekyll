---
title: VALUES Expression
summary: Describes the VALUES expression, which constructs a row or table from other values.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_values.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# VALUES Expression

The `VALUES` expression allows construction of a row or a table from
other values.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
{
 VALUES ( Value {, Value }* )
    [ , ( Value {, Value }* ) ]* |
 VALUES Value [ , Value ]*
}
  [ <a href="sqlref_clauses_orderby.html">ORDER BY clause</a> ]
  [ <a href="sqlref_clauses_resultoffset.html">result offset clause</a> ]
  [ <a href="sqlref_clauses_resultoffset.html">fetch first clause</a> ]</pre>

</div>
<div class="paramList" markdown="1">
Value
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    Expression | DEFAULT
{: .FcnSyntax}

</div>
The first form constructs multi-column rows. The second form constructs
single-column rows, each expression being the value of the column of the
row.
{: .paramDefnFirst}

The `DEFAULT` keyword is allowed only if the `VALUES` expression is in
an `INSERT` statement. Specifying `DEFAULT` for a column inserts the
column's default value into the column. Another way to insert the
default value into the column is to omit the column from the column list
and only insert values into other columns in the table.
{: .paramDefn}

ORDER BY clause
{: .paramName}

The &nbsp;[`ORDER BY` clause](sqlref_clauses_orderby.html) allows you to
specify the order in which rows appear in the result set.
{: .paramDefnFirst}

result offset and fetch first clauses
{: .paramName}

The &nbsp;[`fetch first` clause](sqlref_clauses_resultoffset.html), which can
be combined with the `result offset` clause, limits the number of rows
returned in the result set.
{: .paramDefnFirst}

</div>
## Usage

A `VALUES` expression can be used in all the places where a query can,
and thus can be used in any of the following ways:

* As a statement that returns a *ResultSet*
* Within expressions and statements wherever subqueries are permitted
* As the source of values for an
 &nbsp;[`INSERT`](sqlref_statements_insert.html) statement (in an `INSERT`
  statement, you normally use a `VALUES` expression when you do not use
  a *[SelectExpression](sqlref_expressions_select.html)*)

You can use a `VALUES` expression to generate new data values with a
query that selects from a `VALUES` clause; for example:
{: .body}

<div class="preWrapperWide" markdown="1">

     SELECT R1,R2
       FROM (VALUES('GROUP 1','GROUP 2')) AS MYTBL(R1,R2);
{: .Example xml:space="preserve"}

</div>
A `VALUES` expression that is used in an `INSERT` statement cannot use
an `ORDER BY` clause. However, if the `VALUES` expression does not
contain the `DEFAULT` keyword, the `VALUES` clause can be put in a
subquery and ordered, as in the following statement:

<div class="preWrapper" markdown="1">
    INSERT INTO t SELECT * FROM (VALUES 'a','c','b') t ORDER BY 1;
{: .Example}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
       -- 3 rows of 1 column
    splice> VALUES (1),(2),(3);

       -- 3 rows of 1 column
    splice> VALUES 1, 2, 3;

       -- 1 row of 3 columns
    splice> VALUES (1, 2, 3);

       -- 3 rows of 2 columns
    splice> VALUES (1,21),(2,22),(3,23);

       -- using ORDER BY and FETCH FIRST
    splice> VALUES (3,21),(1,22),(2,23) ORDER BY 1 FETCH FIRST 2 ROWS ONLY;

       -- using ORDER BY and OFFSET
    splice> VALUES (3,21),(1,22),(2,23) ORDER BY 1 OFFSET 1 ROW;

       -- constructing a derived table
    splice> VALUES ('orange', 'orange'), ('apple', 'red'), ('banana', 'yellow');

       -- Insert two new departments using one statement into the DEPARTMENT table,
       -- but do not assign a manager to the new department.
    splice> INSERT INTO DEPARTMENT (DEPTNO, DEPTNAME, ADMRDEPT)
      VALUES ('B11', 'PURCHASING', 'B01'),
        ('E41', 'DATABASE ADMINISTRATION', 'E01');

       -- insert a row with a DEFAULT value for the MAJPROJ column
    splice> INSERT INTO PROJECT (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTDATE, MAJPROJ)
    VALUES ('PL2101', 'ENSURE COMPAT PLAN', 'B01', '000020', CURRENT_DATE, DEFAULT);

       -- using a built-in function
    splice> VALUES CURRENT_DATE;

       -- getting the value of an arbitrary expression
    splice> VALUES (3*29, 26.0E0/3);

       -- getting a value returned by a built-in function
    splice> values char(1);
{: .Example xml:space="preserve"}

</div>
## See Also

* [`FROM`](sqlref_clauses_from.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`INSERT`](sqlref_statements_insert.html) statement

</div>
</section>
