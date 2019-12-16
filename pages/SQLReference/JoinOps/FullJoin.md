---
title: FULL JOIN
summary: Join operation that selects all rows from both tables, combining the results of a left outer join and a right outer join.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_joinops_fulljoin.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# FULL JOIN

A `FULL JOIN` is a &nbsp; [`JOIN` operation](sqlref_joinops_about.html) that
allows you to combine the rows from two tables, including the rows in either table that don't have match in the other table.

A *FULL JOIN* can also be referred to as a *FULL OUTER JOIN*.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
<a href="sqlref_expressions_table.html">TableExpression</a>
  { ON booleanExpression | <a href="sqlref_clauses_using.html">USING clause</a> }</pre>

</div>
You can specify the join clause by specifying `ON` with a Boolean
expression.

The scope of expressions in the `ON` clause includes the current tables
and any tables in outer query blocks to the current `SELECT`. In the
following example, the `ON` clause refers to the current tables:

<div class="preWrapper" markdown="1">
    SELECT *
      FROM SAMP.EMPLOYEE FULL JOIN SAMP.STAFF
      ON EMPLOYEE.SALARY < STAFF.SALARY;
{: .Example xml:space="preserve"}

</div>
The `ON` clause can reference tables not being joined and does not have
to reference either of the tables being joined (though typically it
does).

## Examples


## See Also

* [JOIN operations](sqlref_joinops_intro.html)
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>
