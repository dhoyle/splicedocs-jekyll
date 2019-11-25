---
title: CREATE TRIGGER statement
summary: Creates a trigger, which defines a set of actions that are executed when a database event occurs on a specified table
keywords: creating a trigger
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_createtrigger.html
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
   ON { <a href="sqlref_identifiers_types.html#TableName">table-Name</a> }
   [ REFERENCING {  OLD AS correlation-name
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

The `NO CASCADE` modifier is ignored by Splice Machine.
{: .noteNote}

`BEFORE` triggers fire before the statement's changes are applied and
before any constraints have been applied. `AFTER` triggers fire after
all constraints have been satisfied and after the changes have been
applied to the target table.
{: .paramDefn}

When a database event occurs that fires a trigger, Splice Machine
performs actions in this order:
{: .paramDefn}

<div class="indented" markdown="1">
* It fires `BEFORE` triggers.
* It performs constraint checking (primary key, unique key, foreign key, check).
* It performs the `INSERT`, `UPDATE`, `SELECT`, or `DELETE` operations.
* It fires `AFTER` triggers.
</div>

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

Referencing Clause
{: .paramName}

You can use the `REFERENCING` clause to refer to to old or new data that is currently being changed by the database event that caused the trigger to fire.
{: .paramDefnFirst}

<div class="paramListNested" markdown="1">
OLD AS correlation-name
{: .paramName}

Specifies the row correlation name that identifies the values in the row prior to the triggering SQL operation.
{: .paramDefnFirst}

NEW AS correlation-name
{: .paramName}

Specifies the row correlation name that identifies the values in the row as modified by the triggering SQL operation and by any SET statement in a `BEFORE` trigger that has already been executed.
{: .paramDefnFirst}
</div>

The complete set of rows that are affected by the triggering operation is available to the triggered action by using table names that are specified as follows:
{: .paramDefn}

<div class="paramListNested" markdown="1">
OLD_TABLE AS table-name
{: .paramName}

Specifies the name of a temporary table that identifies the values in the complete set of rows that are modified rows by the triggering SQL operation prior to any actual changes.
{: .paramDefnFirst}

NEW_TABLE AS table-name
{: .paramName}

Specifies the name of a temporary table that identifies the values in the complete set of rows as modified by the triggering SQL operation and by any SET statement in a before trigger that has already been executed.
{: .paramDefnFirst}
</div>

Only one `OLD` and one `NEW` correlation-name can be specified for a trigger. Only one `OLD_TABLE` and one `NEW_TABLE` table-identifier can be specified for a trigger. All of the correlation-names and table-identifiers must be unique from one another.
{: .paramDefn}

See the description of using the Referencing Clause in the [Using Database Triggers in Splice Machine](developers_fundamentals_triggers.html#ReferencingClause) topic for additional specifics about and examples of using this clause.
{: .paramDefn}

FOR EACH {ROW \| STATEMENT}
{: .paramName}

A `FOR EACH STATEMENT` trigger fires once per triggering event and regardless of whether any rows are modified by the insert, update, or delete event. This is the default value, which is assumed if you omit the `FOR EACH` clause.
{: .paramDefnFirst}

A `FOR EACH ROW` triggered action executes once for each row that the triggering statement affects. Note that an update that sets a column value to its same value __does__ cause a row trigger to fire.
{: .paramDefn}

Currently, you cannot use a `FOR EACH STATEMENT` trigger when you specify a `REFERENCING OLD_TABLE` or `REFERENCING NEW_TABLE` clause. This limitation will be removed in the near future.
{: .noteNote}

MODE DB2SQL
{: .paramName}

This option is ignored by Splice Machine.
{: .paramDefnFirst}

search-condition
{: .paramName}

The Boolean expression that defines whether the triggered SQL statement(s) should execute for a specific trigger event; the statements are executed only if this expression evaluates to `TRUE`.
{: .paramDefnFirst}

This `search-condition` *can* refer to the correlation names or tables names defined in the `REFERENCING` clause.
{: .noteNote}

Triggered-SQL-Statement
{: .paramName}

A statement that is executed when the trigger fires. The statement has
the following restrictions:
{: .paramDefnFirst}

<div class="indented" markdown="1">
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
</div>

The statement can reference database objects other than the table upon which the trigger is declared. If any of these database objects is
dropped, the trigger is invalidated. If the trigger cannot be
successfully recompiled upon the next execution, the invocation throws
an exception and the statement that caused it to fire will be rolled
back.
{: .paramDefn}

You can use the `SIGNAL` statement to trigger a rollback and to return the specified error code to the user; you can also optionally specify a diagnostic text message to return in the `SIGNAL` statement.
{: .paramDefn}

BEGIN ATOMIC ... END
{: .paramName}

You can specify multiple `triggered-sql-statements` between the `BEGIN ATOMIC` and `END` keywords. Each of these `triggered-sql-statement` is executed when the trigger fires; each must be terminated with a semicolon (`;`).
{: .paramDefnFirst}

Multiple `triggered-sql-statements` are not currently supported; this limitation will be removed in the near future.
{: .noteNote}

</div>

### Trigger Recursion

The maximum trigger recursion depth is 16.

## Examples

This section presents examples of creating triggers:

### A statement trigger:

```
splice> CREATE TRIGGER myTrigger
   AFTER UPDATE
   ON TARGET_TABLE
   FOR EACH STATEMENT
       INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE was updated');
0 rows inserted/updated/deleted
```
{: .Example}

### A statement trigger calling a custom stored procedure:

```
splice> CREATE TRIGGER myTrigger
   AFTER UPDATE
   ON TARGET_TABLE
   FOR EACH STATEMENT
      CALL my_custom_stored_procedure('arg1', 'arg2');
0 rows inserted/updated/deleted
```
{: .Example}

### A simple row trigger:

```
splice> CREATE TRIGGER myTrigger
   AFTER UPDATE
   ON TARGET_TABLE
   FOR EACH ROW
      INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE row was updated');
0 rows inserted/updated/deleted
```
{: .Example}

### A row trigger defined on a subset of columns:

```
splice> CREATE TRIGGER myTrigger
   AFTER UPDATE OF col1, col2
   ON TARGET_TABLE
   FOR EACH ROW
      INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE col1 or col2 of row was updated');
0 rows inserted/updated/deleted
```
{: .Example}

```
splice> CREATE TRIGGER UpdateSingles
   AFTER UPDATE OF Hits, Doubles, Triples, Homeruns
   ON Batting
   FOR EACH ROW
      UPDATE Batting Set Singles=(Hits-(Doubles+Triples+Homeruns));
0 rows insert/updated/deleted
```
{: .Example}


### A row trigger defined on a subset of columns, referencing new and old values:

```

splice> CREATE TRIGGER myTrigger
   AFTER UPDATE OF col1, col2
   ON T
   REFERENCING OLD AS OLD_ROW NEW AS NEW_ROW
   FOR EACH ROW
      INSERT INTO AUDIT_TABLE VALUES (CURRENT_TIMESTAMP, 'TARGET_TABLE row was updated', OLD_ROW.col1, NEW_ROW.col1);
0 rows insert/updated/deleted
```
{: .Example}

### A row trigger defined on a subset of columns, referencing new and old values, calling custom stored procedure:

```

splice> CREATE TRIGGER myTrigger
   AFTER UPDATE OF col1, col2
   ON T
   REFERENCING OLD AS OLD_ROW NEW AS NEW_ROW
   FOR EACH ROW
      CALL my_custom_stored_procedure('arg1', 'arg2', OLD_ROW.col1, NEW_ROW.col1);
0 rows insert/updated/deleted
```
{: .Example}

## See Also

* [Database Triggers](developers_fundamentals_triggers.html)
* [`DROP TRIGGER`](sqlref_statements_droptrigger.html) statement
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>
