---
title: FirstValue.html
summary: Built-in SQL aggregate or window function that evaluates the value of an expression from the first row of a window partition.
keywords: first row of a window, first value, first_value
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_firstvalue.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# FIRST_VALUE

`FIRST_VALUE` is a window function that returns the values of a
specified expression that is evaluated at the first row of a window for
the current row. This means that you can select a first value from a set
of rows without having to use a self join.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    FIRST_VALUE ( expression [ {IGNORE | RESPECT} NULLS ] ) OVER ( overClause )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression<![CDATA[ ]]>
{: .paramName}

The expression to evaluate; typically a column name or computation
involving a column name.
{: .paramDefnFirst}

IGNORE NULLS
{: .paramName}

If this optional qualifier is specified, `NULL` values are ignored, and
the first non-`NULL` value is evaluated.
{: .paramDefnFirst}

If you specify this and all values are `NULL`, `FIRST_VALUE` returns
`NULL`.
{: .paramDefn}

RESPECT NULLS
{: .paramName}

This qualifier is the default behavior: it specifies that the first
value is always returned, even if it is `NULL`.
{: .paramDefnFirst}

overClause
{: .paramName}

See the [`OVER`](sqlref_clauses_over.html) clause documentation.
{: .paramDefnFirst}

</div>
## Usage Notes

Splice Machine recommends that you use the `FIRST_VALUE` function with
the [`ORDER BY`](sqlref_clauses_orderby.html) clause to produce
deterministic results.

## Results

Returns value(s) resulting from the evaluation of the specified
expression; the return type is of the same value type as the date stored
in the column used in the expression..

* `FIRST_VALUE` returns the first value in the set, unless that value is
  `NULL` and you have specified the `IGNORE NULLS` qualifier; if you've
  specified `IGNORE NULLS`, this function returns the first
  non-`NULL` value in the set.
* If all values in the set are `NULL`, `FIRST_VALUE` always returns
  `NULL`.

Splice Machine always sorts `NULL` values first in the results.
{: .noteNote}

## Examples

The following query finds all players with 10 or more HomeRuns, and
compares each player's home run count with the lowest total within that
group on his team:

<div class="preWrapper" markdown="1">
    splice> SELECT Team, DisplayName, HomeRuns,
       FIRST_VALUE(HomeRuns) OVER (PARTITION BY Team ORDER BY HomeRuns
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) "Least"
       FROM Players JOIN Batting ON Players.ID=Batting.ID
       WHERE HomeRuns > 10
       ORDER BY Team, HomeRuns DESC;
    TEAM     |DISPLAYNAME             |HOMER&|Least
    -----------------------------------------------
    Cards    |Mitch Canepa            |28    |11
    Cards    |Jonathan Pearlman       |17    |11
    Cards    |Roger Green             |17    |11
    Cards    |Michael Rastono         |13    |11
    Cards    |Jack Hellman            |13    |11
    Cards    |Kelly Wacherman         |11    |11
    Giants   |Bob Cranker             |21    |12
    Giants   |Buddy Painter           |19    |12
    Giants   |Billy Bopper            |18    |12
    Giants   |Mitch Duffer            |12    |12
    
    10 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [Window and Aggregate
  ](sqlref_builtinfcns_windowfcnsintro.html)functions
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`LAG`](sqlref_builtinfcns_lag.html) function
* [`LAST_VALUE`](sqlref_builtinfcns_lastvalue.html) function
* [`LEAD`](sqlref_builtinfcns_lead.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`OVER`](sqlref_clauses_over.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>

