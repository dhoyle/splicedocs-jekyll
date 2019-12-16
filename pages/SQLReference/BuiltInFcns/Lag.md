---
title: LAG built-in SQL function
summary: Built-in SQL aggregate or window function that evaluates the expression at a specified offset before the current row within a partition.
keywords: window function
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_lag.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LAG

`LAG` returns the values of a specified expression that is evaluated at
the specified offset number of rows before the current row in a window.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LAG ( expression [ , offset ] ) OVER ( overClause )
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

See the &nbsp;[`OVER`](sqlref_clauses_over.html) clause documentation.
{: .paramDefnFirst}

</div>
Our current implementation of this function does not allow for
specifying a default value, as is possible in some other database
software.
{: .noteRelease}

## Usage Notes

Splice Machine recommends that you use the `LAG` function with the &nbsp;
[`ORDER BY`](sqlref_clauses_orderby.html) clause to produce
deterministic results.

## Results

Returns value(s) resulting from the evaluation of the specified
expression; the return type is of the same value type as the date stored
in the column used in the expression.

## Examples

The following example shows the salaries per position for players in our
baseball database, grouped by position, and ordered from highest salary to lowest for each position:
{: .body}

<div class="preWrapper" markdown="1">
    splice> SELECT Position, Players.ID, Salary,
       LAG(Salary) OVER (PARTITION BY Position ORDER BY Salary DESC) "PrevHigherSalary"
       FROM Players JOIN Salaries ON Players.ID=Salaries.ID
       WHERE Salary > 999999
       ORDER BY Position, Salary DESC;
    POS&|ID    |SALARY              |PrevHigherSalary
    -----------------------------------------------------
    1B  |2     |3600000             |NULL
    1B  |63    |2379781             |3600000
    1B  |50    |2000000             |2379781
    3B  |14    |4800000             |NULL
    3B  |53    |3750000             |4800000
    C   |1     |17277777            |NULL
    C   |49    |15200000            |17277777
    CF  |7     |10250000            |NULL
    CF  |59    |4125000             |10250000
    CF  |55    |1650000             |4125000
    LF  |54    |17000000            |2000000
    LF  |6     |4000000             |17000000
    LF  |27    |1100000             |4000000
    P   |34    |20833333            |NULL
    P   |33    |18000000            |20833333
    P   |31    |12000000            |18000000
    P   |76    |9375000             |12000000
    P   |32    |9000000             |9375000
    P   |75    |7000000             |9000000
    P   |28    |6950000             |7000000
    P   |40    |6000000             |6950000
    P   |41    |6000000             |6000000
    P   |46    |5000000             |6000000
    P   |30    |4000000             |5000000
    P   |43    |4000000             |4000000
    P   |35    |3578825             |4000000
    P   |86    |3500000             |3578825
    P   |82    |3000000             |3500000
    P   |88    |2675000             |3000000
    P   |90    |2652732             |2675000
    P   |36    |2100000             |2652732
    P   |79    |2000000             |2100000
    P   |80    |1950000             |2000000
    P   |94    |1200000             |1950000
    RF  |8     |18500000            |NULL
    RF  |56    |8300000             |18500000
    RF  |12    |8000000             |8300000
    RF  |10    |1000000             |8000000
    SS  |4     |3175000             |NULL
    SS  |52    |1500000             |3175000
    UT  |17    |1450000             |NULL

    41 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [Window and Aggregate
  ](sqlref_builtinfcns_intro.html#window)functions
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`FIRST_VALUE`](sqlref_builtinfcns_firstvalue.html) function
* [`LAST_VALUE`](sqlref_builtinfcns_lastvalue.html) function
* [`LEAD`](sqlref_builtinfcns_lead.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`OVER`](sqlref_clauses_over.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>
