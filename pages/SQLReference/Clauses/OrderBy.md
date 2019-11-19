---
title: ORDER BY clause
summary: A clause that allows you to specify the order in which rows appear in the result set.
keywords: row order, DISTINCT, ROW NUMBER
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_orderby.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ORDER BY

The `ORDER BY` clause is an optional element of the following:

* A &nbsp;[`SELECT` statement](sqlref_expressions_select.html)
* A *[SelectExpression](sqlref_expressions_select.html)*
* A &nbsp;[`VALUES` expression](sqlref_expressions_values.html)
* A *[ScalarSubquery](sqlref_queries_scalarsubquery.html)*
* A *[TableSubquery](sqlref_queries_tablesubquery.html)*

It can also be used in an &nbsp;[`CREATE
VIEW`](sqlref_statements_createview.html) statement.

An `ORDER BY` clause allows you to specify the order in which rows
appear in the result set. In subqueries, the `ORDER BY` clause is
meaningless unless it is accompanied by one or both of the `result
offset` and `fetch first` clauses or in conjunction with the
`ROW_NUMBER` function, since there is no guarantee that the order is
retained in the outer result set. It is permissible to combine `ORDER
BY` on the outer query with `ORDER BY` in subqueries.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
ORDER BY { <a href="sqlref_identifiers_types.html#ColumnName">column-Name</a> |
           ColumnPosition |
           Expression }
    [ ASC | DESC ]
    [ , <a href="sqlref_identifiers_types.html#ColumnName">column-Name</a> | ColumnPosition | Expression
      [ ASC | DESC ]
      [ NULLS FIRST | NULLS LAST ]
    ]*</pre>

</div>
<div class="paramList" markdown="1">
column-Name
{: .paramName}

A column name, as described in the
[`SELECT`](sqlref_expressions_select.html) statement. The column name(s)
that you specify in the `ORDER BY` clause do not need to be the `SELECT`
list.
{: .paramDefnFirst}

ColumnPosition
{: .paramName}

An integer that identifies the number of the column in the
<var>SelectItems</var> in the underlying query of the `SELECT`
statement. `ColumnPosition` must be greater than 0 and not greater than
the number of columns in the result table. In other words, if you want
to order by a column, that column must be specified in the `SELECT`
list.
{: .paramDefnFirst}

Expression
{: .paramName}

A sort key expression, such as numeric, string, and datetime
expressions. *Expression* can also be a row value expression such as a
scalar subquery or case expression.
{: .paramDefnFirst}

ASC
{: .paramName}

Specifies that the results should be returned in ascending order. If the
order is not specified, `ASC` is the default.
{: .paramDefnFirst}

DESC
{: .paramName}

Specifies that the results should be returned in descending order.
{: .paramDefnFirst}

<div markdown="1">
NULLS FIRST
{: .paramName}

Specifies that `NULL` values should be returned before
non-`NULL` values. This is the default value for descending
(`DESC`) order.
{: .paramDefnFirst}

NULLS LAST
{: .paramName}

Specifies that `NULL` values should be returned after non-`NULL` values.
This is the default value for ascending (`ASC`) order.
{: .paramDefnFirst}

</div>
</div>
## Using

If `SELECT DISTINCT` is specified or if the `SELECT` statement contains
a `GROUP BY` clause, the `ORDER BY` columns must be in the `SELECT`
list.

## Example using a correlation name

You can sort the result set by a correlation name, if the correlation
name is specified in the select list. For example, to return from the
`CITIES` database all of the entries in the `CITY_NAME` and `COUNTRY`
columns, where the `COUNTRY` column has the correlation name `NATION`,
you specify this `SELECT` statement:

<div class="preWrapper" markdown="1">
    SELECT CITY_NAME, COUNTRY AS NATION
      FROM CITIES
      ORDER BY NATION;
{: .Example xml:space="preserve"}

</div>
## Example using a numeric expression

You can sort the result set by a numeric expression, for example:

<div class="preWrapper" markdown="1">
    SELECT name, salary, bonus FROM employee
      ORDER BY salary+bonus;
{: .Example xml:space="preserve"}

</div>
In this example, the salary and bonus columns are `DECIMAL` data types.

## Example using a function

You can sort the result set by invoking a function, for example:

<div class="preWrapper" markdown="1">
    SELECT i, len FROM measures
      ORDER BY sin(i);
{: .Example xml:space="preserve"}

</div>
## Example of specifying a NULL ordering

You can sort the result set by invoking a function, for example:

<div class="preWrapper" markdown="1">
    SELECT * FROM Players
      ORDER BY BirthDate DESC NULLS LAST;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`GROUP BY`](sqlref_clauses_groupby.html) clause
* [`WHERE`](sqlref_clauses_where.html) clause
* [`SELECT`](sqlref_expressions_select.html) expression
* [`VALUES`](sqlref_expressions_values.html) expression
* [`CREATE VIEW`](sqlref_statements_createview.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement

</div>
</section>
