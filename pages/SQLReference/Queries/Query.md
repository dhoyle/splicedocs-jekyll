---
title: QUERY
summary: Creates a virtual table based on existing tables or constants built into tables.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_queries_query.html
folder: SQLReference/Queries
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Query   {#SQL-Queries.Query}

A *Query* creates a virtual table based on existing tables or constants
built into tables.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    {
      ( Query
           [ ORDER BY clause ]
           [ result offset clause ]
           [ fetch first clause ] 
      ) |
       Query EXCEPT [ ALL | DISTINCT ] Query |
       Query UNION [ ALL | DISTINCT ] Query |
       VALUES Expression
    }
{: .FcnSyntax xml:space="preserve"}

</div>
You can arbitrarily put parentheses around queries, or use the
parentheses to control the order of evaluation of the `UNION`
operations. These operations are evaluated from left to right when no
parentheses are present.

## Duplicates in UNION and EXCEPT ALL results

The `ALL` and `DISTINCT` keywords determine whether duplicates are
eliminated from the result of the operation. If you specify the
`DISTINCT` keyword, then the result will have no duplicate rows. If you
specify the `ALL` keyword, then there may be duplicates in the result,
depending on whether there were duplicates in the input. `DISTINCT` is
the default, so if you don't specify `ALL` or `DISTINCT`, the duplicates
will be eliminated. For example, `UNION` builds an intermediate
*ResultSet* with all of the rows from both queries and eliminates the
duplicate rows before returning the remaining rows. `UNION ALL` returns
all rows from both queries as the result.

Depending on which operation is specified, if the number of copies of a
row in the left table is L and the number of copies of that row in the
right table is R, then the number of duplicates of that particular row
that the output table contains (assuming the `ALL` keyword is specified)
is:

* `UNION`: ( L + R ).
* `EXCEPT`: the maximum of ( L - R ) and 0 (zero).

## Examples

Here's a simple `SELECT` expression:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    SELECT *
      FROM ORG;
{: .Example xml:space="preserve"}

</div>
Here's a `SELECT` with a subquery:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    SELECT *
      FROM (SELECT CLASS_CODE FROM CL_SCHED) AS CS;
{: .Example xml:space="preserve"}

</div>
Here's a `SELECT` with a subquery:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    SELECT *
      FROM (SELECT CLASS_CODE FROM CL_SCHED) AS CS;
{: .Example xml:space="preserve"}

</div>
Here's a `UNION` that lists all employee numbers from certain
departments who are assigned to specified project numbers:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    SELECT EMPNO, 'emp'
      FROM EMPLOYEE
      WHERE WORKDEPT LIKE 'E%'
      UNION
        SELECT EMPNO, 'emp_act'
           FROM EMP_ACT
           WHERE PROJNO IN('MA2100', 'MA2110', 'MA2112');
{: .Example xml:space="preserve"}

</div>
## See Also

* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`SELECT`](sqlref_expressions_select.html) expression
* [`SELECT`](sqlref_expressions_select.html) statement
* [`VALUES`](sqlref_expressions_values.html) expression

</div>
</section>

