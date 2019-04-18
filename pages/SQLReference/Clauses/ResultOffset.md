---
title: RESULT OFFSET and FETCH FIRST clauses
summary: Clauses that provides a way to skip the N  first rows in a result set before starting to return any  rows and/or to limit the number of rows returned in the result set.
keywords: skipping rows in result set
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_resultoffset.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RESULT OFFSET and FETCH FIRST

The *result offset clause* provides a way to skip the N first rows in a
result set before starting to return any rows.

The *fetch first clause*, which can be combined with the *result offset
clause*, limits the number of rows returned in the result set. The
*fetch first clause* can sometimes be useful for retrieving only a few
rows from an otherwise large result set, usually in combination with an
`ORDER BY` clause. Use of this clause can increase efficienty and make
programming simpler.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    OFFSET { integer-literal | ? }
           {ROW | ROWS}
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
integer-literal
{: .paramName}

An integer value that specifies the number of rows to skip. The default
value is `0`.
{: .paramDefnFirst}

If non-zero, this must be a positive integer value. If you specify a
value greater than the number of rows in the underlying result set, no
rows are returned.
{: .paramDefn}

 
{: .paramDefnFirst}

</div>
<div class="fcnWrapperWide" markdown="1">
    FETCH { FIRST | NEXT }
       [integer-literal | ? ]
       {ROW | ROWS} ONLY
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
integer-literal
{: .paramName}

An integer value that specifies the maximum number of rows to return in
the result set. The default value is `1`.
{: .paramDefnFirst}

This must be a positive integer value greater than or equal to `1`.
{: .paramDefn}

</div>
## Usage

Note that:

* `ROW` and `ROWS` are synonymous
* `FIRST` and `NEXT` are synonymous

Be sure to specify the `ORDER BY` clause if you expect to retrieve a
sorted result set.

## Examples

<div class="preWrapperWide" markdown="1">
       -- Fetch the first row of T
    SELECT * FROM T FETCH FIRST ROW ONLY;
    
       -- Sort T using column I, then fetch rows 11 through 20
       --   of the sorted rows (inclusive)
    SELECT * FROM T ORDER BY I
             OFFSET 10 ROWS
             FETCH NEXT 10 ROWS ONLY;
    
       -- Skip the first 100 rows of T
       -- If the table has fewer than 101 records,
       --   an empty result set is returned
    SELECT * FROM T OFFSET 100 ROWS;
    
       -- Use of ORDER BY and FETCH FIRST in a subquery
    SELECT DISTINCT A.ORIG_AIRPORT, B.FLIGHT_ID FROM
       (SELECT FLIGHT_ID, ORIG_AIRPORT
           FROM FLIGHTS
           ORDER BY ORIG_AIRPORT DESC
           FETCH FIRST 40 ROWS ONLY)
        AS A, FLIGHTAVAILABILITY AS B
       WHERE A.FLIGHT_ID = B.FLIGHT_ID;
    
       -- JDBC (using a dynamic parameter):
    PreparedStatement p =
       con.prepareStatement("SELECT * FROM T
                             ORDER BY I
                             OFFSET ? ROWS");
       p.setInt(1, 100);
    ResultSet rs = p.executeQuery();
{: .Example xml:space="preserve"}

</div>
## See Also

* [`LIMIT n`](sqlref_clauses_limitn.html) clause
* [`SELECT`](sqlref_expressions_select.html) statement
* [`TOP n`](sqlref_clauses_topn.html) clause

</div>
</section>

