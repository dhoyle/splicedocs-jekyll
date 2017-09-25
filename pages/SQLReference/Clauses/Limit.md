---
title: LIMIT clause
summary: A clause that  limits the number of results returned by a query and supports an offset to retrieve a specific range of records.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_limitn.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LIMIT n 

A `LIMIT n` clause, limits the results of a query to a specified number
of records.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    '{' LIMIT {count} '}'
{: .FcnSyntax xml:space="preserve"}

</div>
You must surround the `LIMIT` clause with left  and right curly brackets
(`{` and `}`).
{: .noteNote}

<div class="paramList" markdown="1">
count
{: .paramName}

An integer value specifying the maximum number of rows to return from
the query.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> select * from limittest order by a;
    A |B |C |D
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
    
    splice> select * from limittest order by a {LIMIT 1};
    A |B |C |D
    --------------------------------------------------------------------------------
    a1 |b1 |c1 |d1
    1 row selected
    
    
    splice> select * from limittest order by a {LIMIT 3};
    A |B |C |D
    --------------------------------------------------------------------------------
    a1 |b1 |c1 |d1
    a2 |b2 |c2 |d2
    a3 |b3 |c3 |d3
    3 rows selected
    
    
    splice> select * from limittest order by a {LIMIT 10};
    A |B |C |D
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
{: .Example xml:space="preserve"}

</div>
## See Also

* [`RESULT OFFSET`](sqlref_clauses_resultoffset.html) clause
* [`SELECT`](sqlref_expressions_select.html) expression
* [`TOP n`](sqlref_clauses_topn.html) clause

</div>
</section>

