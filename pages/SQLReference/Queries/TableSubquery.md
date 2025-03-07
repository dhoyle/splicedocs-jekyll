---
title: Table Subquery
summary: A subquery that returns multiple rows.
keywords: exists, order by
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_queries_tablesubquery.html
folder: SQLReference/Queries
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Table Subquery

A *TableSubquery* is a subquery that returns multiple rows.

## Syntax


<div class="fcnWrapperWide"><pre class="FcnSyntax">
( <a href="sqlref_queries_query.html">Query</a>
  [ <a href="sqlref_clauses_orderby.html">ORDER BY clause</a> ]
  [ <a href="sqlref_clauses_resultoffset.html">result offset clause</a> ]
  [ <a href="sqlref_clauses_resultoffset.html">fetch first clause</a> ]
)</pre>

</div>
## Usage

Unlike a *[ScalarSubquery](sqlref_queries_scalarsubquery.html),* a
*TableSubquery* is allowed only:

* as a *[TableExpression](sqlref_expressions_table.html)* in a &nbsp;[`FROM`
  clause](sqlref_clauses_from.html)
* with `EXISTS`, `IN`, or quantified comparisons.

When used as a *[TableExpression](sqlref_expressions_table.html)* in a
[`FROM` clause](sqlref_clauses_from.html), or with `EXISTS`, it can
return multiple columns.

When used with `IN` or quantified comparisons, it must return a single
column.

## Example

This example shows a subquery used as a table expression in a
`FROM` clause:
{: .body}

<div class="preWrapperWide" markdown="1">

    SELECT VirtualFlightTable.flight_ID
      FROM
         (SELECT flight_ID, orig_airport, dest_airport
            FROM Flights
            WHERE (orig_airport = 'SFO' OR dest_airport = 'SCL')
          )
      AS VirtualFlightTable;
{: .Example xml:space="preserve"}

</div>
This shows one subquery used with `EXISTS` and another used with `IN`:
{: .body}

<div class="preWrapperWide" markdown="1">

    SELECT *
      FROM Flights
      WHERE EXISTS
        (SELECT *
           FROM Flights
           WHERE dest_airport = 'SFO'
           AND orig_airport = 'GRU');

    SELECT flight_id, segment_number
      FROM Flights
      WHERE flight_id IN
        (SELECT flight_ID
           FROM Flights
           WHERE orig_airport = 'SFO'
           OR dest_airport = 'SCL');
{: .Example xml:space="preserve"}

</div>
## See Also

* [`FROM`](sqlref_clauses_from.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`SELECT`](sqlref_expressions_select.html) expression
* [`TABLE`](sqlref_expressions_table.html) expression

</div>
</section>
