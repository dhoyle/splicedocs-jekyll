---
title: UNPIN TABLE statement
summary: Unpins a pinned table.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_unpintable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# UNPIN TABLE

The `UNPIN TABLE` statement unpins a table, which means that the pinned
(previously cached) version of the table no longer exists.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
UNPIN TABLE <a href="sqlref_identifiers_types.html#TableName">table-Name</a></pre>

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
    2           Two
    2 rows selected
    splice> PIN TABLE myTbl;
    0 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl --splice-properties pin=true
    > ;
    COL 1      |COL2
    ---------------------
    1           One
    2           Two
    2 rows selected
    splice> UNPIN TABLE myTbl;splice> SELECT * FROM myTbl;
    COL 1      |COL2
    ---------------------
    1           One
    2           Two
    2 rows selected
    splice> SELECT * FROM myTbl --splice-properties pin=true
    > ERROR: Pinned table read failed with exception 'Table or view not found in database'
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE EXTERNAL TABLE`](sqlref_statements_createexternaltable.html) statement
* [`CREATE TABLE`](sqlref_statements_createtable.html) statement
* [`PIN TABLE`](sqlref_statements_pintable.html) statement
* [Using Hints to Improve Performance](bestpractices_optimizer_hints.html)

</div>
</section>
