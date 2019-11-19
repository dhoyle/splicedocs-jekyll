---
title: DROP TABLE statement
summary: Drops a table from a database.
keywords: dropping a table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_droptable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP TABLE

The `DROP TABLE` statement removes the specified table.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
DROP TABLE [IF EXISTS] <a href="sqlref_identifiers_types.html#TableName">table-Name</a></pre>

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the table that you want to drop from your database.
{: .paramDefnFirst}

</div>
<div markdown="1">
## Statement dependency system

Indexes and constraints , constraints (primary, unique, check and
references from the table being dropped) and triggers on the table are
silently dropped.

Dropping a table invalidates statements that depend on the table.
(Invalidating a statement causes it to be recompiled upon the next
execution. See [Interaction with the dependency
system](sqlref_statements_interactions.html).)

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> DROP TABLE Salaries;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`ALTER TABLE`](sqlref_statements_update.html) statement
* [`CREATE TABLE`](sqlref_statements_createtable.html) statement
* [`CONSTRAINT`](sqlref_clauses_constraint.html) clause

</div>
</section>
