---
title: Syntax and Usage of SQL Identifiers
summary: Syntax, capitalization, and special character usage within Splice Machine queries.
keywords: identifier syntax
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_identifiers_syntax.html
folder: SQLReference/Identifiers
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SQL Identifier Syntax

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

This view name:

<div class="preWrapperWide" markdown="1">
    CREATE VIEW PitchingCoaches(RECEIVED) AS VALUES 1;
{: .Example xml:space="preserve"}

</div>
is stored in system catalogs as `PITCHINGCOACHES`, since it is not
quoted.

Whereas this view name:

<div class="preWrapperWide" markdown="1">
    CREATE VIEW "PitchingCoaches"(RECEIVED) AS VALUES 1;
{: .Example xml:space="preserve"}

</div>
is quoted, and thus is stored as `PitchingCoaches` in the system catalog

## Qualifying dictionary objects

Since some dictionary objects can be contained within other objects, you
can qualify those dictionary object names. Each component is separated
from the next by a period (`.`). You qualify a dictionary object name in
order to avoid ambiguity.

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
## Rules for SQL Identifiers   {#SQL92Rules}

Here are some additional rules that apply to SQLIdentifiers:
{: .body}

* Ordinary identifiers are identifiers not surrounded by double
  quotation marks:
  
  * An ordinary identifier must begin with a letter and contain only
    letters, underscore characters (`_`), and digits.
  * All Unicode letters and digits are permitted; however, Splice
    Machine does not attempt to ensure that the characters in
    identifiers are valid in the database's locale.
  {: .bullet}

* Delimited identifiers are identifiers surrounded by double quotation
  marks:
  
  * A delimited identifier can contain any characters within the double
    quotation marks.
  * The enclosing double quotation marks are not part of the identifier;
    they serve only to mark its beginning and end.
  * Spaces at the end of a delimited identifier are truncated.
  * You can use two consecutive double quotation marks within a
    delimited identifier to include a double quotation mark within the
    identifier.
  {: .bullet}

## Capitalization and Special Characters in SQL Statements

You can submit SQL statements to Splice Machine as strings by using
JDBC; these strings use the Unicode character set. Within these strings:

* Double quotation marks delimit special identifiers referred to in
  ANSI SQL as *delimited identifiers*.
* Single quotation marks delimit character strings.
* Within a character string, to represent a single quotation mark or
  apostrophe, use two single quotation marks. (In other words, a single
  quotation mark is the escape character for a single quotation mark).
* SQL keywords are case-insensitive. For example, you can type the
  keyword `SELECT` as `SELECT`, `Select`, `select`, or `sELECT`.
* ANSI SQL -style identifiers are case-insensitive unless they are
  delimited.
* Java-style identifiers are always case-sensitive.

### Other Special Characters:

* `*` is a wildcard within a *[Select
  Expression](sqlref_expressions_select.html#StarWildcard)*. It can also
  be the multiplication operator. In all other cases, it is a
  syntactical metasymbol that flags items you can repeat 0 or more
  times.
* `%` and `_` are character wildcards when used within character strings
  following a `LIKE` operator (except when escaped with an escape
  character). See [Boolean
  expressions](sqlref_expressions_boolean.html).
* Comments can be either single-line or multi-line, as per the ANSI SQL
  standard:
  
  * Single line comments start with two dashes (`--`) and end with the
    newline character.
  * Multi-line comments are bracketed and start with forward slash star
    (`/*`), and end with star forward slash (`*/`). Note that bracketed
    comments may be nested. Any text between the starting and ending
    comment character sequence is ignored.
  {: style="list-style-type: square;"}

</div>
</section>

