---
title: ABS built-in SQL function
summary: Built-in SQL function that returns the absolute value of a numeric expression
keywords: Abs, absolute value
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_abs.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ABS or ABSVAL

`ABS` or `ABSVAL` returns the absolute value of a numeric expression.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ABS(NumericExpression)
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
NumericExpression
{: .paramName}

A numeric expression; all built-in numeric types are supported:
[`SMALLINT`](sqlref_builtinfcns_smallint.html)
{: .paramDefnFirst}

</div>
## Results

The return type is the type of the input parameter.

## Example

<div class="preWrapper" markdown="1">

    splice> VALUES ABS(-3);
    1
    ----------
    3

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_intro.html)

</div>
</section>
