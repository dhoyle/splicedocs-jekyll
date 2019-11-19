---
title: CREATE SYNONYM statement
summary:  Creates a synonym/alias, which can provide an alternate namefor a table or a view.
keywords: creating a synonym
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_createsynonym.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE SYNONYM

The `CREATE SYNONYM` statement allows you to create an alternate name
for a table or a view.

<p class="noteIcon">Aliases and synonyms are exactly the same and can be used interchangeably, which means that you can use <code>CREATE SYNONYM</code> and <code><a href="sqlref_statements_createalias.html">CREATE ALIAS</a></code> and interchangeably.</p>

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE SYNONYM( <a href="sqlref_identifiers_types.html#SynonymName">synonymName</a>
                FOR { <a href="sqlref_identifiers_types.html#ViewName">viewName</a> | <a href="sqlref_identifiers_types.html#TableName">tableName</a> } );</pre>

</div>
<div class="paramList" markdown="1">
synonymName
{: .paramName}

An [SQLIdentifier](sqlref_identifiers_intro.html), which can optionally
include a schema name. This is the new, alternative name you want to create for the view or table.
{: .paramDefnFirst}

viewName
{: .paramName}

An [SQLIdentifier](sqlref_identifiers_intro.html) that identifies the
view for which you are creating a synonym.
{: .paramDefnFirst}

tableName
{: .paramName}

An [SQLIdentifier](sqlref_identifiers_intro.html) that identifies the
table for which you are creating a synonym.
{: .paramDefnFirst}

</div>
## Usage

Here are a few important notes about using synonyms:

* Synonyms/Aliases share the same name space as tables or views. You cannot
  create a synonym/alias with the same name as a table that already exists in
  the same schema. Similarly, you cannot create a table or view with a
  name that matches a synonym/alias that is already present.
* You can create a synonym/alias for a table or view that does not yet exist;
  however, you can only use the synonym/alias if the table or view is present
  in your database.
* You can create synonyms/aliases for other synonyms/aliases (nested synonyms); however, an error will occur if you attempt to create one that results in  a circular reference.
* You cannot create synonyms/aliases in system schemas. Any schema that starts  with `SYS` is a system schema.
* You cannot define a synonym/alias for a temporary table.

## Example

<div class="preWrapper" markdown="1">
    splice> CREATE SYNONYM Hitting FOR Batting;
    0 rows inserted/updated/deleted

    splice> SELECT ID, Games FROM Batting WHERE ID < 11;
    ID    |GAMES
    -------------
    1     |150
    2     |137
    3     |100
    4     |143
    5     |149
    6     |93
    7     |133
    8     |52
    9     |115
    10    |100

    0 rows inserted/updated/deleted

    splice> SELECT ID, Games FROM Hitting WHERE ID < 11;
    ID    |GAMES
    -------------
    1     |150
    2     |137
    3     |100
    4     |143
    5     |149
    6     |93
    7     |133
    8     |52
    9     |115
    10    |100

    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also


* [`CREATE ALIAS`](sqlref_statements_createalias.html) statement
* [`DROP ALIAS`](sqlref_statements_dropalias.html) statement
* [`DROP SYNONYM`](sqlref_statements_dropsynonym.html) statement
* [`SHOW ALIASES`](cmdlineref_showaliases.html) command
* [`SHOW SYNONYMS`](cmdlineref_showsynonyms.html) command

</div>
</section>
