---
title: SIGN built-in SQL function
summary: Built-in SQL function that returns the sign of a number
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_sign.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SIGN

The `SIGN` function returns the sign of the specified number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SIGN ( number )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number
that specifies the value whose sign you want.
{: .paramDefnFirst}

</div>
## Results

The data type of the returned value is
[`INTEGER`](sqlref_builtinfcns_integer.html):.

* If the specified number is `NULL`, the result of this function is
  `NULL`.
* If the specified number is zero (`0`), the result of this function is
  zero (`0`).
* If the specified number is greater than zero (`0`), the result of this
  function is plus one (`+1`).
* If the specified number is less than zero (`0`), the result of this
  function is minus one (`-1`).

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES( SIGN(84.4), SIGN(-85.5), SIGN(0), SIGN(NULL) );
    1          |2          |3          |4
    -----------------------------------------------
    1          |-1         |0          |NULL
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

