---
title: SET SCHEMA statement
summary: Sets the default schema for a connection's session.
keywords: default schema, setting schema, change schema, changing schema
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_setschema.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SET SCHEMA

The `SET SCHEMA` statement sets the default schema for a connection's
session to the designated schema. The default schema is used as the
target schema for all statements issued from the connection that do not
explicitly specify a schema name.

The target schema must exist for the `SET SCHEMA` statement to succeed.
If the schema doesn't exist an error is returned.

The `SET SCHEMA` statement is not transactional: if the `SET SCHEMA`
statement is part of a transaction that is rolled back, the schema
change remains in effect.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SET [CURRENT] SCHEMA [=] schemaName
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the schema; this name is not case sensitive.
{: .paramDefnFirst}

</div>
## Examples

These examples are equivalent:
{: .body}

<div class="preWrapperWide" markdown="1">

    splice> SET SCHEMA BASEBALL;
    0 rows inserted/updated/deleted

    splice> SET SCHEMA Baseball;
    0 rows inserted/updated/deleted

    splice> SET CURRENT SCHEMA BaseBall;
    0 rows inserted/updated/deleted

    splice> SET CURRENT SQLID BASEBALL;
    0 rows inserted/updated/deleted

    splice> SET SCHEMA "BASEBALL";
    0 rows inserted/updated/deleted

    splice> SET SCHEMA 'BASEBALL'
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

These fail because of case sensitivity:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SET SCHEMA "Baseball";
    ERROR 42Y07: Schema 'Baseball' does not exist

    splice> SET SCHEMA 'BaseBall';
    ERROR 42Y07: Schema 'BaseBall' does not exist
{: .Example xml:space="preserve"}
</div>

Here's an example using a prepared statement:
{: .body}

<div class="preWrapperWide" markdown="1">
    PreparedStatement ps = conn.PrepareStatement("set schema ?");
    ps.setString(1,"HOTEL");
    ps.executeUpdate();
      ... these work:
    ps.setString(1,"SPLICE");

    ps.executeUpdate();
    ps.setString(1,"splice");       //error - string is case sensitive
        // no app will be found
     ps.setNull(1, Types.VARCHAR); //error - null is not allowed
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE SCHEMA`](sqlref_statements_createschema.html) statement
* [`DROP SCHEMA`](sqlref_statements_dropschema.html) statement
* [Schema Name](sqlref_identifiers_types.html#SchemaName)

</div>
</section>
