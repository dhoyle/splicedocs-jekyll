---
title: FROM clause
summary: A&#160;clause in a Select Expression that specifies the tables from which the other clauses of the query can access columns for use in expressions.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
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

<div class="fcnWrapperWide" markdown="1">
    FROM TableExpression [ , TableExpression ] *
{: .FcnSyntax}

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
      FROM SYS.SYSTABLES T, SYS.SYSCONGLOMERATES C
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
## See Also

* [`SELECT`](sqlref_expressions_select.html) expression
* [`TABLE`](sqlref_expressions_table.html) expression

</div>
</section>

