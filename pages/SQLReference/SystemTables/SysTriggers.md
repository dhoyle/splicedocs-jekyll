---
title: SYSTRIGGERS system table
summary: System table that describes the database's triggers.
keywords: triggers table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_systriggers.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTRIGGERS System Table

The `SYSTRIGGERS` table describes the database's triggers. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSTRIGGERS` system
table.

<table>
    <caption>SYSTRIGGERS system table</caption>
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Length</th>
            <th>Nullable</th>
            <th>Contents</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>TRIGGERID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the trigger</td>
        </tr>
        <tr>
            <td><code>TRIGGERNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Name of the trigger</td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>ID of the trigger's schema (join with <code>SYSSCHEMAS.SCHEMAID</code>)</td>
        </tr>
        <tr>
            <td><code>CREATIONTIMESTAMP</code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>Time the trigger was created</td>
        </tr>
        <tr>
            <td><code>EVENT</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">Possible values are:</p>
                <ul>
                    <li><code>'U'</code> for update</li>
                    <li><code>'D'</code> for delete</li>
                    <li><code>'I</code>' for insert</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>FIRINGTIME</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">Possible values are:</p>
                <ul>
                    <li><code>'B'</code> for before</li>
                    <li><code>'A'</code> for after</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>TYPE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">Possible values are:</p>
                <ul>
                    <li><code>'R'</code> for row</li>
                    <li><code>'S'</code> for statement</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>STATE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>
                <p class="noSpaceAbove">Possible values are:</p>
                <ul>
                    <li><code>'E'</code> for enabled</li>
                    <li><code>'D'</code> for disabled</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>TABLEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>ID of the table on which the trigger is defined</td>
        </tr>
        <tr>
            <td><code>WHENSTMTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>YES</code></td>
            <td>Used only if there is a <code>WHEN</code> clause (not yet supported)</td>
        </tr>
        <tr>
            <td><code>ACTIONSTMTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>YES</code></td>
            <td>ID of the stored prepared statement for a single triggered SQL statement (join with <code>SYSSTATEMENTS.STMTID</code>).</td>
        </tr>
        <tr>
            <td><code>ACTIONSTMTIDLIST</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>YES</code></td>
            <td>A list of the IDs of the stored prepared statements for a trigger with multiple SQL statements. <code>NULL</code> for single statements.</td>
        </tr>
        <tr>
            <td><code>REFERENCEDCOLUMNS</code></td>
            <td class="CodeFont">org.apache.Splice Machine.<br />catalog.ReferencedColumns</td>
            <td><code>-1</code></td>
            <td><code>YES</code></td>
            <td><p>Descriptor of the columns to be updated, if this trigger is an update trigger (that is, if the <code>EVENT</code> column contains <code>'U'</code>)</p>
                <p>This class is not part of the public API.</p></td>
        </tr>
        <tr>
            <td><code>TRIGGERDEFINITION</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>2,147,483,647</code></td>
            <td><code>YES</code></td>
            <td>Text of the action SQL statement</td>
        </tr>
        <tr>
            <td><code>TRIGGERDEFINITIONLIST</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>2,147,483,647</code></td>
            <td><code>YES</code></td>
            <td>The trigger definition list for a trigger with multiple SQL statements. <code>NULL</code> for single statements.</td>
        </tr>
        <tr>
            <td><code>REFERENCINGOLD</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>YES</code></td>
            <td>Whether or not the <code>OLDREFERENCINGNAME</code>, if non-null, refers
		to the <code>OLD</code> row or table</td>
        </tr>
        <tr>
            <td><code>REFERENCINGNEW </code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>YES</code></td>
            <td>Whether or not the <code>NEWREFERENCINGNAME</code>, if non-null, refers
		to the <code>NEW</code> row or table</td>
        </tr>
        <tr>
            <td><code>OLDREFERENCINGNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>YES</code></td>
            <td>Pseudoname as set using the <code>REFERENCING OLD AS</code> clause</td>
        </tr>
        <tr>
            <td><code>NEWREFERENCINGNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>YES</code></td>
            <td>Pseudoname as set using the <code>REFERENCING NEW AS</code> clause </td>
        </tr>
        <tr>
            <td><code>WHENCLAUSETEXT</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>2,147,483,647</code></td>
            <td><code>YES</code></td>
            <td>The text of the <code>WHEN</code> clause for this trigger.</td>
        </tr>
    </tbody>
</table>

## Triggers with a Single Statement

Any SQL text that is part of a trigger with a single SQL statement is compiled and
stored in the `SYSSTATEMENTS` table. `ACTIONSTMTID` and `WHENSTMTID` are
foreign keys that reference `SYSSTATEMENTS.STMTID`. The statement for a
trigger is always in the same schema as the trigger.

## Triggers with Multiple Statements

To create a trigger with multiple statements:

1. Create the multiple statements in multiple rows of the `SYSSTATEMENTS` table.

2. Create a row for each statement in the `SYSDEPENDS` table. The rows in the `SYSDEPENDS` table should use the same `DEPENDENTID` value, and use the `PROVIDERID` value to point to the `STMTID` for the corresponding statement in the in the `SYSSTATEMENTS` table.

3. In the `SYSTRIGGERS` table, create a row whose `ACTIONSTMTID` has the value of the `DEPENDENTID` with multiple rows in the `SYSDEPENDS` table.

4. The `STMTID` column in the `SYSSTATEMENTS` table is checked for the value in the `ACTIONSTMTID` column of the `SYSTRIGGERS` table.

5. If a value is not found – as is the case for a trigger with multiple statements – the `DEPENDENTID` column in the `SYSDEPENDS` table is checked for the value in the `ACTIONSTMTID` column of the `SYSTRIGGERS` table.  

6. When the the value is found in the `DEPENDENTID` column in the `SYSDEPENDS` table, the `TRIGGERDEFINITIONLIST` and  `ACTIONSTMTIDLIST` columns of the `STSTRIGGERS` table are loaded with Java lists of the `TRIGGERDEFINITION` and `ACTIONSTMTID` values for the multiple statements.

7. The referenced multiple statements are executed when the trigger is activated.


## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSTRIGGERS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSTRIGGERS;
```
{: .Example}


</div>
</section>
