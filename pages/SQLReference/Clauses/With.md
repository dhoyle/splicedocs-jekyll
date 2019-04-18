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
   AS SELECT Query</pre>

</div>
<div class="paramList" markdown="1">
queryName
{: .paramName}

An identifier that names the subquery clause.
{: .paramDefnFirst}

</div>
## Restrictions

You cannot currently use a temporary table in a `WITH` clause. This is
being addressed in a future release of Splice Machine.
{: .body}

## Examples

If we create the following table:
{: .body}

<div class="preWrapperWide" markdown="1">
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
{: .Example}

</div>
We can then use a common table expression to improve the readability of
a statement that finds the per-city total assets and income for the
states with the top net income:
{: .body}

<div class="preWrapperWide" markdown="1">
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
{: .Example}

</div>
## See Also

* [`SELECT`](sqlref_expressions_select.html) expression
* [`Query`](sqlref_queries_query.html) 

<div class="hiddenText">
WITH
</div>
</div>
</section>
