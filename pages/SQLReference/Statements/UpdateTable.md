---
title: UPDATE statement
summary: Updates values in a table.
keywords: updating a table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_update.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# UPDATE   {#Statements.Update}

Use the `UPDATE` statement to update existing records in a table.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    {
     UPDATE table-Name
       [[AS] correlation-Name]
       SET column-Name = Value
           [ , column-Name = Value} ]*
       [WHERE clause]
    } 
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the table to update.
{: .paramDefnFirst}

correlation-Name
{: .paramName}

An optional correlation name for the update.
{: .paramDefnFirst}

column-Name = Value
{: .paramName}

Sets the value of the named column to the named value in any records .
{: .paramDefnFirst}

*Value* is either an *[Expression](sqlref_expressions_about.html)* or
the literal `DEFAULT`. If you specify `DEFAULT` for a column's value,
the value is set to the default defined for the column in the table.
{: .paramDefn}

The `DEFAULT` literal is the only value that you can directly assign to
a generated column. Whenever you alter the value of a column referenced
by the *[generation-clause](sqlref_statements_generationclause.html)* of
a generated column, Splice Machine recalculates the value of the
generated column.
{: .paramDefn}

WHERE clause
{: .paramName}

Specifies the records to be updated.
{: .paramDefnFirst}

</div>
## Example

This example updates the Birthdate value for a specific player:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> UPDATE Players
       SET Birthdate='03/27/1987'
       WHERE DisplayName='Buddy Painter';
    1 row inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example updates the team name associated with all players on the
`Giants` team:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> UPDATE Players
       SET Team='SFGiants'
       WHERE Team='Giants';
    48 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## Statement dependency system

A searched update statement depends on the table being updated, all of
its conglomerates (units of storage such as heaps or indexes), all of
its constraints, and any other table named in the `DROP
			INDEX` statement or an [`ALTER
TABLE`](sqlref_statements_altertable.html) statement for the target
table of a prepared searched update statement invalidates the prepared
searched update statement.

A `CREATE` or `DROP INDEX` statement or an `ALTER TABLE` statement for
the target table of a prepared positioned update invalidates the
prepared positioned update statement.

Dropping an alias invalidates a prepared update statement if the latter
statement uses the alias.

Dropping or adding triggers on the target table of the update
invalidates the update statement.

## See Also

* [`ALTER TABLE`](sqlref_statements_altertable.html)statement
* [`CONSTRAINT`](sqlref_clauses_constraint.html)clause
* [`CREATE TABLE`](sqlref_statements_createtable.html)statement
* [`CREATE TRIGGER`](sqlref_statements_createtrigger.html)
* [`DROP INDEX`](sqlref_statements_dropindex.html)statement
* [`DROP TRIGGER`](sqlref_statements_droptrigger.html)
* [`WHERE`](sqlref_clauses_where.html)clause

</div>
</section>

