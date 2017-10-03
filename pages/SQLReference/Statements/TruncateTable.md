---
title: TRUNCATE TABLE statement
summary: Resets a table to its initial empty state.
keywords: truncating a table, resetting a table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_truncatetable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TRUNCATE TABLE

The `TRUNCATE TABLE` statement allows you to quickly remove all content
from the specified table and return it to its initial empty state.

To truncate a table, you must either be the database owner or the table
owner.

You cannot truncate system tables or global temporary tables with this
statement.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
TRUNCATE TABLE <a href="sqlref_identifiers_types.html#TableName">table-Name</a></pre>

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the table to truncate.
{: .paramDefnFirst}

</div>
## Examples

To truncate the entire `Players_Test` table, use the following
statement:

<div class="preWrapper" markdown="1">
    splice> TRUNCATE TABLE Players_Test;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
</div>
</section>
