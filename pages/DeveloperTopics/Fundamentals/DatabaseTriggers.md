---
title: Using Database Triggers in Splice Machine
summary: Describes database triggers and how you can use them with Splice Machine.
keywords: triggers
toc: false
product: all
sidebar: home_sidebar
permalink: developers_fundamentals_triggers.html
folder: DeveloperTopics/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Database Triggers

This topic describes database triggers and how you can use them with
Splice Machine.

## About Database Triggers

A database trigger is a set of actions that are automatically executed in response to certain events occurring on a particular table in a database. The triggering events can be delete, insert, or update operations. We refer to the execution of those actions as the *firing* of the trigger; for example, you might create a trigger that fires whenever a row in a certain table is updated.

Triggers are primarily used for maintaining the integrity of the information on the database; for example, they are commonly used to:

* automatically generate derived column values
* enforce complex security authorizations
* enforce referential integrity across nodes in a distributed database
* enforce complex business rules
* provide transparent event logging
* provide sophisticated auditing
* gather statistics on table access

You can also use triggers for purpose such as issuing alerts, updating other tables, and sending e-mail messages.

You can define any number of triggers for a single table, including multiple triggers on the same table for the same event. You can create a trigger in any schema in which you are either the schema owner or have been granted the `TRIGGER` privilege.

### Trigger Definition Syntax

For a complete description of the parameters, see the [`CREATE TRIGGER`](sqlref_statements_createtrigger.html) reference page.

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

### Components of a Trigger

Trigger definitions have a number of required and optional components:

<table summary="Descriptions of trigger components.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Required</th>
            <th>Component</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="4">YES</td>
            <td class="ItalicFont">Trigger Name</td>
            <td>The name of the trigger.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Before or After?</td>
            <td>
                <p>A <code>BEFORE</code> trigger fires before the statement's changes are applied and before any constraints have been applied.</p>
                <p>An <code>AFTER</code> trigger fires after all constraints have been satisfied and after the changes have been applied to the target table. </p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Triggering event (or statement)</td>
            <td>
                <p>The SQL statement that causes a trigger to be fired. This can be one of the following statement types:</p>
                <ul>
                    <li class="CodeFont" value="1">INSERT</li>
                    <li class="CodeFont" value="2">UPDATE</li>
                    <li class="CodeFont" value="3">DELETE</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Trigger action</td>
            <td>
                <p>The SQL statement(s) to execute when a triggering statement is issued and any trigger restrictions evaluate to <code>TRUE</code>. </p>
                <p>A trigger action is one of the following:</p>
                <ul>
                    <li>A single SQL statement.</li>
                    <li>A sequence of SQL statements enclosed between the <code>BEGIN ATOMIC</code> and <code>END</code> keywords. Each of these statements must be terminated with a semicolon (<code>;</code>) character.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td rowspan="3">NO</td>
            <td class="ItalicFont">Statement or Row</td>
            <td>
                <p>A <em>statement trigger</em>, fires once per triggering event, regardless of how many rows (including zero rows) are modified by the event. Triggers are statement triggers by default, or you can explicitly specify a statement trigger with <code>FOR EACH STATEMENT</code>.</p>
                <p>You specify a <em>row trigger</em> with <code>FOR EACH ROW</code>; row triggers fire once for each row that is affected by the triggering event; for example, each row modified by an <code>UPDATE</code> statement. If zero rows are affected by the event, the trigger does not fire.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Referencing Clause</td>
            <td>
                <p>Your triggered SQL statements can refer to the data this is being changed by the triggered action, both before the changes and after the changes, using the optional <em>referencing clause</em>.</p>
                <p>Please see the <a href="#ReferencingClause">Referencing Clause</a> section below for a detailed description and examples.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Search Condition</td>
            <td>
                <p>You can optionally define a Boolean expression in the `WHEN` clause that specifies a *search condition* for a trigger. If you include a `WHEN` clause in your trigger, the trigger action is only executed if the search condition evaluates to `TRUE`.</p>
                <p class="noteNote">This `search-condition` *can* refer to the correlation names or tables names defined in the `REFERENCING` clause.</p>
            </td>
        </tr>
    </tbody>
</table>

## How Trigger Actions are Performed

When a database event occurs that fires a trigger, Splice Machine performs actions in the following order; it:

1. Fires the `BEFORE` triggers.
2. Performs constraint checking: primary key, unique key, foreign key, and check constraints
3. Performs the trigger action(s).
4. Fires `AFTER` triggers.

If you have defined multiple `BEFORE` or multiple `AFTER` triggers that fire on the same database event and same table, the triggers are fired in the order in which you created them.

## The Referencing Clause   {#ReferencingClause}

