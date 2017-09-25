---
title: Splice Machine Window Functions
summary: A quick summary of window functions, as implemented in Splice Machine SQL.
keywords: window functions, grouping, partition, default value
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_windowfcns.html
folder: Developers/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Window Functions

An SQL *window function* performs a calculation across a set of table
rows that are related to the current row, either by proximity in the
table, or by the value of a specific column or set of columns; these
columns are known as the *partition*.

This topic provides a very quick summary of window functions, as
implemented in Splice Machine. For more general information about
SQL window functions, we recommending visiting some of the sources
listed in the [Additional Information](#ForMoreInfo){: .selected}
section at the end of this topic.

Here's a quick example of using a window function to operate on the
following table:

<div class="indented">
<table>
                    <col />
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>OrderID</th>
                            <th>CustomerID</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>123</td>
                            <td>1</td>
                            <td>100</td>
                        </tr>
                        <tr>
                            <td>
                            144
                        </td>
                            <td>1</td>
                            <td>250</td>
                        </tr>
                        <tr>
                            <td>167</td>
                            <td>1</td>
                            <td>150</td>
                        </tr>
                        <tr>
                            <td>
                            202
                        </td>
                            <td>
                            1
                        </td>
                            <td>250</td>
                        </tr>
                        <tr>
                            <td>209</td>
                            <td>1</td>
                            <td>325</td>
                        </tr>
                        <tr>
                            <td>
                            224
                        </td>
                            <td>
                            1
                        </td>
                            <td>125</td>
                        </tr>
                        <tr>
                            <td>66</td>
                            <td>2</td>
                            <td>100</td>
                        </tr>
                        <tr>
                            <td>
                            94
                        </td>
                            <td>
                            2
                        </td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>127</td>
                            <td>2</td>
                            <td>300</td>
                        </tr>
                        <tr>
                            <td>
                            444
                        </td>
                            <td>
                            2
                        </td>
                            <td>400</td>
                        </tr>
                    </tbody>
                </table>
</div>
This query will find the first Order ID for each specified Customer ID
in the above table:

    SELECT OrderID, CustomerID,
        FIRST_VALUE(OrderID) OVER (
            PARTITION BY CustomerID
            ORDER BY OrderID
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
    AS FirstOrderID
    FROM ORDERS
    WHERE CustomerID IN (1,2);
{: .Example xml:space="preserve"}

This works by partitioning (grouping) the selected rows by CustomerID,
ordering them for purposes of applying the function to the rows in the
partition, and then using the `FIRST_VALUE` window function to evaluate
the OrderID values in each partition and find the first value in each.
The results for our sample table are:

<div class="indented">
<table summary="Sample table results from a FIRST_VALUE operation.">
                    <col />
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>OrderID</th>
                            <th>CustomerID</th>
                            <th>FirstOrderID</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>123</td>
                            <td>1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>144</td>
                            <td>1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>167</td>
                            <td>1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>202</td>
                            <td>1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>209</td>
                            <td>1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>224</td>
                            <td>1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>66</td>
                            <td>2</td>
                            <td>66</td>
                        </tr>
                        <tr>
                            <td>94</td>
                            <td>2</td>
                            <td>66</td>
                        </tr>
                        <tr>
                            <td>127</td>
                            <td>2</td>
                            <td>66</td>
                        </tr>
                        <tr>
                            <td>444</td>
                            <td>2</td>
                            <td>66</td>
                        </tr>
                    </tbody>
                </table>
</div>
See the [Window Frames](#Window2){: .selected} section below for a
further explanation of this query.

## About Window Functions

Window functions:

* Operate on a window, or set of rows. The rows considered by a window
  function are produced by the query's `FROM` clause as filtered by its
  `WHERE`, `GROUP BY`, and `HAVING` clauses, if any. This means that any
  row that doesn't meet the `WHERE` condition is not seen by a window
  function.
* Are similar to aggregate functions, except that a window function does
  not group rows into a single output row. Instead, a window function
  returns a value for every row in the window. This is sometimes
  referred to as tuple-based aggregation.
* The values are calculated from the set of rows in the window.
* Always contain an `OVER` clause, which determines how the rows of the
  query are divided and sequenced for processing by the window function.
* The `OVER` clause can contain a `PARTITION` clause that specifies the
  set of rows in the table that form the window, relative to the current
  row.
* The `OVER` clause can contain an optional `ORDER BY` clause that
  specifies in which order rows are processed by the window function.
  This `ORDER BY` clause is independent of the `ORDER BY` clause that
  specifies the order in which rows are output.
  
  Note that the [ROW NUMBER](sqlref_builtinfcns_rownumber.html) **must
  contain** an `ORDER BY` clause.

* The `OVER` clause can also contain an optional *frame clause* that
  further restricts which of the rows in the partition are sent to the
  function for evaluation.

### About Windows, Partitions, and Frames

Using window functions can seem complicated because they involve a
number of overlapping terms, including *window*, *sliding window*,
*partition*, *set*, and *window frame*. An additional complication is
that window frames can be specified using either *rows* or *ranges*.

Let's start with basic terminology definitions:

<table summary="Window functions terminology glossary.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Terms</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>window function</em></td>
                        <td>A function that operates on a set of rows and produces output for each row.</td>
                    </tr>
                    <tr>
                        <td><em>window partition</em></td>
                        <td>
                            <p>The grouping of rows within a table.</p>
                            <p>Note that window partitions retains the rows, unlike aggregates, </p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>window ordering</em></td>
                        <td>The sequence of rows within each partition; this is the order in which the rows are passed to the window function for evaluation.</td>
                    </tr>
                    <tr>
                        <td><em>window frame</em></td>
                        <td>A frame of rows within a window partition, relative to the current row. The window frame is used to further restrict the set of rows operated on by a function, and is sometimes referred to as the <em>row or range</em> clause.</td>
                    </tr>
                    <tr>
                        <td><em>OVER clause</em></td>
                        <td>
                            <p>This is the clause used to define how the rows of the table are divided, or partitioned, for processing by the window function. It also orders the rows within the partition.</p>
                            <p>See the <a href="#The" class="selected">The OVER Clause</a> section below for more information.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>partitioning clause</em></td>
                        <td>
                            <p>An optional part of an <code>OVER</code> clause that divides the rows into partitions, similar to using the <code>GROUP BY</code> clause. The default partition is all rows in the table, though window functions are generally calculated over a partition.</p>
                            <p>See the <a href="#Window" class="selected">The Partition Clause</a> section below for more information.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>ordering clause</em></td>
                        <td>
                            <p>Defines the ordering of rows within each partition. </p>
                            <p>See the <a href="#The2" class="selected">The Order Clause</a> section below for more information.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>frame clause</em></td>
                        <td>
                            <p>Further refines the set of rows when you include an <code>ORDER BY</code> clause in your window function specification, by allowing you to include or exclude rows or values within the ordering. </p>
                            <p>See the <a href="#Window2" class="selected">The Frame Clause</a> section below for examples and more information.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
### The OVER Clause   {#The}

A window function alway contains an `OVER` clause, which determines how
the rows of the query are divided, or partitioned, for processing by the
window function.

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

</div>
When you use an [aggregate
function](sqlref_builtinfcns_windowfcnsintro.html) such as `AVG` with an
`OVER` clause, the aggregated value is computed per partition.
{: .noteNote}

### The Partition Clause   {#Window}

The partition clause, which is optional, specifies how the window
function is broken down over groups, in the same way that
`GROUP BY` specifies groupings for regular aggregate functions. Some
example partitions are:

* departments within an organization
* regions within a geographic area
* quarters within years for sales

If you omit the partition clause, the default partition, which contains
all rows in the table, is used.However, since window functions are used
to perform calculations over subsets (partitions) of rows in a table,
you generally should specify a partition clause.
{: .noteNote}

#### Syntax

<div class="fcnWrapperWide" markdown="1">
    PARTITION BY expression [, ...]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramListNested" markdown="1">
expression [,...]
{: .paramName}

A list of expressions that define the partitioning.
{: .paramDefnFirst}

</div>
If you omit this clause, there is one partition that contains all rows
in the entire table.

Here's a simple example of using the partition clause to compute the
average order amount per customer:

    SELECT OrderID, CustomerID, Amount,
        Avg(Amount) OVER (
            PARTITION BY CustomerID
            ORDER BY OrderID
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
    AS AverageOrderAmt FROM ORDERS
    WHERE CustomerID IN (1,2);
{: .Example xml:space="preserve"}

<div class="indented">
<table summary="Results table from an AVG operation.">
                    <col />
                    <col />
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>OrderID</th>
                            <th>CustomerID</th>
                            <th>Amount</th>
                            <th>AverageOrderAmt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>123</td>
                            <td>1</td>
                            <td>100</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>144</td>
                            <td>1</td>
                            <td>250</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>167</td>
                            <td>1</td>
                            <td>150</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>202</td>
                            <td>1</td>
                            <td>250</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>209</td>
                            <td>1</td>
                            <td>325</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>224</td>
                            <td>1</td>
                            <td>125</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>66</td>
                            <td>2</td>
                            <td>100</td>
                            <td>250</td>
                        </tr>
                        <tr>
                            <td>94</td>
                            <td>2</td>
                            <td>200</td>
                            <td>250</td>
                        </tr>
                        <tr>
                            <td>127</td>
                            <td>2</td>
                            <td>300</td>
                            <td>250</td>
                        </tr>
                        <tr>
                            <td>444</td>
                            <td>2</td>
                            <td>400</td>
                            <td>250</td>
                        </tr>
                    </tbody>
                </table>
</div>
### The Order Clause   {#The2}

You can also control the order in which rows are processed by window
functions using `ORDER BY` within your `OVER` clause. This is optional,
though it is important for any ranking or cumulative functions.

#### Syntax

<div class="fcnWrapperWide" markdown="1">
    ORDER BY expression
       [ ASC | DESC | USING operator ]   [ NULLS FIRST | NULLS LAST ]
       [, ...]
{: .FcnSyntax xml:space="preserve"}

</div>
Some notes about the `ORDER BY` clause in an `OVER` clause:
{: .spaceAbove}

* Ascending order (`ASC`) is the default ordering.
* If you specify `NULLS LAST`, then `NULL` values are returned last;
  this is the default when you use `ASC` order.
* If you specify `NULLS FIRST`, then `NULL` values are returned first;
  this is the default when you use `DESC` order.
* The `ORDER BY` clause in your `OVER` clause *does not* have to match
  the order in which the rows are output.
* You can only specify a *frame clause* if you include an
  `ORDER BY` clause in your `OVER` clause.

### The Frame Clause   {#Window2}

The optional frame clause defines which of the rows in the partition
(the `frame`) should be evaluated by the window function. You can limit
which rows in the partition are passed to the function in two ways:

* Specify a `ROWS` frame to limit the frame to a fixed number of rows
  from the partition that precede or follow the current row.
* Specify `RANGE` to only include rows in the frame whose evaluated
  value falls within a certain range of the current row's value. This is
  the default, and the current default range is `1`, which means that
  only rows whose value matches that of the current row are passed to
  the function.

Some sources refer to the frame clause as the *Rows or Ranges* clause.
If you omit this clause, the default is to include all rows

Window frames can only be used when you include an `ORDER BY` clause
within the `OVER` clause.
{: .noteNote}

#### Syntax

This clause specifies two offsets: one determines the start of the
window frame, and the other determines the end of the window frame.

<div class="fcnWrapperWide" markdown="1">
    [RANGE | ROWS] frameStart |
    [RANGE | ROWS] BETWEEN frameStart AND frameEnd
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramListNested" markdown="1">
`RANGE`
{: .paramName}

The frame includes rows whose values are within a specified range of the
current row's value.
{: .paramDefnFirst}

The range is determined by the `ORDER BY` column(s). Rows with identical
values for their `ORDER BY` columns are referred to as *peer rows*.
{: .paramDefn}

`ROWS`
{: .paramName}

The frame includes a fixed number of rows based on their position in the
table relative to the current row.
{: .paramDefnFirst}

frameStart
{: .paramName}

Specifies the start of the frame.
{: .paramDefnFirst}

For `ROWS` mode, you can specify:
{: .paramDefn}

> <div class="fcnWrapperWide" markdown="1">
>     UNBOUNDED PRECEDING
>     | value PRECEDING
>     | CURRENT ROW
>     | value FOLLOWING
> {: .FcnSyntax xml:space="preserve"}
> 
> </div>
> 
> <div class="paramListNested" markdown="1">
> <span class="CodeItalicFont">value</span>
> {: .paramName}
> 
> A non-negative integer value.
> {: .paramDefnFirst}
> 
> </div>

For `RANGE` mode, you can only specify:
{: .paramDefnFirst}

> <div class="fcnWrapperWide" markdown="1">
>     CURRENT ROW
>     | UNBOUNDED FOLLOWING
> {: .FcnSyntax xml:space="preserve"}
> 
> </div>

frameEnd
{: .paramName}

Specifies the end of the frame. The default value is `CURRENT ROW`.
{: .paramDefnFirst}

For `ROWS` mode, you can specify:
{: .paramDefn}

> <div class="fcnWrapperWide" markdown="1">
>     value PRECEDING
>     | CURRENT ROW
>     | value FOLLOWING
>     | UNBOUNDED FOLLOWING
> {: .FcnSyntax xml:space="preserve"}
> 
> </div>
> 
> <div class="paramListNested" markdown="1">
> <span class="CodeItalicFont">value</span>
> {: .paramName}
> 
> A non-negative integer value.
> {: .paramDefnFirst}
> 
> </div>

For `RANGE` mode, you can only specify:
{: .paramDefnFirst}

> <div class="fcnWrapperWide" markdown="1">
>     CURRENT ROW
>     | UNBOUNDED FOLLOWING
> {: .FcnSyntax xml:space="preserve"}
> 
> </div>

</div>
#### Ranges and Rows

Probably the easiest way to understand how `RANGE` and `ROWS` work is by
way of some simple `OVER` clause examples:
{: .body}

> ##### Example 1:   {#Example}
> 
> This clause can be used to apply a window function to all rows in the
> partition from the top of the partition to the current row:
> {: .body}
> 
>     OVER (PARTITION BY customerID ORDER BY orderDate)
> {: .Example xml:space="preserve"}
> 
> ##### Example 2:
> 
> Both of these clauses specify the same set of rows as [Example
> 1:](#Example){: .selected}
> {: .body}
> 
>     OVER (PARTITION BY customerID ORDER BY orderDate UNBOUNDED PRECEDING preceding)
>     
>     OVER (PARTITION BY customerID ORDER BY orderDate RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
> {: .Example xml:space="preserve"}
> 
> ##### Example 3:
> 
> This clause can be used to apply a window function to the current row
> and the 3 preceding row's values in the partition:
> {: .body}
> 
>     OVER (PARTITION BY customerID ORDER BY orderDate ROWS 3 preceding)
> {: .Example xml:space="preserve"}

#### FrameStart and FrameEnd

Some important notes about the frame clause:

* `UNBOUNDED PRECEDING` means that the frame starts with the first row
  of the partition.
* `UNBOUNDED FOLLOWING` means that the frame ends with the last row of
  the partition.
* You must specify the <span class="CodeItalicFont">frameStart</span>
  first and the <span class="CodeItalicFont">frameEnd</span> last within
  the frame clause.
* In `ROWS` mode, `CURRENT ROW` means that the frame starts or ends with
  the current row; in `RANGE` mode, `CURRENT ROW` means that the frame
  starts or ends with the current row's first or last peer in the
  `ORDER BY` ordering.
* The default *frameClause* is to include all values from the start of
  the partition through the current row: 
  
  <div class="preWrapper" markdown="1">
      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  {: .Example xml:space="preserve"}
  
  </div>

#### Common Frame Clauses

When learning about window functions, you may find references to these
specific frame clause types:

<table summary="Some common frame clause examples">
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
                        <td><code>BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING</code></td>
                    </tr>
                    <tr>
                        <td><em>Cumulative</em></td>
                        <td><code>BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW</code></td>
                    </tr>
                    <tr>
                        <td><em>Rolling</em></td>
                        <td><code>BETWEEN 2 PRECEDING AND 2 FOLLOWING</code></td>
                    </tr>
                </tbody>
            </table>
### Examples

This is a simple example that doesn't use a frame clause:

<div class="opsStepsList" markdown="1">
1.  Rank each year within a player by the number of home runs hit by
    that player:
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        
        RANK() OVER (PARTITION BY playerID ORDER BY H desc); 
    {: .Example xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
Here are some examples of window functions using frame clauses:

<div class="opsStepsList" markdown="1">
1.  Compute the running sum of G for each player:
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        
        SUM(G) OVER (PARTITION BY playerID ORDER BY yearID
          RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW); 
    {: .Example xml:space="preserve"}
    
    </div>

2.  Compute the career year:
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        
        YearID - min(YEARID) OVER (PARTITION BY playerID
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) + 1; 
    {: .Example xml:space="preserve"}
    
    </div>

3.  Compute a rolling average of games by player:
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        
        AVG(G) OVER (PARTITION BY playerID ORDER BY yearID
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING); 
    {: .Example xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
## The Ranking Functions   {#The3}

A subset of our window functions are known as *ranking functions*:

* {: .CodeFont value="1"} [DENSE_RANK](sqlref_builtinfcns_denserank.html)<span class="bodyFont">
  ranks each row in the result set. If values in the ranking column are
  the same, they receive the same rank. The next number in the ranking
  sequence is then used to rank the row or rows that follow, which means
  that `DENSE_RANK` always returns consecutive numbers.</span>
* {: .CodeFont value="2"} [RANK](sqlref_builtinfcns_rank.html)<span class="bodyFont"> ranks each
  row in the result set. If values in the ranking column are the same,
  they receive the same rank. However, the next number in the ranking
  sequence is then skipped, which means that `RANK` can return
  non-consecutive numbers.</span>
* {: .CodeFont value="3"} [ROW NUMBER](sqlref_builtinfcns_rownumber.html)<span class="bodyFont">
  assigns a sequential number to each row in the result set.</span>

All ranking functions **must include** an `ORDER BY` clause in the
`OVER()` clause, since that is how they compute ranking values.

## Window Function Restrictions

Because window functions are only allowed in
[`ORDER BY`](sqlref_clauses_orderby.html) clauses, and because window
functions are computed after both `WHERE` and `HAVING`, you sometimes
need to use subqueries with window functions to accomplish what seems
like it could be done in a simpler query.

For example, because you cannot use an `OVER` clause in a
`WHERE` clause, a query like the following is not possible:

<div class="preWrapper" markdown="1">
    SELECT *
    FROM Batting
    WHERE rank() OVER (PARTITION BY playerID ORDER BY G) = 1;
{: .Example xml:space="preserve"}

</div>
And because `WHERE` and `HAVING` are computed before the windowing
functions, this won't work either:

<div class="preWrapper" markdown="1">
    SELECT playerID, rank() OVER (PARTITION BY playerID ORDER BY G) as player_rank FROM Batting
    WHERE player_rank = 1;
{: .Example xml:space="preserve"}

</div>
Instead, you need to use a subquery:

<div class="preWrapper" markdown="1">
    SELECT *
    FROM (
       SELECT playerID, G, rank() OVER (PARTITION BY playerID ORDER BY G) as "pos"
       FROM Batting
    ) tmp
    WHERE "pos" = 1;
{: .Example xml:space="preserve"}

</div>
And note that the above subquery will add a rank column to the original
columns,

## Window Functions Included in This Release   {#IncludedFcns}

Splice Machine is currently expanding the set of SQL functions already
able to take advantage of windowing functionality.

The [`OVER`](sqlref_clauses_over.html) clause topic in our
*SQL Reference* completes the complete reference information for `OVER`.

Here is a list of the functions that currently support windowing:

* {: .CodeFont value="1"} [AVG](sqlref_builtinfcns_avg.html)
* {: .CodeFont value="2"} [COUNT](sqlref_builtinfcns_count.html)
* {: .CodeFont value="3"} [DENSE_RANK](sqlref_builtinfcns_denserank.html)
* {: .CodeFont value="4"} [FIRST_VALUE](sqlref_builtinfcns_firstvalue.html)
* {: .CodeFont value="5"} [LAG](sqlref_builtinfcns_lag.html)
* {: .CodeFont value="6"} [LAST_VALUE](sqlref_builtinfcns_lastvalue.html)
* {: .CodeFont value="7"} [LEAD](sqlref_builtinfcns_lead.html)
* {: .CodeFont value="8"} [MAX](sqlref_builtinfcns_max.html)
* {: .CodeFont value="9"} [MIN](sqlref_builtinfcns_min.html)
* {: .CodeFont value="10"} [RANK](sqlref_builtinfcns_rank.html)
* {: .CodeFont value="11"} [ROW NUMBER](sqlref_builtinfcns_rownumber.html)
* {: .CodeFont value="12"} [SUM](sqlref_builtinfcns_sum.html)

## Additional Information   {#ForMoreInfo}

There are numerous articles about window functions that you can find
online. Here are a few you might find valuable:

* The [simple talk articles from Red Gate][1]{: target="_blank"} about
  window functions are probably the most straightforward and
  comprehensive descriptions of window functions.
* This [Oracle Technology Network article][2]{: target="_blank"}
  provides an excellent technical introduction.
* This [PostgreSQL page][3]{: target="_blank"} introduces their version
  of window functions and links to other pages.
* This [PostgreSQL wiki page][4]{: target="_blank"} about SQL windowing
  queries page provides a succinct explanation of why windowing
  functions are used, and includes several useful examples.
* The [Wikipedia SQL SELECT][5]{: target="_blank"} page contains
  descriptions of specific window functions and links to other pages.

</div>
</section>



[1]: https://www.simple-talk.com/sql/learn-sql-server/window-functions-in-sql-server/
[2]: http://www.oracle.com/technetwork/issue-archive/2013/13-mar/o23sql-1906475.html
[3]: http://www.postgresql.org/docs/9.1/static/tutorial-window.html
[4]: https://wiki.postgresql.org/wiki/SQL2008_windowing_queries
[5]: http://en.wikipedia.org/wiki/Select_(SQL)
