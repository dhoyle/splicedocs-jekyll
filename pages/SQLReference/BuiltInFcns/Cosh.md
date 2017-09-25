---
title: COSH built-in SQL function
summary: Built-in SQL function that returns the hyperbolic cosine of a specified number
keywords: hyperbolic cosine
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_cosh.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# COSH   {#BuiltInFcns.Cosh}

The `COSH` function returns the hyperbolic cosine of a specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    COSH ( number )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the angle, in radians, for which you want the hyperbolic
cosine computed.
{: .paramDefnFirst}

</div>
## Results

The data type of the returned value is a [`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

* If the specified number is `NULL`, the result of this function is
  `NULL`.
* If the specified number is zero (`0`), the result of this function is
  one (`1.0`).

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES COSH(1.234);
    1
    ----------
    2.2564425307671042E36
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`ACOS`](sqlref_builtinfcns_acos.html) function
* [`ASIN`](sqlref_builtinfcns_asin.html) function
* [`ATAN`](sqlref_builtinfcns_atan.html) function
* [`ATAN2`](sqlref_builtinfcns_atan2.html) function
* [`COS`](sqlref_builtinfcns_cos.html) function
* [`COT`](sqlref_builtinfcns_cot.html) function
* [`DEGREES`](sqlref_builtinfcns_degrees.html) function
* [`RADIANS`](sqlref_builtinfcns_radians.html) function
* [`SIN`](sqlref_builtinfcns_sin.html) function
* [`SINH`](sqlref_builtinfcns_sinh.html) function
* [`TAN`](sqlref_builtinfcns_tan.html) function
* [`TANH`](sqlref_builtinfcns_tanh.html) function

</div>
</section>