Many triggered-SQL-statements need to refer to data that is currently being changed by the database event that caused them to fire. The triggered-SQL-statement might need to refer to the old (pre-change or *before*) values or to the new (post-change or *after*) values. You can use the optional *referencing clause* refer to the data that is currently being changed by the database event that caused the trigger to fire.

You can use the optional *referencing clause* refer to the data that is currently being changed by the database event that caused the trigger to fire, in its pre-trigger-action (old) state, and in its post-trigger-action (new) state.

The referencing clause can designate only one new correlation name or identifier and only one old correlation or identifier.

### Referencing Rows in Row Triggers

You can refer to a single row before (`OLD`) or after (`NEW`) modification in the referencing clause of a *row trigger*:

* `REFERENCING OLD AS <correlation-name>` to refer to a single row before modification.
* `REFERENCING NEW AS <correlation-name>` to refer to a single row after modification.

The correlation-name variables in the referencing clause are sometimes referred to as *transition variables*.

For example, if you include the following clause in your row trigger definition:

```
REFERENCING OLD AS DELETED_ROW
```
{: .Example}

You can then refer to the correlation-name, `DELETED_ROW` in the triggered action; for example:

```
DELETE FROM HotelAvailability WHERE hotel_id = DELETED_ROW.hotel_id;
```
{: .Example}

#### Row Trigger Restrictions

Row triggers have the following reference restrictions:

* Row trigger reference clauses can only specify one correlation name.
* `INSERT` row triggers cannot reference an OLD row.
* `DELETE` row triggers cannot reference a NEW row.
* Row triggers cannot designate `OLD_TABLE` or `NEW_TABLE`.

Note that Splice Machine considers `OLD_TABLE` equivalent to `OLD TABLE`, and  `NEW_TABLE` equivalent to `NEW TABLE`.

### Referencing Tables in Statement Triggers

You can refer to a temporary table that identifies the values in the complete set of rows modified by the triggering SQL operation:

* Use `REFERENCING OLD_TABLE AS <table-name>` to refer to the set of rows prior to any actual changes.
* Use `REFERENCING NEW_TABLE AS <table-name>` to refer to the set of rows as modified by the triggering SQL operation, and by any SET statement in a `BEFORE` trigger that has already been executed.

The table-name variables in the referencing clause are sometimes referred to as *transition tables*. The old and new transition tables map to a `java.sql.ResultSet` with cardinality equivalent to the number of rows affected by the triggering event.

For example, if you include the following clause in your row trigger definition:

```
REFERENCING OLD_TABLE AS DELETED_HOTEL
```
{: .Example}

You can then refer to the correlation-name, `DELETED_HOTEL` in the triggered action; for example:

```
DELETE FROM HotelAvailability WHERE hotel_id IN
    (SELECT hotel_id FROM DeletedHotels);
```
{: .Example}

#### Statement Trigger Restrictions

Statement triggers have the following reference restrictions:

* Statement trigger reference clauses can only specify one table name.
* `INSERT` statement triggers cannot reference an OLD table.
* `DELETE` statement triggers cannot reference a NEW table.
* Statement triggers cannot use `OLD` or `NEW` to designate a row correlation name.

## Using the SIGNAL SQLSTATE Statement  {#SignalStmt}

You can use a `SIGNAL SQLSTATE` statement within a trigger definition to abort and rollback the triggering action and any other triggers that may have fired along with that action. This statement also returns an error with the specified SQLState (error code) and optional message text.

`SIGNAL SQLSTATE` is often used in conjuction with a `WHEN` clause as a form of constraint, so that a DML statement can be conditionally rolled back if certain prerequisites are not met.
{:. noteNote}

Here are the two forms for specifying this statement:

```
SIGNAL SQLSTATE diagnosticId "(" messageExpr ")"

SIGNAL SQLSTATE diagnosticId SET MESSAGE_TEXT = messageExpr
```
{: .FcnSyntax}

The `mesgExpr` string constant or expression (of data type `CHAR` or `VARCHAR`) that describes the error or warning condition.

These two statements are equivalent:

```
SIGNAL SQLSTATE '12345' ('This is the diagnostic text.')

SIGNAL SQLSTATE '12345' SET MESSAGE_TEXT = 'This is the diagnostic text.'
```
{: .Example}

The `diagnosticId` is a five-character long identifier. If you specify an ID longer than 5 characters, it is truncated; if you specify an ID of less than 5 characters, the ID will be left-padded with spaces.

Here is an example:

