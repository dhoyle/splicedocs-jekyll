---
title: CREATE VIEW statement
summary: Creates a view, which is a virtual table formed by a query.
keywords: creating a view
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_createview.html
folder: SQLReference/Statements
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE VIEW

Views are virtual tables formed by a query. A view is a dictionary
object that you can use until you drop it. Views are not updatable.

If a qualified view name is specified, the schema name cannot begin with
*SYS*.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE VIEW <a href="sqlref_identifiers_types.html#ViewName">view-Name</a>
   [ ( <a href="sqlref_identifiers_types.html#SimpleColumnName">Simple-column-Name</a>] * ) ]
   AS query
     [ <a href="sqlref_clauses_orderby.html">ORDER BY orderby-clause</a> ]
     [ <a href="sqlref_clauses_resultoffset.html">RESULT OFFSET resultoffset-clause</a> ]
     [ <a href="sqlref_clauses_resultoffset.html">FETCH FIRST fetchfirst-clause</a> ]</pre>

</div>

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE RECURSIVE VIEW <a href="sqlref_identifiers_types.html#ViewName">view-Name</a>
   [ ( <a href="sqlref_identifiers_types.html#SimpleColumnName">Simple-column-Name</a>] * ) ]
   AS
   ( seed-query
     UNION ALL
     recursive-query
   )</pre>
</div>

A view definition can contain an optional view column list to explicitly
name the columns in the view. If there is no column list, the view
inherits the column names from the underlying query. All columns in a
view must be uniquely named.

<div class="paramList" markdown="1">
view-Name
{: .paramName}

The name to assign to the view.
{: .paramDefnFirst}

Simple-column-Name*
{: .paramName}

An optional list of names to be used for columns of the view. If not
given, the column names are deduced from the query.
{: .paramDefnFirst}

The maximum number of columns in a view is
`{{splvar_limit_MaxColumnsInView}}`.
{: .paramDefn}

query
{: .paramName}

A `SELECT` or `VALUES` command that provides the columns and rows of the
view.
{: .paramDefnFirst}

orderby-clause
{: .paramName}

Use the [`ORDER BY` clause](sqlref_clauses_orderby.html) to specify the order in which rows
appear in the view.
{: .paramDefnFirst}

resultoffset-clause
{: .paramName}

The &nbsp;[`RESULT OFFSET` clause](sqlref_clauses_resultoffset.html) provides a way to skip the N first rows in a result set before starting to add any rows to the view.
{: .paramDefnFirst}

fetchfirst-clause
{: .paramName}

The &nbsp;[`FETCH FIRST` clause](sqlref_clauses_resultoffset.html) can
be combined with the `RESULT OFFSET` clause to limit the number of rows added to the view.
{: .paramDefnFirst}

seed-query
{: .paramName}

A `SELECT` or `VALUES` command that provides the seed of a recursive view.
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


## Recursive View Restrictions

In the current release, these restrictions apply to recursive views:

* You cannot nest recursive views: a recursive view (or `with recursive` clause) cannot reference another recursive view (or `with recursive`) clause.

* The `recursive-query` can only contain one recursive reference.

* The recursive reference cannot occur in a subquery.

## Examples

This section contains examples of using the `CREATE VIEW` statement.

### Example 1
This example creates a view that shows the age of each player in our
database:

