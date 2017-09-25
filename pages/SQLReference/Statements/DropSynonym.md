---
title: DROP SYNONYM statement
summary: Drops a synonym from a database.
keywords: dropping a synonym
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_dropsynonym.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP SYNONYM   {#Statements.DropSynonym}

The `DROP SYNONYM` statement drops a synonym that was previously defined
for a table or view.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP SYNONYM synonymName
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
synonymName
{: .paramName}

The name of the synonym that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> DROP SYNONYM Hitting;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE_SYNONYM`](sqlref_statements_createrole.html) statement
* [`SHOW SYNONYMS`](cmdlineref_showsynonyms.html) command in our
  *Developer's Guide*.

</div>
</section>

