---
title: DROP ALIAS statement
summary: Drops a synonym/alias from a database.
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

The `DROP ALIAS` statement drops an alias/synonym that was previously defined
for a table or view.

<p class="noteIcon">Aliases and synonyms are exactly the same and can be used interchangeably, which means that you can use either <code>DROP SYNONYM</code> or <code>DROP ALIAS</code> to drop a synonym/alias that was defined with either&nbsp;&nbsp;<code><a href="sqlref_statements_createsynonym.html">CREATE SYNONYM</a></code> or <code><a href="sqlref_statements_createalias.html">CREATE ALIAS</a></code>.</p>

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
DROP ALIAS <a href="sqlref_identifiers_types.html#AliasName">aliasName</a></pre>

</div>
<div class="paramList" markdown="1">
aliasName
{: .paramName}

The name of the alias/synonym that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Example

```
splice> CREATE ALIAS Hitting FOR Batting;
0 rows inserted/updated/deleted
splice> CREATE SYNONYM Goofs for Errors;
0 rows inserted/updated/deleted
splice> DROP ALIAS Hitting;
0 rows inserted/updated/deleted
splice> DROP ALIAS Goofs;
0 rows inserted/updated/deleted
```
{: .Example }

## See Also


* [`CREATE ALIAS`](sqlref_statements_createalias.html) statement
* [`CREATE SYNONYM`](sqlref_statements_createsynonym.html) statement
* [`DROP SYNONYM`](sqlref_statements_dropsynonym.html) statement
* [`SHOW ALIASES`](cmdlineref_showaliases.html) command
* [`SHOW SYNONYMS`](cmdlineref_showsynonyms.html) command

</div>
</section>
