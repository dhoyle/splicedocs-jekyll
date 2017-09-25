---
title: RIGHT OUTER JOIN
summary: Join operation that returns all rows from the right table (table2), with the matching rows in the left table (table1). The result is NULL in the left side when there is no match.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_joinops_rightouterjoin.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RIGHT OUTER JOIN   {#JoinOps.RightOuterJoin}

A `RIGHT OUTER JOIN` is one of the [`JOIN`
operations](sqlref_joinops_about.html) that allow you to specify a
`JOIN` clause. It preserves the unmatched rows from the second (right)
table, joining them with a `NULL` in the shape of the first (left)
table. A Right Outer `JOIN B `is equivalent to `B RIGHT OUTER JOIN A`,
with the columns in a different order.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TableExpression
    {
     ON booleanExpression | USING clause
    }
{: .FcnSyntax xml:space="preserve"}

</div>
The scope of expressions in the `ON` clause includes the current tables
and any tables in query blocks outer to the current `SELECT`. The `ON`
clause can reference tables not being joined and does not have to
reference either of the tables being joined (though typically it does).

## Example 1

<div class="preWrapperWide" markdown="1">
       -- get all countries and corresponding cities, including
       -- countries without any cities
    splice> SELECT COUNTRIES.COUNTRY, CITIES.CITY_NAME
      FROM CITIES  RIGHT OUTER JOIN COUNTRIES
      ON CITIES.COUNTRY_ISO_CODE = COUNTRIES.COUNTRY_ISO_CODE;
    
       -- get all countries in Africa and corresponding cities,
       -- including countries without any cities
    splice> SELECT COUNTRIES.COUNTRY, CITIES.CITY_NAME
      FROM CITIES
      RIGHT OUTER JOIN COUNTRIES
      ON CITIES.COUNTRY_ISO_CODE = COUNTRIES.COUNTRY_ISO_CODE
      WHERE Countries.region = 'Africa';
    
      -- use the synonymous syntax, RIGHT JOIN, to achieve exactly
      -- the same results as in the example above
    splice> SELECT COUNTRIES.COUNTRY, CITIES.CITY_NAME
      FROM CITIES
      RIGHT JOIN COUNTRIES
      ON CITIES.COUNTRY_ISO_CODE = COUNTRIES.COUNTRY_ISO_CODE
      WHERE Countries.region = 'Africa';
{: .Example xml:space="preserve"}

</div>
## Example 2

<div class="preWrapperWide" markdown="1">
       -- a TableExpression can be a joinOperation. Therefore
       -- you can have multiple join operations in a FROM clause
       -- List every employee number and last name
       -- with the employee number and last name of their manager
    splice> SELECT E.EMPNO, E.LASTNAME, M.EMPNO, M.LASTNAME
      FROM EMPLOYEE E RIGHT OUTER JOIN
      DEPARTMENT RIGHT OUTER JOIN EMPLOYEE M
      ON MGRNO = M.EMPNO
      ON E.WORKDEPT = DEPTNO;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`JOIN`](sqlref_joinops_intro.html) operations
* [`TABLE`](sqlref_expressions_table.html) expression
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>

