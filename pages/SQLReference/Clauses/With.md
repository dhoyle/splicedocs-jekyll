---
title: WITH clause
summary: The WITH clause is also known as the subquery refactoring clause, and is used to name a subquery, which improves readability and can improve query efficiency.
keywords: WITH CLAUSE, Common Table Expression, CTE
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_with.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# WITH CLAUSE (Common Table Expression)

You can use Common Table Expressions, also known as the `WITH` clause,
to break down complicated queries into simpler parts by naming and
referring to subqueries within queries.

A Common Table Expression (CTE) provides a way of defining a temporary
result set whose definition is available only to the query in which the
CTE is defined. The result of the CTE is not stored; it exists only for
the duration of the query. CTEs are helpful in reducing query complexity
and increasing readability. They can be used as substitutions for views
in cases where either you dont have permission to create a view or the
query would be the only one using the view. CTEs allow you to more
easily enable grouping by a column that is derived from a scalar sub
select or a function that is non deterministic.

The `WITH` clause is also known as the *subquery factoring clause*.
{: .noteNote}

The handling and syntax of `WITH` queries are similar to the handling
and syntax of views. The `WITH` clause can be processed as an inline
view and shares syntax with `CREATE VIEW`. The `WITH` clause can also
resolve as a temporary table, which may enhance the efficiency of a
query.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
WITH <a href="sqlref_queries_query.html">queryName</a>
   AS SELECT query</pre>
</div>

<div class="fcnWrapperWide"><pre class="FcnSyntax">
WITH RECURSIVE  <a href="sqlref_identifiers_types.html#TableName">queryName</a>
   [ ( <a href="sqlref_identifiers_types.html#SimpleColumnName">Simple-column-Name</a>] * ) ]
   AS
   ( seed-query
     UNION ALL
     recursive-query
   )</pre>
</div>

<div class="paramList" markdown="1">
queryName
{: .paramName}

An identifier that names the subquery clause.
{: .paramDefnFirst}

query
{: .paramName}

The subquery.
{: .paramDefnFirst}

seed-query
{: .paramName}

A `SELECT` or `VALUES` command that provides the seed row(s) of a recursive view.
{: .paramDefnFirst}

recursive-query
{: .paramName}

A `SELECT` or `VALUES` command that provides the body of a recursive view.
{: .paramDefnFirst}
The `FROM` clause of your `recursive-query` should contain a self-reference to the `queryName`.
{: .noteNote}

</div>

## Recursion Usage Notes

Splice Machine has implemented a recursive iteration limit to limit runaway recursion. The default limit value is `20`. You can modify this value in your configuration by changing the value of this parameter:

```
splice.execution.recursiveQueryIterationLimit
```
{: .Example}

You can also override the system limit in your current database connection using the [`set session_property`](cmdlineref_setsessionproperty.html) command; for example:
{: .spaceAbove}

```
splice> set session_property recursivequeryiterationlimit=30;
```
{: .Example}

To discover the current value of that property, use the `values current session_property` command:
{: .spaceAbove}

```
splice> values current session_property;
1
---------------------------------------------------------------------------------
RECURSIVEQUERYITERATIONLIMIT=30;
```
{: .Example}

Finally, to unset the session-level property and revert to the system property, use this command:
{: .spaceAbove}

```
set session_property recursivequeryiterationlimit=null;
```
{: .Example}

## Restrictions

These are restrictions that will be addressed in a future release of Splice Machine.

For all `with` clauses:

* You cannot currently use a temporary table in a `WITH` clause. This is
being addressed in a future release of Splice Machine.

For recursive `with` clauses:

* You cannot nest recursive clauses: a `with recursive` clause (or recursive view) cannot reference another `with recursive` clause (or recursive view).

* The `recursive-query` can only contain one recursive reference.

* The recursive reference cannot occur in a subquery.


## Examples:

This section contains examples of using the `WITH` clause.

### Example 1

If we create the following table:

```
CREATE TABLE BANKS (
       INSTITUTION_ID INTEGER NOT NULL,
       INSTITUTION_NAME VARCHAR(100),
       CITY VARCHAR(100),
       STATE VARCHAR(2),
       TOTAL_ASSETS DECIMAL(19,2),
       NET_INCOME DECIMAL(19,2),
       OFFICES INTEGER,
       PRIMARY KEY(INSTITUTION_ID)
);
```
{: .Example}

We can then use a common table expression to improve the readability of
a statement that finds the per-city total assets and income for the
states with the top net income:
{: .body}

```
WITH state_sales AS (
       SELECT STATE, SUM(NET_INCOME) AS total_sales
       FROM BANKS
       GROUP BY STATE
   ), top_states AS (
       SELECT STATE
       FROM state_sales
       WHERE total_sales > (SELECT SUM(total_sales)/10 FROM state_sales)
   )
SELECT STATE,
       CITY,
       SUM(TOTAL_ASSETS) AS assets,
       SUM(NET_INCOME) AS income
FROM BANKS
WHERE STATE IN (SELECT STATE FROM top_states)
GROUP BY STATE, CITY;

```
{: .Example}

## Example 2:

If we create the following table:

```
CREATE TABLE edge (nodeA INT,  nodeB INT);
INSERT INTO edge VALUES (1,2), (1,3), (2,4), (2,5), (3,6), (3,7), (5,8), (7,9);
CREATE TABLE vertex (node INT, name VARCHAR(10));
INSERT INTO vertex VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D'), (5, 'E'), (6,'F'), (7, 'G'), (8, 'H'), (9,'I');
```
{: .Example}

We can then use a common table expression to find the name and depth of all vertices that are reachable from node 1:

```
WITH RECURSIVE dt AS (
    SELECT node, name, 1 AS level FROM vertex WHERE node=1
    UNION ALL
    SELECT edge.nodeB AS node, vertex.name, level+1 AS level FROM dt, edge, vertex WHERE dt.node=edge.nodeA AND edge.nodeB = vertex.node AND dt.level < 10)
SELECT * FROM dt ORDER BY node;

NODE       |NAME      |LEVEL
-------------------------------------------
1          |A         |1
2          |B         |2
3          |C         |2
4          |D         |3
5          |E         |3
6          |F         |3
7          |G         |3
8          |H         |4
9          |I         |4

9 rows selected
```
{: .Example}

## See Also

* [`SELECT`](sqlref_expressions_select.html) expression
* [`Query`](sqlref_queries_query.html) 

<div class="hiddenText">
WITH
</div>
</div>
</section>
