---
title: ASIN built-in SQL function
summary: Built-in SQL function that returns the arc sine of a number.
keywords: asin, arc sine
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_asin.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ASIN

The `ASIN` function returns the arc sine of a specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ASIN ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the sine, in radians, of the angle that you want.
{: .paramDefnFirst}

</div>
## Results

The data type of the returned value is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number. The returned
value, in radians, is in the range `pi/2` to `pi/2`.

* If the specified number is `NULL`, the result of this function is
  `NULL`.
* If the specified number is zero (`0`), the result of this function is
  zero with the same sign as the specified number.
* If the absolute value of the specified number is greater than 1, an
  exception is returned that indicates that the value is out of range
  (SQL state 22003).

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES ASIN(0.5);
    1
    ----------
    0.5235987755982989

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`ACOS`](sqlref_builtinfcns_acos.html) function
* [`ATAN`](sqlref_builtinfcns_atan.html) function
* [`ATAN2`](sqlref_builtinfcns_atan2.html) function
* [`COS`](sqlref_builtinfcns_cos.html) function
* [`COSH`](sqlref_builtinfcns_cosh.html) function
* [`COT`](sqlref_builtinfcns_cot.html) function
* [`DEGREES`](sqlref_builtinfcns_degrees.html) function
* [`RADIANS`](sqlref_builtinfcns_radians.html) function
* [`SIN`](sqlref_builtinfcns_sin.html) function
* [`SINH`](sqlref_builtinfcns_sinh.html) function
* [`TAN`](sqlref_builtinfcns_tan.html) function
* [`TANH`](sqlref_builtinfcns_tanh.html) function

</div>
</section>
