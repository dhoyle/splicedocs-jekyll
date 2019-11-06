---
title: DROP ALIAS statement
summary: Drops an alias from a database.
keywords: dropping an alias
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_dropalias.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP ALIAS

The `DROP ALIAS` statement drops an alias that was previously defined
for a table or view.

<p class="noteIcon"><code>DROP ALIAS</code> and <code>DROP ALIAS</code> provide the same functionality.</p>

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
DROP ALIAS <a href="sqlref_identifiers_types.html#AliasName">aliasName</a></pre>

</div>
<div class="paramList" markdown="1">
aliasName
{: .paramName}

The name of the alias that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> DROP ALIAS Hitting;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also


* [`CREATE ALIAS`](sqlref_statements_createalias.html) statement
* [`CREATE SYNONYM`](sqlref_statements_createsynonym.html) statement
* [`DROP SYNONYM`](sqlref_statements_dropsynonym.html) statement
* [`SHOW ALIASES`](cmdlineref_showaliases.html) command
* [`SHOW SYNONYMS`](cmdlineref_showsynonyms.html) command

</div>
</section>
