---
title: LN (or LOG) built-in SQL function
summary: Built-in SQL function that returns the natural logarithm (base e) of a number
keywords: log, ln, logarithm
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_ln.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LN or LOG   {#BuiltInFcns.LnOrLog}

The `LN` and `LOG` functions return the natural logarithm (base `e`) of
the specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LN ( number )
    LOG ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that is greater than zero (`0`).
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES( LOG(84.4), LN(84.4) );
    1                  |2
    --------------------------------------
    4.435674016019115  |4.435674016019115
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## Results

The data type of the returned value is a [`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

* If the specified number is `NULL`, the result of these functions is
  `NULL`.
* If the specified number is zero or a negative number, an exception is
  returned that indicates that the value is out of range (SQL state
  22003).

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

