---
title: GROUPING built-in SQL function
summary: Built-in SQL aggregate function that returns whether a column is aggregated.
keywords: minimum window function, minimum aggregate function, DISTINCT
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_grouping.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# GROUPING

The `GROUPING` function identifies whether or not a column in a &nbsp;&nbsp;[`GROUP BY`](sqlref_clauses_groupby.html) list is aggregated.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
GROUPING ( <a href="sqlref_identifiers_types.html#ColumnName"><code>groupby_colName</code></a> )</pre>
</div>


<div class="paramList" markdown="1">
groupby_colName
{: .paramName}

The name of a single column in the `GROUP BY` clause of a `SELECT` expression or `HAVING` clause.
{: .paramDefnFirst}

</div>
## Usage

Use the `GROUPING` function to specify that a column used by the `GROUP BY` clause and/or `ROLLUP` operator is aggregated. This function returns a `TINYINT` value:

* If the specified column is aggregated, `GROUPING` returns `1`.
* If the specified column is not aggregated, `GROUPING` returns `0`,

### Usage Restrictions

You can only use the `GROUPING` function in a [SelectExpression](sqlref_expressions_select.html) or [`HAVING`](sqlref_clauses_having.html) clause.

The `GROUPING` function cannot appear in `WHERE`, `ON`, or `GROUP BY` clauses, nor as a parameter for aggregate or window functions.

## Results

Returns a `TINYINT` value.

## Examples

```
CREATE TABLE t1 (a1 INT, b1 INT, c1 INT);
INSERT INTO t1 VALUES (1,1,1), (1, NULL, 4);

splice> SELECT a1, b1,
    GROUPING(a1) AS GA,
    GROUPING(b1) AS GB,
    COUNT(*) AS CC
    FROM t1
    GROUP BY ROLLUP(a1,b1);

A1         |B1         |GA    |GB    |CC
----------------------------------------------------------
1          |1          |0     |0     |1
1          |NULL       |0     |0     |1
NULL       |NULL       |1     |1     |2
1          |NULL       |0     |1     |2

4 rows selected
```
{: .Example}

## See Also

* [Window and Aggregate
  functions](sqlref_builtinfcns_windowfcnsintro.html)

</div>
</section>
