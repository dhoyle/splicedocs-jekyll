---
title: DROP PROCEDURE statement
summary: Drops a procedure from a database.
keywords: dropping a procedure
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_dropprocedure.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP PROCEDURE

The `DROP PROCEDURE` statement drops a procedure from your database.
Procedures are added to the database with the
[`CREATE PROCEDURE`](sqlref_statements_createprocedure.html) statement.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP PROCEDURE procedure-name
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
procedure-Name
{: .paramName}

The name of the procedure that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Usage

Use this statement to drop a statement from your database. It is valid
only if there is exactly one procedure instance with the
*procedure-name* in the schema. The specified procedure can have any
number of parameters defined for it.

An error will occur in any of the following circumstances:

* If no procedure with the indicated name exists in the named or implied
  schema (the error is SQLSTATE 42704)
* If there is more than one specific instance of the procedure in the
  named or implied schema
* If you try to drop a user-defined procedure that is invoked in the
  *[generation-clause](sqlref_statements_generationclause.html)* of a
  generated column
* If you try to drop a user-defined procedure that is invoked in a view

## Example

<div class="preWrapper" markdown="1">
    splice> DROP PROCEDURE SALES.TOTAL_REVENUE;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [Argument matching](sqlref_sqlargmatching.html)
* [`CREATE_PROCEDURE`](sqlref_statements_createprocedure.html) statement
* [`CURRENT_USER`](sqlref_builtinfcns_currentuser.html) function
* [Data Types](sqlref_datatypes_numerictypes.html)
* [Schema Name](sqlref_identifiers_types.html#SchemaName)
* [SQL Identifier](sqlref_identifiers_intro.html)
* [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) function
* [`USER`](sqlref_builtinfcns_user.html) function

</div>
</section>

