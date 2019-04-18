---
title: TOP n clause
summary: A clause that limits the number of results returned by a query.
keywords: limiting results
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_topn.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TOP n

A `TOP` clause, also called the `TOP n` clause, limits the results of a
query to the first `n` result records.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
TOP [number] <a href="sqlref_identifiers_types.html#ColumnName">column-Name</a>]*</pre>

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

Optional. An integer value that specifies the maximum number of rows to
return from the query. If you omit this parameter, the default value of
1 is used.
{: .paramDefnFirst}

column-Name
{: .paramName}

A column name, as described in the &nbsp;[`Column
Name`](sqlref_identifiers_types.html#ColumnName) topic.
{: .paramDefnFirst}

You can specify `*` as the column name to represent all columns.
{: .paramDefn}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> select * from toptest order by a;
    A  |B  |C  |D
    --------------------------------------------------------------------------------
    a1 |b1 |c1 |d1
    a2 |b2 |c2 |d2
    a3 |b3 |c3 |d3
    a4 |b4 |c4 |d4
    a5 |b5 |c5 |d5
    a6 |b6 |c6 |d6
    a7 |b7 |c7 |d7
    a8 |b8 |c8 |d8
    8 rows selected

    splice> select top * from toptest order by a;
    A |B |C |D
    --------------------------------------------------------------------------------
    a1 |b1 |c1 |d1
    1 row selected


    splice> select top 3 a, b, c from toptest order by a;
    A  |B  |C
    --------------------------------------------------------------------------------
    a1 |b1 |c1
    a2 |b2 |c2
    a3 |b3 |c3
    3 rows selected


    splice> select top 10 a, b from toptest order by a;
    A  |B
    --------------------------------------------------------------------------------
    a1 |b1
    a2 |b2
    a3 |b3
    a4 |b4
    a5 |b5
    a6 |b6
    a7 |b7
    a8 |b8
    8 rows selected

    splice> select top 4 * from toptest order by a offset 1 row;
    A |B |C |D
    --------------------------------------------------------------------------------
    a2 |b2 |c2 |d2
    a3 |b3 |c3 |d3
    a4 |b4 |c4 |d4
    a5 |b5 |c5 |d5
    4 rows selected

    splice> select top 4 * from toptest order by a offset 2 row;
    A |B |C |D
    --------------------------------------------------------------------------------
    a3 |b3 |c3 |d3
    a4 |b4 |c4 |d4
    a5 |b5 |c5 |d5
    a6 |b6 |c6 |d6
    4 rows selected

    splice> select top 4 * from toptest order by a offset -1 row ;
    ERROR 2201X: Invalid row count for OFFSET, must be >= 0.


    splice> select top 4 * from toptest order by a offset 10 row;
    A |B |C |D
    --------------------------------------------------------------------------------
    0 rows selected
    splice> select top -1 * from toptest;
    ERROR 2201W: Row count for FIRST/NEXT/TOP must be >= 1 and row count for LIMIT must be >= 0.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`LIMIT n`](sqlref_clauses_limitn.html) clause
* [`RESULT OFFSET`](sqlref_clauses_resultoffset.html) clause
* [`SELECT`](sqlref_expressions_select.html) expression

</div>
</section>
