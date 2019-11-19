---
title: PIN TABLE statement
summary: Pins a table in memory.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_pintable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# PIN TABLE

The `PIN TABLE` statement allows you to pin (cache) a table in memory,
which can improve performance for tables that are being used frequently
in analytic operations.

The pinned version of a table is a static version of that table; updates
to the underlying table are not automatically reflected in the pinned
version. To refresh the pinned version, you need to unpin and then repin
the table, as described in the [Usage Notes](#Usage) section below.
{: .noteImportant}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    PIN TABLE tableName;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
tableName
{: .paramName}

A string that specifies the name of the table that you want to pin in
memory.
{: .paramDefnFirst}

An error occurs if the named table does not exist.
{: .paramDefn}

</div>
## Usage Notes   {#Usage}

Here are a few important notes about using pinned tables:

* [Pinned and Unpinned Table Versions](#Pinned)
* [Refreshing the Pinned Version of a Table](#Refreshi)
* [Unpinning and Dropping Pinned Tables](#Unpinnin)

### Pinned and Unpinned Table Versions   {#Pinned}

Once you pin a table, you effectively have two versions of it to work
with:

* The original table continues to work just as usual
* The pinned version is a static version of the table at the time you
  pinned it. To access the pinned version of a table, you must specify
  the Splice `pin=true` property. If you do not specify this property in
  your query, the query will operate on the unpinned version of the
  table.

The pinned version (version) of a table is statically cached in memory;
this means that:

* Updates to the table (unpinned version) are not automatically
  reflected in the pinned version of the table.
* Updates to the pinned version of the table are not permitted: you
  cannot insert into, delete from, or update the pinned version of a
  table.

Here's a simple example that illustrates these qualities:

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE myTbl (col1 int, col2 varchar(10));
    0 rows inserted/updated/deleted
    splice> INSERT INTO myTbl VALUES (1, 'One'), (2, 'Two');
    2 rows inserted/updated/deleted
    splice> PIN TABLE myTbl;
    0 rows inserted/updated/deleted
    splice> INSERT INTO myTbl VALUES (3, 'Three'), (4, 'Four');
    2 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    COL1      |COL2
    ---------------------
    1           One
    2           Two
    3           Three
    4           Four

    4 rows selected
    splice> SELECT * FROM myTbl --splice-properties pin=true
    > ;
    COL1      |COL2
    ---------------------
    1           One
    2           Two2 rows selectedsplice> UPDATE myTbl SET col1=11 WHERE col1=1;1 row inserted/updated/deletedsplice> UPDATE myTbl --splice-properties pin=trueSET col1=21 WHERE col1=2;ERROR: Pinned Table read failed with exception Table or view not found in database.
{: .Example xml:space="preserve"}

</div>
### Refreshing the Pinned Version of a Table   {#Refreshi}

If you update the table and want the pinned version to reflect those
updates, you need to refresh your pinned table version. You can simply
unpin the table from memory, and then repin it into memory:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> UNPIN TABLE Players;0 rows inserted/updated/deletedsplice> PIN TABLE Players;0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
Now the pinned version of the table matches the original version.
{: .body}

### Unpinning and Dropping Pinned Tables   {#Unpinnin}

When you drop a table (with the
[`DROP TABLE`](sqlref_statements_droptable.html) statement), the pinned
version is automatically deleted and can no longer be used.

To delete just the pinned version of a table, use the
[`UNPIN TABLE`](sqlref_statements_unpintable.html) statement.

## See Also

* [`CREATE EXTERNAL TABLE`](sqlref_statements_createexternaltable.html) statement
* [`CREATE TABLE`](sqlref_statements_createtable.html) statement
* [`UNPIN TABLE`](sqlref_statements_unpintable.html) statement
* [Using Hints to Improve Performance](bestpractices_optimizer_hints.html)

</div>
</section>
