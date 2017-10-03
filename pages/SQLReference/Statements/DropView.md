---
title: DROP VIEW statement
summary: Drops a view from a database.
keywords: dropping a view
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_dropview.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP VIEW

The `DROP VIEW` statement drops the specified view.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
DROP VIEW <a href="sqlref_identifiers_types.html#ViewName">view-Name</a></pre>

</div>
<div class="paramList" markdown="1">
view-Name
{: .paramName}

The name of the viewthat you want to drop from your database.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> DROP VIEW PlayerAges;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## Statement dependency system

Any statements referencing the view are invalidated on a `DROP VIEW`
statement.

## See Also

* [`CREATE VIEW`](sqlref_statements_createview.html) statement
* [`ORDER BY`](sqlref_clauses_orderby.html) clause

</div>
</section>
