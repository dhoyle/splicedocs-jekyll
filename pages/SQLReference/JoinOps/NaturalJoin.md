---
title: NATURAL JOIN
summary: Join operation that creates an implicit join clause for you based on the common columns (those with the same name in both tables)&#160;in the two tables being joined.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_joinops_naturaljoin.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NATURAL JOIN

A `NATURAL JOIN` is a &nbsp; [ `JOIN` operation](sqlref_joinops_about.html)
that creates an implicit join clause for you based on the common columns
in the two tables being joined. Common columns are columns that have the
same name in both tables.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
<a href="sqlref_expressions_table.html">TableExpression</a> NATURAL
   [ { LEFT | RIGHT }
     [ OUTER ] | INNER ] JOIN
   { <a href="sqlref_expressions_table.html#TableViewExpression">TableViewOrFunctionExpression</a> | ( <a href="sqlref_expressions_table.html">TableExpression</a> ) }</pre>

</div>
## Usage

A `NATURAL JOIN` can be an `INNER` join, a `LEFT OUTER` join, or a
`RIGHT OUTER` join. The default is `INNER` join.

If the `SELECT` statement in which the `NATURAL JOIN` operation appears
has an asterisk (`*`) in the select list, the asterisk will be expanded
to the following list of columns (in the shown order):

* All the common columns
* Every column in the first (left) table that is not a common column
* Every column in the second (right) table that is not a common column

An asterisk qualified by a table name (for example, `COUNTRIES.*`) will
be expanded to every column of that table that is not a common column.

If a common column is referenced without being qualified by a table
name, the column reference points to the column in the first (left)
table if the join is an `INNER JOIN` or a `LEFT OUTER JOIN`. If it is a
`RIGHT OUTER JOIN`, unqualified references to a common column point to
the column in the second (right) table.

Splice Machine does not currently support `NATURAL SELF JOIN`
operations.
{: .noteNote}

## Examples

If the tables `COUNTRIES` and `CITIES` have two common columns named
`COUNTRY` and `COUNTRY_ISO_CODE`, the following two `SELECT` statements
are equivalent:

<div class="preWrapper" markdown="1">
    splice> SELECT *
      FROM COUNTRIES
      NATURAL JOIN CITIES;

    splice> SELECT *
      FROM COUNTRIES
      JOIN CITIES
      USING (COUNTRY, COUNTRY_ISO_CODE);
{: .Example xml:space="preserve"}

</div>
The following example is similar to the one above, but it also preserves
unmatched rows from the first (left) table:

<div class="preWrapper" markdown="1">
    splice> SELECT *
      FROM COUNTRIES
      NATURAL LEFT JOIN CITIES;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`JOIN`](sqlref_joinops_intro.html) operations
* [`TABLE`](sqlref_expressions_table.html) expression
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>
