---
title: BIGINT built-in SQL function
summary: Built-in SQL function that converts input to a 64-bit integer representation
keywords: big integer
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_bigint.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# BIGINT

The `BIGINT` function returns a 64-bit integer representation of a
number or character string in the form of an integer constant.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    BIGINT (CharacterExpression | NumericExpression ) 
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

An expression that returns a character string value of length not
greater than the maximum length of a character constant. Leading and
trailing blanks are eliminated and the resulting string must conform to
the rules for forming an SQL integer constant. The character string
cannot be a long string. If the argument is a CharacterExpression, the
result is the same number that would occur if the corresponding integer
constant were assigned to a big integer column or variable.
{: .paramDefnFirst}

NumericExpression
{: .paramName}

An expression that returns a value of any built-in numeric data type. If
the argument is a NumericExpression, the result is the same number that
would occur if the argument were assigned to a big integer column or
variable. If the whole part of the argument is not within the range of
integers, an error occurs. The decimal part of the argument is truncated
if present.
{: .paramDefnFirst}

</div>
## Results

The result of the function is a big integer.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL` value.

## Example

Using the `Batting` table from our Doc Examples database, select the
`TotalBases` column in big integer form for further processing in the
application:

<div class="preWrapper" markdown="1">
    splice> SELECT ID, BIGINT(TotalBases) "TotalBases"
       FROM Batting
       WHERE ID < 11;
    ID    |TotalBases
    ---------------------------
    1     |262
    2     |235
    3     |174
    4     |234
    5     |245
    6     |135
    7     |170
    8     |99
    9     |135
    10    |85
    
    10 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`BIGINT`](sqlref_builtinfcns_bigint.html) data type

</div>
</section>

