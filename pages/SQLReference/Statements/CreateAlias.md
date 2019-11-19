---
title: CREATE ALIAS statement
summary:  Creates an alias/synonym, which can provide an alternate name for a table or a view.
keywords: creating an alias
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_createalias.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE ALIAS

The `CREATE ALIAS` statement allows you to create an alternate name
for a table or a view.

<p class="noteIcon">Aliases and synonyms are exactly the same and can be used interchangeably, which means that you can use <code>CREATE ALIAS</code> and <code><a href="sqlref_statements_createsynonym.html">CREATE SYNONYM</a></code> interchangeably.</p>

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE ALIAS( <a href="sqlref_identifiers_types.html#AliasName">aliasName</a>
                FOR { <a href="sqlref_identifiers_types.html#ViewName">viewName</a> | <a href="sqlref_identifiers_types.html#TableName">tableName</a> } );</pre>

</div>
<div class="paramList" markdown="1">
aliasName
{: .paramName}

An [SQLIdentifier](sqlref_identifiers_intro.html), which can optionally
include a schema name. This is the new, alternative name you want to create for the
view or table.
{: .paramDefnFirst}

viewName
{: .paramName}

An [SQLIdentifier](sqlref_identifiers_intro.html) that identifies the
view for which you are creating an alias.
{: .paramDefnFirst}

tableName
{: .paramName}

An [SQLIdentifier](sqlref_identifiers_intro.html) that identifies the
table for which you are creating an alias.
{: .paramDefnFirst}

</div>
## Usage

Here are a few important notes about using aliases:

* Aliases/Synonyms share the same name space as tables or views. You cannot
  create an alias/synonym with the same name as a table that already exists in
  the same schema. Similarly, you cannot create a table or view with a
  name that matches an alias/synonym that is already present.
* You can create an alias/synonyn for a table or view that does not yet exist;
  however, you can only use the alias/synonym if the table or view is present
  in your database.
* You can create aliases/synonyms for other aliases/synonyms (nested aliases); however, an error will occur if you attempt to create one that results in a circular reference.
* You cannot create aliases/synonyms in system schemas. Any schema that starts with `SYS` is a system schema.
* You cannot define an alias/synonym for a temporary table.

## Example

<div class="preWrapper" markdown="1">
    splice> CREATE ALIAS Hitting FOR Batting;
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

* [`CREATE SYNONYM`](sqlref_statements_createsynonym.html) statement
* [`DROP ALIAS`](sqlref_statements_dropalias.html) statement
* [`DROP SYNONYM`](sqlref_statements_dropsynonym.html) statement
* [`SHOW ALIASES`](cmdlineref_showaliases.html) command
* [`SHOW SYNONYMS`](cmdlineref_showsynonyms.html) command

</div>
</section>
