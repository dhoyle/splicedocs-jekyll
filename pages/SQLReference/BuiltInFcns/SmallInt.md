---
title: SMALLINT built-in SQL function
summary: Built-in SQL function that returns a small integer representation of a number or character expression
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_smallint.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SMALLINT   {#BuiltInFcns.SmallInt}

The `SMALLINT` function returns a small integer representation of a
number or character string, in the form of a small integer constant.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SMALLINT ( NumericExpression | CharacterExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
NumericExpression
{: .paramName}

An expression that returns a value of any built-in numeric data type.
{: .paramDefnFirst}

CharacterExpression
{: .paramName}

An expression that returns a character string value of length not
greater than the maximum length of a character constant. Leading and
trailing blanks are eliminated and the resulting string must conform to
the rules for forming an SQL integer constant. The value of the constant
must be in the range of small integers. The character string cannot be a
long string.
{: .paramDefnFirst}

</div>
## Results

The result of the function is a
[`SMALLINT`](sqlref_builtinfcns_smallint.html). If the argument can be
`NULL`, the result can be `NULL`. If the argument is `NULL`, the result
is the `NULL`value.

If the argument is a *NumericExpression*, the result is the same number
that would occur if the argument were assigned to a small integer column
or variable. If the whole part of the argument is not within the range
of small integers, an error occurs. The decimal part of the argument is
truncated if present.

If the argument is a *CharacterExpression*, the result is the same
number that would occur if the corresponding integer constant were
assigned to a small integer column or variable.

## Examples

Using the `Pitching` table from our Doc Examples database, select the
`Era` column in big integer form for further processing in the
application:

<div class="preWrapper" markdown="1">
    splice> SELECT ID, SMALLINT(Era) "ERA"
       FROM Pitching
       WHERE MOD(ID,2) = 0;
    ID    |ERA
    -------------
    28    |2
    30    |4
    32    |3
    34    |5
    36    |3
    38    |5
    40    |5
    42    |2
    44    |5
    46    |2
    48    |5
    72    |2
    74    |3
    76    |2
    78    |3
    80    |1
    82    |3
    84    |2
    86    |2
    88    |0
    90    |2
    92    |2
    94    |2
    
    23 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)

</div>
</section>

