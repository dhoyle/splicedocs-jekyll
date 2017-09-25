---
title: Concatenation operator (||)
summary: Built-in SQL function that concatenates one character or bit string expression onto another.
keywords: concat, concatenate
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_concat.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Concatenation Operator   {#BuiltInFcns.Concatenation}

The concatenation operator, `||`, concatenates its right operand onto
the end of its left operand; it operates on character string or bit
string expressions.

Since all built-in data types are implicitly converted to strings, this
function can act on all built-in data types.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    {
       { CharacterExpression || CharacterExpression } |
       { BitExpression || BitExpression }
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

An expression.
{: .paramDefnFirst}

expression1
{: .paramName}

An expression.
{: .paramDefnFirst}

expressionN
{: .paramName}

You can specify more than two argument; you MUST specify at least two
arguments.
{: .paramDefnFirst}

</div>
## Results

For character strings:

* If both the left and right operands are of type
  [`VARCHAR`](sqlref_datatypes_varchar.html).
* The normal blank padding/trimming rules for `CHAR` and `VARCHAR` apply
  to the result of this operator.
* The length of the resulting string is the sum of the lengths of both
  operands.

## Examples

<div class="preWrapper" markdown="1">
       -- returns 'San Francisco Giants'
    splice> VALUES 'San' || ' ' || 'Francisco' || ' ' || 'Giants';
    
       -- returns NULL
    splice> VALUES CAST (null AS VARCHAR(7))|| 'Something';
    
       -- returns 'Today it is: 93'
    splice> VALUES 'Today it is: ' || '93';
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LTRIM`](sqlref_builtinfcns_ltrim.html) function
* [`REGEX_LIKE`](sqlref_builtinfcns_regexplike.html) operator
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

