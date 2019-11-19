---
title: CREATE SEQUENCE statement
summary: Creates a sequence generator, which is&#xA;  a mechanism for generating exact numeric values, one at a time.
keywords: creating a sequence
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_createsequence.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE SEQUENCE

The `CREATE SEQUENCE` statement creates a sequence generator, which is a
mechanism for generating exact numeric values, one at a time.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE SEQUENCE
   [ <a href="sqlref_identifiers_intro.html">SQL Identifier</a> ]
   [ sequenceElement ]*</pre>

</div>
The sequence name is composed of an optional *schemaName* and a *SQL
Identifier*. If a *schemaName* is not provided, the current schema is
the default schema. If a qualified sequence name is specified, the
schema name cannot begin with SYS.

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

The name of the sequence
{: .paramDefnFirst}

sequenceElement
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    {
      AS dataType
       | START WITH startValue
       | INCREMENT BY incrementValue
       | MAXVALUE maxValue | NO MAXVALUE
       | MINVALUE minValue | NO MINVALUE
       | CYCLE | NO CYCLE
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramListNested" markdown="1">
dataType
{: .paramName}

If specified, the *dataType* must be an integer type (`TINYINT`, `SMALLINT`, `INT`,
or `BIGINT`). If not specified, the default data type is `INT`.
{: .paramDefnFirst}

startValue
{: .paramName}

If specified, this is a signed integer representing the first value
returned by the sequence object. The `START` value must be a value less
than or equal to the maximum and greater than or equal to the minimum
value of the sequence object.
{: .paramDefnFirst}

The default start value for a new ascending sequence object is the
minimum value. The default start value for a descending sequence objest
is the maximum value.
{: .paramDefn}

incrementValue
{: .paramName}

If specifed, the `incrementValue` is a non-zero signed integer value
that fits in a *DataType* value.
{: .paramDefnFirst}

If this is not specified, the `INCREMENT` defaults to `1`. If
`incrementValue` is positive, the sequence numbers get larger over time;
if it is negative, the sequence numbers get smaller over time.
{: .paramDefn}

minValue
{: .paramName}

If specified, `minValue` must be a signed integer that fits in a
*DataType* value.
{: .paramDefnFirst}

If `minValue`is not specified, or if `NO MINVALUE`is specified, then
`minValue`defaults to the smallest negative number that fits in a
*DataType* value.
{: .paramDefn}

maxValue
{: .paramName}

If specified, `maxValue` must be a signed integer that fits in a
*DataType* value.
{: .paramDefnFirst}

If `maxValue`is not specified, or if `NO MAXVALUE`is specified, then
`maxValue`defaults to the largest positive number that fits in a
*DataType* value.
{: .paramDefn}

Note that the `maxValue` must be greater than the `minValue`.
{: .paramDefn}

CYCLE
{: .paramName}

The `CYCLE` clause controls what happens when the sequence generator
exhausts its range and wraps around.
{: .paramDefnFirst}

If `CYCLE` is specified, the wraparound behavior is to reinitialize the
sequence generator to its `START` value.
{: .paramDefn}

If `NO CYCLE` is specified, Splice Machine throws an exception when the
generator wraps around. The default behavior is `NO CYCLE`.
{: .paramDefn}

</div>
</div>
To retrieve the next value from a sequence generator, use a &nbsp;[`NEXT VALUE
FOR` expression](sqlref_expressions_nextvaluefor.html).

## Usage Privileges

The owner of the schema where the sequence generator lives automatically
gains the `USAGE` privilege on the sequence generator, and can grant
this privilege to other users and roles. Only the database owner and the
owner of the sequence generator can grant these `USAGE` privileges. The
`USAGE` privilege cannot be revoked from the schema owner. See &nbsp;[`GRANT
statement`](sqlref_statements_grant.html) and &nbsp;[`REVOKE
statement`](sqlref_statements_revoke.html) for more information.

## Performance

To boost performance and concurrency, Splice Machine pre-allocates
ranges of upcoming values for sequences. The lengths of these ranges can
be configured by adjusting the value of the
`derby.language.sequence.preallocator` property.

## Examples

The following statement creates a sequence generator of type `INT`, with
a start value of `-2147483648` (the smallest `INT` value). The value
increases by `1`, and the last legal value is the largest possible
`INT`. If `NEXT VALUE FOR` is invoked on the generator after it reaches
its maximum value, Splice Machine throws an exception.

<div class="preWrapper" markdown="1">
    splice> CREATE SEQUENCE order_id;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example creates a player ID sequence that starts with the integer
value `100`:

<div class="preWrapper" markdown="1">
    splice> CREATE SEQUENCE PlayerID_seq 
       START WITH 100;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
The following statement creates a sequence of type `BIGINT` with a start
value of `3,000,000,000`. The value increases by `1`, and the last legal
value is the largest possible `BIGINT`. If `NEXT VALUE FOR` is invoked
on the generator after it reaches its maximum value, Splice Machine
throws an exception.

<div class="preWrapper" markdown="1">
    splice> CREATE SEQUENCE order_entry_id
       AS BIGINT
       START WITH 3000000000;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DROP SEQUENCE`](sqlref_statements_dropsequence.html) statement
* [`GRANT`](sqlref_statements_grant.html) statement
* [`Next Value For`](sqlref_expressions_nextvaluefor.html) expression
* [`REVOKE`](sqlref_statements_revoke.html) statement
* [Schema Name](sqlref_identifiers_types.html#SchemaName)
* [SQL Identifier](sqlref_identifiers_intro.html)

</div>
</section>
