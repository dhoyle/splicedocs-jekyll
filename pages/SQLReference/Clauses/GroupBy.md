---
title: GROUP BY clause
summary: A clause that is part of a Select Expression that groups a result into subsets that have matching values for one or more columns.
keywords: grouping results, SelectExpression, ROLLUP
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_groupby.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# GROUP BY

A `GROUP BY` clause is part of a
*[SelectExpression](sqlref_expressions_select.html),* that groups a
result into subsets that have matching values for one or more columns.
In each group, no two rows have the same value for the grouping column
or columns. NULLs are considered equivalent for grouping purposes.

You typically use a `GROUP BY` clause in conjunction with an aggregate
expression.

Using the `ROLLUP` syntax, you can specify that multiple levels of
grouping should be computed at once.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
GROUP BY
  {
  <a href="sqlref_identifiers_types.html#ColumnNameOrPosn">column-Name-or-Position</a> ]*  |
  ROLLUP ( <a href="sqlref_identifiers_types.html#ColumnNameOrPosn">column-Name-or-Position</a>
       [ , <a href="sqlref_identifiers_types.html#ColumnNameOrPosn">column-Name-or-Position</a> ]* )
  }</pre>

</div>
<div class="paramList" markdown="1">
column-Name-or-Position
{: .paramName}

Must be either the name or position of a column from the current scope
of the query; there can be no columns from a query block outside the
current scope. For example, if a `GROUP BY` clause is in a subquery, it
cannot refer to columns in the outer query.
{: .paramDefnFirst}

</div>
## Usage Notes

*SelectItems* in the
*[SelectExpression](sqlref_expressions_select.html)* with a `GROUP BY`
clause must contain only aggregates or grouping columns.

## Examples

#### Create our Test Table:

<div class="preWrapperWide" markdown="1">
    CREATE TABLE Test1
    (
        TRACK_SEQ VARCHAR(40),
        TRACK_CD VARCHAR(18),
        REC_SEQ_NBR BIGINT,
        INDIV_ID BIGINT,
        BIZ_ID BIGINT,
        ADDR_ID BIGINT,
        HH_ID BIGINT,
        TRIAD_CB_DT DATE
    );
{: .Example}

</div>
#### Populate our Test Table:

<div class="preWrapperWide" markdown="1">
    CREATE TABLE Test1
    INSERT INTO Test1 VALUES
        ('1','A',1,1,1,1,1,'2017-07-01'),
        ('1','A',1,1,2,2,2,'2017-07-02'),
        ('3','C',3,1,3,3,3,'2017-07-03'),
        ('1','A',1,2,1,1,1,'2017-07-01'),
        ('1','A',1,2,2,2,2,'2017-07-02'),
        ('3','C',3,2,3,3,3,'2017-07-03');
{: .Example}

</div>
#### Example: Query Using Column Names:

<div class="preWrapperWide" markdown="1">
    SELECT indiv_id, track_seq, rec_seq_nbr, triad_cb_dt, ROW_NUMBER()
    OVER (PARTITION BY indiv_id ORDER BY triad_cb_dt desc,rec_seq_nbr desc) AS ranking
    FROM Test1
    GROUP BY indiv_id,track_seq,rec_seq_nbr,triad_cb_dt;
    INDIV_ID |TRACK_SEQ |REC_SEQ_NBR |TRIAD_CB_&|RANKING
    ---------------------------------------------------------
    1        |1         |1           |2017-07-01|3
    1        |1         |1           |2017-07-02|2
    1        |3         |3           |2017-07-03|1
    2        |1         |1           |2017-07-01|3
    2        |1         |1           |2017-07-02|2
    2        |3         |3           |2017-07-03|1
    6 rows selected
{: .Example}

</div>
#### Example: Query Using Column Positions:

<div class="preWrapperWide" markdown="1">
    SELECT indiv_id, track_seq, rec_seq_nbr, triad_cb_dt, ROW_NUMBER()
    OVER (PARTITION BY indiv_id ORDER BY triad_cb_dt desc,rec_seq_nbr desc) AS ranking
    FROM Test1
    GROUP BY 1,2,3,4;
    INDIV_ID |TRACK_SEQ |REC_SEQ_NBR |TRIAD_CB_&|RANKING
    ---------------------------------------------------------
    1        |1         |1           |2017-07-01|3
    1        |1         |1           |2017-07-02|2
    1        |3         |3           |2017-07-03|1
    2        |1         |1           |2017-07-01|3
    2        |1         |1           |2017-07-02|2
    2        |3         |3           |2017-07-03|1
    6 rows selected
{: .Example}

</div>
## See Also

* [`SELECT`](sqlref_expressions_select.html) expression

</div>
</section>
