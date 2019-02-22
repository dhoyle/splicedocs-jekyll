---
title: CREATE TABLE statement
summary: Creates a new table.
keywords: creating a table, create table as, 'with no data'
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createtable.html
folder: SQLReference/Statements
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE TABLE

A `CREATE TABLE` statement creates a table. Tables contain columns and
constraints, rules to which data must conform. Table-level constraints
specify a column or columns. Columns have a data type and can specify
column constraints (column-level constraints).

The table owner and the database owner automatically gain the following
privileges on the table and are able to grant these privileges to other
users:

* {: .CodeFont value="1"} INSERT
* {: .CodeFont value="2"} SELECT
* {: .CodeFont value="3"} TRIGGER
* {: .CodeFont value="4"} UPDATE

These privileges cannot be revoked from the table and database owners.

Only database and schema owners can use the `CREATE TABLE` statement,
which means that table creation privileges cannot be granted to others.
{: .noteIcon}

For information about constraints, see &nbsp;[`CONSTRAINT`
clause](sqlref_clauses_constraint.html).

You can specify a default value for a column. A default value is the
value to be inserted into a column if no other value is specified. If
not explicitly specified, the default value of a column is `NULL`.

If a qualified table name is specified, the schema name cannot begin
with `SYS`.

<!--
The [PIN TABLE](sqlref_statements_pintable.html) statements are
documented separately in this section.
{: .noteNote}
-->

## Syntax

There are two different variants of the `CREATE TABLE` statement,
depending on whether you are specifying the column definitions and
constraints, or whether you are modeling the columns after the results
of a query expression with the `CREATE TABLE AS` form:

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE TABLE <a href="sqlref_identifiers_types.html#TableName">table-Name</a>
  {
      ( {<a href="sqlref_statements_columndef.html">column-definition</a> |
         <a href="sqlref_clauses_constraint.html#TableConstraint">Table-level constraint</a>}
         [ , {<a href="sqlref_statements_columndef.html">column-definition}</a> ] *
      )
      [ [LOGICAL | PHYSICAL] SPLITKEYS LOCATION filePath]
  |
      [ ( <a href="sqlref_identifiers_types.html#ColumnName">column-name</a> ]* ) ]
      AS query-expression [AS &lt;name&gt;]
      WITH NO DATA
  }</pre>

</div>

<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name to assign to the new table.
{: .paramDefnFirst}

column-definition
{: .paramName}

A column definition.
{: .paramDefnFirst}

The maximum number of columns allowed in a table is
`{{splvar_limit_MaxColumnsInTable}}`.
{: .paramDefn}

Table-level constraint
{: .paramName}

A constraint that applies to the table.
{: .paramDefnFirst}

column-name
{: .paramName}

A column definition.
{: .paramDefnFirst}

