---
title: AVG aggregate and window (analytic) function
summary: Built-in SQL aggregate or window (analytic) function that returns the average of an expression over a set of rows
keywords: average, aggregate function, DISTINCT
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_avg.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# AVG

`AVG` evaluates the average of an expression over a set of rows. You can
use it as an [window
(analytic) function](sqlref_builtinfcns_windowfcnsintro.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    AVG ( [ DISTINCT | ALL ] Expression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
DISTINCT
{: .paramName}

If this qualifier is specified, duplicates are eliminated
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

Only one `DISTINCT` aggregate expression per
*[Expression](sqlref_expressions_select.html)* is allowed. For example,
the following query is not valid:

<div class="preWrapperWide" markdown="1">
       --- query not valid
    SELECT AVG (DISTINCT AtBats), SUM (DISTINCT Hits)
      FROM Batting;
{: xml:space="preserve" .Example}

</div>
Note that specifying `DISTINCT` can result in a different value, since a
smaller number of values may be averaged. For example, if a column
contains the values 1.0, 1.0, 1.0, 1.0, and 2.0, `AVG(col)` returns a
smaller value than `AVG(DISTINCT col)`.
{: .noteNote}

## Results

The resulting data type is the same as the expression on which it
operates; it will never overflow.

The following query, for example, returns the INTEGER `1`, which might
not be what you would expect:

<div class="preWrapperWide" markdown="1">
    SELECT AVG(c1)
      FROM (VALUES (1), (1), (1), (1), (2))
      AS myTable (c1);
{: .Example xml:space="preserve"}

</div>
[`CAST`](sqlref_builtinfcns_cast.html) the expression to another data
type if you want more precision:

<div class="preWrapperWide" markdown="1">
    SELECT AVG(CAST (c1 AS DOUBLE PRECISION))
      FROM (VALUES (1), (1), (1), (1), (2)) AS myTable (c1);
{: .Example xml:space="preserve"}

</div>
## Aggregate Example

<div class="preWrapperWide" markdown="1">
    splice> SELECT AVG(salary) "Average" FROM Salaries;
    Average
    --------
    2949737
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Analytic Example

The following example shows the average salary paid, per position, for
the San Francisco Giants in 2015:

<div class="preWrapperWide" markdown="1">
    splice> SELECT Position, Players.ID, Salary, AVG(Cast(Salary as DECIMAL(11,3)))
       OVER (PARTITION by Position) "Average for Position"
       FROM players join Salaries on players.ID=salaries.ID
       WHERE Team='Giants' and Season=2015;
    
    POS&|ID    |SALARY              |Average for Po&
    ------------------------------------------------
    C   |1     |17277777            |3733139.8000
    C   |13    |468674              |3733139.8000
    C   |18    |800000              |3733139.8000
    C   |20    |41598               |3733139.8000
    C   |24    |77650               |3733139.8000
    IF  |23    |91516               |91516.0000
    1B  |2     |3600000             |1815252.5000
    1B  |26    |30505               |1815252.5000
    LF  |6     |4000000             |1792987.0000
    LF  |16    |278961              |1792987.0000
    LF  |27    |1100000             |1792987.0000
    P   |28    |6950000             |4759511.3333
    P   |29    |485314              |4759511.3333
    P   |30    |4000000             |4759511.3333
    P   |31    |12000000            |4759511.3333
    P   |32    |9000000             |4759511.3333
    P   |33    |18000000            |4759511.3333
    P   |34    |20833333            |4759511.3333
    P   |35    |3578825             |4759511.3333
    P   |36    |2100000             |4759511.3333
    P   |37    |210765              |4759511.3333
    P   |38    |507500              |4759511.3333
    P   |39    |507500              |4759511.3333
    P   |40    |6000000             |4759511.3333
    P   |41    |6000000             |4759511.3333
    P   |42    |374385              |4759511.3333
    P   |43    |4000000             |4759511.3333
    P   |44    |72103               |4759511.3333
    P   |45    |91516               |4759511.3333
    P   |46    |5000000             |4759511.3333
    P   |47    |74877               |4759511.3333
    P   |48    |163620              |4759511.3333
    3B  |5     |509000              |2654500.0000
    3B  |14    |4800000             |2654500.0000
    MI  |15    |288767              |288767.0000
    SS  |4     |3175000             |3175000.0000
    RF  |8     |18500000            |9166666.6666
    RF  |10    |1000000             |9166666.6666
    RF  |12    |8000000             |9166666.6666
    2B  |3     |507500              |339719.5000
    2B  |11    |171939              |339719.5000
    CF  |7     |10250000            |10250000.0000
    UT  |17    |1450000             |749959.0000
    UT  |22    |49918               |749959.0000
    OF  |9     |3600000             |962397.2500
    OF  |19    |91516               |962397.2500
    OF  |21    |149754              |962397.2500
    OF  |25    |8319                |962397.2500
    
    48 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Window and aggregate
  functions](sqlref_builtinfcns_windowfcnsintro.html)
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`MAX`](sqlref_builtinfcns_max.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`OVER`](sqlref_clauses_over.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>

