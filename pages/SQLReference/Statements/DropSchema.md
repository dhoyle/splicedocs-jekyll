---
title: DROP SCHEMA statement
summary: Drops a schema from a database.
keywords: dropping a schema
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_dropschema.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP SCHEMA   {#Statements.DropSchema}

The `DROP SCHEMA` statement drops a schema. The target schema must be
empty for the drop to succeed.

Neither the *SPLICE* schema (the default user schema) nor the *SYS*
schema can be dropped.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP SCHEMA schemaName RESTRICT
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
schema
{: .paramName}

The name of the schema that you want to drop from your database.
{: .paramDefnFirst}

RESTRICT
{: .paramName}

This is **required**. It enforces the rule that the schema cannot be
deleted from the database if there are any objects defined in the
schema.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapperWide" markdown="1">
    splice> DROP SCHEMA Baseball_Stats RESTRICT;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE SCHEMA`](sqlref_statements_createschema.html) statement
* [Schema Name](sqlref_identifiers_types.html#SchemaName)
* [`SET SCHEMA`](sqlref_statements_setschema.html) statement

</div>
</section>

