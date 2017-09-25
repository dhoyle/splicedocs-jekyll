---
title: RANDOM built-in SQL function
summary: Built-in SQL function that computes a random number
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_random.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RANDOM   {#BuiltInFcns.Random}

The `RANDOM` function returns a random number.

The `RANDOM` function returns a
[`INTEGER`](sqlref_builtinfcns_integer.html) seed number.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RANDOM()
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES RANDOM();
    1
    ----------
    0.2826393098638572
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

