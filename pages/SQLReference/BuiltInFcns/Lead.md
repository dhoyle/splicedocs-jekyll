---
title: LEAD built-in SQL function
summary: Built-in SQL aggregate or window function that evaluates the expression at a specified offset after the current row within a partition.
keywords: window function
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_lead.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LEAD

`LEAD` is a window function that returns the values of a specified
expression that is evaluated at the specified offset number of rows
after the current row in a window.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LEAD ( expression [ , offset ] ) OVER ( overClause )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

The expression to evaluate; typically a column name or computation
involving a column name.
{: .paramDefnFirst}

offset
{: .paramName}

An integer value that specifies the offset (number of rows) from the
current row at which you want the expression evaluated.
{: .paramDefnFirst}

The default value is 1.
{: .paramDefn}

overClause
{: .paramName}

See the [`OVER`](sqlref_clauses_over.html) clause documentation.
{: .paramDefnFirst}

</div>
Our current implementation of this function does not allow for
specifying a default value, as is possible in some other database
software.
{: .noteRelease}

## Usage Notes

Splice Machine recommends that you use the `LEAD` function with the
[`ORDER BY`](sqlref_clauses_orderby.html) clause to produce
deterministic results.

## Results

Returns value(s) resulting from the evaluation of the specified
expression; the return type is of the same value type as the date stored
in the column used in the expression.

## Examples

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName, Position, Salary,
       LEAD(SALARY) OVER (PARTITION BY Position ORDER BY Salary DESC) "NextLowerSalary"
       FROM Players JOIN Salaries ON Players.ID=Salaries.ID
       WHERE Salary>999999
       ORDER BY Position, Salary DESC;
    DISPLAYNAME             |POS&|SALARY              |NextLowerSalary
    -----------------------------------------------------------------------
    Billy Bopper            |1B  |3600000             |2379781
    Barry Morse             |1B  |2379781             |2000000
    Michael Rastono         |1B  |2000000             |NULL
    Craig McGawn            |3B  |4800000             |3750000
    Mitch Canepa            |3B  |3750000             |NULL
    Buddy Painter           |C   |17277777            |15200000
    Yuri Milleton           |C   |15200000            |NULL
    Alex Paramour           |CF  |10250000            |4125000
    Jeremy Johnson          |CF  |4125000             |1650000
    Pablo Bonjourno         |CF  |1650000             |NULL
    Mitch Hassleman         |LF  |17000000            |4000000
    Norman Aikman           |LF  |4000000             |1100000
    Trevor Imhof            |LF  |1100000             |NULL
    Greg Brown              |OF  |3600000             |NULL
    Martin Cassman          |P   |20833333            |18000000
    Tam Lassiter            |P   |18000000            |12000000
    Thomas Hillman          |P   |12000000            |9375000
    James Grasser           |P   |9375000             |9000000
    Jack Peepers            |P   |9000000             |7000000
    Larry Lintos            |P   |7000000             |6950000
    Marcus Bamburger        |P   |6950000             |6000000
    Jalen Ardson            |P   |6000000             |6000000
    Steve Raster            |P   |6000000             |5000000
    Sam Castleman           |P   |5000000             |4000000
    Randy Varner            |P   |4000000             |4000000
    Jason Lilliput          |P   |4000000             |3578825
    Mitch Lovell            |P   |3578825             |3500000
    Mitch Brandon           |P   |3500000             |3000000
    Robert Cohen            |P   |3000000             |2675000
    James Woegren           |P   |2675000             |2652732
    Sam Culligan            |P   |2652732             |2100000
    Yuri Piamam             |P   |2100000             |2000000
    Carl Vanamos            |P   |2000000             |1950000
    Alex Wister             |P   |1950000             |1200000
    Jan Bromley             |P   |1200000             |NULL
    Harry Pennello          |RF  |18500000            |8300000
    Jack Hellman            |RF  |8300000             |8000000
    Mark Briste             |RF  |8000000             |1000000
    Jason Minman            |RF  |1000000             |NULL
    Bob Cranker             |SS  |3175000             |1500000
    Jonathan Pearlman       |SS  |1500000             |NULL
    Joseph Arkman           |UT  |1450000             |NULL
    
    42 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [Window and Aggregate
  ](sqlref_builtinfcns_windowfcnsintro.html)functions
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`FIRST_VALUE`](sqlref_builtinfcns_firstvalue.html) function
* [`LAG`](sqlref_builtinfcns_lag.html) function
* [`LAST_VALUE`](sqlref_builtinfcns_lastvalue.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`OVER`](sqlref_clauses_over.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>

