---
title: ACOS built-in SQL function
summary: Built-in SQL function that returns the arc cosine of a specified number
keywords: acos, arc cosine
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_acos.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ACOS

The `ACOS` function returns the arc cosine of a specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ACOS ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the cosine, in radians, of the angle that you want.
{: .paramDefnFirst}

</div>
## Results

The data type of the returned value is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number. The returned
value, in radians, is in the range of zero (`0`) to `pi`.

* If the specified *number* is `NULL`, the result of this function is
  `NULL`.
* If the absolute value of the specified number is greater than 1, an
  exception is returned that indicates that the value is out of range
  (SQL state 22003).

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES ACOS(0.5);
    1
    ----------
    1.0471975511965979

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`ASIN`](sqlref_builtinfcns_asin.html) function
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
