---
title: Identifiers in Splice Machine SQL
summary: A summary of the different identifier types you can use in Splice Machine SQL
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_identifiers_intro.html
folder: SQLReference/Identifiers
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Identifiers

This section contains the reference documentation for the Splice Machine
SQL Identifiers, in these topics:

* This page provides an introduction to `SQLIdentifiers`.
* The [SQL Identifier Syntax](sqlref_identifiers_syntax.html) topic
  contains additional information about `SQLIdentifier` naming rules,
  capitalization, and special characters.
* The [SQL Identifier Types](sqlref_identifiers_types.html) topic
  provides specific information about the different types of
  `SQLIdentifiers` that you'll find mentioned in this manual, including:
  
  * {: .nested value="1"} AuthorizationIdentifier
  * {: .nested value="2"} column-Name and simple-column-Name
  * {: .nested value="3"} constraint-Name
  * {: .nested value="4"} correlation-Name
  * {: .nested value="5"} index-Name
  * {: .nested value="6"} new-Table-Name
  * {: .nested value="7"} RoleName
  * {: .nested value="8"} schemaName
  * {: .nested value="9"} synonym-Name
  * {: .nested value="10"} table-Name
  * {: .nested value="11"} triggerName
  * {: .nested value="12"} view-Name
  {: .codeList}

## About SQLIdentifiers   {#SQLIdentifier}

An SQLIdentifier is a dictionary object identifier that conforms to the
rules of ANSI SQL; identifiers for dictionary objects:

* are limited to 128 characters
* are automatically translated into uppercase by the system, making them
  case-insensitive unless delimited by double quotes
* cannot be a [Splice Machine SQL keyword](sqlref_sqlreserved.html)
  unless delimited by double quotes
* can sometimes be qualified by a schema, table, or correlation name, as
  described below

### Examples:

Here is an example of a simple, unqualified SQLIdentifier used to name a
table:

<div class="preWrapperWide" markdown="1">
    CREATE TABLE Coaches( ID INT NOT NULL );
{: .Example xml:space="preserve"}

</div>
And here's an example of a table name (`Coaches`) qualified by a schema
name (`Baseball`):

<div class="preWrapperWide" markdown="1">
    CREATE TABLE Baseball.Coaches( ID INT NOT NULL );
{: .Example xml:space="preserve"}

</div>
This view name is stored in system catalogs as `PITCHINGCOACHES`, since
it is not quoted:

<div class="preWrapperWide" markdown="1">
    CREATE VIEW PitchingCoaches(RECEIVED) AS VALUES 1;
{: .Example xml:space="preserve"}

</div>
Whereas this view name is quoted, and thus is stored as
`PitchingCoaches` in the system catalog:

<div class="preWrapperWide" markdown="1">
    CREATE VIEW "PitchingCoaches"(RECEIVED) AS VALUES 1;
{: .Example xml:space="preserve"}

</div>
Complete syntax, including information about case sensitivity and
special character usage, in SQL Identifier types is found in the
[SQL Identifier Syntax](sqlref_identifiers_syntax.html) topic in this
section.
{: .noteIcon}

</div>
</section>

