---
title: RADIANS built-in SQL function
summary: Built-in SQL function that converts a number from degrees to radians
keywords: convert degrees to radians
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_radians.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RADIANS

The `RADIANS` function converts a specified number from degrees to
radians.

The specified number is an angle measured in degrees, which is converted
to an approximately equivalent angle measured in radians. The specified
number must be a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

The conversion from degrees to radians is not exact.
{: .noteNote}

The data type of the returned value is a `DOUBLE PRECISION` number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RADIANS ( number )
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES RADIANS(90);
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
* [`ATAN2`](sqlref_builtinfcns_atan2.html) function
* [`COS`](sqlref_builtinfcns_cos.html) function
* [`COSH`](sqlref_builtinfcns_cosh.html) function
* [`COT`](sqlref_builtinfcns_cot.html) function
* [`DEGREES`](sqlref_builtinfcns_degrees.html) function
* [`SIN`](sqlref_builtinfcns_sin.html) function
* [`SINH`](sqlref_builtinfcns_sinh.html) function
* [`TAN`](sqlref_builtinfcns_tan.html) function
* [`TANH`](sqlref_builtinfcns_tanh.html) function

</div>
</section>

