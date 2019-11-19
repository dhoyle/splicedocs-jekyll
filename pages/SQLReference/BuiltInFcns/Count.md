---
title: COUNT built-in SQL function
summary: Built-in SQL aggregate or window function that returns the number of rows that are returned by a query.
keywords: count, results count, DISTINCT
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_count.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# COUNT

`COUNT` returns the number of rows returned by the query. You can use it
as an [window
(analytic) function](sqlref_builtinfcns_windowfcnsintro.html).

The `COUNT(Expression)` version returns the number of row where
*Expression* is not null. You can count either all rows, or only
distinct values of *Expression*.

The `COUNT(*)` version returns all rows, including duplicates and nulls.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    COUNT( [ DISTINCT | ALL ] Expression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
DISTINCT
{: .paramName}

If this qualifier is specified, duplicates are eliminated from the
count.
{: .paramDefnFirst}

*ALL*
{: .paramName}

If this qualifier is specified, all duplicates are retained. This is the
default value.
{: .paramDefnFirst}

Expression
{: .paramName}

An expression that evaluates to a numeric data
type: [`SMALLINT`](sqlref_builtinfcns_smallint.html).
{: .paramDefnFirst}

An *Expression* can contain multiple column references or expressions,
but it cannot contain another aggregate or subquery.
{: .paramDefn}

If an *Expression*evaluates to `NULL`, the aggregate skips that value.
{: .paramDefn}

</div>
## Usage

Only one `DISTINCT` aggregate expression per
*[Expression](sqlref_expressions_select.html)* is allowed. For example,
the following query is not valid:

<div class="preWrapper" markdown="1">
       -- query not allowed
    SELECT COUNT (DISTINCT flying_time), SUM (DISTINCT miles)
      FROM Flights
{: .Example xml:space="preserve"}

</div>
Note that specifying `DISTINCT` can result in a different value, since a
smaller number of values may be counted. For example, if a column
contains the values 1, 1, 1, 1, and 2, `COUNT(col)` returns a greater
value than `COUNT(DISTINCT col)`.
{: .noteNote}

## Results

The resulting data type is [BIGINT](sqlref_builtinfcns_bigint.html).

## Aggregate Example

<div class="preWrapper" markdown="1">
    splice> Select COUNT (Name) "Players", Team
       FROM Players
       GROUP BY Team
       HAVING COUNT(Team) > 1;
    Players             |TEAM
    -------------------------------------------------------------------------------------
    46                  |Cards
    48                  |Giants
    
    2 rows selected
{: .Example xml:space="preserve"}

</div>
## Analytic Example

The following example shows the product ID, quantity, and count of all
rows from the beginning of the data window:

<div class="preWrapperWide" markdown="1">
    splice> SELECT displayName, homeruns,
       COUNT(*) OVER (ORDER BY HomeRuns ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
         as "Running Count"
       FROM Players JOIN Batting ON Players.ID=Batting.ID
       WHERE homeRuns > 5
       ORDER BY "Running Count";
    DISPLAYNAME             |HOMER&|Running Count
    ----------------------------------------------------
    Jeremy Packman          |6     |1
    Jason Minman            |7     |2
    Stan Post               |7     |3
    John Purser             |8     |4
    Harry Pennello          |9     |5
    Kelly Wacherman         |11    |6
    Mitch Duffer            |12    |7
    Michael Rastono         |13    |8
    Jack Hellman            |13    |9
    Jonathan Pearlman       |17    |10
    Roger Green             |17    |11
    Billy Bopper            |18    |12
    Buddy Painter           |19    |13
    Bob Cranker             |21    |14
    Mitch Canepa            |28    |15
    
    15 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [<span>About Data Types</span>](sqlref_datatypes_numerictypes.html)
* [Window and Aggregate
  Functions](sqlref_builtinfcns_windowfcnsintro.html)
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`MAX`](sqlref_builtinfcns_max.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`OVER`](sqlref_clauses_over.html) clause

</div>
</section>