```
splice> MAXIMUMDISPLAYWIDTH 0;
splice> CREATE TABLE t1 (a INT, b INT);
0 rows inserted/updated/deleted

splice> CREATE TABLE t2 (a INT, b INT);
0 rows inserted/updated/deleted

splice> INSERT INTO t1 VALUES (1,1);
1 row inserted/updated/deleted

splice> INSERT INTO t2 VALUES (1,1);
1 row inserted/updated/deleted

splice> CREATE TRIGGER mytrig
   AFTER UPDATE OF a,b
   ON t1
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW
   WHEN (EXISTS (SELECT 1 from t2 where t2.a = OLD.a and t2.b = OLD.b))
BEGIN ATOMIC
SIGNAL SQLSTATE '87101' SET MESSAGE_TEXT = 'mytrig fired.  Old row: ' concat char(old.a) concat ', ' concat char(old.b) concat '    New row rejected: ' concat char(new.a) concat ', ' concat char(new.b);
END;
0 rows inserted/updated/deleted

splice> UPDATE t1 SET a=2;
ERROR 87101: Application raised error or warning with diagnostic text: "mytrig fired.  Old row: 1          , 1              New row rejected: 2          , 1          "

splice> SELECT * FROM t1;
A|B
---
1|1
```
{: .Example}


## Using the `SET` Statement  {#SetStmt}

You can use the `SET` statement in a `BEFORE` trigger to modify a column value that’s being inserted or updated. The value you specify in the `SET` statement is inserted or updated instead of the value that came from the `UPDATE` or `INSERT` statments; this value can be a literal or an SQL expression.

Here are the two forms for using the `SET` statement in a trigger:

```
SET NEW.columnIdentifier = value

SET NEW.columnIdentifier1 = value1, NEW.columnIdentifier2 = value2, ...
```
{: .FcnSyntax}

Here's an example:

```
CREATE TABLE t1 (a VARCHAR(30), b VARCHAR(30));

CREATE TRIGGER mytrig
   BEFORE INSERT
   ON t1
   REFERENCING NEW AS N
   FOR EACH ROW
BEGIN ATOMIC
    SET N.a = 'hello', N.b = 'goodbye';
END;

INSERT INTO t1 VALUES ('Guten Tag', 'Auf Wiedersehen');
1 row inserted/updated/deleted

splice> SELECT * FROM t1;
A                             |B
-------------------------------------------------------------
hello                         |goodbye
```
{: .Example}

## Examples

This section presents examples of using database triggers.

### Example 1: Row Level AFTER Trigger

This example shows a row level trigger that is called after a row is
updated in the `employees` table. The action of this trigger is to
insert one record into the audit trail table (`employees_log`) for each
record that gets updated in the `employees` table.

<div class="preWrapperWide" markdown="1">
    CREATE TRIGGER log_salary_increase
    AFTER UPDATE ON employees FOR EACH ROW
    INSERT INTO employees_log
        (emp_id, log_date, new_salary, action)
        VALUES ( new.empno, CURRENT_DATE,  new.salary, 'NEW SALARY');
{: .Example xml:space="preserve"}

</div>
If you then issue following statement to update salaries of all
employees in the PD department:

<div class="preWrapperWide" markdown="1">
    UPDATE employees
     SET salary = salary + 1000.0
     WHERE department = 'PD';
{: .Example xml:space="preserve"}

</div>
Then the trigger will fire once (and one audit record will be
inserted) for each employee in the department named `PD`.

### Example 2: Row Level After Trigger

This example shows a row level trigger that is called after a row is
updated in the `employees` table. The action of this trigger is to
insert one record into the audit trail table (`employees_log`) for each
record that gets updated in the `employees` table.

<div class="preWrapperWide" markdown="1">
    CREATE TRIGGER log_salary_increase
    AFTER UPDATE ON employees
    REFERENCING NEW as NEW
    FOR EACH ROW
      INSERT INTO employees_log
        (emp_id, log_date, new_salary, action)
        VALUES (NEW.empno, CURRENT_DATE, NEW.salary, 'NEW SALARY');
{: .Example xml:space="preserve"}

</div>
If you then issue the same Update statement as used in the previous
example:

<div class="preWrapperWide" markdown="1">
    UPDATE employees SET salary = salary + 1000.0
    WHERE department = 'PD';
{: .Example xml:space="preserve"}

</div>
Then the trigger will fire once and exactly one record will be inserted
into the `employees_log` table for each record that is updated by the statement.

### Example 3: Statement Level Before Trigger

This example shows a row level trigger that is called before a row is
inserted into the `employees` table.

<div class="preWrapperWide" markdown="1">
    CREATE TRIGGER empUpdateTrig
    BEFORE UPDATE ON employees
       FOR EACH STATEMENT SELECT ID FROM myTbl;
{: .Example xml:space="preserve"}

</div>

