---
title: Examples of Using Splice Machine's Explain Plan
summary: Presents examples of output from using the Splice Machine Explain Plan features.
keywords: explain plan
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_tuning_explainplan_examples.html
folder: DeveloperTopics/TuningAndDebugging
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Explain Plan Examples

This topic contains the following examples of using the `explain`
command to display the execution plan for a statement, including the
following examples:

* [TableScan Examples](#TableSca)
* [IndexScan Examples](#IndexSca)
* [Projection and Restriction Examples](#Projecti)
* [Index Lookup](#Index)
* [Join Example](#Join)
* [Union Example](#Union)
* [Order By Example](#Order)
* [Aggregation Operation Examples](#Aggregat)
* [Subquery Example](#Subquery)

The format and meaning of the common fields in the output plans shown
here is found in the previous topic, [About Explain
Plan](developers_tuning_explainplan.html).
{: .noteIcon}

## TableScan Examples   {#TableSca}

This example show a plan for a `TableScan` operation that has no
qualifiers, known as a *raw scan*:

<div class="preWrapperWide" markdown="1">
    splice> explain select * from sys.systables;Plan
    -------------------------------------------------------------------------------------------------
    Cursor(n=3,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=2,totalCost=8.594,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
        ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
    
    3 rows selected
{: .AppCommand xml:space="preserve"}

</div>
This example show a plan for a `TableScan` operation that does have
qualifiers::

<div class="preWrapperWide" markdown="1">
    splice> explain select * from sys.systables --SPLICE-PROPERTIES index=NULL   where tablename='SYSTABLES';Plan
    -------------------------------------------------------------------------------------------------Cursor(n=3,rows=18,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=2,totalCost=8.54,outputRows=18,outputHeapSize=2.988 KB,partitions=1)
        ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=18,outputHeapSize=2.988 KB,partitions=1,preds=[(TABLENAME[0:2] = SYSTABLES)])
    
    3 rows selected
{: .AppCommand}

</div>
### Nodes

* The plan labels this operation as
  `TableScan[`*tableId*(*conglomerateId*)`]`:
  
  * *tableId* is the name of the table, in the form `schemaName '.'
    tableName`.
  * *conglomerateId* is an ID that is unique to every HBase table; this
    value is used internally, and can be used for certain administrative
    tasks
  {: .SecondLevel}

* The `preds` field includes qualifiers that were pushed down to the
  base table.

## IndexScan Examples   {#IndexSca}

This example show a plan for an `IndexScan` operation that has no
predicates:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename from sys.systables; --covering index
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=3,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=2,totalCost=8.31,outputRows=20,outputHeapSize=560 B,partitions=1)
        ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=560 B,partitions=1,baseTable=SYSTABLES(32))
    
    3 rows selected
{: .AppCommand xml:space="preserve"}

</div>
This example shows a plan for an `IndexScan` operation that contains
predicates:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename from sys.systables --SPLICE-PROPERTIES index=SYSTABLES_INDEX1
            where tablename = 'SYSTABLES';
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=3,rows=18,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=2,totalCost=8.272,outputRows=18,outputHeapSize=432 B,partitions=1)
        ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.049,outputRows=18,outputHeapSize=432 B,partitions=1,baseTable=SYSTABLES(48),preds=[(TABLENAME[0:1] = SYSTABLES)])
    
    3 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The plan labels this operation as
  `IndexScan[`*indexId(conglomerateId)*`]`:
  
  * *indexId* is the name of the index
  * *conglomerateId* is an ID that is unique to every HBase table; this
    value is used internally, and can be used for certain administrative
    tasks
  {: .SecondLevel}

* The `preds` field includes qualifiers that were pushed down to the
  base table.

## Projection and Restriction Examples   {#Projecti}

This example show a plan for a `Projection` operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename || 'hello' from sys.systables;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=4,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=3,totalCost=8.302,outputRows=20,outputHeapSize=480 B,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))
    
    4 rows selected
{: .AppCommand xml:space="preserve"}

</div>
This example shows a plan for a `Restriction` operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename from sys.systables
            where tablename like '%SYS%';
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=4,rows=10,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=3,totalCost=8.178,outputRows=10,outputHeapSize=240 B,partitions=1)
        ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=10,outputHeapSize=240 B,partitions=1,preds=[like(TABLENAME[0:1], %SYS%)])
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=240 B,partitions=1,baseTable=SYSTABLES(48))
    
    4 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The plan labels both projection and restriction operations as
  `ProjectRestrict`. which can contain both *projections* and
  *non-qualifier restrictions*. A *non-qualifier restriction* is a
  predicate that cannot be pushed to the underlying table scan.

