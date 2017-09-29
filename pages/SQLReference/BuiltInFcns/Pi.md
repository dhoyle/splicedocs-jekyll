---
title: PI built-in SQL function
summary: Built-in SQL function that returns the constant PI.
keywords: 3.1416
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_pi.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# PI

The `PI` function returns a value that is closer than any other value to
`pi`. The constant `pi` is the ratio of the circumference of a circle to
the diameter of a circle.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    PI (  )
{: .FcnSyntax}

</div>
## Syntax

The data type of the returned value is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES PI();
    1
    ----------
    3.14159265358793
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>

