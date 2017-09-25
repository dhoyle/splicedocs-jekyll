---
title: CREATE INDEX statement
summary: Creates an index on a table.
keywords: creating index, primary key, unique
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createindex.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE INDEX   {#Statements.CreateIndex}

A `CREATE INDEX` statement creates an index on a table. Indexes can be
on one or more columns in the table.

 

If an index to be created has the same index columns with an existing
index, then the index will not be created. For example, if an index idx
has been created on table t(col1, col2), and a user run the following
SQL

create index idx2 on t(col1, col2)

idx2 will not be created.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CREATE [UNIQUE] INDEX indexName
       ON tableName(
          simpleColumnName
          [ ASC  | DESC ]
          [ , simpleColumnName [ ASC | DESC ]] *
         )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
indexName
{: .paramName}

An identifier, the length of which cannot exceed 128 characters.
{: .paramDefnFirst}

tableName
{: .paramName}

A table name, which can optionally be qualified by a schema name.
{: .paramDefnFirst}

simpleColumnName
{: .paramName}

A simple column name.
{: .paramDefnFirst}

You cannot use the same column name more than once in a single `CREATE
INDEX` statement. Note, however, that a single column name can be used
in multiple indexes.
{: .paramDefn}

</div>
## Usage

Splice Machine can use indexes to improve the performance of data
manipulation statements. In addition, `UNIQUE` indexes provide a form of
data integrity checking.

**Index names are unique within a schema**. (Some database systems allow
different tables in a single schema to have indexes of the same name,
but Splice Machine does not.) Both index and table are assumed to be in
the same schema if a schema name is specified for one of the names, but
not the other. If schema names are specified for both index and table,
an exception will be thrown if the schema names are not the same. If no
schema name is specified for either table or index, the current schema
is used.

You cannot create an index that has the same index columns as an
existing index; if you attempt to do so, Splice Machine issues a warning
and does not create the index, as you can see in this example:

<div class="preWrapperWide" markdown="1">
    splice> CREATE INDEX idx1 ON myTable(id, eventType);
    0 rows inserted/updated/deleted
    splice> CREATE INDEX idx2 ON myTable(id, eventType);
    WARNING 01504: The new index is a duplicate of an existing index: idx1.
    splice> DROP INDEX idx2;
    ERROR 42X65: Index 'idx2' does not exist.
{: .Example}

</div>
By default, Splice Machine uses the ascending order of each column to
create the index. Specifying `ASC` after the column name does not alter
the default behavior. <span>The `DESC` keyword after the column name
causes Splice Machine to use descending order for the column to create
the index. Using the descending order for a column can help improve the
performance of queries that require the results in mixed sort order or
descending order and for queries that select the minimum or maximum
value of an indexed column.</span>

If a qualified index name is specified, the schema name cannot begin
with `SYS`.

## Indexes and constraints

Unique and primary key constraints generate indexes that enforce or
"back" the constraint (and are thus sometimes called *backing indexes*).
If a column or set of columns has a `UNIQUE` or `PRIMARY KEY` constraint
on it, you can not create an index on those columns.

Splice Machine has already created it for you with a system-generated
name. System-generated names for indexes that back up constraints are
easy to find by querying the system tables if you name your constraint.
Adding a `PRIMARY KEY` or `UNIQUE` constraint when an existing `UNIQUE`
index exists on the same set of columns will result in two physical
indexes on the table for the same set of columns. One index is the
original `UNIQUE` index and one is the backing index for the new
constraint.

## Statement Dependency System

Prepared statements that involve `SELECT, INSERT, UPDATE`, and `DELETE`
on the table referenced by the `CREATE INDEX` statement are invalidated
when the index is created.

## Example

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable (ID INT NOT NULL, NAME VARCHAR(32) NOT NULL );
    0 rows inserted/updated/deleted
    
    splice> CREATE INDEX myIdx ON myTable(ID);
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DELETE`](sqlref_statements_delete.html) statement
* [`DROP INDEX`](sqlref_statements_dropindex.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>

