---
title: DEGREES built-in SQL function
summary: Built-in SQL function that converts a number from radians to degrees
keywords: convert radians to degrees
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_degrees.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DEGREES   {#BuiltInFcns.Degrees}

The `DEGREES` function converts (approximately) a specified number from
radians to degrees.

The conversion from radians to degrees is not exact. You should not
expect `DEGREES(ACOS(0.5))` to return exactly `60.0`.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DEGREES ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the angle you want converted, in radians.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES DEGREES(ACOS(0.5));
    1
    ----------
    60.00000000000001
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Results

The data type of the returned value is a [`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`ACOS`](sqlref_builtinfcns_acos.html) function
* [`ASIN`](sqlref_builtinfcns_asin.html) function
* [`ATAN`](sqlref_builtinfcns_atan.html) function
* [`ATAN2`](sqlref_builtinfcns_atan2.html) function
* [`COS`](sqlref_builtinfcns_cos.html) function
* [`COSH`](sqlref_builtinfcns_cosh.html) function
* [`COT`](sqlref_builtinfcns_cot.html) function
* [`RADIANS`](sqlref_builtinfcns_radians.html) function
* [`SIN`](sqlref_builtinfcns_sin.html) function
* [`SINH`](sqlref_builtinfcns_sinh.html) function
* [`TAN`](sqlref_builtinfcns_tan.html) function
* [`TANH`](sqlref_builtinfcns_tanh.html) function

</div>
</section>

