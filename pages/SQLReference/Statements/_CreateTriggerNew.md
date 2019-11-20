---
title: CREATE TRIGGER statement
summary: Creates a trigger, which defines a set of actions that are executed when a database event occurs on a specified table
keywords: creating a trigger
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_newcreatetrigger.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE TRIGGER

A `CREATE TRIGGER` statement creates a trigger, which defines a set of
actions that are executed when a database event known as the `triggering
event` occurs on a specified table. The event can be a `INSERT`,
`UPDATE`, or `DELETE` statement. When a trigger fires, the set of
SQL statements that constitute the action are executed.

You can define any number of triggers for a single table, including
multiple triggers on the same table for the same event. To define a
trigger on a table, you must be the owner of the of the database, the
owner of the table's schema, or have `TRIGGER` privileges on the table.
You cannot define a trigger for any schema whose name begins with `SYS`.

The [Database Triggers](developers_fundamentals_triggers.html) topic in
our *Developer's Guide* provides additional information about database
triggers.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE TRIGGER <a href="sqlref_identifiers_types.html#TriggerName">TriggerName</a>
   { AFTER | [NO CASCADE] BEFORE }
   { INSERT | DELETE | UPDATE [ OF column-Name [, <a href="sqlref_identifiers_types.html#ColumnName">column-Name</a>]* ] }
   ON { <a href="sqlref_identifiers_types.html#TableName">table-Name</a> | <a href="sqlref_identifiers_types.html#ViewName">view-Name</a> }
   [ REFERENCING { OLD AS correlation-name
                 | NEW AS correlation-name
                 | OLD_TABLE AS table-Name
                 | NEW_TABLE AS table-Name } ]
   [ FOR EACH { ROW | STATEMENT } ]
   [ WHEN search-condition]
   { triggered-sql-statement
   | BEGIN ATOMIC (triggered-sql-statement;)+ END }</pre>
</div>

<div class="paramList" markdown="1">
TriggerName
{: .paramName}

The name to associate with the trigger.
{: .paramDefnFirst}

AFTER \| BEFORE
{: .paramName}

Triggers are defined as either `Before` or `After` triggers.
{: .paramDefnFirst}

`BEFORE` triggers fire before the statement's changes are applied and
before any constraints have been applied. `AFTER` triggers fire after
all constraints have been satisfied and after the changes have been
applied to the target table.
{: .paramDefn}

When a database event occurs that fires a trigger, Splice Machine
performs actions in this order:
{: .paramDefn}

* It fires `BEFORE` triggers.
* It performs constraint checking (primary key, unique key, foreign key,
  check).
* It performs the `INSERT`, `UPDATE`, `SELECT`, or `DELETE` operations.
* It fires `AFTER` triggers.

When multiple triggers are defined for the same database event for the
same table for the same trigger time (before or after), triggers are
fired in the order in which they were created.
{: .paramDefnFirst}

INSERT \| DELETE \| SELECT \| UPDATE
{: .paramName}

Defines which database event causes the trigger to fire. If you specify
`UPDATE`, you can specify which column(s) cause the triggering event.
{: .paramDefnFirst}

table-Name
{: .paramName}

The name of the table for which the trigger is being defined.
{: .paramDefnFirst}

ReferencingClause
{: .paramName}