### Example 4: Row Level with WHEN Clause

This example shows a row level trigger that is called after a row is updated in table `t1`, to insert a new row in table `t2`; the trigger only executes the insertion if the WHEN condition evaluates to `true`.

```
splice> CREATE TABLE t1 (a INT, b INT, PRIMARY KEY(a));
0 rows inserted/updated/deleted
splice> CREATE TABLE t2 (a INT, b INT);
0 rows inserted/updated/deleted
splice> INSERT INTO t1 VALUES (1,2);
1 row inserted/updated/deleted

splice> SELECT * FROM t1;
A          |B
-----------------------
1          |2

1 row selected

splice> SELECT * FROM t2;
A          |B
-----------------------

0 rows selected

splice> CREATE TRIGGER mytrig
>   AFTER UPDATE OF a,b
>   ON t1
>   REFERENCING OLD AS OLD_ROW NEW AS NEW_ROW
>   FOR EACH ROW
>     WHEN (NEW_ROW.a = OLD_ROW.b OR OLD_ROW.a = NEW_ROW.b)
>        INSERT INTO t2 values(OLD_ROW.a + 2, NEW_ROW.b - 40);
0 rows inserted/updated/deleted

splice> UPDATE t1 SET a=2;
1 row inserted/updated/deleted

splice> SELECT * FROM t1;
A          |B
-----------------------
2          |2

1 row selected

splice> SELECT * FROM t2;
A          |B
-----------------------
3          |-38

1 row selected
```
{: .Example}

### Example 5: Statement Trigger with Referencing Clause


This example shows a statement trigger that uses a `REFERENCING` clause.

```
splice> create table t1 (a int, b int, primary key(b));
0 rows inserted/updated/deleted
splice> create table t2 (a int, b int, primary key(b));
0 rows inserted/updated/deleted
splice> create table t3 (a_old int, a_new int);
0 rows inserted/updated/deleted
splice> insert into t1 values (1,12);
1 row inserted/updated/deleted
splice> insert into t1 values (2,34);
1 row inserted/updated/deleted
splice> insert into t1 values (3,56);
1 row inserted/updated/deleted
splice> insert into t1 values (4,78);
1 row inserted/updated/deleted
splice> insert into t2 select * from t1;
4 rows inserted/updated/deleted
splice> -- In the following trigger "OLD" and "NEW" are treated as independent tables
-- that contain the old version of updated rows (before the update took place),
-- and the new version of the updated rows (after the update took place).
CREATE TRIGGER mytrig
   AFTER UPDATE OF a,b
   ON t2
   REFERENCING OLD TABLE AS OLD NEW TABLE AS NEW
   FOR EACH STATEMENT
insert into t3 select OLD.A, NEW.A from OLD, NEW where OLD.B = NEW.B;
0 rows inserted/updated/deleted
splice> UPDATE t2 SET a=a*2 WHERE A >= 3;
2 rows inserted/updated/deleted
splice> -- Here we have collected the before value and after value of column A.
SELECT * from t3;
A_OLD|A_NEW
-----------
3|6
4|8
```
{: .Example}

### Example 6: Trigger with Multiple Statements

```
splice> CREATE TABLE base (col1 int, col2 int);
splice> CREATE TABLE t1(col1 int, col2 int);
splice> CREATE TABLE t2(col1 int, col2 int);
splice> CREATE TRIGGER multi_statement_trigger AFTER UPDATE OF
col1 ON base REFERENCING NEW AS N OLD AS O
FOR EACH ROW
WHEN (O.col1 <> N.col1)
BEGIN ATOMIC
  UPDATE t1 T
    SET T.col1 = N.col1 WHERE T.col2 = N.col2;
  UPDATE t2 D
    SET D.col1 = N.col1 WHERE D.col2 = N.col2;
END;
splice> select * from base;
COL1       |COL2
-----------------------
0          |0

splice> select * from t1;
COL1       |COL2
-----------------------
0          |0

splice> select * from t2;
COL1       |COL2
-----------------------
0          |0

splice> update base set col1 = 19 where col2 = 0;
splice> select * from base;
COL1       |COL2
-----------------------
19         |0

splice> select * from t1;
COL1       |COL2
-----------------------
19         |0

splice> select * from t2;
COL1       |COL2
-----------------------
19         |0

```
{: .Example}

## See Also

* [`CREATE TRIGGER`](sqlref_statements_createtrigger.html)
* [`DROP TRIGGER`](sqlref_statements_droptrigger.html)
* [Foreign keys](developers_fundamentals_foreignkeys.html)
* [`UPDATE`](sqlref_statements_update.html)
* [`WHERE`](sqlref_clauses_where.html)

</div>
</section>
