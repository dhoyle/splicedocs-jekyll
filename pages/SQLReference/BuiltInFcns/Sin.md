---
title: SIN built-in SQL function
summary: Built-in SQL function that returns the sine of a number
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_sin.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SIN

The `SIN` function returns the sine of a specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SIN ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the angle, in radians, for which you want the sine
computed.
{: .paramDefnFirst}

</div>
## Results

The data type of the returned value is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

If *number* is `NULL`, the result of the function is `NULL`.

If *number* is `0`, the result of the function is `0`.

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES SIN(84.4);
    1
    ------------------
    0.4104993826174394
    
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
* [`COSH`](sqlref_builtinfcns_cosh.html) function
* [`COT`](sqlref_builtinfcns_cot.html) function
* [`DEGREES`](sqlref_builtinfcns_degrees.html) function
* [`RADIANS`](sqlref_builtinfcns_radians.html) function
* [`SINH`](sqlref_builtinfcns_sinh.html) function
* [`TAN`](sqlref_builtinfcns_tan.html) function
* [`TANH`](sqlref_builtinfcns_tanh.html) function

</div>
</section>

