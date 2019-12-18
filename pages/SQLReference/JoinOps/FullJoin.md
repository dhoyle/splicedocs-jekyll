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

The  `ON` clause can only reference the left and right sources of the join; for example:

<div class="preWrapper" markdown="1">
    SELECT *
      FROM SAMP.EMPLOYEE FULL JOIN SAMP.STAFF
      ON EMPLOYEE.SALARY < STAFF.SALARY;
{: .Example xml:space="preserve"}

</div>

## Examples

```
splice> CREATE TABLE t1 (a1 INT, b1 INT, c1 INT);
splice> INSERT INTO t1 VALUES (1,1,1), (2,2,2), (2,2,2), (3,3,3), (4,4,null);
splice> CREATE TABLE t2 (a2 INT, b2 INT, c2 INT);
splice> INSERT INTO t2 VALUES (2,2,2), (2,2,2), (3,3,3), (4,4,null), (5,5,5), (6,6,6);

splice> SELECT a1, b1, a2, b2, c2 FROM t1 FULL JOIN t2 ON a1>a2;

A1         |B1         |A2         |B2         |C2
-----------------------------------------------------------
2          |2          |NULL       |NULL       |NULL
1          |1          |NULL       |NULL       |NULL
2          |2          |NULL       |NULL       |NULL
3          |3          |2          |2          |2
3          |3          |2          |2          |2
4          |4          |2          |2          |2
4          |4          |2          |2          |2
4          |4          |3          |3          |3
NULL       |NULL       |4          |4          |NULL
NULL       |NULL       |5          |5          |5
NULL       |NULL       |6          |6          |6

11 rows selected
```
{: .Example}

## See Also

* [JOIN operations](sqlref_joinops_intro.html)
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>
