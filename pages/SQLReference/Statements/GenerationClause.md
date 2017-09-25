---
title: generation-clause
summary: Describes the syntax and restrictions that apply to the generation clauses used to create virtual column values.
keywords: generated always as
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_generationclause.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# generation-clause   {#Statements.GenerationClause}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    GENERATED ALWAYS AS ( value-expression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
value-expression
{: .paramName}

An *[Expression](sqlref_expressions_about.html)* that resolves to a
single value, with some limitations:
{: .paramDefnFirst}

* The *generation-clause* may reference other non-generated columns in
  the table, but it must not reference any generated column. The
  *generation-clause* must not reference a column in another table.
* The *generation-clause* must not include subqueries.
* The *generation-clause* may invoke user-coded functions, if the
  functions meet the requirements in the [User Function
  Restrictions](#UserFunctions) section below.

</div>
## User Function Restrictions   {#UserFunctions}

The *generation-clause* may invoke user-coded functions, if the
functions meet the following requirements:

* The functions must not read or write SQL data.
* The functions must have been declared `DETERMINISTIC`.
* The functions must not invoke any of the following possibly
  non-deterministic system functions:
  * {: .CodeFont value="1"} [SESSION_USER](sqlref_builtinfcns_sessionuser.html)
  {: .SecondLevel}

## Example

<div class="preWrapperWide" markdown="1">
    CREATE TABLE employee(
      employeeID           int,
      name                 varchar( 50 ),
      caseInsensitiveName  GENERATED ALWAYS AS( UPPER( name ) )
      );
    
    CREATE INDEX caseInsensitiveEmployeeName
      ON employee( caseInsensitiveName );
{: .Example xml:space="preserve"}

</div>
</div>
</section>

