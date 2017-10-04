---
title: INNER JOIN
summary: Join operation that selects all rows from both tables as long as there is a match between the columns in both tables.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_joinops_innerjoin.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# INNER JOIN

An `INNER JOIN` is a &nbsp; [`JOIN` operation](sqlref_joinops_about.html) that
allows you to specify an explicit join clause.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
<a href="sqlref_expressions_table.html">TableExpression</a>
  { ON booleanExpression | <a href="sqlref_clauses_using.html">USING clause</a> }</pre>

</div>
You can specify the join clause by specifying `ON` with a boolean
expression.

The scope of expressions in the `ON` clause includes the current tables
and any tables in outer query blocks to the current `SELECT`. In the
following example, the `ON` clause refers to the current tables:

<div class="preWrapper" markdown="1">
    SELECT *
      FROM SAMP.EMPLOYEE INNER JOIN SAMP.STAFF
      ON EMPLOYEE.SALARY < STAFF.SALARY;
{: .Example xml:space="preserve"}

</div>
The `ON` clause can reference tables not being joined and does not have
to reference either of the tables being joined (though typically it
does).

## Examples

<div class="preWrapperWide" markdown="1">
       -- Join the EMP_ACT and EMPLOYEE tables
       -- select all the columns from the EMP_ACT table and
       -- add the employee's surname (LASTNAME) from the EMPLOYEE table
       -- to each row of the result
    splice> SELECT SAMP.EMP_ACT.*, LASTNAME
      FROM SAMP.EMP_ACT JOIN SAMP.EMPLOYEE
      ON EMP_ACT.EMPNO = EMPLOYEE.EMPNO;

       -- Join the EMPLOYEE and DEPARTMENT tables,
       -- select the employee number (EMPNO),
       -- employee surname (LASTNAME),
       -- department number (WORKDEPT in the EMPLOYEE table and DEPTNO in the
       -- DEPARTMENT table)
       -- and department name (DEPTNAME)
       -- of all employees who were born (BIRTHDATE) earlier than 1930.
    splice> SELECT EMPNO, LASTNAME, WORKDEPT, DEPTNAME
      FROM SAMP.EMPLOYEE JOIN SAMP.DEPARTMENT
      ON WORKDEPT = DEPTNO
      AND YEAR(BIRTHDATE) < 1930;

       -- Another example of "generating" new data values,
       -- using a query which selects from a VALUES clause (which is an
       -- alternate form of a fullselect).
       -- This query shows how a table can be derived called "X"
       -- having 2 columns "R1" and "R2" and 1 row of data
    splice> SELECT *
      FROM (VALUES (3, 4), (1, 5), (2, 6))
      AS VALUESTABLE1(C1, C2)
      JOIN (VALUES (3, 2), (1, 2),
      (0, 3)) AS VALUESTABLE2(c1, c2)
      ON VALUESTABLE1.c1 = VALUESTABLE2.c1;
       -- This results in:
       -- C1         |C2         |C1         |2
       -- -----------------------------------------------
       -- 3          |4          |3          |2
       -- 1          |5          |1          |2

       -- List every department with the employee number and
       -- last name of the manager
    splice> SELECT DEPTNO, DEPTNAME, EMPNO, LASTNAME
      FROM DEPARTMENT INNER JOIN EMPLOYEE
      ON MGRNO = EMPNO;

       -- List every employee number and last name
       -- with the employee number and last name of their manager
    splice> SELECT E.EMPNO, E.LASTNAME, M.EMPNO, M.LASTNAME
      FROM EMPLOYEE E INNER JOIN
      DEPARTMENT INNER JOIN EMPLOYEE M
      ON MGRNO = M.EMPNO
      ON E.WORKDEPT = DEPTNO;
{: .Example xml:space="preserve"}

</div>
## See Also

* [JOIN operations](sqlref_joinops_intro.html)
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>
