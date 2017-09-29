---
title: OVER clause
summary: A clause used in window functions to define the window on which the function operates. Window functions are permitted only in the SELECT list and the ORDER BY clause of queries.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_over.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# OVER

The `OVER` clause is used in window functions to define the window on
which the function operates. Window functions are permitted only in the
&nbsp;&nbsp;[`ORDER BY`](sqlref_clauses_orderby.html) clause of queries.

For general information about and examples of Window functions in Splice
Machine, see the [Using Window
Functions](developers_fundamentals_windowfcns.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    expression OVER( 
         [partitionClause]
         [orderClause]
         [frameClause] );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

Any value expression that does not itself contain window function calls.
{: .paramDefnFirst}

partitionClause
{: .paramName}

Optional. Specifies how the window function is broken down over groups,
in the same way that `GROUP BY` specifies groupings for regular
aggregate functions. If you omit this clause, there is one partition
that contains all rows.
{: .paramDefnFirst}

The syntax for this clause is essentially the same as for the
[`GROUP BY`](sqlref_clauses_groupby.html) clause for queries; To recap:
{: .paramDefn}

<div class="fcnWrapperWide" markdown="1">
    PARTITION BY expression [, ...]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression [,...]
{: .paramName}

A list of expressions that define the partitioning.
{: .paramDefnFirst}

</div>
orderClause
{: .paramName}

Optional. Controls the ordering. It is important for ranking functions,
since it specifies by which variables ranking is performed. It is also
needed for cumulative functions. The syntax for this clause is
essentially the same as for the
[`SQL Reference`](sqlref_clauses_orderby.html). To recap:
{: .paramDefnFirst}

<div class="fcnWrapperWide" markdown="1">
    ORDER BY expression
       [ ASC | DESC | USING operator ]   [ NULLS FIRST | NULLS LAST ]
       [, ...]
{: .FcnSyntax xml:space="preserve"}

</div>
The default ordering is ascending (`ASC`). For ascending order,
`NULL` values are returned last unless you specify `NULLS FIRST`; for
descending order, `NULL` values are returned first unless you specify
`NULLS LAST`.
{: .noteNote}

frameClause
{: .paramName}

Optional. Defines which of the rows (which *frame*) that are passed to
the window function should be included in the computation. The
*frameClause* provides two offsets that determine the start and end of
the frame.
{: .paramDefnFirst}

The syntax for the frame clause is:
{: .paramDefn}

<div class="fcnWrapperWide" markdown="1">
    [RANGE | ROWS] frameStart |
    [RANGE | ROWS] BETWEEN frameStart AND frameEnd
{: .FcnSyntax xml:space="preserve"}

</div>
The syntax for both *frameStart* and *frameEnd* is:
{: .paramDefn}

<div class="fcnWrapperWide" markdown="1">
    UNBOUNDED PRECEDING |
    <n> PRECEDING       |
    CURRENT ROW         |
    <n> FOLLOWING       |
    UNBOUNDED FOLLOWING
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
&lt;n&gt;
{: .paramName}

A a non-negative integer value.
{: .paramDefnFirst}

</div>
</div>
## Usage Restrictions

Because window functions are only allowed in
[`HAVING`](sqlref_clauses_using.html)clauses, you sometimes need to use
subqueries with window functions to accomplish what seems like it could
be done in a simpler query.

For example, because you cannot use an `OVER` clause in a
`WHERE` clause, a query like the following is not possible:

<div class="preWrapperWide" markdown="1">
    SELECT *
    FROM Batting
    WHERE rank() OVER (PARTITION BY "playerID" ORDER BY "G") = 1;
{: .Example xml:space="preserve"}

</div>
And because `WHERE` and `HAVING` are computed before the windowing
functions, this won't work either:

<div class="preWrapperWide" markdown="1">
    SELECT *, rank() OVER (PARTITION BY "playerID" ORDER BY "G") as rank
    FROM Batting
    WHERE rank = 1;
{: .Example xml:space="preserve"}

</div>
Instead, you need to use a subquery:

<div class="preWrapperWide" markdown="1">
    SELECT *
    FROM (
       SELECT *, rank() OVER (PARTITION BY "playerID" ORDER BY "G") as rank
       FROM Batting
    ) tmp
    WHERE rank = 1;
{: .Example xml:space="preserve"}

</div>
And note that the above subquery will add a rank column to the original
columns,

## Simple Window Function Examples

The examples in this section are fairly simple because they don't use
the frame clause.

<div class="preWrapperWide" markdown="1">
    --- Rank each year within a player by the number of home runs hit by that player
    RANK() OVER (PARTITION BY playerID ORDER BY desc(H));

    --- Compute the change in number of games played from one year to the next:
    G - LAG(G) OVER (PARTITION G playerID ORDER BY yearID);
{: .Example xml:space="preserve"}

</div>
## Examples with Frame Clauses

The frame clause can be confusing, given all of the options that it
presents. There are three commonly used frame clauses:

<table summary="Frame clause types">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Frame Clause Type</th>
                        <th>Example</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Recycled</em></td>
                        <td class="CodeFont">
                            <p>BETWEEN UNBOUNDED PRECEEDING AND UNBOUNDED FOLLOWING</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Cumulative</em></td>
                        <td class="CodeFont">
                            <p>BETWEEN UNBOUNDED PRECEEDING AND CURRENT ROW</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Rolling</em></td>
                        <td><code>BETWEEN 2 PRECEEDING AND 2 FOLLOWING</code></td>
                    </tr>
                </tbody>
            </table>
Here are some examples of window functions using frame clauses:

<div class="preWrapperWide" markdown="1">
    --- Compute the running sum of G for each player:
    SUM(G) OVER (PARTITION BY playerID ORDER BY yearID
      BETWEEN UNBOUNDED PRECEEDING AND CURRENT ROW);

    --- Compute the career year:
    YearID - min(YEARID) OVER (PARTITION BY playerID
       BETWEEN UNBOUNDED PRECEEDING AND UNBOUNDED FOLLOWING) + 1;

    --- Compute a rolling average of games by player:
    MEAN(G) OVER (PARTITION BY playerID ORDER BY yearID
       BETWEEN 2 PRECEEDING AND 2 FOLLOWING);
{: .Example xml:space="preserve"}

</div>
## See Also

* [Window and Aggregate
  ](sqlref_builtinfcns_windowfcnsintro.html)functions
* [`SELECT`](sqlref_expressions_select.html) expression
* [`HAVING`](sqlref_clauses_having.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`WHERE`](sqlref_clauses_where.html) clause
* The [Using Window Functions](developers_fundamentals_windowfcns.html)
  section in our *Splice Machine Developer's Guide*

</div>
</section>
