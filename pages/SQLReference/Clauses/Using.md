---
title: USING clause
summary: A clause that specifies which columns to test for equality when two tables are joined.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_using.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
#  USING

The `USING` clause specifies which columns to test for equality when two
tables are joined. It can be used instead of an `ON` clause in `JOIN`
operations that have an explicit join clause.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    USING ( Simple-column-Name ]* )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
SimpleColumnName
{: .paramName}

The name of a table column, as described in the [Simple Column
Name](sqlref_identifiers_types.html#SimpleColumnName) topic.
{: .paramDefnFirst}

</div>
## Using

The columns listed in the `USING` clause must be present in both of the
tables being joined. The `USING` clause will be transformed to an `ON`
clause that checks for equality between the named columns in the two
tables.

When a `USING` clause is specified, an asterisk (`*`) in the select list
of the query will be expanded to the following list of columns (in this
order):

* All the columns in the `USING` clause
* All the columns of the first (left) table that are not specified in
  the `USING` clause
* All the columns of the second (right) table that are not specified in
  the `USING` clause

An asterisk qualified by a table name (for example, <span
class="Example">COUNTRIES.*</span>) will be expanded to every column of
that table that is not listed in the `USING` clause.

If a column in the `USING` clause is referenced without being qualified
by a table name, the column reference points to the column in the first
(left) table if the join is a &nbsp;[`LEFT OUTER JOIN`](sqlref_joinops_leftouterjoin.html). If it is a &nbsp;[`RIGHT OUTER
JOIN`](sqlref_joinops_rightouterjoin.html), unqualified references to a
column in the `USING` clause point to the column in the second (right)
table.

## Examples

The following query performs an inner join between the `COUNTRIES` table
and the `CITIES` table on the condition that `COUNTRIES.COUNTRY` is
equal to `CITIES.COUNTRY`:

<div class="preWrapper" markdown="1">
    SELECT * FROM COUNTRIES JOIN CITIES
       USING (COUNTRY);
{: .Example xml:space="preserve"}

</div>
The next query is similar to the one above, but it has the additional
join condition that `COUNTRIES.COUNTRY_ISO_CODE` is equal to
`CITIES.COUNTRY_ISO_CODE`:

<div class="preWrapper" markdown="1">
    SELECT * FROM COUNTRIES JOIN CITIES
       USING (COUNTRY, COUNTRY_ISO_CODE);
{: .Example xml:space="preserve"}

</div>
## See Also

* [Join Operations](sqlref_joinops_intro.html)
* [`SELECT`](sqlref_expressions_select.html) statement

</div>
</section>
