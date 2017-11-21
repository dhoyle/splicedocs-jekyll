---
title: WHERE clause
summary: An optional clause in a SelectExpression, DELETE statement, or UPDATE statement that lets you select rows based on a Boolean expression.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_where.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# WHERE

The `WHERE` clause is an optional part of an  &nbsp;[`UPDATE`](sqlref_statements_update.html) statement.

The `WHERE` clause lets you select rows based on a Boolean expression.
Only rows for which the expression evaluates to `TRUE` are selected to
return or operate upon (delete or update).

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
WHERE <a href="sqlref_expressions_boolean.html">BooleanExpression</a></pre>

</div>
<div class="paramList" markdown="1">
BooleanExpression
{: .paramName}

A Boolean expression. For more information, see the [Boolean
Expressions](sqlref_expressions_boolean.html) topic.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapperWide" markdown="1">

       -- find the flights where no business-class seats have been booked
    SELECT *
      FROM FlightAvailability
      WHERE business_seats_taken IS NULL
         OR business_seats_taken = 0;

       -- Join the EMP_ACT and EMPLOYEE tables
       -- select all the columns from the EMP_ACT table and
       -- add the employee's surname (LASTNAME) from the EMPLOYEE table
       -- to each row of the result.
    SELECT SAMP.EMP_ACT.*, LASTNAME
      FROM SAMP.EMP_ACT, SAMP.EMPLOYEE
      WHERE EMP_ACT.EMPNO = EMPLOYEE.EMPNO;


       -- Determine the employee number and salary of sales representatives
       -- along with the average salary and head count of their departments.
       -- This query must first create a new-column-name specified in the AS clause
       -- which is outside the fullselect (DINFO)
       -- in order to get the AVGSALARY and EMPCOUNT columns,
       -- as well as the DEPTNO column that is used in the WHERE clause
    SELECT THIS_EMP.EMPNO, THIS_EMP.SALARY, DINFO.AVGSALARY, DINFO.EMPCOUNT
      FROM EMPLOYEE THIS_EMP,
         (SELECT OTHERS.WORKDEPT AS DEPTNO,
               AVG(OTHERS.SALARY) AS AVGSALARY,
               COUNT(*) AS EMPCOUNT
            FROM EMPLOYEE OTHERS
            GROUP BY OTHERS.WORKDEPT
          )AS DINFO
      WHERE THIS_EMP.JOB = 'SALESREP'
        AND THIS_EMP.WORKDEPT = DINFO.DEPTNO;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`Select`](sqlref_expressions_select.html) expressions
* [`DELETE`](sqlref_statements_delete.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>
