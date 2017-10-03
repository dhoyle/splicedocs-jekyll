---
title: RENAME COLUMN statement
summary: Renames a column in a table.
keywords: renaming a column
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_renamecolumn.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RENAME COLUMN

Use the `RENAME COLUMN` statement to rename a column in a table.

The `RENAME COLUMN` sactatement allows you to rename an existing column
in an existing table in any schema (except the schema `SYS`).

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
RENAME COLUMN <a href="sqlref_identifiers_types.html#SimpleColumnName">simple-Column-Name</a>
  TO <a href="sqlref_identifiers_types.html#SimpleColumnName">simple-Column-Name</a></pre>

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the table containing the column to rename.
{: .paramDefnFirst}

simple-Column-Name
{: .paramName}

The name of the column to be renamed.
{: .paramDefnFirst}

simple-Column-Name
{: .paramName}

The new name for the column.
{: .paramDefnFirst}

</div>
## Usage Notes

To rename a column, you must either be the database owner or the table
owner.

To perform other table alterations, see the &nbsp;[`ALTER TABLE`
statement](sqlref_statements_altertable.html).

If a view, <span>trigger, </span>check constraint, or
*[generation-clause](sqlref_statements_generationclause.html)* of a
generated column references the column, an attempt to rename it will
generate an error.
{: .noteRestriction}

The RENAME COLUMN statement is not allowed if there are any open cursors
that reference the column that is being altered.
{: .noteNote}

If there is an index defined on the column, the column can still be
renamed; the index is automatically updated to refer to the column by
its new name.
{: .noteNote}

## Examples

To rename the `Birthdate` column in table `Players` to `BornDate`, use
the following syntax:

<div class="preWrapper" markdown="1">
    splice> RENAME COLUMN Players.Birthdate TO BornDate;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
If you want to modify a column's data type, you can combine `ALTER
TABLE`, `UPDATE`, and `RENAME COLUMN` using these steps, as show in the
example below:

1.  Add a new column to the table with the new data type
2.  Copy the values from the "old" column to the new column with an
    UPDATE statement.
3.  Drop the "old" column.
4.  Rename the new column with the old column's name.

<div class="preWrapper" markdown="1">

    splice> ALTER TABLE Players ADD COLUMN NewPosition VARCHAR(8);
    0 rows inserted/updated/deleted

    splice> UPDATE Players SET NewPosition = Position;
    0 rows inserted/updated/deleted

    splice> ALTER TABLE Players DROP COLUMN Position;
    0 rows inserted/updated/deleted

    splice> RENAME COLUMN Players.NewPosition TO Position;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`ALTER`](sqlref_statements_altertable.html) statement

</div>
</section>
