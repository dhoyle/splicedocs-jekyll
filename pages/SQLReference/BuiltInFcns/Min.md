---
title: MIN built-in SQL function
summary: Built-in SQL aggregate or window function that evaluates the minimum of an expression over a set of rows
keywords: minimum window function, minimum aggregate function, DISTINCT
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_min.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MIN

`MIN` evaluates the minimum of an expression over a set of rows. You can
use it as an [window
(analytic) function](sqlref_builtinfcns_intro.html#window).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    MIN ( [ DISTINCT | ALL ] Expression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
DISTINCT
{: .paramName}

If this qualifier is specified, duplicates are eliminated.
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

The expression can contain multiple column references or expressions,
but it cannot contain another aggregate or subquery, and it must
evaluate to an ANSI SQL numeric data type. This means that you can call
methods that evaluate to ANSI SQL data types.
{: .paramDefn}

If an expression evaluates to `NULL`, the aggregate skips that value.
{: .paramDefn}

</div>
## Usage

Only one `DISTINCT` aggregate expression per *Expression* is allowed.
For example, the following query is not valid:

<div class="preWrapper" markdown="1">
       --- Not a valid query:
    SELECT COUNT (DISTINCT flying_time),
                  MIN (DISTINCT miles)
     FROM Flights;
{: .Example xml:space="preserve"}

</div>
Since duplicate values do not change the computation of the minimum
value, the `DISTINCT` and `ALL` qualifiers have no impact on this
function.
{: .noteNote}

The *Expression* can contain multiple column references or expressions,
but it cannot contain another aggregate or subquery. It must evaluate to
a built-in data type. You can therefore call methods that evaluate to
built-in data types. (For example, a method that returns a
*java.lang.Integer* or *int* evaluates to an `INTEGER`.) If an
expression evaluates to `NULL`, the aggregate skips that value.

## Results

The resulting data type is the same as the expression on which it
operates; it will never overflow.

The comparison rules for the *Expression's* type determine the resulting
minimum value. For example, if you supply a
[`VARCHAR`](sqlref_datatypes_varchar.html) argument, the number of blank
spaces at the end of the value can affect how the minimum value is
evaluated: if the values `'z'` and `'z '` are both stored in a column,
you cannot control which one will be returned as the minimum, because
blank spaces are ignored for character comparisons.

## Examples

<div class="preWrapperWide" markdown="1">
    splice> SELECT MIN (BirthDate) FROM Players;
    1
    ----------
    1975-07-13
{: .Example xml:space="preserve"}

</div>
This example finds the minimum number of walks and strikeouts by any
pitcher in the database:

<div class="preWrapper" markdown="1">
    splice> SELECT MIN(Walks) "Walks", Min(Strikeouts) "Strikeouts"
       FROM Pitching JOIN Players on Pitching.ID=Players.ID
       WHERE Position='P';
    Walks |Strik&
    -------------
    1     |1
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Analytic Example

The following shows the homeruns hit by all batters who hit more than
10, compared to the least number of Homeruns by a player who hit 10 or
more on his team:

<div class="preWrapperWide" markdown="1">
    splice> SELECT Team, DisplayName, HomeRuns,
       MIN(HomeRuns) OVER (PARTITION BY Team ORDER BY HomeRuns
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) "Least"
       FROM Players JOIN Batting ON Players.ID=Batting.ID
       WHERE HomeRuns > 10
       ORDER BY Team, HomeRuns DESC;
    TEAM      |DISPLAYNAME             |HOMER&|Least
    --------------------------------------------------
    Cards     |Mitch Canepa            |28    |11
    Cards     |Jonathan Pearlman       |17    |11
    Cards     |Roger Green             |17    |11
    Cards     |Michael Rastono         |13    |11
    Cards     |Jack Hellman            |13    |11
    Cards     |Kelly Wacherman         |11    |11
    Giants    |Bob Cranker             |21    |12
    Giants    |Buddy Painter           |19    |12
    Giants    |Billy Bopper            |18    |12
    Giants    |Mitch Duffer            |12    |12
    
    10 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [Window and Aggregate
  functions](sqlref_builtinfcns_intro.html#window)
* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`MAX`](sqlref_builtinfcns_max.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`OVER`](sqlref_clauses_over.html) clause

</div>
</section>

