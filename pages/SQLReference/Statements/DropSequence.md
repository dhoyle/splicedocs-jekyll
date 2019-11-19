---
title: DROP SEQUENCE statement
summary: Drops a sequence from a database.
keywords: dropping a sequence
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_dropsequence.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP SEQUENCE

The `DROP SEQUENCE` statement removes a sequence generator that was
created using a &nbsp;[`CREATE SEQUENCE`
statement](sqlref_statements_createsequence.html).

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
DROP SEQUENCE [ schemaName "." ] <a href="sqlref_identifiers_intro.html">SQL Identifier</a> RESTRICT</pre>

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema to which this sequence belongs. If you do not
specify a schema name, the current schema is assumed.
{: .paramDefnFirst}

You cannot use a schema name that begins with the `SYS.` prefix.
{: .paramDefn}

SQL Identifier
{: .paramName}

The name of the sequence.
{: .paramDefnFirst}

RESTRICT
{: .paramName}

This is **required**. It specifies that if a trigger or view references
the sequence generator, Splice Machine will throw an exception.
{: .paramDefnFirst}

</div>
## Usage

Dropping a sequence generator implicitly drops all `USAGE` privileges
that reference it.

## Example

<div class="preWrapper" markdown="1">
    splice> DROP SEQUENCE PLAYERID_SEQ RESTRICT;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE SEQUENCE`](sqlref_statements_createsequence.html) statement
* [Schema Name](sqlref_identifiers_types.html#SchemaName)

</div>
</section>