```
splice> CREATE VIEW PlayerAges (Player, Team, Age)
   AS SELECT DisplayName, Team,
      INT( (Now - Birthdate) / 365.25) AS Age
      FROM Players;
0 rows inserted/updated/deleted

splice> SELECT * FROM PlayerAges WHERE Age > 30 ORDER BY Team, Age DESC;
PLAYER                  |TEAM     |AGE
-----------------------------------------
Robert Cohen            |Cards    |40
Jason Larrimore         |Cards    |37
David Janssen           |Cards    |36
Mitch Hassleman         |Cards    |35
Mitch Brandon           |Cards    |35
Tam Croonster           |Cards    |34
Alex Wister             |Cards    |34
Yuri Milleton           |Cards    |33
Jonathan Pearlman       |Cards    |33
Michael Rastono         |Cards    |32
Barry Morse             |Cards    |32
Carl Vanamos            |Cards    |32
Jan Bromley             |Cards    |31
Thomas Hillman          |Giants   |40
Mark Briste             |Giants   |38
Randy Varner            |Giants   |38
Jason Lilliput          |Giants   |38
Jalen Ardson            |Giants   |36
Sam Castleman           |Giants   |35
Alex Paramour           |Giants   |34
Jack Peepers            |Giants   |34
Norman Aikman           |Giants   |33
Craig McGawn            |Giants   |33
Kameron Fannais         |Giants   |33
Jason Martell           |Giants   |33
Harry Pennello          |Giants   |32
Jason Minman            |Giants   |32
Trevor Imhof            |Giants   |32
Steve Raster            |Giants   |32
Greg Brown              |Giants   |31
Alex Darba              |Giants   |31
Joseph Arkman           |Giants   |31
Tam Lassiter            |Giants   |31
Martin Cassman          |Giants   |31
Yuri Piamam             |Giants   |31

35 rows selected
```
{: .Example}

### Example 2

This example uses a simple recursive view to generate the Fibonacci sequence:

```
CREATE RECURSIVE VIEW fib_up_to_100 (a,b) AS
    SELECT a, b from (values (0, 1)) AS dt(a,b)
    UNION ALL
    SELECT b, a + b AS b FROM fib_up_to_100 WHERE b <= 100;

0 rows inserted/updated/deleted

splice> SELECT * FROM fib_up_to_100;

A          |B
----------------
0          |1
1          |1
1          |2
2          |3
3          |5
5          |8
8          |13
13         |21
21         |34
34         |55
55         |89
89         |144

12 rows selected
```
{: .Example}


### Example 3

This example records the nodes and edges of a tree. Here's an example tree:

```
              1.A
              |
     |-----------------|
     2.B               3.C
     |                 |
|--------|       |-----------|
4.D      5.E     6.F         7.G
         |                   |
         8.H                 9.I
```
{: .Example}

We use two tables to record the nodes and edges:

```
CREATE TABLE edge (nodeA INT,  nodeB INT);
INSERT INTO edge VALUES (1,2), (1,3), (2,4), (2,5), (3,6), (3,7), (5,8), (7,9);
CREATE TABLE vertex (node INT, name VARCHAR(10));
INSERT INTO vertex VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D'),
                          (5, 'E'), (6,'F'), (7, 'G'), (8, 'H'), (9,'I');
```
{: .Example}

And this query returns all the vertices reachable from node 1  and their depths:

```
WITH RECURSIVE dt AS (
    SELECT node, name, 1 AS level FROM vertex WHERE node=1
    UNION ALL
    SELECT edge.nodeB AS node, vertex.name, level+1 AS level FROM dt, edge, vertex
            WHERE dt.node=edge.nodeA AND edge.nodeB = vertex.node AND dt.level < 10)
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

## Statement Dependency System

View definitions are dependent on the tables and views referenced within
the view definition. DML (data manipulation language) statements that
contain view references depend on those views, as well as the objects in
the view definitions that the views are dependent on. Statements that
reference the view depend on indexes the view uses; which index a view
uses can change from statement to statement based on how the query is
optimized. For example, given:

```
splice> CREATE TABLE T1 (C1 DOUBLE PRECISION);
0 rows inserted/updated/deleted

splice>CREATE FUNCTION SIN (DATA DOUBLE)
   RETURNS DOUBLE
   EXTERNAL NAME 'java.lang.Math.sin'
   LANGUAGE JAVA PARAMETER STYLE JAVA;
0 rows inserted/updated/deleted

splice> CREATE VIEW V1 (C1) AS SELECT SIN(C1) FROM T1;
0 rows inserted/updated/deleted
```
{: .Example}

The following `SELECT`:
{: .spaceAbove}

```
SELECT * FROM V1;
```
{: .Example}

Is dependent on view *V1*, table *T1,* and external scalar function
*SIN.*

## See Also

* [`DROP VIEW`](sqlref_statements_dropview.html) statement
* [`ORDER BY`](sqlref_clauses_orderby.html) clause

</div>
</section>
