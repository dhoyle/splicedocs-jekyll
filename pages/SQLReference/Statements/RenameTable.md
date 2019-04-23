---
title: RENAME TABLE statement
summary: Renames an existing table in a schema.
keywords: renaming a table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_renametable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RENAME TABLE

The `RENAME TABLE` statement allows you to rename an existing table in
any schema (except the schema `SYS`).

To rename a table, you must either be the database owner or the table
owner.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RENAME TABLE table-Name TO new-Table-Name
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the table to be renamed.
{: .paramDefnFirst}

new-Table-Name
{: .paramName}

The new name for the table.
{: .paramDefnFirst}

</div>
## Usage Notes

Attempting to rename a table generates an error if:

* there is a view or a foreign key that references the table
* there are any check constraints <span>or triggers </span>on the table

## Example

<div class="preWrapper" markdown="1">
    splice> RENAME TABLE MorePlayers to PlayersTest;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
See the &nbsp;[`ALTER TABLE` statement](sqlref_statements_altertable.html) for
more information.

</div>
</section>