## Index Lookup   {#Index}

This example shows a plan for an `IndexLookup` operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select * from SYS.SYSTABLES --SPLICE-PROPERTIES index=SYSTABLES_INDEX1
    where tablename = 'SYSTABLES';;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=4,rows=18,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=3,totalCost=177.265,outputRows=18,outputHeapSize=921.586 KB,partitions=1)
        ->  IndexLookup(n=2,totalCost=78.715,outputRows=18,outputHeapSize=921.586 KB,partitions=1)
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=6.715,outputRows=18,outputHeapSize=921.586 KB,partitions=1,baseTable=SYSTABLES(48),preds=[(TABLENAME[1:2] = SYSTABLES)])
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The plan labels the operation as `IndexLookup`; you may see this
  labeled as an `IndexToBaseRow` operation elsewhere.
* Plans for `IndexLookup` operations do not contain any special fields.

## Join Example   {#Join}

This example shows a plan for a `Join` operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select * from sys.systables t, sys.sysschemas s
            where t.schemaid =s.schemaid;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=5,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=4,totalCost=21.728,outputRows=20,outputHeapSize=6.641 KB,partitions=1)
        ->  BroadcastJoin(n=3,totalCost=12.648,outputRows=20,outputHeapSize=6.641 KB,partitions=1,preds=[(T.SCHEMAID[4:4] = S.SCHEMAID[4:8])])
          ->  TableScan[SYSSCHEMAS(32)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=6.641 KB,partitions=1)
          ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
    
    5 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The plan labels the operation using the *join type* followed by
  `Join`; the possible values are:
  
  * {: .CodeFont value="1"} BroadcastJoin
  * {: .CodeFont value="2"} MergeJoin
  * {: .CodeFont value="3"} MergeSortJoin
  * {: .CodeFont value="4"} NestedLoopJoin
  * {: .CodeFont value="5"} OuterJoin
  {: .SecondLevel}

* The plan may include a `preds` field, which lists the join predicates.
* `NestedLoopJoin` operations do not include a `preds` field; instead,
  the predicates are listed in either a `ProjectRestrict` or in the
  underlying scan.
* The right side of the *Join* operation is listed first, followed by
  the left side of the join.

### Outer Joins

An *outer join* does not display it as a separate strategy in the plan;
instead, it is treated a *postfix* for the strategy that's used. For
example, if you are using a Broadcast join, and it's a left outer join,
then you'll see `BroadcastLeftOuterJoin`. Here's an example:

<div class="preWrapperWide" markdown="1">
    explain select s.schemaname,t.tablename from sys.sysschemas s left outer join sys.systables t
    > on s.schemaid = t.schemaid;
    Plan
    -------------------------------------------------------------------------------------------------
    Cursor(n=6,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=5,totalCost=348.691,outputRows=20,outputHeapSize=2 MB,partitions=1)
        ->  ProjectRestrict(n=4,totalCost=130.579,outputRows=20,outputHeapSize=2 MB,partitions=1)
          ->  BroadcastLeftOuterJoin(n=3,totalCost=130.579,outputRows=20,outputHeapSize=2 MB,partitions=1,preds=[(S.SCHEMAID[4:1] = T.SCHEMAID[4:4])])
            ->  IndexScan[SYSTABLES_INDEX1(145)](n=2,totalCost=7.017,outputRows=20,outputHeapSize=2 MB,partitions=1,baseTable=SYSTABLES(48))
            ->  TableScan[SYSSCHEMAS(32)](n=1,totalCost=7.516,outputRows=20,outputHeapSize=1023.984 KB,partitions=1)
{: .AppCommand xml:space="preserve"}

