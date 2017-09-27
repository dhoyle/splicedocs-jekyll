---
title: CREATE VIEW statement
summary: Creates a view, which is a virtual table formed by a query.
keywords: creating a view
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createview.html
folder: SQLReference/Statements
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE VIEW   {#Statements.CreateView}

Views are virtual tables formed by a query. A view is a dictionary
object that you can use until you drop it. Views are not updatable.

If a qualified view name is specified, the schema name cannot begin with
*SYS*.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    
    CREATE VIEW view-Name
       [ ( Simple-column-Name] * ) ]
       AS ORDER BY clause ]
         [ RESULT OFFSET clause ]
         [ FETCH FIRST clause ] 
{: .FcnSyntax xml:space="preserve"}

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

AS Query [ORDER BY clause]
{: .paramName}

A `SELECT` or `VALUES` command that provides the columns and rows of the
view.
{: .paramDefnFirst}

result offset and fetch first clauses
{: .paramName}

The [`FETCH FIRST` clause](sqlref_clauses_resultoffset.html), which can
be combined with the `RESULT OFFSET` clause, limits the number of rows
added to the view.
{: .paramDefnFirst}

</div>
## Examples

This example creates a view that shows the age of each player in our
database:
{: .body}

<div class="preWrapperWide" markdown="1">
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
{: .Example xml:space="preserve"}

</div>
## Statement Dependency System

View definitions are dependent on the tables and views referenced within
the view definition. DML (data manipulation language) statements that
contain view references depend on those views, as well as the objects in
the view definitions that the views are dependent on. Statements that
reference the view depend on indexes the view uses; which index a view
uses can change from statement to statement based on how the query is
optimized. For example, given:

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE T1 (C1 DOUBLE PRECISION);
    0 rows inserted/updated/deleted
    
    splice>CREATE FUNCTION SIN (DATA DOUBLE)
       RETURNS DOUBLE
       EXTERNAL NAME 'java.lang.Math.sin'
       LANGUAGE JAVA PARAMETER STYLE JAVA;
    0 rows inserted/updated/deleted
    
    splice> CREATE VIEW V1 (C1) AS SELECT SIN(C1) FROM T1;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
The following `SELECT`:

<div class="preWrapper" markdown="1">
    SELECT * FROM V1;
{: .Example xml:space="preserve"}

</div>
Is dependent on view *V1*, table *T1,* and external scalar function
*SIN.*

## See Also

* [`DROP VIEW`](sqlref_statements_dropview.html) statement
* [`ORDER BY`](sqlref_clauses_orderby.html) clause

</div>
</section>

