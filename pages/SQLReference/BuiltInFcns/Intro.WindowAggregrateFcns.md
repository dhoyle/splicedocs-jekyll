---
title: Window and Aggregate Functions in Splice Machine SQL
summary: Summarizes the window and aggregate functions you can use to evaluate an expression over a set of rows in Splice Machine SQL.
keywords: window functions, aggregate functions
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_windowfcnsintro.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Window and Aggregate Functions

This section contains the Aggregate and Window (analytic) functions
built into Splice Machine SQL.

* [Aggregate functions](#Aggregat), which are sometimes referred to as
  set functions, provide a means of evaluating an expression over a set
  of rows. Each aggregate function outputs one value for the set of rows
  on which it operates. All aggregate functions can also be used as
  window functions.
* [Window functions](#Window), which are sometimes referred to as
  *analytic functions*, perform calculations across a set of table rows
  that are related to the current row. Each window function outputs one
  value for each row on which it operates. Some of the window functions
  *cannot* be used as aggregate functions.
  
  A subset of the window functions are sometimes referred to as *ranking
  functions*, as noted below.
  {: .noteNote}

<table summary="Summary of Splice Machine SQL Window and Aggregate Functions">
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th><strong>Function Name</strong>
                        </th>
                        <th>Window or Aggregate</th>
                        <th>Description</th>
                        <th>Permitted Data Types</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><a href="sqlref_builtinfcns_avg.html"><code>AVG</code></a>
                        </td>
                        <td>Both</td>
                        <td>Returns the average computed over a subset (partition) of a table.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_count.html"><code>COUNT</code></a>
                        </td>
                        <td>Both</td>
                        <td>Returns the number of rows in a partition.</td>
                        <td>All types.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_denserank.html"><code>DENSE_RANK</code></a>
                        </td>
                        <td>Window</td>
                        <td>A ranking function that returns the ranking of a row within a partition.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_firstvalue.html"><code>FIRST_VALUE</code></a>
                        </td>
                        <td>Window</td>
                        <td>Returns the first value within  a partition..</td>
                        <td>All types.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_lag.html"><code>LAG</code></a>
                        </td>
                        <td>Window</td>
                        <td>Returns the value of an expression evaluated at a specified offset number of rows <em>before</em> the current row in a partition.</td>
                        <td>All types.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_lastvalue.html"><code>LAST_VALUE</code></a>
                        </td>
                        <td>Window</td>
                        <td>Returns the last value within a partition..</td>
                        <td>All types.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_lead.html"><code>LEAD</code></a>
                        </td>
                        <td>Window</td>
                        <td>Returns the value of an expression evaluated at a specified offset number of rows <em>after</em> the current row in a partition.</td>
                        <td>All types.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_max.html"><code>MAX</code></a>
                        </td>
                        <td>Both</td>
                        <td>Returns the maximum value computed over a partition.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_min.html"><code>MIN</code></a>
                        </td>
                        <td>Both</td>
                        <td>Returns the minimum value computed over a partition.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_rank.html"><code>RANK</code></a>
                        </td>
                        <td>Window</td>
                        <td>A ranking function that returns the ranking of a row within a subset of a table.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_rownumber.html"><code>ROW_NUMBER</code></a>
                        </td>
                        <td>Window</td>
                        <td>
                            <p>A ranking function that returns the row number of a row within a partition.</p>
                        </td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_stddevpop.html"><code>STDDEV_POP</code></a>
                        </td>
                        <td>Both</td>
                        <td>Returns the sum of a value calculated over a partition.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><code><a href="sqlref_builtinfcns_stddevsamp.html">STDDEV_SAMP
                        </a></code>
                        </td>
                        <td>Both</td>
                        <td>Returns the sum of a value calculated over a partition.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_builtinfcns_sum.html"><code>SUM</code></a>
                        </td>
                        <td>Both</td>
                        <td>Returns the sum of a value calculated over a partition.</td>
                        <td>The <a href="#numeric_built-in_data_types_">numeric built-in data types</a>.</td>
                    </tr>
                </tbody>
            </table>
### The Numeric Built-in Data Types   {#numeric_built-in_data_types_}

The numeric built-in data types
are: [`SMALLINT`](sqlref_builtinfcns_smallint.html).
{: .indentLevel1}

## Using Aggregate Functions   {#Aggregat}

Aggregate functions (also described as *set functions* in ANSI SQL and
as *column functions* in some database literature). They provide a means
of evaluating an expression over a set of rows.

Whereas the other built-in functions operate on a single expression,
aggregates operate on a set of values and reduce them to a single scalar
value. Built-in aggregates can calculate the minimum, maximum, sum,
count, and average of an expression over a set of values as well as
count rows. The following table shows the data types on which each
built-in aggregate function can operate.

Aggregates are permitted only in the following:

* A *SelectItem* in a
  *[SelectExpression](sqlref_expressions_select.html).*
* A [`HAVING` clause](sqlref_clauses_having.html).
* An [`ORDER BY` clause](sqlref_clauses_orderby.html) if and only if the
  aggregate appears in a *SelectItem* in a
  *[SelectExpression](sqlref_expressions_select.html).*

All expressions in *SelectItems* in the
*[SelectExpression](sqlref_expressions_select.html)* must be either
aggregates or grouped columns (see [`GROUP BY`
clause](sqlref_clauses_groupby.html)).(The same is true if there is a
`HAVING` clause without a `GROUP BY` clause.)

This is because the *ResultSet* of a
*[SelectExpression](sqlref_expressions_select.html)* must be either a
scalar (single value) or a vector (multiple values), but not a mixture
of both. (Aggregates evaluate to a scalar value, and the referenceto a
column can evaluate to a vector.) For example, the following query mixes
scalar and vector values and thus is not valid:

<div class="preWrapper" markdown="1">
       -- not valid
    SELECT MIN(flying_time), flight_id
      FROM Flights;
{: .Example xml:space="preserve"}

</div>
Aggregates are not allowed on outer references (correlations). This
means that if a subquery contains an aggregate, that aggregate cannot
evaluate an expression that includes a reference to a column in the
outer query block. For example, the following query is not valid because
SUM operates on a column from the outer query:

<div class="preWrapper" markdown="1">
    SELECT c1
      FROM t1
      GROUP BY c1
      HAVING c2 >
      SELECT t2.x
      FROM t2
      WHERE t2.y = SUM(t1.c3));
{: .Example xml:space="preserve"}

</div>
## Using Window Functions   {#Window}

Window functions, sometimes referred to as *analytic* functions, perform
calculations across a set of table rows that are related to the current
row. They are similar to aggregate functions, with several significant
differences; a window function:

* Always includes an [`OVER`](sqlref_clauses_over.html) clause
* Outputs one row for each input value it operates upon.
* Groups rows with window partitioning and frame clauses, rather than
  using [`GROUP BY`](sqlref_clauses_groupby.html) clauses

Most developers who are new to window functions find that the easiest
way to understand them is to view examples, such as the ones in the
[Window Functions](developers_fundamentals_windowfcns.html) topic in our
*Splice Machine Developer's Guide*.
{: .noteNote}

Window functions can be used to handle complex analysis and reporting.
For example, it's easy to output running totals, moving averages for a
specific time frame, and similar functions. There are a few simple rules
about window function usage you need to know:

* Window functions are permitted only in the `SELECT` list and the
  `ORDER BY` clause of the query. They are forbidden elsewhere, such as
  in `GROUP BY`, `HAVING` and `WHERE` clauses. These restrictions are
  due to the fact that window functions execute after the processing of
  those clauses.
* You can include an aggregate function call in the arguments to a
  window function; however, you cannot include a window function in the
  arguments to a regular aggregate function. This is again due to the
  fact that window functions execute after regular aggregate functions
  have executed.
* When the function runs, a window of rows is computed in relation to
  the current row; as the current row advances, the window moves along
  with it.

The rows considered by a window function (its input rows) are those of
the *virtual table* produced by the query's `FROM` clause as filtered by
its `WHERE`, `GROUP BY`, and `HAVING` clauses, if any. This means, for
example, that a row removed because it does not meet the `WHERE`
condition is not seen by any window function. A query can contain
multiple window functions that slice up the data in different ways by
means of different `OVER` clauses, but they all act on the same
collection of rows defined by this virtual table.

For examples and further explanation of window functions, please see the
[Window Functions](developers_fundamentals_windowfcns.html) topic in our
*Splice Machine Developer's Guide*.

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`AVG`](sqlref_builtinfcns_currentdate.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`DENSE_RANK`](sqlref_builtinfcns_denserank.html) function
* [`FIRST_VALUE`](sqlref_builtinfcns_firstvalue.html) function
* [`LAG`](sqlref_builtinfcns_lag.html) function
* [`LAST_VALUE`](sqlref_builtinfcns_lastvalue.html) function
* [`LEAD`](sqlref_builtinfcns_lead.html) function
* [`MAX`](sqlref_builtinfcns_max.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`RANK`](sqlref_builtinfcns_rank.html) function
* [`ROW_NUMBER`](sqlref_builtinfcns_rownumber.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`SELECT`](sqlref_expressions_select.html) expression
* [`GROUP BY`](sqlref_clauses_groupby.html) clause
* [`HAVING`](sqlref_clauses_having.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* *[Using Window Functions](developers_fundamentals_windowfcns.html)* in
  the *Developer Guide*.

</div>
</section>

