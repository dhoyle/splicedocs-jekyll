---
title: ROWID built-in SQL function (pseudocolumn)
summary: A built-in SQL pseudocolumn that uniquely defines a single row in a database table
keywords: row id, row identity
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_rowid.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ROWID

`ROWID` is a *pseudocolumn* that uniquely defines a single row in a
database table.

The term pseudocolumn is used because you can refer to `ROWID` in the &nbsp;
[`WHERE`](sqlref_clauses_where.html) clauses of a query as you would
refer to a column stored in your database; the difference is you cannot
insert, update, or delete `ROWID` values.

The `ROWID` value for a given row in a table remains the same for the
life of the row, with one exception: the `ROWID` may change if the table
is an index organized table and you change its primary key.

## Syntax   {#Syntax}

<div class="fcnWrapperWide" markdown="1">
    ROWID
{: .FcnSyntax xml:space="preserve"}

</div>
## Usage

You can use a `ROWID` value to refer to a row in a table in the &nbsp; 
[`WHERE`](sqlref_clauses_where.html) clauses of a query. These values
have several valuable uses:

* They are the fastest way to access a single row.
* They are a built-in, unique identifier for every row in a table.
* They provide information about how the rows in a table are stored.

Some important notes about `ROWID` values:

* Do not use `ROWID` as the primary key of a table.
* The `ROWID` of a deleted row can later be reassigned to a new row.
* A `ROWID` value is associated with a table row when the row is
  created.
* `ROWID` values are unique within a table, but not necessarily unique
  within a database.
* If you delete and re-import a row in a table, the `ROWID` may change.
* The `ROWID` value for a row may change if the row is in an index
  organized table and you change the table's primary key.

### Using ROWID with JDBC

You can access `ROWID` with JDBC result sets; for example:

<div class="preWrapper" markdown="1">
    () ResultSet.getRowId(int);
{: .Example xml:space="preserve"}

</div>
You can also use `ROWID` in JDBC queries; for example:

<div class="preWrapper" markdown="1">
    () CallableStatement.setRowId(int, RowId);
    () PreparedStatement.setRowId(int, RowId);
{: .Example xml:space="preserve"}

</div>
## Examples

This statement selects the unique row address and salary of all records
in the employees database in the engineering department:

<div class="preWrapper" markdown="1">
    splice> SELECT ROWID, DisplayName, Position
       FROM Players
       WHERE Team='Giants' and Position='OF';

    ROWID                         |DISPLAYNAME             |POS&
    ------------------------------------------------------------
    89                            |Greg Brown              |OF
    93                            |Jeremy Packman          |OF
    95                            |Jason Pratter           |OF
    99                            |Reed Lister             |OF

    4 rows selected
{: .Example xml:space="preserve"}

</div>
This statement updates column `c` in all rows in which column `b` equals
`10`:

<div class="preWrapperWide" markdown="1">
    UPDATE mytable SET c=100 WHERE rowid=(SELECT rowid FROM mytable WHERE b=10);
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SELECT`](sqlref_expressions_select.html) expression
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>
