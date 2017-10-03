---
title: ROW_NUMBER built-in SQL function
summary: Built-in SQL window function normally used to limit the number of rows returned for a query
keywords: row number function, ranking functions
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_rownumber.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ROW_NUMBER

`ROW_NUMBER()` is a *ranking function* that numbers the rows within the
ordered partition of values defined by its `OVER` clause. Ranking
functions are a subset of [window
functions](sqlref_builtinfcns_windowfcnsintro.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ROW_NUMBER() OVER ( overClause )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
overClause
{: .paramName}

See the &nbsp;[`OVER`](sqlref_clauses_over.html) clause documentation.
{: .paramDefnFirst}

Ranking functions such as `ROW_NUMBER` must include an &nbsp; 
[`ORDER BY`](sqlref_clauses_orderby.html) clause in the `OVER` clause.
This is because the ranking is calculated based on the ordering.
{: .noteNote}

</div>
## Results

The resulting data type is &nbsp;[`BIGINT`](sqlref_builtinfcns_bigint.html).

## Example

The following query ranks the salaries of players on the Cards whose
salaries are at least $1 million:

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName, Salary,
       ROW_NUMBER() OVER (PARTITION BY Team ORDER BY Salary DESC) "RowNum"
       FROM Players JOIN Salaries ON Players.ID=Salaries.ID
       WHERE Team='Cards' and Salary>999999;

    DISPLAYNAME             |SALARY              |RowNum
    ------------------------------------------------------------------
    Mitch Hassleman         |17000000            |1
    Yuri Milleton           |15200000            |2
    James Grasser           |9375000             |3
    Jack Hellman            |8300000             |4
    Larry Lintos            |7000000             |5
    Jeremy Johnson          |4125000             |6
    Mitch Canepa            |3750000             |7
    Mitch Brandon           |3500000             |8
    Robert Cohen            |3000000             |9
    James Woegren           |2675000             |10
    Sam Culligan            |2652732             |11
    Barry Morse             |2379781             |12
    Michael Rastono         |2000000             |13
    Carl Vanamos            |2000000             |14
    Alex Wister             |1950000             |15
    Pablo Bonjourno         |1650000             |16
    Jonathan Pearlman       |1500000             |17
    Jan Bromley             |1200000             |18

    18 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [Window and Aggregate
  ](sqlref_builtinfcns_windowfcnsintro.html)functions
* [`BIGINT`](sqlref_builtinfcns_bigint.html) data type
* [`OVER`](sqlref_clauses_over.html) clause
* [`OVER`](sqlref_clauses_over.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>
