---
title: Using Database Triggers in Splice Machine
summary: Describes database triggers and how you can use them with Splice Machine.
keywords: triggers
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_triggers.html
folder: Developers/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Database Triggers

This topic describes database triggers and how you can use them with
Splice Machine.

## About Database Triggers

A database trigger is procedural code that is automatically executed in
response to certain events on a particular table or view in a database.
Triggers are mostly used for maintaining the integrity of the
information on the database; they are most commonly used to:

* automatically generate derived column values
* enforce complex security authorizations
* enforce referential integrity across nodes in a distributed database
* enforce complex business rules
* provide transparent event logging
* provide sophisticated auditing
* gather statistics on table access

### Components of a Trigger

Each trigger has two required components:

<table summary="Descriptions of trigger components.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Component</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Triggering event (or statement)</td>
                        <td>
                            <p class="noSpaceAbove">The SQL statement that causes a trigger to be fired. This can be one of the following types of statement:</p>
                            <ul>
                                <li class="CodeFont" value="1">INSERT</li>
                                <li class="CodeFont" value="2">UPDATE</li>
                                <li class="CodeFont" value="3">DELETE</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>Trigger action</td>
                        <td>
                            <p class="noSpaceAbove">The procedure that contains the SQL statements to be executed when a triggering statement is issued and any trigger restrictions evaluate to <code>TRUE</code>. </p>
                            <p>A trigger action is one of the following:</p>
                            <ul>
                                <li>arbitrary SQL</li>
                                <li>a call to a <a href="developers_fcnsandprocs_intro.html">user-defined stored procedure</a></li>
                            </ul>
                        </td>
                    </tr>
                </tbody>
            </table>
### When a Trigger Fires

You can define both statement and row triggers as either *before
triggers* or *after triggers*:

<table summary="Before triggers and after triggers.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Trigger Type</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Before Triggers</em></td>
                        <td>A before trigger fires before the statement's changes are applied and before any constraints have been applied.</td>
                    </tr>
                    <tr>
                        <td><em>After Triggers</em></td>
                        <td>An after trigger fires after all constraints have been satisfied and after the changes have been applied to the target table. </td>
                    </tr>
                </tbody>
            </table>
### How Often a Trigger Fires

You can define triggers as either *statement triggers* or *row
triggers*, which defines how often a trigger will fire for a triggering
event.

<table summary="Statement triggers and row triggers.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Trigger Type</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Statement Triggers</em></td>
                        <td>A statement trigger fires once per triggering event, regardless of how many rows (including zero rows) are modified by the event.</td>
                    </tr>
                    <tr>
                        <td><em>Row Triggers</em></td>
                        <td>
                            <p>A row trigger fires once for each row that is affected by the triggering event; for example, each row modified by an <code>UPDATE</code> statement. If no rows are affected by the event, the trigger does not fire.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
<div class="indented" markdown="1">
Triggers are statement triggers by default. You specify a row trigger in
the `FOR EACH` clause of the
[`CREATE TRIGGER`](sqlref_statements_createtrigger.html) statement.
{: .noteNote}

</div>
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
        VALUES (:new.empno, CURRENT_DATE, :new.salary, 'NEW SALARY');
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

### Example 2: Statement Level After Trigger

This example shows a statement level trigger that is called after the
`employees` table is updated. The action of this trigger is to insert
exactly one record into the change history table (`reviews_history`)
whenever the `employee_reviews` table is updated.

This example shows a row level trigger that is called after a row is
updated in the `employees` table. The action of this trigger is to
insert one record into the audit trail table (`employees_log`) for each
record that gets updated in the `employees` table.

<div class="preWrapperWide" markdown="1">
    CREATE TRIGGER log_salary_increase
    AFTER UPDATE ON employees referencing NEW as NEW FOR EACH ROW
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
into the `employees_log` table, no matter how many records are updated
by the statement.

### Example 3: Statement Level Before Trigger

This example shows a row level trigger that is called before a row is
inserted into the `employees` table.

<div class="preWrapperWide" markdown="1">
    CREATE TRIGGER empUpdateTrig
    BEFORE UPDATE ON employees
       FOR EACH STATEMENT SELECT ID FROM myTbl;
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE TRIGGER`](sqlref_statements_createtrigger.html)
* [`DROP TRIGGER`](sqlref_statements_droptrigger.html)
* [Foreign keys](developers_fundamentals_foreignkeys.html)
* [`UPDATE`](sqlref_statements_update.html)
* [`WHERE`](sqlref_clauses_where.html)

</div>
</section>
