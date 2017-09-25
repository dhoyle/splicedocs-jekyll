---
title: ATAN2 built-in SQL function
summary: Built-in SQL function that returns the arctangent, in radians, of the quotient of two numbers
keywords: atan2, arc tangent radians
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_atan2.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ATAN2   {#BuiltInFcns.Atan2}

The `ATAN2` function returns the arctangent, in radians, of the quotient
of the two arguments.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ATAN2 ( y, x )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
y
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number.
{: .paramDefnFirst}

x
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number.
{: .paramDefnFirst}

</div>
## Results

`ATAN2` returns the arc tangent of *y*/*x* in the range -*pi* to *pi*
radians, as a [`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html)number.

* If either argument is `NULL`, the result of the function is `NULL`.
* If the first argument is zero and the second argument is positive, the
  result of the function is zero.
* If the first argument is zero and the second argument is negative, the
  result of the function is the double value closest to *pi*.
* If the first argument is positive and the second argument is zero, the
  result is the double value closest to*pi*/2.
* If the first argument is negative and the second argument is zero, the
  result is the double value closest to -*pi*/2.

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES ATAN2(1, 0);
    1
    ----------
    1.5707963267948966
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`ACOS`](sqlref_builtinfcns_acos.html) function
* [`ASIN`](sqlref_builtinfcns_asin.html) function
* [`ATAN`](sqlref_builtinfcns_atan.html) function
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