filePath
{: .paramName}
You can optionally specify that you want the new table split among regions by supplying a file of split key values. This capability is typically used when you're creating a table into which a table backed up with [`SYSCS_UTIL.SYSCS_BACKUP_TABLE`](#sqlref_sysprocs_backuptable.html) is being restored. Creating a table with pre-defined splits is much faster than creating a table with one region and then splitting it into many regions.
{: .paramDefnFirst}
You can supply either `LOGICAL` (primary key) or `PHYSICAL` (encoded hbase) split keys yourself in a file. See the [Using Split Keys](#splitkeys) section for more information.
{: .paramDefn}
This parameter value is the path to the file that contains the split key values when using non-automatic splitting.
{: .paramDefn}

AS query-expression
{: .paramName}

See the &nbsp;[`CREATE TABLE AS`](#createAs) section below.
{: .paramDefnFirst}

If this select list contains an expression, you must name the result of
the expression. Refer to the final example at the bottom of this topic
page.
{: .paramDefn}

WITH NO DATA
{: .paramName}

See the &nbsp;[`CREATE TABLE AS`](#createAs) section below.
{: .paramDefnFirst}

</div>

### Using Split Keys  {#splitkeys}
You can optionally include a file of split keys for the new table; you can include split keys when you know how the data that is going to be added to the table should be split into regions. This capability is typically used when you're creating a table for restoring a table that was previously backed up using the  [`SYSCS_UTIL.SYSCS_BACKUP_TABLE`](#sqlref_sysprocs_backuptable.html) system procedure.

Creating a table with pre-defined splits is much faster than creating a table with one region and then splitting it into many regions. The split keys file can contain either
 `LOGICAL` or `PHYSICAL` keys:

* Logical keys are the primary key column values that you want to define the splits.
* Physical keys are actual split keys for the HBase table, in encoded HBase format.

## CREATE TABLE ... AS ...    {#createAs}

With this alternate form of the `CREATE TABLE` statement, the column
names and/or the column data types can be specified by providing a
query. The columns in the query result are used as a model for creating
the columns in the new table.

**You cannot include** an `ORDER BY` clause in the query expression you
use in the `CREATE TABLE AS` statement.

If the select list contains an expression, **you must name the result of
the expression**. Refer to the final example at the bottom of this topic
page.
{: .noteNote}

If no column names are specified for the new table, then all the columns
in the result of the query expression are used to create same-named
columns in the new table, of the corresponding data type(s). If one or
more column names are specified for the new table, then the same number
of columns must be present in the result of the query expression; the
data types of those columns are used for the corresponding columns of
the new table.

The `WITH NO DATA` clause specifies that the data rows which result from
evaluating the query expression are not used; only the names and data
types of the columns in the query result are used.

<div class="notePlain" markdown="1">
There is currently a known problem using the `CREATE TABLE AS` form of
the `CREATE TABLE` statement .when the data to be inserted into the new
table results from a `RIGHT OUTER JOIN` operation. For example, the
following statement currently produces a table with all `NULL` values:

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE t3 AS
       SELECT t1.a,t1.b,t2.c,t2.d
       FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c
       WITH DATA;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
There's a simple workaround for now: create the table without inserting
the data, and then insert the data; for example:

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE t3 AS
       SELECT t1.a,t1.b,t2.c,t2.d
       FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c
       WITH NO DATA;
    0 rows inserted/updated/deleted

    splice> INSERT INTO t3
       SELECT t1.a,t1.b,t2.c,t2.d
       FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
</div>

## Examples

This section presents examples of both forms of the
`CREATE TABLE` statement.

### CREATE TABLE

This example creates our Players table:
{: .body}

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE Players(
        ID           SMALLINT NOT NULL PRIMARY KEY,
        Team         VARCHAR(64) NOT NULL,
        Name         VARCHAR(64) NOT NULL,
        Position     CHAR(2),
        DisplayName  VARCHAR(24),
        BirthDate    DATE
        );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

This example includes a table-level primary key definition that includes
two columns:
{: .body}

<div class="preWrapper" markdown="1">

    splice> CREATE TABLE HOTELAVAILABILITY (
       Hotel_ID INT NOT NULL,
       Booking_Date DATE NOT NULL,
       Rooms_Taken INT DEFAULT 0,
       PRIMARY KEY (Hotel_ID, Booking_Date ));
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example assigns an identity column attribute with an initial value
of 5 that increments by 5, and also includes a primary key constraint:
{: .body}

<div class="preWrapper" markdown="1">

    splice> CREATE TABLE PEOPLE (
       Person_ID INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 5, INCREMENT BY 5)
          CONSTRAINT People_PK PRIMARY KEY,
       Person VARCHAR(26) );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

For more examples of `CREATE TABLE` statements using the various
constraints, see &nbsp;[`CONSTRAINT` clause](sqlref_clauses_constraint.html)
{: .noteNote}


### CREATE TABLE with SPLIT KEYS

#### Using Logical Split Keys
This is an example of creating a new table that will be split into regions based on the primary key values in the `lineitemKeys.csv` file:

```
CREATE TABLE LINEITEM (
  L_ORDERKEY      INTEGER NOT NULL,
  L_PARTKEY       INTEGER NOT NULL,
  L_SUPPKEY       INTEGER NOT NULL,
  L_LINENUMBER    INTEGER NOT NULL,
  L_QUANTITY      DECIMAL(15, 2),
  L_EXTENDEDPRICE DECIMAL(15, 2),
  L_DISCOUNT      DECIMAL(15, 2),
  L_TAX           DECIMAL(15, 2),
  L_RETURNFLAG    CHAR(1),
  L_LINESTATUS    CHAR(1),
  L_SHIPDATE      DATE,
  L_COMMITDATE    DATE,
  L_RECEIPTDATE   DATE,
  L_SHIPINSTRUCT  CHAR(25),
  L_SHIPMODE      CHAR(10),
  L_COMMENT       VARCHAR(44),
  PRIMARY KEY (L_ORDERKEY, L_LINENUMBER)
) splitkeys location '/temp/lineitemKeys.csv';
```
{: .Example}

Here's what the `lineitemKeys.csv` file looks like:
{: .spaceAbove}

```
1424004,7
2384419,4
3244416,6
5295747,4
```
{: .Example}

#### Using Physical Split Keys
This is an example of creating a new table that will be split into regions based on the encoded HBase split keys:

```
CREATE TABLE LINEITEM (
  L_ORDERKEY      INTEGER NOT NULL,
  L_PARTKEY       INTEGER NOT NULL,
  L_SUPPKEY       INTEGER NOT NULL,
  L_LINENUMBER    INTEGER NOT NULL,
  L_QUANTITY      DECIMAL(15, 2),
  L_EXTENDEDPRICE DECIMAL(15, 2),
  L_DISCOUNT      DECIMAL(15, 2),
  L_TAX           DECIMAL(15, 2),
  L_RETURNFLAG    CHAR(1),
  L_LINESTATUS    CHAR(1),
  L_SHIPDATE      DATE,
  L_COMMITDATE    DATE,
  L_RECEIPTDATE   DATE,
  L_SHIPINSTRUCT  CHAR(25),
  L_SHIPMODE      CHAR(10),
  L_COMMENT       VARCHAR(44),
  PRIMARY KEY (L_ORDERKEY, L_LINENUMBER)
) physical splitkeys location '/temp/lineitemKeys.txt';
```
{: .Example}

Here is what the `lineitemKeys.txt` file looks like:
{: .spaceAbove}

```
\xE4\x15\xBA\x84\x00\x87
\xE4$b#\x00\x84
\xE41\x81\x80\x00\x86
\xE4P\xCE\x83\x00\x84
```
{: .Example}

### CREATE TABLE AS

This example creates a new table that uses all of the columns (and their
data types) from an existing table, but does not duplicate the data:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE NewPlayers
       AS SELECT * 
             FROM Players WITH NO DATA;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example creates a new table that includes the data and uses only
some of the columns from an existing table, and assigns new names for
the columns:
{: .body}

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE MorePlayers (ID, PlayerName, Born)
       AS SELECT ID, DisplayName, Birthdate
             FROM Players WITH DATA;
    94 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example creates a new table using unnamed expressions in the query
and shows that the data types are the same for the corresponding columns
in the newly created table:
{: .body}

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE T3 (X,Y)
       AS SELECT 2*I AS COL1, 2.0*F AS COL2
             FROM T1 WITH NO DATA;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`ALTER TABLE`](sqlref_statements_altertable.html) statement
* [`CREATE EXTERNAL TABLE`](sqlref_statements_createexternaltable.html) statement
* [`CONSTRAINT`](sqlref_clauses_constraint.html) clause
* [`DROP TABLE`](sqlref_statements_droptable.html) statement
* [Foreign Keys](developers_fundamentals_foreignkeys.html) in the *Developer's Guide*.
* [Triggers](developers_fundamentals_triggers.html) in the *Developer's Guide*.

</div>
</section>
