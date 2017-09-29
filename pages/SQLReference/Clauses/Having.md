---
title: HAVING clause
summary: A clause that restricts the results of a GROUP BY clause in a Select Expression.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_having.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# HAVING

A `HAVING` clause restricts the results of a `SelectExpression.`

The `HAVING` clause is applied to each group of the grouped table,
similarly to how a &nbsp;[`WHERE`](sqlref_clauses_where.html) clause is
applied to a select list.

If there is no `GROUP BY` clause, the `HAVING` clause is applied to the
entire result as a single group. The
[`SELECT`](sqlref_expressions_select.html) expression cannot refer
directly to any column that does not have a `GROUP BY` clause. It can,
however, refer to constants, aggregates, and special registers.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    HAVING searchCondition
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
searchCondition
{: .paramName}

A specialized Boolean expression, as described in the next section.
{: .paramDefnFirst}

</div>
## Using

The *searchCondition*, is a specialized
*[booleanExpression](sqlref_expressions_boolean.html)* that can contain
only;

* grouping columns (see &nbsp;[`GROUP BY`](sqlref_clauses_groupby.html)
  clause)
* columns that are part of aggregate expressions
* columns that are part of a subquery

For example, the following query is illegal, because the column `SALARY`
is not a grouping column, it does not appear within an aggregate, and it
is not within a subquery:

<div class="preWrapper" markdown="1">
    
    SELECT COUNT(*)
      FROM SAMP.STAFF
      GROUP BY ID
      HAVING SALARY > 15000;
{: .Example xml:space="preserve"}

</div>
Aggregates in the `HAVING` clause do not need to appear in the `SELECT`
list. If the `HAVING` clause contains a subquery, the subquery can refer
to the outer query block if and only if it refers to a grouping column.

## Example

<div class="preWrapperWide" markdown="1">
    
       -- Find the total number of economy seats taken on a flight,
       -- grouped by airline,
       -- only when the group has at least 2 records.
    SELECT SUM(ECONOMY_SEATS_TAKEN), AIRLINE_FULL
      FROM FLIGHTAVAILABILITY, AIRLINES
      WHERE SUBSTR(FLIGHTAVAILABILITY.FLIGHT_ID, 1, 2) = AIRLINE
      GROUP BY AIRLINE_FULL
      HAVING COUNT(*) > 1;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SELECT`](sqlref_expressions_select.html) expression
* [`GROUP BY`](sqlref_clauses_groupby.html) clause
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>

