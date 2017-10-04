---
title: EXCEPT clause
summary: Performs set intersection on results from multiple queries
keywords: intersection, except, ORDER, DISTINCT
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_except.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# EXCEPT

The `EXCEPT` operator combines the result set of two or more similar
`SELECT` queries, returning the results from the first query that do not
appear in the results of the second query.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
EXCEPT [ <a href="sqlref_expressions_select.html">SELECT expression</a> ]*</pre>

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
including duplicates. With `ALL`, a row that has m duplicates in the
left table and n duplicates in the right table will appear `max(m-n,0)`
times in the result set.
{: .paramDefnFirst}

</div>
## Usage

Each `SELECT` statement in the operation must contain the same number of
columns, with similar data types, in the same order. Although the
number, data types, and order of the fields in the select queries that
you combine in an `EXCEPT` clause must correspond, you can use
expressions, such as calculations or subqueries, to make them
correspond.
{: .body}

When comparing column values for determining `DISTINCT` rows, two `NULL`
values are considered equal.
{: .body}

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

    splice> SELECT id,i1,i2 FROM t1 EXCEPT SELECT id,i1,i2 FROM t2 ORDER BY id,i1,i2;
    ID         |I1         |I2
    -----------------------------------
    4          |1          |3
    3          |1          |3
    6          |NULL       |NULL

    3 rows selected
{: .Example}

    splice> SELECT i1,i2 FROM t1 EXCEPT SELECT i1,i2 FROM t2 where id = -1 ORDER BY 1,2;
    I1         |I2
    -----------------------
    NULL       |NULL
    1          |3
    1          |2
    1          |1

    4 rows selected
{: .Example}

    splice> SELECT i1,i2 FROM t1 where id = -1 EXCEPT SELECT i1,i2 FROM t2 ORDER BY 1,2;
    I1         |I2
    -----------------------

    0 rows selected
{: .Example}

</div>
## See Also

* [Union clause](sqlref_clauses_union.html)

</div>
</section>
