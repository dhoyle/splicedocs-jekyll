---
title: DROP TRIGGER statement
summary: Drops a trigger from a database.
keywords: dropping a trigger
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_droptrigger.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP TRIGGER

The `DROP TRIGGER` statement removes the specified trigger.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP TRIGGER TriggerName
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
TriggerName
{: .paramName}

The name of the trigger that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> DROP TRIGGER UpdateSingles;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## Statement dependency system

When a table is dropped, all triggers on that table are automatically
dropped; this means that do not have to drop a table's triggers before
dropping the table.

## See Also

* [Database Triggers](developers_fundamentals_triggers.html) in the
  *Developer's Guide*
* [`CREATE TRIGGER`](sqlref_statements_createtrigger.html) statement

</div>
</section>

