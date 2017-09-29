---
title: CONSTRAINT clause
summary: An optional clause in CREATE TABLE and ALTER TABLE statements that specifies a rule to which the data must conform.
keywords: constraints, column-level constraints, primary key, foreign key, unique
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_constraint.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CONSTRAINT

A `CONSTRAINT` clause is a rule to which data must conform, and is an
optional part of &nbsp;[`ALTER TABLE`](sqlref_clauses_constraint.html)
statements. Constraints can optionally be named.

There are two types of constraints:

<div class="paramList" markdown="1">
column-level constraints
{: .paramName}

A column-level constraint refers to a single column in a table (the
column that it follows syntactically) in the table. Column constraints,
other than `CHECK `constraints, do not specify a column name.
{: .paramDefnFirst}

table-level constraints
{: .paramName}

A table-level constraints refers to one or more columns in a table by
specifying the names of those columns. Table-level `CHECK` constraints
can refer to 0 or more columns in the table.
{: .paramDefnFirst}

</div>
Column constraints and table constraints have the same function; the
difference is in where you specify them.

* Table constraints allow you to specify more than one column in a
  `PRIMARY KEY ` or `CHECK `<span>, `UNIQUE` or `FOREIGN KEY`</span>
  constraint definition.
* Column-level constraints (except for check constraints) refer to only
  one column.

## Column Constraints   {#ColumnConstraint}

