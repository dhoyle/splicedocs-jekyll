---
title: CEIL built-in SQL function
summary: Built-in SQL function that returns the smallest integer greater than or equal to a specified numeric value
keywords: ceiling
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_ceil.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CEIL or CEILING   {#BuiltInFcns.Ceil}

The `CEIL` and `CEILING` functions round the specified number up, and
return the smallest number that is greater than or equal to the
specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CEIL ( number )
{: .FcnSyntax}

</div>
<div class="fcnWrapperWide" markdown="1">
    CEILING ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) value.
{: .paramDefnFirst}

The expression can contain multiple column references or expressions,
but it cannot contain another aggregate or subquery, and it must
evaluate to an ANSI SQL numeric data type. This means that you can call
methods that evaluate to ANSI SQL data types.
{: .paramDefn}

If an expression evaluates to `NULL`, the aggregate skips that value.
{: .paramDefn}

</div>
## Results

The data type of the returned value is a [`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

The returned value is the smallest (closest to negative infinity) double
floating point value that is greater than or equal to the specified
number. The returned value is equal to a mathematical integer.

* If the specified number is `NULL`, the result of these functions is
  `NULL`.
* If the specified number is equal to a mathematical integer, the result
  of these functions is the same as the specified number.
* If the specified number is zero (0), the result of these functions is
  zero.
* If the specified number is less than zero but greater than -1.0, then
  the result of these functions is zero.

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES CEIL(3.33);
    1
    ----------
    4
    
    1 row selected
    
    splice> VALUES CEILING(3.67);
    1
    ----------
    4
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

