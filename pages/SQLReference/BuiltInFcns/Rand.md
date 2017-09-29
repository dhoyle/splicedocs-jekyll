---
title: RAND built-in SQL function
summary: Built-in SQL function that computes a random number
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_rand.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RAND

The `RAND` function returns a random number given a seed number

The `RAND` function returns an &nbsp;
[`INTEGER`](sqlref_builtinfcns_integer.html) seed number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RAND( seed )
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES RAND(13);
    1
    ----------
    0.7298032243379924

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>
