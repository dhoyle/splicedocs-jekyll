---
title: LOG10 built-in SQL function
summary: Built-in SQL function that returns the base-10 logarithm of a number
keywords: base-10 logarithm
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_log10.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LOG10   {#BuiltInFcns.Log10}

The `LOG10` function returns the base-10 logarithm of the specified
number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LOG10 ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that is greater than zero (`0`).
{: .paramDefnFirst}

</div>
## Results

The data type of the returned value is a [`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

* If the specified number is `NULL`, the result of this function is
  `NULL`.
* If the specified number is zero or a negative number, an exception is
  returned that indicates that the value is out of range (SQL state
  22003).

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES LOG10(84.4);
    1
    ----------
    1.926342446625655
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

