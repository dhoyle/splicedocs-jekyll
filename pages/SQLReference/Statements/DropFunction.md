---
title: DROP FUNCTION statement
summary: Drops a function from a database.
keywords: dropping functions
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_dropfunction.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DROP FUNCTION   {#Statements.DropFunction}

The `DROP FUNCTION` statement drops a function from your database.
Functions are added to the database with the
[`CREATE FUNCTION`](sqlref_statements_createfunction.html) statement.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DROP FUNCTION function-name
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
function-Name
{: .paramName}

The name of the function that you want to drop from your database.
{: .paramDefnFirst}

</div>
## Usage

Use this statement to drop a function from your database. It is valid
only if there is exactly one function instance with the *function-name*
in the schema. The specified function can have any number of parameters
defined for it.

An error will occur in any of the following circumstances:

* If no function with the indicated name exists in the named or implied
  schema (the error is SQLSTATE 42704)
* If there is more than one specific instance of the function in the
  named or implied schema
* If you try to drop a user-defined function that is invoked in the
  *[generation-clause](sqlref_statements_generationclause.html)* of a
  generated column
* If you try to drop a user-defined function that is invoked in a view

## Example

<div class="preWrapper" markdown="1">
    splice> DROP FUNCTION TO_DEGREES;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE FUNCTION`](sqlref_statements_createprocedure.html) statement

</div>
</section>