A means of referring to old/new data that is currently being changed by
the database event that caused the trigger to fire. See the [Referencing
Clause](#ReferencingClause) section below.
{: .paramDefnFirst}

FOR EACH {ROW \| STATEMENT}
{: .paramName}

A `FOR EACH ROW` triggered action executes once for each row that the
triggering statement affects.
{: .paramDefnFirst}

A `FOR EACH STATEMENT` trigger fires once per triggering event and
regardless of whether any rows are modified by the insert, update, or
delete event.
{: .paramDefn}

Triggered-SQL-Statement
{: .paramName}

The statement that is executed when the trigger fires. The statement has
the following restrictions:
{: .paramDefnFirst}

* It must not contain any dynamic (`?`) parameters.
* It cannot create, alter, or drop any table.
* It cannot add an index to or remove an index from any table.
* It cannot add a trigger to or drop a trigger from any table.
* It must not commit or roll back the current transaction or change the
  isolation level.
* Before triggers cannot have `INSERT`, `UPDATE`, `SELECT`, or `DELETE`
  statements as their action.
* Before triggers cannot call procedures that modify SQL data as their
  action.
* The `NEW` variable of a `BEFORE` trigger cannot reference a generated
  column.

The statement can reference database objects other than the table upon
which the trigger is declared. If any of these database objects is
dropped, the trigger is invalidated. If the trigger cannot be
successfully recompiled upon the next execution, the invocation throws
an exception and the statement that caused it to fire will be rolled
back.
{: .paramDefn}

</div>
## The Referencing Clause   {#ReferencingClause}

Many triggered-SQL-statements need to refer to data that is currently
being changed by the database event that caused them to fire. The
triggered-SQL-statement might need to refer to the old (pre-change or
*before*) values or to the new (post-change or *after*) values. You can
refer to the data that is currently being changed by the database event
that caused the trigger to fire.

Note that the referencing clause can designate only one new correlation
or identifier and only one old correlation or identifier.

### Transition Variables in Row Triggers

Use the transition variables `OLD` and `NEW` with row triggers to refer
to a single row before (`OLD`) or after (`NEW`) modification. For
example:

<div class="preWrapper" markdown="1">
    REFERENCING OLD AS DELETEDROW;
{: .Example xml:space="preserve"}

</div>
You can then refer to this correlation name in the
triggered-SQL-statement:

<div class="preWrapperWide" markdown="1">
    splice> DELETE FROM HotelAvailability WHERE hotel_id = DELETEDROW.hotel_id;
{: .Example xml:space="preserve"}

</div>
The `OLD` and `NEW` transition variables map to a *java.sql.ResultSet*
with a single row.

`INSERT` row triggers cannot reference an `OLD` row.

`DELETE` row triggers cannot reference a `NEW` row.
{: .noteNote}

## Trigger Recursion

The maximum trigger recursion depth is 16.

## Examples

This section presents examples of creating triggers:

#### A statement trigger:

<div class="preWrapperWide" markdown="1">
    splice> CREATE TRIGGER triggerName
       AFTER UPDATE
       ON TARGET_TABLE
       FOR EACH STATEMENT
           INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE was updated');
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
#### A statement trigger calling a custom stored procedure:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TRIGGER triggerName
       AFTER UPDATE
       ON TARGET_TABLE
       FOR EACH STATEMENT
          CALL my_custom_stored_procedure('arg1', 'arg2');
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
#### A simple row trigger:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TRIGGER triggerName
       AFTER UPDATE
       ON TARGET_TABLE
       FOR EACH ROW
          INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE row was updated');
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
#### A row trigger defined on a subset of columns:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TRIGGER triggerName
       AFTER UPDATE OF col1, col2
       ON TARGET_TABLE
       FOR EACH ROW
          INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE col1 or col2 of row was updated');
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
<div class="preWrapperWide" markdown="1">
    splice> CREATE TRIGGER UpdateSingles
       AFTER UPDATE OF Hits, Doubles, Triples, Homeruns
       ON Batting
       FOR EACH ROW
       UPDATE Batting Set Singles=(Hits-(Doubles+Triples+Homeruns));
    0 rows insert/updated/deleted
{: .Example xml:space="preserve"}

</div>
#### A row trigger defined on a subset of columns, referencing new and old values:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TRIGGER triggerName
       AFTER UPDATE OF col1, col2
       ON T
       REFERENCING OLD AS OLD_ROW NEW AS NEW_ROW
       FOR EACH ROW
          INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE row was updated', OLD_ROW.col1, NEW_ROW.col1);
    0 rows insert/updated/deleted
{: .Example xml:space="preserve"}

</div>
#### A row trigger defined on a subset of columns, referencing new and old values, calling custom stored procedure:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TRIGGER triggerName
       AFTER UPDATE OF col1, col2
       ON T
       REFERENCING OLD AS OLD_ROW NEW AS NEW_ROW
       FOR EACH ROW
          CALL my_custom_stored_procedure('arg1', 'arg2', OLD_ROW.col1, NEW_ROW.col1);
    0 rows insert/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [Database Triggers](developers_fundamentals_triggers.html)
* [`DROP TRIGGER`](sqlref_statements_droptrigger.html) statement
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>
