---
title: Simple-column-Name
summary: Used in statements to specify the definition of a column.
keywords: column name, column definition
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_columndef.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# column-definition   {#Statements.ColumnDefinition}

<div class="fcnWrapperWide" markdown="1">
    Simple-column-Name
       [ DataType ]
       [ Column-level-constraint ]*
       [ [ WITH ] DEFAULT DefaultConstantExpression
         | generated-column-spec
         | generation-clause
       ]
       [ Column-level-constraint ]*
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
DataType
{: .paramName}

Must be specified unless you specify a generation-clause, in which case
the type of the generated column is that of the generation-clause.
{: .paramDefnFirst}

If you specify both a *DataType* and a *generation-clause*, the type of
the *generation-clause* must be assignable to *DataType*
{: .paramDefn}

Column-level-constraint
{: .paramName}

See the [`CONSTRAINT` clause](sqlref_clauses_constraint.html)
documentation.
{: .paramDefnFirst}

DefaultConstantExpression
{: .paramName #ColumnDefault}

For the definition of a default value, a
<var>DefaultConstantExpression</var> is an expression that does not
refer to any table. It can include constants, date-time special
registers, current schemas, and null:
{: .paramDefnFirst}

<div class="fcnWrapperWide" markdown="1">
    DefaultConstantExpression:
       NULL
     | CURRENT { SCHEMA | SQLID }
     | DATE
     | TIME
     | TIMESTAMP
     | CURRENT DATE | CURRENT_DATE
     | CURRENT TIME | CURRENT_TIME
     | CURRENT TIMESTAMP | CURRENT_TIMESTAMP
     | literal
{: .FcnSyntax xml:space="preserve"}

</div>
The values in a <var>DefaultConstantExpression</var> must be compatible
in type with the column, but a <var>DefaultConstantExpression</var> has
the following additional type restrictions:
{: .paramDefn}

* If you specify `CURRENT SCHEMA` or `CURRENT SQLID`, the column must be
  a character column whose length is at least 128.
* If the column is an integer type, the default value must be an integer
  literal.
* If the column is a decimal type, the scale and precision of the
  default value must be within those of the column.

</div>
## Example

This example creates a table and uses two column definitions.
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable (ID INT NOT NULL, NAME VARCHAR(32) );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CONSTRAINT`](sqlref_clauses_constraint.html) clause

</div>
</section>

