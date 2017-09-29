---
title: RENAME INDEX statement
summary: Renames an index in the current schema.
keywords: renaming an index
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_renameindex.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RENAME INDEX

The `RENAME INDEX` statement allows you to rename an index in the
current schema. Users cannot rename indexes in the `SYS` schema.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RENAME INDEX index-Name TO new-index-Name
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
index-Name
{: .paramName}

The name of the index to be renamed.
{: .paramDefnFirst}

new-Index-Name
{: .paramName}

The new name for the index.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> RENAME INDEX myIdx TO Player_index;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`ALTER`](sqlref_statements_altertable.html) statement

</div>
</section>

