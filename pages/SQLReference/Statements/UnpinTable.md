---
title: UNPIN TABLE statement
summary: Unpins a pinned table.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_unpintable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# UNPIN TABLE   {#Statements.UnpinTable}

The `UNPIN TABLE` statement unpins a table, which means that the pinned
(previously cached) version of the table no longer exists.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    UNPIN TABLE table-Name
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the pinned table that you want to unpin.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE myTbl (col1 int, col2 varchar(10));
    0 rows inserted/updated/deleted
    splice> INSERT INTO myTbl VALUES (1, 'One'), (2, 'Two');
    2 rows inserted/updated/deleted
    COL 1      |COL2
    ---------------------
    1           One
    2           Two2 rows selectedsplice> PIN TABLE myTbl;
    0 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl --splice-properties pin=true
    > ;
    COL 1      |COL2
    ---------------------
    1           One
    2           Two2 rows selectedsplice> UNPIN TABLE myTbl;splice> SELECT * FROM myTbl;COL 1      |COL2
    ---------------------
    1           One
    2           Two2 rows selectedsplice> SELECT * FROM myTbl --splice-properties pin=true> ERROR: Pinned table read failed with exception 'Table or view not found in database'
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE EXTERNAL TABLE`](sqlref_statements_createexternaltable.html) statement
* [`CREATE TABLE`](sqlref_statements_createtable.html) statement
* [`PIN TABLE`](sqlref_statements_pintable.html) statement
* [Query Optimizations](developers_tuning_queryoptimization.html) in the
  *Splice Machine Developer's Guide*

</div>
</section>

