---
title: NEXT VALUE FOR Expression
summary: Describes the NEXT VALUE FOR expression, which retrieves the next value from a sequence generator.
keywords: sequences, find next value, sequence, increment
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_nextvaluefor.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NEXT VALUE FOR Expression   {#Expressions.NextValueFor}

The `NEXT VALUE FOR` expression retrieves the next value from a sequence
generator that was created with a [`CREATE SEQUENCE`
statement](sqlref_statements_createsequence.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    NEXT VALUE FOR sequenceName
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
sequenceName
{: .paramName}

A sequence name is an identifier that can optionally be qualified by a
schema name:
{: .paramDefnFirst}

<div class="fcnWrapperWide" markdown="1">
    [ SQLIdentifier
{: .FcnSyntax}

</div>
If *schemaName* is not provided, the current schema is the default
schema. If a qualified sequence name is specified, the schema name
cannot begin with the `SYS. `prefix.
{: .paramDefnFirst}

</div>
## Usage

If this is the first use of the sequence generator, the generator
returns its `START` value. Otherwise, the `INCREMENT` value is added to
the previous value returned by the sequence generator. The data type of
the value is the *dataType* specified for the sequence generator.

If the sequence generator wraps around, then one of the following
happens:

* If the sequence generator was created using the `CYCLE` keyword, the
  sequence generator is reset to its `START` value.
* If the sequence generator was created with the default `NO CYCLE`
  behavior, Splice Machine throws an exception.

In order to retrieve the next value of a sequence generator, you or your
session's current role must have `USAGE` privilege on the generator.

A `NEXT VALUE FOR` expression may occur in the following places:

* [`SELECT` statement](sqlref_expressions_select.html): As part of the
  expression defining a returned column in a `SELECT` list
* [`VALUES` expression](sqlref_expressions_values.html): As part of the
  expression defining a column in a row constructor (`VALUES`
  expression)
* [`UPDATE` statement](sqlref_statements_update.html); As part of the
  expression defining the new value to which a column is being set

The next value of a sequence generator is not affected by whether the
user commits or rolls back a transaction which invoked the sequence
generator.

## Restrictions

Only one `NEXT VALUE FOR` expression is allowed per sequence per
statement.

The `NEXT VALUE FOR` expression is not allowed in any statement which
has a `DISTINCT` or `ORDER BY` expression.

A `NEXT VALUE` expression **may not appear** in any of these situations:

* [`CASE`](sqlref_expressions_case.html) expression
* [`WHERE`](sqlref_clauses_where.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [Aggregate expression](sqlref_builtinfcns_windowfcnsintro.html)
* [Window functions](sqlref_builtinfcns_windowfcnsintro.html)
* [`ROW_NUMBER`](sqlref_builtinfcns_rownumber.html) function
* `DISTINCT` select list

## Examples

<div class="preWrapper" markdown="1">
    VALUES (NEXT VALUE FOR order_id);
    
    INSERT INTO re_order_table
      SELECT NEXT VALUE FOR order_id, order_date, quantity
      FROM orders
      WHERE back_order = 1;
    
    UPDATE orders
      SET oid = NEXT VALUE FOR order_id
      WHERE expired = 1;
{: .Example}

</div>
## See Also

* [`CREATE SEQUENCE`](sqlref_statements_createsequence.html) function
* [`SELECT`](sqlref_expressions_select.html) statement
* [`VALUES`](sqlref_expressions_values.html) expression
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>

