---
title: DOUBLE data type
summary: The DOUBLE data type provides 8-byte storage for numbers using IEEE floating-point notation. DOUBLE PRECISION can be used synonymously with DOUBLE.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_double.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DOUBLE

The `DOUBLE` data type provides 8-byte storage for numbers using IEEE
floating-point notation. `DOUBLE PRECISION` can be used synonymously
with `DOUBLE`, and the documentation for this topic is identical to the
documentation for the
[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DOUBLE
{: .FcnSyntax}

</div>
or, alternately

<div class="fcnWrapperWide" markdown="1">
    DOUBLE PRECISION
{: .FcnSyntax}

</div>
## Usage Notes

Here are several usage notes for the `DOUBLE`/`DOUBLE PRECISION` data
type:

* The following range limitations apply:
  <table summary="Range limitations for DOUBLE values"><col /><col /><thead><tr><th>Limit type</th><th>Limitation</th></tr></thead><tbody><tr><td>Smallest <code>DOUBLE</code> value</td><td><code>-1.79769E+308</code></td></tr><tr><td>Largest <code>DOUBLE</code> value</td><td><code> 1.79769E+308</code></td></tr><tr><td>Smallest positive <code>DOUBLE</code> value</td><td><code> 2.225E-307</code></td></tr><tr><td>Largest negative <code>DOUBLE</code> value</td><td><code>-2.225E-307</code></td></tr></tbody></table>
  
  These limits are different from the `java.lang.Double` Java type
  limits.
  {: .noteNote}

* An exception is thrown when any double value is calculated or entered
  that is outside of these value ranges. Arithmetic operations **do
  not** round their resulting values to zero. If the values are too
  small, you will receive an exception.
* Numeric floating point constants are limited to a length of 30
  characters.
  <div class="preWrapperWide" markdown="1">
         -- this example will fail because the constant is too long:
      values 01234567890123456789012345678901e0;
  {: .Example}
  
  </div>

* When mixed with other data types in expressions, the resulting data
  type follows the rules shown in [Storing values of one numeric data
  type in columns of another numeric data
  type](sqlref_datatypes_numerictypes.html#StoringValues).

## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Double
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    DOUBLE
{: .FcnSyntax}

</div>
## Examples

<div class="preWrapper" markdown="1">
    3421E+09
    425.43E9
    9E-10
    4356267544.32333E+30
{: .Example}

</div>
</div>
</section>

