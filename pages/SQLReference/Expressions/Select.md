---
title: SELECT Expression
summary: Describes the SELECT expression, which builds a table value based on filtering and projecting values from other tables.
keywords: 
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_select.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SELECT Expression   {#Expressions.Select}

A *SelectExpression* is the basic `SELECT-FROM-WHERE` construct used to
build a table value based on filtering and projecting values from other
tables.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SELECT [ DISTINCT | ALL ] SelectItem [ , SelectItem ]*
       FROM clause
       [ WHERE clause]
       [ GROUP BY clause ]
       [ HAVING clause ]
       [ ORDER BY clause ]
       [ result offset clause ]
       [ fetch first clause ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
SELECT clause
{: .paramName}

The `SELECT` clause contains a list of expressions and an optional
quantifier that is applied to the results of the [`WHERE`
clause](sqlref_clauses_where.html).
{: .paramDefnFirst}

If `DISTINCT` is specified, only one copy of any row value is included
in the result. Nulls are considered duplicates of one another for the
purposes of `DISTINCT`.
{: .paramDefn}

If no quantifier, or `ALL`, is specified, no rows are removed from the
result in applying the `SELECT` clause. This is the default behavior.
{: .paramDefn}

<div class="paramListNested" markdown="1">
SelectItem:
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    {
        * |
        { correlation-Name } .* |
          Expression [AS Simple-column-Name] }
    }
{: .FcnSyntax xml:space="preserve"}

</div>
A<em> SelectItem</em> projects one or more result column values for a
table result being constructed in a *SelectExpression*.
{: .paramDefn}

For queries that do not select a specific column from the tables
involved in the *SelectExpression* (for example, queries that use
`COUNT(*)`), the user must have at least one column-level SELECT
privilege or table-level SELECT privilege. See [GRANT
statement](sqlref_statements_grant.html) for more information.
{: .paramDefn}

</div>
FROM clause
{: .paramName}

The result of the [`FROM` clause](sqlref_clauses_from.html) is the cross
product of the `FROM` items.
{: .paramDefnFirst}

WHERE clause
{: .paramName}

The [`WHERE` clause](sqlref_clauses_where.html) can further qualify the
result of the `FROM` clause.
{: .paramDefnFirst}

GROUP BY clause
{: .paramName}

The [`GROUP BY` clause](sqlref_clauses_where.html) groups rows in the
result into subsets that have matching values for one or more columns.
{: .paramDefnFirst}

`GROUP BY` clauses are typically used with aggregates. If there is a
`GROUP BY` clause, the `SELECT` clause must contain *only* aggregates or
grouping columns. If you want to include a non-grouped column in the
`SELECT` clause, include the column in an aggregate expression. For
example, this query computes the average salary of each team in a
baseball league:
{: .paramDefn}

<div class="preWrapper" markdown="1">
    splice> SELECT COUNT(*) AS PlayerCount, Team, AVG(Salary) AS AverageSalary
       FROM Players JOIN Salaries ON Players.ID=Salaries.ID
       GROUP BY Team
       ORDER BY AverageSalary;
{: .Example xml:space="preserve"}

</div>
If there is no `GROUP BY` clause, but a *SelectItem* contains an
aggregate not in a subquery, the query is implicitly grouped. The entire
table is the single group.
{: .paramDefnFirst}

HAVING clause
{: .paramName}

The [`HAVING` clause](sqlref_clauses_having.html) can further qualify
the result of the `FROM` clause. This clause restricts a grouped table,
specifying a search condition (much like a `WHERE` clause) that can
refer only to grouping columns or aggregates from the current scope.
{: .paramDefnFirst}

The `HAVING` clause is applied to each group of the grouped table. If
the `HAVING` clause evaluates to `TRUE`, the row is retained for further
processing; if it evaluates to `FALSE` or `NULL`, the row is discarded.
If there is a `HAVING` clause but no `GROUP BY`, the table is implicitly
grouped into one group for the entire table.
{: .paramDefn}

ORDER BY clause
{: .paramName}

The [`ORDER BY` clause](sqlref_clauses_orderby.html) allows you to
specify the order in which rows appear in the result set. In subqueries,
the `ORDER BY` clause is meaningless unless it is accompanied by one or
both of the result offset and fetch first clauses.
{: .paramDefnFirst}

<span class="CodeItalicFont">result offset</span> and <span
class="CodeItalicFont">fetch first</span> clauses
{: .paramName}

The [`fetch first` clause](sqlref_clauses_resultoffset.html), which can
be combined with the `result offset` clause, limits the number of rows
returned in the result set.
{: .paramDefnFirst}

</div>
## Usage

The result of a *SelectExpression* is always a table.

Splice Machine processes the clauses in a `Select` expression in the
following order:

* `FROM` clause
* `WHERE` clause
* `GROUP BY` (or implicit `GROUP BY`)
* `HAVING` clause
* `ORDER BY` clause
* `Result offset` clause
* `Fetch first` clause
* `SELECT` clause

When a query does not have a `FROM` clause (when you are constructing a
value, not getting data out of a table), use a
[`VALUES`](sqlref_expressions_values.html) expression, not a
*SelectExpression*. For example:

<div class="preWrapper" markdown="1">
    VALUES CURRENT_TIMESTAMP;
{: .Example xml:space="preserve"}

</div>
## The * wildcard   {#StarWildcard}

The wildcard character (***) expands to all columns in the tables in the
associated `FROM` clause.

*[correlation-Name](sqlref_identifiers_types.html).** expand to all
columns in the identified table. That table must be listed in the
associated `FROM` clause.

## Naming columns

You can name a *SelectItem* column using the `AS` clause.

If a column of a *SelectItem* is not a simple *ColumnReference*
expression or named with an `AS` clause, it is given a generated unique
name.

These column names are useful in several cases:

* They are made available on the JDBC *ResultSetMetaData*.
* They are used as the names of the columns in the resulting table when
  the *SelectExpression* is used as a table subquery in a `FROM` clause.
* They are used in the `ORDER BY` clause as the column names available
  for sorting.

## Examples

This example shows using a `SELECT` with `WHERE` and `ORDER BY` clauses;
it selects the name, team, and birth date of all players born in 1985
and 1989:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SELECT DisplayName, Team, BirthDate
       FROM Players
       WHERE YEAR(BirthDate) IN (1985, 1989)
       ORDER BY BirthDate;
    DISPLAYNAME             |TEAM      |BIRTHDATE
    -----------------------------------------------
    Jeremy Johnson          |Cards     |1985-03-15
    Gary Kosovo             |Giants    |1985-06-12
    Michael Hillson         |Cards     |1985-11-07
    Mitch Canepa            |Cards     |1985-11-26
    Edward Erdman           |Cards     |1985-12-21
    Jeremy Packman          |Giants    |1989-01-01
    Nathan Nickels          |Giants    |1989-05-04
    Ken Straiter            |Cards     |1989-07-20
    Marcus Bamburger        |Giants    |1989-08-01
    George Goomba           |Cards     |1989-08-08
    Jack Hellman            |Cards     |1989-08-09
    Elliot Andrews          |Giants    |1989-08-21
    Henry Socomy            |Giants    |1989-11-17
    
    13 rows selected
{: .Example xml:space="preserve"}

</div>
This example shows using correlation names for the tables:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    splice> SELECT CONSTRAINTNAME, COLUMNNAME
      FROM SYS.SYSTABLES t, SYS.SYSCOLUMNS col,
      SYS.SYSCONSTRAINTS cons, SYS.SYSCHECKS checks
      WHERE t.TABLENAME = 'FLIGHTS'
        AND t.TABLEID = col.REFERENCEID
        AND t.TABLEID = cons.TABLEID
        AND cons.CONSTRAINTID = checks.CONSTRAINTID
      ORDER BY CONSTRAINTNAME;
{: .Example}

This example shows using the `DISTINCT` clause:
{: .body}

    
     SELECT DISTINCT SALARY   FROM Salaries;
{: .Example}

This example shows how to rename an expression. We use the name BOSS as
the maximum department salary for all departments whose maximum salary
is less than the average salary i all other departments:
{: .body}

    
     SELECT WORKDEPT AS DPT, MAX(SALARY) AS BOSS
       FROM EMPLOYEE EMP_COR
       GROUP BY WORKDEPT
       HAVING MAX(SALARY) <     (SELECT AVG(SALARY)
          FROM EMPLOYEE
          WHERE NOT WORKDEPT = EMP_COR.WORKDEPT)
       ORDER BY BOSS;
{: .Example}

</div>
## See Also

* [`FROM`](sqlref_clauses_from.html) clause
* [`GROUP BY`](sqlref_clauses_groupby.html) clause
* [`HAVING`](sqlref_clauses_having.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>

