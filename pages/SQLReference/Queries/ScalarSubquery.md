---
title: Scalar Subquery
summary: A subquery that returns a single row with a single column.
keywords: exists, order by
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_queries_scalarsubquery.html
folder: SQLReference/Queries
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Scalar Subquery

A *ScalarSubquery* turns a
*[SelectExpression](sqlref_expressions_select.html)* result into a
scalar value because it returns only a single row and column value.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
( <a href="sqlref_queries_query.html">Query</a>
  [ <a href="sqlref_clauses_orderby.html">ORDER BY clause</a> ]
  [ <a href="sqlref_clauses_resultoffset.html">result offset clause</a> ]
  [ <a href="sqlref_clauses_resultoffset.html">fetch first clause</a> ]
)</pre>

</div>
## Usage

You can place a *ScalarSubquery* anywhere an *Expression* is permitted.
The query must evaluate to a single row with a single column.

Scalar subqueries are also called *expression subqueries*.

## Examples

The `AVG` function always returns a single value; thus, this is a scalar
subquery:
{: .body}

<div class="preWrapperWide" markdown="1">

    SELECT NAME, COMM
      FROM STAFF
      WHERE EXISTS
        (SELECT AVG(BONUS + 800)
           FROM EMPLOYEE
           WHERE COMM < 5000
           AND EMPLOYEE.LASTNAME = UPPER(STAFF.NAME)
        );
{: .Example xml:space="preserve"}

</div>
## See Also

* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`SELECT`](sqlref_expressions_select.html) expression

</div>
</section>
