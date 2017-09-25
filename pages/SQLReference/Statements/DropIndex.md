---
title: DROP INDEX statement
summary: Drops an index from a database.
keywords: dropping an index
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_dropindex.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP INDEX   {#Statements.DropIndex}

The `DROP INDEX` statement removes the specified index.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP INDEX index-Name
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
index-Name
{: .paramName}

The name of the index that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapper" markdown="1">
    splice> DROP INDEX myIdx;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE_INDEX`](sqlref_statements_createindex.html) statement
* [`DELETE`](sqlref_statements_delete.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>

