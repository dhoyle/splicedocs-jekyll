---
title: TABLE Expression
summary: Describes the TABLE expression, which specifies a table, view, or function in a FROM clause.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_table.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TABLE Expression

A *TableExpression* specifies a table, view, or function in a &nbsp;[`FROM`
clause](sqlref_clauses_from.html). It is the source from which a
*[TableExpression](#)* selects a result.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    {
       JOIN operations
    }
{: .FcnSyntax}

</div>
## Usage

A correlation name can be applied to a table in a *TableExpression* so
that its columns can be qualified with that name.

* If you do not supply a correlation name, the table name qualifies the
  column name.
* When you give a table a correlation name, you cannot use the table
  name to qualify columns.
* You must use the correlation name when qualifying column names.
* No two items in the `FROM` clause can have the same correlation name,
  and no correlation name can be the same as an unqualified table name
  specified in that `FROM` clause.

In addition, you can give the columns of the table new names in the `AS`
clause. Some situations in which this is useful:

* When a `TableSubquery,` since there is no other way to name the
  columns of a `VALUES` expression.
* When column names would otherwise be the same as those of columns in
  other tables; renaming them means you don't have to qualify them.

The Query in a *[TableSubquery](sqlref_queries_tablesubquery.html).*

## Example

<div class="preWrapper" markdown="1">
       -- SELECT from a JOIN expression
    SELECT E.EMPNO, E.LASTNAME, M.EMPNO, M.LASTNAME
      FROM EMPLOYEE E LEFT OUTER JOIN
           DEPARTMENT INNER JOIN EMPLOYEE M
           ON MGRNO = M.EMPNO
           ON E.WORKDEPT = DEPTNO;
{: .Example xml:space="preserve"}

</div>
## TableViewOrFunctionExpression   {#TableViewExpression}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
{
   { <a href="sqlref_identifiers_types.html#ViewName">view-Name</a> }
   [ CorrelationClause ]  |
   { <a href="sqlref_queries_tablesubquery.html">TableSubquery</a> | <a href="sqlref_expressions_table.html#TableFunction">TableFunctionInvocation</a> }
   CorrelationClause
}</pre>

</div>
where *CorrelationClause* is

<div class="fcnWrapperWide"><pre class="FcnSyntax">
    [ AS ]
    correlation-Name
    [ ( <a href="sqlref_identifiers_types.html#SimpleColumnName">Simple-column-Name</a> * ) ]</pre>

</div>
## TableFunctionExpression   {#TableFunction}

<div class="fcnWrapperWide" markdown="1">

    {
      TABLE function-name( [ [ function-arg ] [, function-arg ]* ] )
    }
{: .FcnSyntax xml:space="preserve"}

</div>
Note that when you invoke a table function, you must bind it to a
correlation name. For example:

<div class="preWrapper" markdown="1">
    splice> SELECT s.* FROM TABLE( externalEmployees( 42 ) ) s;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`FROM`](sqlref_clauses_from.html) clause
* [`JOIN`](sqlref_joinops_about.html) operations
* [`SELECT`](sqlref_expressions_select.html) statement
* [`VALUES`](sqlref_expressions_values.html) expression

</div>
</section>
