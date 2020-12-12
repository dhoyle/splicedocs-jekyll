---
title: FROM clause
summary: A&#160;clause in a Select Expression that specifies the tables from which the other clauses of the query can access columns for use in expressions.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_from.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# FROM

The `FROM` clause is a mandatory clause in a
*[SelectExpression](sqlref_expressions_select.html).* It specifies the
tables (*[TableExpression](sqlref_expressions_table.html)*) from which
the other clauses of the query can access columns for use in
expressions.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
FROM <a href="sqlref_expressions_table.html">TableExpression</a> [ , <a href="sqlref_expressions_table.html">TableExpression</a> ]*</pre>

</div>
<div class="paramList" markdown="1">
TableExpression
{: .paramName}

Specifies a table, view, or function; it is the source from which a
*[TableExpression](sqlref_expressions_table.html)* selects a result.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapperWide" markdown="1">

    SELECT Cities.city_id
      FROM Cities
      WHERE city_id < 5;

        -- other types of TableExpressions
      SELECT TABLENAME, ISINDEX
      FROM SYSVW.SYSTABLESVIEW T, SYSVW.SYSCONGLOMERATESINSCHEMA C
      WHERE T.TABLEID = C.TABLEID
      ORDER BY TABLENAME, ISINDEX;

        -- force the join order
      SELECT *
      FROM Flights, FlightAvailability
      WHERE FlightAvailability.flight_id = Flights.flight_id
       AND FlightAvailability.segment_number = Flights.segment_number
       AND Flights.flight_id < 'AA1115';

       -- a TableExpression can be a joinOperation. Therefore
       -- you can have multiple join operations in a FROM clause
      SELECT COUNTRIES.COUNTRY, CITIES.CITY_NAME,
    	 FLIGHTS.DEST_AIRPORT
      FROM COUNTRIES LEFT OUTER JOIN CITIES
      ON COUNTRIES.COUNTRY_ISO_CODE = CITIES.COUNTRY_ISO_CODE
      LEFT OUTER JOIN FLIGHTS
      ON Cities.AIRPORT = FLIGHTS.DEST_AIRPORT;
{: .Example xml:space="preserve"}

</div>

## FROM Clause Qualifiers: OLD TABLE, NEW TABLE, FINAL TABLE  {#from-clause-qualifiers}

Applications that modify tables with INSERT, UPDATE, or DELETE statements might require additional processing on the modified rows. To facilitate this processing, you can embed SQL data-change operations in the FROM clause of SELECT and SELECT INTO statements. Within a single unit of work, applications can retrieve a result set containing the modified rows from a table or view modified by an SQL data-change operation.

The modified rows of the table or view targeted by a SQL data-change operation in the FROM clause of a SELECT statement compose an intermediate result table. The intermediate result table includes all the columns of the target table or view, along with any include columns defined in the SQL data-change operation. You can reference all of the columns in an intermediate result table by name in the select list, the ORDER BY clause, or the WHERE clause.

The contents of the intermediate result table are dependent on the qualifier specified in the FROM clause. You must include one of the following FROM clause qualifiers in SELECT statements that retrieve result sets as intermediate result tables.

### OLD TABLE

The rows in the intermediate result table will contain values of the target table rows at the point immediately preceding the execution of before triggers and the SQL data-change operation. The OLD TABLE qualifier applies to UPDATE and DELETE operations.

### NEW TABLE

The rows in the intermediate result table will contain values of the target table rows at the point immediately after the SQL data-change statement has been executed, but before referential integrity evaluation and the firing of any after triggers. The NEW TABLE qualifier applies to UPDATE and INSERT operations.

### FINAL TABLE

This qualifier returns the same intermediate result table as NEW TABLE. In addition, the use of FINAL TABLE guarantees that no after trigger or referential integrity constraint will further modify the target of the UPDATE or INSERT operation. The FINAL TABLE qualifier applies to UPDATE and INSERT operations.

FINAL TABLE guarantees that the returned rows hold the actual final column values that will be added or modified, and that no other trigger will fire during the statement to cause the values to change, or to alter the set of changed rows. If such a trigger fires as part of the SQL statement, the statement is aborted with an error message indicating the name of the trigger that is updating the changed rows.

### Example

<div class="preWrapperWide" markdown="1">

    SELECT * FROM FINAL TABLE (INSERT INTO t1 values (1,1));

</div>

Inside the parentheses we may have any INSERT, UPDATE or DELETE statement. The rows that are inserted, updated, or deleted are returned back to the user as part of the SELECT. There can be a WHERE clause appended at the end, so that only a subset of the changed rows are returned, for example:

<div class="preWrapperWide" markdown="1">

    SELECT * FROM FINAL TABLE (INSERT INTO t1 select * from t2) where c1 > 9;

</div>

* OLD TABLE shows the changed rows before the change is applied.
* NEW TABLE and FINAL TABLE show the changed rows after the change is applied.


## See Also

* [`SELECT`](sqlref_expressions_select.html) expression
* [`TABLE`](sqlref_expressions_table.html) expression

</div>
</section>
