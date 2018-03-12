---
title: UNION clause
summary: Set operator used to combine query results
keywords: unioning, combining, DISTINCT
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_union.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# UNION

The `UNION` operator combines the result set of two or more similar
` SELECT ` queries, and returns distinct rows.

## Syntax

<div class="FcnWrapperWide"><pre class="FcnSyntax">
<a href="sqlref_expressions_select.html">SELECT expression</a></pre>

</div>
<div class="paramList" markdown="1">
SELECT expression
{: .paramName}

A `SELECT` expression that does not include an `ORDER BY` clause.
{: .paramDefnFirst}

If you include an `ORDER BY` clause, that clause applies to the
intersection operation.
{: .paramDefn}

DISTINCT
{: .paramName}

(Optional). Indicates that only distinct (non-duplicate) rows from the
queries are included. This is the default.
{: .paramDefnFirst}

ALL
{: .paramName}

(Optional). Indicates that all rows from the queries are included,
including duplicates.
{: .paramDefnFirst}

</div>
## Usage

Each `SELECT` statement in the union must contain the same number of
columns, with similar data types, in the same order. Although the
number, data types, and order of the fields in the select queries that
you combine in a `UNION` clause must correspond, you can use
expressions, such as calculations or subqueries, to make them
correspond.
{: .body}

Each `UNION` keyword combines the` SELECT `statements that immediately
precede and follow it. If you use the `ALL` keyword with some of the
`UNION` keywords in your query, but not with others, the results will
include duplicate rows from the pairs of` SELECT `statements that are
combined by using `UNION ALL`, but will not include duplicate rows from
the` SELECT `statements that are combined by using `UNION` without the
`ALL` keyword.

## Results

A result set.

## Examples

<div class="preWrapper" markdown="1">
    CREATE TABLE t1( id INTEGER NOT NULL PRIMARY KEY,
                     i1 INTEGER, i2 INTEGER,
                     c10 char(10), c30 char(30), tm time);

    CREATE TABLE t2( id INTEGER NOT NULL PRIMARY KEY,
                     i1 INTEGER, i2 INTEGER,
                     vc20 varchar(20), d double, dt date);

    INSERT INTO t1(id,i1,i2,c10,c30) VALUES
      (1,1,1,'a','123456789012345678901234567890'),
      (2,1,2,'a','bb'),
      (3,1,3,'b','bb'),
      (4,1,3,'zz','5'),
      (5,NULL,NULL,NULL,'1.0'),
      (6,NULL,NULL,NULL,'a');

    INSERT INTO t2(id,i1,i2,vc20,d) VALUES
      (1,1,1,'a',1.0),
      (2,1,2,'a',1.1),
      (5,NULL,NULL,'12345678901234567890',3),
      (100,1,3,'zz',3),
      (101,1,2,'bb',NULL),
      (102,5,5,'',NULL),
      (103,1,3,' a',NULL),
      (104,1,3,'NULL',7.4);
{: .Example}

    splice> SELECT id,i1,i2 FROM t1 UNIONSELECT id,i1,i2 FROM t2 ORDER BY id,i1,i2;
    ID         |I1         |I2
    -----------------------------------1          |1          |1
    2          |1          |2
    3          |1          |3
    4          |1          |3
    5          |NULL       |NULL
    6          |NULL       |NULL
    100        |1          |3
    101        |1          |2
    102        |5          |5
    103        |1          |3
    104        |1          |3

    11 rows selected
{: .Example}

    splice> SELECT id,i1,i2 FROM t1 UNION ALLSELECT id,i1,i2 FROM t2 ORDER BY id,i1,i2;
    ID         |I1         |I2
    -----------------------------------
    1          |1          |1
    1          |1          |1
    2          |1          |2
    2          |1          |2
    3          |1          |3
    4          |1          |3
    5          |NULL       |NULL
    5          |NULL       |NULL
    6          |NULL       |NULL
    100        |1          |3
    101        |1          |2
    102        |5          |5
    103        |1          |3
    104        |1          |3

    14 rows selected
{: .Example}

</div>
## See Also

* [Except clause](sqlref_clauses_except.html)

</div>
</section>