</div>
## Union Example   {#Union}

This example shows a plan for a `Union` operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename from sys.systables t union all select schemaname from sys.sysschemas;
    
    Plan
    -------------------------------------------------------------------------------------------------
    Cursor(n=5,rows=40,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=4,totalCost=16.668,outputRows=40,outputHeapSize=1.094 KB,partitions=1)
        ->  Union(n=3,totalCost=12.356,outputRows=40,outputHeapSize=1.094 KB,partitions=1)
          ->  IndexScan[SYSSCHEMAS_INDEX1(209)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=1.094 KB,partitions=1,baseTable=SYSSCHEMAS(32))
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))
    
    5 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The right side of the `Union` is listed first, followed by the left
  side of the union,

## Order By Example   {#Order}

This example shows a plan for an order by operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename from sys.systables order by tablename desc;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=4,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=3,totalCost=16.604,outputRows=20,outputHeapSize=480 B,partitions=1)
        ->  OrderBy(n=2,totalCost=12.356,outputRows=20,outputHeapSize=480 B,partitions=1)
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))
    
    4 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The plan labels this operation as `OrderBy`.

## Aggregation Operation Examples   {#Aggregat}

This example show a plan for a grouped aggregate operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename, count(*) from sys.systables group by tablename;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=6,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=5,totalCost=12.568,outputRows=20,outputHeapSize=480 B,partitions=16)
        ->  ProjectRestrict(n=4,totalCost=8.32,outputRows=20,outputHeapSize=480 B,partitions=16)
          ->  GroupBy(n=3,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
            ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
              ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))
    
    6 rows selected)
{: .AppCommand xml:space="preserve"}

</div>
This example shows a plan for a scalar aggregate operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select count(*) from sys.systables;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=6,rows=1,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=5,totalCost=8.797,outputRows=1,outputHeapSize=0 B,partitions=1)
        ->  ProjectRestrict(n=4,totalCost=4.257,outputRows=1,outputHeapSize=0 B,partitions=1)
          ->  GroupBy(n=3,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
            ->  ProjectRestrict(n=2,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
              ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1,baseTable=SYSTABLES(48))
    
    6 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* The plan labels both grouped and scaled aggregate operations as
  `GroupBy`.

## Subquery Example   {#Subquery}

This example shows a plan for a `SubQuery` operation:

<div class="preWrapperWide" markdown="1">
    splice> explain select tablename, (select tablename from sys.systables t2 where t2.tablename = t.tablename)from sys.systables t;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=6,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=5,totalCost=8.302,outputRows=20,outputHeapSize=480 B,partitions=1)
        ->  ProjectRestrict(n=4,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1)
          ->  Subquery(n=3,totalCost=12.55,outputRows=20,outputHeapSize=480 B,partitions=1,correlated=true,expression=true,invariant=true)
            ->  IndexScan[SYSTABLES_INDEX1(145)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48),preds=[(T2.TABLENAME[0:1] = T.TABLENAME[4:1])])
          ->  IndexScan[SYSTABLES_INDEX1(145)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=480 B,partitions=1,baseTable=SYSTABLES(48))
    
    6 rows selected
{: .AppCommand xml:space="preserve"}

</div>
### Nodes

* Subqueries are listed as a second query tree, whose starting
  indentation level is the same as the `ProjectRestrict` operation that
  *owns* the subquery.
* Includes a *correlated* field, which specifies whether or not the
  query is treated as correlated or uncorrelated.
* Includes an *expression* field, which specifies whether or not the
  subquery is an expression.
* Includes an *invariant* field, which indicates whether the subquery is
  invariant.

## See Also

* [About Explain Plan](developers_tuning_explainplan.html)

</div>
</section>

