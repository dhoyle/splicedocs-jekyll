---
title: Using Foreign Keys
summary: Describes our implementation of foreign keys and how our implementation ensures referential integrity.
keywords: keys, foreign keys, referential integrity
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_foreignkeys.html
folder: Developers/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Foreign Keys and Referential Integrity

This topic describes the Splice Machine implementation of *foreign keys*
and how our implementation ensures referential integrity.

See our *SQL Reference Manual* for full reference information about
defining foreign keys using using [constraint
clauses](sqlref_clauses_constraint.html) when [creating
](sqlref_statements_createtable.html)a database table.

## About Foreign Keys

A foreign key is a column or group of columns in a relational database
table that provides a link between data in two tables. A foreign key
acts as a cross-reference between tables in that it references the
primary key or unique key columns of another table, and thus establishes
a link between them.

The purpose of a foreign key is to identify a particular row of the
referenced table; as such, the foreign key must be equal to the key in
some row of the primary table, or else be `null`. This rule is called a
*referential integrity constraint between the two tables*, and is
usually abbreviated as just *referential integrity*.

### Maintaining Referential Integrity

To maintain referential integrity, Splice Machine ensures that database
operations do not violate foreign key constraints, including not
allowing any operations that will cause a foreign key to not correspond
to a row in the referenced table. This can happen when a row is
inserted, updated, or deleted in either table.

For example, suppose you have:

* A table named `Players` with primary key `player_id`. This table is
  called the *parent table* or *referenced table*.
* A second table named `PlayerStats` has a foreign key, which is also a
  column named `player_id`. This table is called the *child table* or
  *referencing table*.

The `player_id` column in the *referencing* table is the foreign key
that references the primary key `player_id` in the *referenced* table.

When you insert a new record into the referencing `PlayerStats` table,
the insertion must satisfy the foreign key constraint, which means that
it must include a `player_id` value that is present in the referenced
`Players` table. If this is not so, the insert operation fails in order
to maintain the table's referential integrity.

### About Foreign Key Constraints

You can define a foreign key constraint on a table when you create the
table with the
[`CREATE TABLE`](sqlref_statements_createtable.html) statement. Foreign
key constraints are always immediate: a violation of a constraint
immediately throws an exception.

Here's an example of defining a foreign key, in which we use the
`REFERENCES` clause of a column definition in a
`CREATE TABLE` statement:

<div class="preWrapper" markdown="1">
    CREATE TABLE t1 (c1 NUMERIC PRIMARY KEY);
    
    CREATE TABLE t2 (
       c1 NUMERIC PRIMARY KEY,
       c2 NUMERIC REFERENCES t1(c1) );
{: .Example}

</div>
And here's an example that uses the
[`CONSTRAINT`](sqlref_clauses_constraint.html) clause to name the
foreign key constraint:

<div class="preWrapper" markdown="1">
    CREATE TABLE t3 (
       c1 NUMERIC,
       c2 NUMERIC,
       CONSTRAINT t1_fkey FOREIGN KEY (c1) REFERENCES t1);
{: .Example xml:space="preserve"}

</div>
You can also define a foreign key on a combination of columns:

<div class="preWrapper" markdown="1">
    CREATE TABLE dept_20
       (employee_id INT, hire_date DATE,
       CONSTRAINT fkey_empid_hiredate
       FOREIGN KEY (employee_id, hire_date)
       REFERENCES dept_21(employee_id, start_date));
{: .Example xml:space="preserve"}

</div>
## See Also

* [ALTER TABLE](sqlref_statements_altertable.html)
* [CONSTRAINT](sqlref_clauses_constraint.html)
* [CREATE TABLE](sqlref_statements_createtable.html)
* [Using Database Triggers](developers_fundamentals_triggers.html)

 

</div>
</section>

