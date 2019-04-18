---
title: SUM built-in SQL function
summary: Built-in SQL aggregate or window function that returns the sum of values of an expression over a set of rows
keywords: window functions, summing, DISTINCT
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_sum.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SUM

`SUM`returns the sum of values of an expression over a set of rows. You
can use it as an [window
(analytic) function](sqlref_builtinfcns_windowfcnsintro.html).

The `SUM` function function takes as an argument any numeric data type
or any non-numeric data type that can be implicitly converted to a
numeric data type. The function returns the same data type as the
numeric data type of the argument.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SUM ( [ DISTINCT | ALL ] Expression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
DISTINCT
{: .paramName}

If this qualifier is specified, duplicates are eliminated
{: .paramDefnFirst}

If you specify `DISTINCT` in the analytic version of `SUM`, the
[`OVER`](sqlref_clauses_over.html) clause for your window function
cannot include an `ORDER BY` clause or a *frame clause*.
{: .paramDefn}

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

The *Expression* can contain multiple column references or expressions,
but it cannot contain another aggregate or subquery. It must evaluate to
a built-in numeric data type. If an expression evaluates to `NULL`, the
aggregate skips that value.

Only one `DISTINCT` aggregate expression per *Expression* is allowed.
For example, the following query is not valid:

<div class="preWrapper" markdown="1">
       -- query not allowed
    SELECT AVG (DISTINCT flying_time),
      SUM (DISTINCT miles)
      FROM Flights;
{: .Example xml:space="preserve"}

</div>
Note that specifying `DISTINCT` can result in a different value, since a
smaller number of values may be summed. For example, if a column
contains the values 1, 1, 1, 1, and 2, `SUM(col)` returns a greater
value than `SUM(DISTINCT col)`.

## Results

The resulting data type is the same as the expression on which it
operates (it might overflow).

## Aggregate Examples

These queries compute the total of all salaries for all teams, and then
the total for each individually.
{: .body}

<div class="preWrapper" markdown="1">
    splice> SELECT SUM(Salary) FROM Salaries;
    1
    --------------------
    277275362
    
    1 row selected
    splice> SELECT SUM(Salary) FROM Salaries JOIN Players ON Salaries.ID=Players.ID WHERE Team='Cards';
    1
    --------------------
    97007230
    
    1 row selected
    splice> SELECT SUM(Salary) FROM Salaries JOIN Players ON Salaries.ID=Players.ID WHERE Team='Giants';
    1
    --------------------
    180268132
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Analytic Example

This example computes the running total of salaries, per team, counting
only the players who make at least $5 million in salary.
{: .body}

<div class="preWrapper" markdown="1">
    splice> SELECT Team, DisplayName, Salary,
       SUM(Salary) OVER(PARTITION BY Team ORDER BY Salary ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "Running Total"
       FROM Players JOIN Salaries ON Players.ID=Salaries.ID
       WHERE Salary>5000000
       ORDER BY Team;
    
    TEAM     |DISPLAYNAME             |SALARY              |RUNNING TOTAL
    ---------------------------------------------------------------------
    Cards    |Larry Lintos            |7000000             |7000000
    Cards    |Jack Hellman            |8300000             |15300000
    Cards    |James Grasser           |9375000             |24675000
    Cards    |Yuri Milleton           |15200000            |39875000
    Cards    |Mitch Hassleman         |17000000            |56875000
    Giants   |Jalen Ardson            |6000000             |60000000
    Giants   |Steve Raster            |6000000             |12000000
    Giants   |Marcus Bamburger        |6950000             |18950000
    Giants   |Mark Briste             |8000000             |26950000
    Giants   |Jack Peepers            |9000000             |35950000
    Giants   |Alex Paramour           |10250000            |46200000
    Giants   |Thomas Hillman          |12000000            |58200000
    Giants   |Buddy Painter           |17277777            |75477777
    Giants   |Tam Lassiter            |18000000            |93477777
    Giants   |Harry Pennello          |18500000            |111977777
    Giants   |Martin Cassman          |20833333            |132811110
    
    16 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Window and aggregate](sqlref_builtinfcns_windowfcnsintro.html)
  functions
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`MAX`](sqlref_builtinfcns_max.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`OVER`](sqlref_clauses_over.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>

