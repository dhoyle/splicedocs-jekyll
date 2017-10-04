---
title: EXP built-in SQL function
summary: Built-in SQL function that returns e raised to the specified numeric value
keywords: logarithms
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_exp.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# EXP

The `EXP` function returns `e` raised to the power of the specified
number. The constant `e` is the base of the natural logarithms.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    EXP ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the exponent to which you want to raise `e`.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES EXP(1.234);
    1
    ----------
    3.43494186080076
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Results

The data type of the result is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

