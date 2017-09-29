---
title: CROSS JOIN
summary: Join operation that roduces the Cartesian product of two tables:&#160;it produces rows that combine each row from the first table with each row from the second table.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_joinops_crossjoin.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CROSS JOIN

A `CROSS JOIN` is a &nbsp;[`JOIN` operation](sqlref_joinops_about.html) that
produces the Cartesian product of two tables. Unlike other `JOIN`
operators, it does not let you specify a join clause. You may, however,
specify a `WHERE` clause in the `SELECT` statement.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TableExpression CROSS JOIN {
        TableExpression )
    }
{: .FcnSyntax xml:space="preserve"}

</div>
## Examples

The following `SELECT` statements are equivalent:

<div class="preWrapper" markdown="1">
    splice> SELECT * FROM CITIES CROSS JOIN FLIGHTS;

    splice> SELECT * FROM CITIES, FLIGHTS;
{: .Example xml:space="preserve"}

</div>
The following `SELECT` statements are equivalent:

<div class="preWrapper" markdown="1">
    splice> SELECT * FROM CITIES CROSS JOIN FLIGHTS
       WHERE CITIES.AIRPORT = FLIGHTS.ORIG_AIRPORT;

    splice> SELECT * FROM CITIES INNER JOIN FLIGHTS
        ON CITIES.AIRPORT = FLIGHTS.ORIG_AIRPORT;
{: .Example xml:space="preserve"}

</div>
The following example is more complex. The `ON` clause in this example
is associated with the `LEFT OUTER JOIN` operation. Note that you can
use parentheses around a `JOIN` operation.

<div class="preWrapper" markdown="1">
    splice> SELECT * FROM CITIES LEFT OUTER JOIN
      (FLIGHTS CROSS JOIN COUNTRIES)
      ON CITIES.AIRPORT = FLIGHTS.ORIG_AIRPORT
      WHERE COUNTRIES.COUNTRY_ISO_CODE = 'US';
{: .Example xml:space="preserve"}

</div>
A `CROSS JOIN` operation can be replaced with an `INNER JOIN` where the
join clause always evaluates to true (for example, `1=1`). It can also
be replaced with a sub-query. So equivalent queries would be:

<div class="preWrapper" markdown="1">
    splice> SELECT * FROM CITIES LEFT OUTER JOIN
      FLIGHTS INNER JOIN COUNTRIES ON 1=1
      ON CITIES.AIRPORT = FLIGHTS.ORIG_AIRPORT
      WHERE COUNTRIES.COUNTRY_ISO_CODE = 'US';

    splice> SELECT * FROM CITIES LEFT OUTER JOIN
      (SELECT * FROM FLIGHTS, COUNTRIES) S
      ON CITIES.AIRPORT = S.ORIG_AIRPORT
      WHERE S.COUNTRY_ISO_CODE = 'US';
{: .Example xml:space="preserve"}

</div>
## See Also

* [JOIN operations](sqlref_joinops_intro.html)
* [`USING`](sqlref_clauses_using.html) clause

</div>
</section>
