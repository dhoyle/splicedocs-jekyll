---
title: SELECT statement
summary: Selects records from your database.
keywords: selecting records
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_select.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SELECT

Use the `SELECT` statement to query a database and receive back results.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax" markdown="1">
SELECT <a href="sqlref_queries_query.html">Query</a>
   [<a href="sqlref_clauses_orderby.html">ORDER BY clause</a>]
   [<a href="sqlref_clauses_resultoffset.html">result offset clause</a>]
   [<a href="sqlref_clauses_resultoffset.html">fetch first clause</a>]</pre>

</div>
<div class="paramList" markdown="1">
Query
{: .paramName}

The `SELECT` statement is so named because the typical first word of the
query construct is `SELECT`. (*Query* includes the
[`SELECT`](sqlref_expressions_select.html) expressions).
{: .paramDefnFirst}

ORDER BY clause
{: .paramName}

The &nbsp;[`ORDER BY`](sqlref_clauses_orderby.html) clause allows you to order
the results of the `SELECT`. Without the `ORDER BY` clause, the results
are returned in random order.
{: .paramDefnFirst}

result offset and fetch first clauses
{: .paramName}

The &nbsp;[`fetch first` clause](sqlref_clauses_resultoffset.html), which can
be combined with the `result offset` clause, limits the number of rows
fetched.
{: .paramDefnFirst}

</div>
## Examples

This example selects all records in the Players table:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SELECT * FROM Players WHERE ID < 11;
    ID    |TEAM     |POS&|DISPLAYNAME        |BIRTHDATE
    ------------------------------------------------------
    1     |Giants   |C   |Buddy Painter      |1987-03-27
    2     |Giants   |1B  |Billy Bopper       |1988-04-20
    3     |Giants   |2B  |John Purser        |1990-10-30
    4     |Giants   |SS  |Bob Cranker        |1987-01-21
    5     |Giants   |3B  |Mitch Duffer       |1991-01-15
    6     |Giants   |LF  |Norman Aikman      |1982-01-05
    7     |Giants   |CF  |Alex Paramour      |1981-07-02
    8     |Giants   |RF  |Harry Pennello     |1983-04-13
    9     |Giants   |OF  |Greg Brown         |1983-12-24
    10    |Giants   |RF  |Jason Minman       |1983-11-06

    10 rows selected
{: .Example xml:space="preserve"}

</div>
This example selects the Birthdate of all players born in November or
December:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SELECT BirthDate
       FROM Players
       WHERE MONTH(BirthDate) > 10
       ORDER BY BIRTHDATE;
    BIRTHDATE
    ----------
    1980-12-19
    1983-11-06
    1983-11-28
    1983-12-24
    1984-11-22
    1985-11-07
    1985-11-26
    1985-12-21
    1986-11-13
    1986-11-24
    1986-12-16
    1987-11-12
    1987-11-16
    1987-12-17
    1988-12-21
    1989-11-17
    1991-11-15

    17 rows selected
{: .Example xml:space="preserve"}

</div>
This example selects the name, team, and birth date of all players born
in 1985 and 1989:
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

## Statement dependency system

The `SELECT` statement depends on all the tables and views named in the
query and the conglomerates (units of storage such as heaps and indexes)
chosen for access paths on those tables.

The `SELECT` statement depends on all aliases used in the query.
Dropping an alias invalidates any prepared `SELECT` statement that uses
the alias.

## See Also

* [`CREATE INDEX`](sqlref_statements_createindex.html) statement
* [`CREATE VIEW`](sqlref_statements_createview.html) statement
* [`DROP INDEX`](sqlref_statements_dropindex.html) statement
* [`DROP VIEW`](sqlref_statements_dropview.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`FETCH FIRST`](sqlref_clauses_resultoffset.html) clause
* [`RESULT OFFSET`](sqlref_clauses_resultoffset.html) clause

</div>
</section>
