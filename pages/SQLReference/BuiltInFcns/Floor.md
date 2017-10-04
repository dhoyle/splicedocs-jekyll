---
title: FLOOR built-in SQL function
summary: Built-in SQL function that returns  the largest integer less than or equal to a specified numeric value
keywords: rounding down
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_floor.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# FLOOR

The `FLOOR` function rounds the specified number down, and returns the
largest number that is less than or equal to the specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    FLOOR ( number )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES FLOOR(84.4);
    1
    ----------
    84
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Results

The data type of the result is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number. The returned
value is equal to a mathematical integer.

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