<div class="fcnWrapperWide" markdown="1">
    {
      NOT NULL |
     [ [CONSTRAINT constraint-Name] {PRIMARY KEY} ]
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="fcnWrapperWide" markdown="1">
    {
      NOT NULL |
      [ [CONSTRAINT constraint-Name]
      {
         CHECK (searchCondition) |
         {
            PRIMARY KEY |
            UNIQUE |
            REFERENCES clause
          }
        }
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
NOT NULL
{: .paramName}

Specifies that this column cannot hold `NULL` values (constraints of
this type are not nameable).
{: .paramDefnFirst}

PRIMARY KEY
{: .paramName}

Specifies the column that uniquely identifies a row in the table. The
identified columns must be defined as `NOT NULL`.
{: .paramDefnFirst}

At this time, you **cannot** add a primary key using `ALTER TABLE`.
{: .noteNote}

If you attempt to add a primary key using `ALTER TABLE` and any of the
columns included in the primary key contain null values, an error will
be generated and the primary key will not be added. See &nbsp;[`ALTER TABLE`
statement](sqlref_statements_altertable.html) for more information.
{: .noteNote}

UNIQUE
{: .paramName}

Specifies that values in the column must be unique.
{: .paramDefnFirst}

FOREIGN KEY
{: .paramName}

Specifies that the values in the column must correspond to values in a
referenced primary key or unique key column or that they are NULL.
{: .paramDefnFirst}

CHECK
{: .paramName}

Specifies rules for values in the column.
{: .paramDefnFirst}

</div>
## Table Constraints   {#TableConstraint}

<div class="fcnWrapperWide" markdown="1">
    [CONSTRAINT constraint-Name]
    {
       PRIMARY KEY ( Simple-column-Name
       [ , Simple-column-Name ]* )
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="fcnWrapperWide" markdown="1">
    [CONSTRAINT constraint-Name]
    {
        CHECK (searchCondition) |
        {
            PRIMARY KEY ( Simple-column-Name [ , Simple-column-Name ]* ) |
            UNIQUE ( Simple-column-Name [ , Simple-column-Name ]* ) |
            FOREIGN KEY ( Simple-column-Name [ , Simple-column-Name ]* )
                sREFERENCES clause
        }
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
PRIMARY KEY
{: .paramName}

Specifies the column or columns that uniquely identify a row in the
table. `NULL` values are not allowed.
{: .paramDefnFirst}

At this time, you **cannot** add a primary key using `ALTER TABLE`.
{: .noteNote}

UNIQUE
{: .paramName}

Specifies that values in the columns must be unique.
{: .paramDefnFirst}

FOREIGN KEY
{: .paramName}

Specifies that the values in the columns must correspond to values in
referenced primary key or unique columns or that they are `NULL`.
{: .paramDefnFirst}

If the foreign key consists of multiple columns, and *any* column is
`NULL`, the whole key is considered `NULL`. The insert is permitted no
matter what is on the non-null columns.
{: .noteNote}

CHECK
{: .paramName}

Specifies a wide range of rules for values in the table.
{: .paramDefnFirst}

</div>
## Primary Key Constraints

At this time, you **cannot** alter primary keys using `ALTER TABLE`.
{: .noteNote}

Primary keys are constrained as follows:

* A primary key defines the set of columns that uniquely identifies rows
  in a table.
* When you create a primary key constraint, none of the columns included
  in the primary key can have `NULL` constraints; that is, they must not
  permit `NULL` values.
* A table can have at most one `PRIMARY KEY` constraint.

## Unique constraints

A `UNIQUE` constraint defines a set of columns that uniquely identify
rows in a table only if all the key values are not `NULL`. If one or
more key parts are `NULL`, duplicate keys are allowed.

For example, if there is a `UNIQUE` constraint on `col1` and `col2` of a
table, the combination of the values held by `col1` and `col2` will be
unique as long as these values are not `NULL`. If one of `col1` and
`col2` holds a `NULL` value, there can be another identical row in the
table.

A table can have multiple `UNIQUE` constraints.

## Foreign key constraints

Foreign keys providea way to enforce the referential integrity of a
database. A foreign key is a column or group of columns within a table
that references a key in some other table (or sometimes the same table).
The foreign key must always include the columns of which the types
exactly match those in the referenced primary key or unique constraint.

For a table-level foreign key constraint in which you specify the
columns in the table that make up the constraint, you cannot use the
same column more than once.

If there is a column list in the <em>ReferencesSpecification </em>(a
list of columns in the referenced table), it must correspond either to a
unique constraint or to a primary key constraint in the referenced
table. The *ReferencesSpecification* can omit the column list for the
referenced table if that table has a declared primary key.

If there is no column list in the <em>ReferencesSpecification </em>and
the referenced table has no primary key, a statement exception is
thrown. (This means that if the referenced table has only unique keys,
you must include a column list in the *ReferencesSpecification.*)

A foreign key constraint is satisfied if there is a matching value in
the referenced unique or primary key column. If the foreign key consists
of multiple columns, the foreign key value is considered `NULL` if any
of its columns contains a `NULL`.

It is possible for a foreign key consisting of multiple columns to allow
one of the columns to contain a value for which there is no matching
value in the referenced columns, per the ANSI SQL standard. To avoid
this situation, create `NOT NULL` constraints on all of the foreign
key's columns.

### Foreign key constraints and DML

When you insert into or update a table with an enabled foreign key
constraint, Splice Machine checks that the row does not violate the
foreign key constraint by looking up the corresponding referenced key in
the referenced table. If the constraint is not satisfied, Splice Machine
rejects the insert or update with a statement exception.

When you update or delete a row in a table with a referenced key (a
primary or unique constraint referenced by a foreign key), Splice
Machine checks every foreign key constraint that references the key to
make sure that the removal or modification of the row does not cause a
constraint violation.

If removal or modification of the row would cause a constraint
violation, the update or delete is not permitted and Splice Machine
throws a statement exception.

Splice Machine performs constraint checks at the time the statement is
executed, not when the transaction commits.

`PRIMARY KEY` constraints generate unique indexes. `FOREIGN KEY`
constraints generate non-unique indexes.

`UNIQUE` constraints generate unique indexes if all the columns are
non-nullable, and they generate non-unique indexes if one or more
columns are nullable.

Therefore, if a column or set of columns has a `UNIQUE`, `PRIMARY KEY`,
or `FOREIGN KEY` constraint on it, you do not need to create an index on
those columns for performance. Splice Machine has already created it for
you.

## Check constraints

You can use check constraints to limit which values are accepted by one
or more columns in a table. You specify the constraint with a Boolean
expression; if the expression evaluates to `true`, the value is allowed;
if the expression evaluates to `false`, the constraint prevents the
value from being entered into the database.The search condition is
applied to each row that is modified on an `INSERT` or `UPDATE` at the
time of the row modification. When a constraint is violated, the entire
statement is aborted. You can apply check constraints at the column
level or table level.

For example, you could specify that values in the salary column for the
players on your team must be between $250,000 and $30,000,000 with this
expression:

<div class="preWrapper" markdown="1">
    salary >= 250000 AND salary <= 30000000.
{: .Example}

</div>
Any attempt to insert or update a record with a salary value out of that
range would fail.

## Search Condition   {#SearchCondition}

A *searchCondition* is any [Boolean
expression](sqlref_expressions_boolean.html) that meets the requirements
specified below. If a *constraint-Name* is not specified, Splice Machine
generates a unique constraint name (for either column or table
constraints).

### Requirements for search condition

If a check constraint is specified as part of a column-definition, a
column reference can only be made to the same column. Check constraints
specified as part of a table definition can have column references
identifying columns previously defined in the &nbsp;[`CREATE
TABLE`](sqlref_statements_createtable.html) statement.

The search condition must always return the same value if applied to the
same values. Thus, it cannot contain any of the following:

* Dynamic parameters
* Date/Time Functions
  ([`CURRENT_TIMESTAMP`](sqlref_builtinfcns_currenttimestamp.html))
* Subqueries
* User Functions (such as
 &nbsp;[`CURRENT_USER`](sqlref_builtinfcns_currentuser.html))

## Examples

<div class="preWrapperWide" markdown="1">
       -- column-level primary key constraint named OUT_TRAY_PK:
    CREATE TABLE SAMP.OUT_TRAY
    (
    SENT TIMESTAMP,
    DESTINATION CHAR(8),
    SUBJECT CHAR(64) NOT NULL CONSTRAINT
    OUT_TRAY_PK PRIMARY KEY,
    NOTE_TEXT VARCHAR(3000)
    );

    -- the table-level primary key definition allows you to
    -- include two columns in the primary key definition:
    CREATE TABLE SAMP.SCHED
    (
    CLASS_CODE CHAR(7) NOT NULL,
    DAY SMALLINT NOT NULL,
    STARTING TIME,
    ENDING TIME,
    PRIMARY KEY (CLASS_CODE, DAY)
    );
    -- Use a column-level constraint for an arithmetic check
    -- Use a table-level constraint
    -- to make sure that a employee's taxes does not
    -- exceed the bonus
    CREATE TABLE SAMP.EMP
    (
    EMPNO CHAR(6) NOT NULL CONSTRAINT EMP_PK PRIMARY KEY,
    FIRSTNME CHAR(12) NOT NULL,
    MIDINIT vARCHAR(12) NOT NULL,
    LASTNAME VARCHAR(15) NOT NULL,
    SALARY DECIMAL(9,2) CONSTRAINT SAL_CK CHECK (SALARY >= 10000),
    BONUS DECIMAL(9,2),
    TAX DECIMAL(9,2),
    CONSTRAINT BONUS_CK CHECK (BONUS > TAX)
    );

    -- use a check constraint to allow only appropriate
    -- abbreviations for the meals
    CREATE TABLE FLIGHTS
    (
    FLIGHT_ID CHAR(6) NOT NULL ,
    SEGMENT_NUMBER INTEGER NOT NULL ,
    ORIG_AIRPORT CHAR(3),
    DEPART_TIME TIME,
    DEST_AIRPORT CHAR(3),
    ARRIVE_TIME TIME,
    MEAL CHAR(1) CONSTRAINT MEAL_CONSTRAINT
    CHECK (MEAL IN ('B', 'L', 'D', 'S')),
    PRIMARY KEY (FLIGHT_ID, SEGMENT_NUMBER)
    );
{: .Example xml:space="preserve"}

</div>
## Statement dependency system

[`INSERT`](sqlref_statements_insert.html) and
[`UPDATE`](sqlref_statements_update.html) statements depend on all
constraints on the target table.

[`DELETE`](sqlref_statements_delete.html) statements depend on
unique<span>, primary key, and foreign key constraints</span>.

These statements are invalidated if a constraint is added to or dropped
from the target table.

## See Also

* [`ALTER TABLE`](sqlref_statements_altertable.html) statement
* [`CREATE TABLE`](sqlref_statements_createtable.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`DELETE`](sqlref_statements_delete.html) statement
* [Foreign Keys](developers_fundamentals_foreignkeys.html) in the
  *Developer's Guide*.
* [Triggers](developers_fundamentals_triggers.html) in the *Developer's
  Guide*.
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>
