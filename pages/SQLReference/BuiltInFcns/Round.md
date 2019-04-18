---
title: ROUND built-in SQL function
summary: Built-in SQL function that returns a number rounded to a certain number of decimal places
keywords: rounding up
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_round.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ROUND

The `ROUND` function rounds the specified number up or down to the (optionally) specified number of decimal places.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ROUND ( num, decimals )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
num
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number that is the numeric value you want rounded.
{: .paramDefnFirst}

decimals
{: .paramName}
Optional. An integer value that specifies the number of decimal digits to which you want `number` rounded.
{: .paramDefnFirst}

If you do not specify `decimals`, then `num` is rounded to an integer value.
{: .paramDefn}

If `decimals` is a negative number, then `num` is rounded to that number of digits to the *left* of the decimal point.
{: .paramDefn}

</div>
## Examples

<div class="preWrapper" markdown="1">
    splice>VALUES ROUND(84.4);
    1
    ----------
    84


    splice>VALUES ROUND(84.4, 1);
    1
    ----------
    84.4

    1 row selected


    splice>VALUES ROUND(84.4, 0);
    1
    ----------
    84.0

    1 row selected


    splice>VALUES ROUND(84.4, -1);
    1
    ----------
    80.0

    1 row selected


    splice>VALUES ROUND(844.4, -1);
    1
    ----------
    840.0

    1 row selected


    splice>VALUES ROUND(844.4, -2);
    1
    ----------
    800.0

    1 row selected
{: .Example xml:space="preserve"}

</div>
## Results

The data type of the result is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

* If the specified number is `NULL`, the result of this function is
  `NULL`.
* If the specified number is equal to a mathematical integer, the result
  of this function is the same as the specified number.
* If the specified number is zero (`0`), the result of this function is
  zero.

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>
