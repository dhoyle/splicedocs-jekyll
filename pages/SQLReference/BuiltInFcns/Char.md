---
title: CHAR built-in SQL function
summary: Built-in SQL function that returns a fixed-length character string representation.
keywords: fixed-length character string
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_char.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CHAR

The `CHAR` function returns a fixed-length character string
representation. The representations are:

* A character string, if the first argument is any type of character
  string.
* A datetime value, if the first argument is a date, time, or timestamp.
* A decimal number, if the first argument is a decimal number.
* A double-precision floating-point number, if the first argument is a
  `DOUBLE` or `REAL`.
* An integer number, if the first argument is a `TINYINT`, `SMALLINT`, `INTEGER`,
  or `BIGINT`.

The first argument must be of a built-in data type.

The result of the `CHAR` function is a fixed-length character string. If
the first argument can be `NULL`, the result can be `NULL`. If the first
argument is `NULL`, the result is the `NULL`value.

## Character to character syntax

<div class="fcnWrapperWide" markdown="1">
    CHAR (CharacterExpression [, integer] )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

An expression that returns a value that is `CHAR`, `VARCHAR`, `LONG
VARCHAR`, or `CLOB` data type.
{: .paramDefnFirst}

integer
{: .paramName}

The length attribute for the resulting fixed length character string.
The value must be between 0 and 254.
{: .paramDefnFirst}

</div>
### Results

If the length of the character-expression is less than the length
attribute of the result, the result is padded with blanks up to the
length of the result.

If the length of the character-expression is greater than the length
attribute of the result, truncation is performed. A warning is
returned unless the truncated characters were all blanks and the
character-expression was not a long string (`LONG VARCHAR` or `CLOB`).

## Integer to character syntax

<div class="fcnWrapperWide" markdown="1">
    CHAR (IntegerExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
IntegerExpression
{: .paramName}

An expression that returns a value that is an integer data type (either
SMALLINT, INTEGER or BIGINT).
{: .paramDefnFirst}

</div>
### Results

The result is the character string representation of the argument in
the form of an SQL integer constant. The result consists of n
characters that are the significant digits that represent the value of
the argument with a preceding minus sign if the argument is negative.
It is left justified.

* If the first argument is a small integer: the length of the result is 6. If the number of characters in the result is less than 6, then the result is padded on the right with blanks to length 6.
* If the first argument is a large integer: the length of the result is 11. If the number of characters in the result is less than 11, then the result is padded on the right with blanks to length 11.
* If the first argument is a big integer: the length of the result is 20. If the number of characters in the result is less than 20, then the result is padded on the right with blanks to length 20.

## Datetime to character syntax

<div class="fcnWrapperWide" markdown="1">
    CHAR (DatetimeExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
DatetimeExpression
{: .paramName}

An expression that is one of the following three data types:
{: .paramDefnFirst}

<table summary="DateTime expression types">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>DATE</code></td>
                            <td>The result is the character representation of the date. The length of the result is 10.</td>
                        </tr>
                        <tr>
                            <td><code>TIME</code></td>
                            <td>The result is the character representation of the time. The	length of the result is 8.</td>
                        </tr>
                        <tr>
                            <td><code>TIMESTAMP</code></td>
                            <td>The result is the character string representation of
					the timestamp. The length of the result is 26.</td>
                        </tr>
                    </tbody>
                </table>
</div>
## Decimal to character

<div class="fcnWrapperWide" markdown="1">
    CHAR (DecimalExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
DecimalExpression
{: .paramName}

An expression that returns a value that is a decimal data type.
{: .paramDefnFirst}

If a different precision and scale is desired, you can use the `DECIMAL`
scalar function first to make the change.
{: .paramDefn}

</div>
## Floating point to character syntax

<div class="fcnWrapperWide" markdown="1">
    CHAR (FloatingPointExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
FloatingPointExpression
{: .paramName}

An expression that returns a value that is a floating-point data type
(`DOUBLE` or `REAL`).
{: .paramDefnFirst}

</div>
## Example

Use the `CHAR` function to return the values for `PlateAppearances`
(defined as smallint) as a fixed length character string:

<div class="preWrapper" markdown="1">
    splice> SELECT CHAR(AtBats * 2) "DoubledAtBats"
      FROM Batting WHERE ID <= 10;
    DoubledAtBats
    --------------------
    1246
    1112
    864
    1122
    1224
    784
    1102
    446
    744
    548

    10 rows selected
{: .Example xml:space="preserve"}

</div>
Since `AtBats` is declared as `SMALLINT` in our Examples database, each
of the resulting values is padded with blank characters to make it 6
characters long.

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)

</div>
</section>
