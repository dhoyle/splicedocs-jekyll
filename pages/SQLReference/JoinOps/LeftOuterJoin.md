---
title: LEFT OUTER JOIN
summary: Join operation that returns all rows from the left table with the matching rows in the right table. The result is NULL in the right side when there is no match.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_joinops_leftouterjoin.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LEFT OUTER JOIN

A `LEFT OUTER JOIN` is one of the &nbsp;[`JOIN`
operations](sqlref_joinops_about.html) that allow you to specify a join
clause. It preserves the unmatched rows from the first (left) table,
joining them with a `NULL` row in the shape of the second (right) table.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TableExpression
    {
        ON booleanExpression |
        USING clause
    }
{: .FcnSyntax}

</div>
The scope of expressions in either the `ON` clause includes the current
tables and any tables in query blocks outer to the current `SELECT`. The
`ON` clause can reference tables not being joined and does not have to
reference either of the tables being joined (though typically it does).

## Example 1

<div class="preWrapperWide" markdown="1">
       -- match cities to countries in Asia
    splice> SELECT CITIES.COUNTRY, CITIES.CITY_NAME, REGION
      FROM Countries
      LEFT OUTER JOIN Cities
      ON CITIES.COUNTRY_ISO_CODE = COUNTRIES.COUNTRY_ISO_CODE
      WHERE REGION = 'Asia';
    
       -- use the synonymous syntax, LEFT JOIN, to achieve exactly
       -- the same results as in the example above
    splice> SELECT  COUNTRIES.COUNTRY, CITIES.CITY_NAME,REGION
      FROM COUNTRIES
      LEFT JOIN CITIES
      ON CITIES.COUNTRY_ISO_CODE = COUNTRIES.COUNTRY_ISO_CODE
      WHERE REGION = 'Asia';
{: .Example xml:space="preserve"}

</div>
## Example 2

<div class="preWrapperWide" markdown="1">
       -- Join the EMPLOYEE and DEPARTMENT tables,
       -- select the employee number (EMPNO),
       -- employee surname (LASTNAME),
       -- department number (WORKDEPT in the EMPLOYEE table
       -- and DEPTNO in the DEPARTMENT table)
       -- and department name (DEPTNAME)
       -- of all employees who born (BIRTHDATE) earlier than 1930
    splice> SELECT EMPNO, LASTNAME, WORKDEPT, DEPTNAME
      FROM SAMP.EMPLOYEE LEFT OUTER JOIN SAMP.DEPARTMENT
      ON WORKDEPT = DEPTNO
      AND YEAR(BIRTHDATE) < 1930;
    
       -- List every department with the employee number and
       -- last name of the manager,
       -- including departments without a manager
    splice> SELECT DEPTNO, DEPTNAME, EMPNO, LASTNAME
      FROM DEPARTMENT LEFT OUTER JOIN EMPLOYEE
      ON MGRNO = EMPNO;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`JOIN`](sqlref_joinops_intro.html) operations
* [`TABLE`](sqlref_expressions_table.html) expression
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>

