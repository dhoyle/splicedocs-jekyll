---
title: DOUBLE built-in SQL function
summary: Built-in SQL function that returns a floating point number
keywords: convert to double
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_double.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DOUBLE

The `DOUBLE` function returns a floating-point number corresponding to
a:

* number if the argument is a numeric expression
* character string representation of a number if the argument is a
  string expression

## Numeric to Double

<div class="fcnWrapperWide" markdown="1">
    DOUBLE [PRECISION] (NumericExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
NumericExpression
{: .paramName}

The argument is an expression that returns a value of any built-in
numeric data type.
{: .paramDefnFirst}

</div>
### Results

The data type of the returned value is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL`value.

The result is the same value that would result if the argument were
assigned to a double-precision floating-point column or variable.

## Character String to Double

<div class="fcnWrapperWide" markdown="1">
    DOUBLE (StringExpression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
StringExpression
{: .paramName}

The argument can be of type &nbsp;[`VARCHAR`](sqlref_datatypes_varchar.html)
in the form of a numeric constant. Leading and trailing blanks in
argument are ignored.
{: .paramDefnFirst}

</div>
### Results

The data type of the returned value is a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) number.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL`value.

The result is the same value that would result if the string was
considered a constant and assigned to a double-precision floating-point
column or variable.

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES DOUBLE(84.4);
    1
    ----------
    84.4

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)

</div>
</section>
