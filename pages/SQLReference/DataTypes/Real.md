---
title: REAL data type
summary: The REAL data type provides 4 bytes of storage for numbers using &#xA;IEEE floating-point notation.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_real.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# REAL

The `REAL` data type provides 4 bytes of storage for numbers using IEEE
floating-point notation.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    REAL
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Float
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    REAL
{: .FcnSyntax}

</div>
## Limitations

<div class="fcnWrapperWide" markdown="1">
    REAL value ranges:
{: .FcnSyntax}

</div>
<table summary="Limits of real values">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Limit type</th>
                        <th>Limit value</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Smallest REAL value</em></td>
                        <td><code>-3.402E+38</code></td>
                    </tr>
                    <tr>
                        <td><em>Largest REAL value</em></td>
                        <td><code> 3.402E+38</code></td>
                    </tr>
                    <tr>
                        <td><em>Smallest positive REAL value</em></td>
                        <td><code> 1.175E-37</code></td>
                    </tr>
                    <tr>
                        <td><em>Largest negative REAL value</em></td>
                        <td><code>-1.175E-37</code></td>
                    </tr>
                </tbody>
            </table>
These limits are different from the `java.lang.Float` Java type limits.
{: .noteNote}

## Usage Notes

Here are several usage notes for the `REAL` data type:

* An exception is thrown when any double value is calculated or entered
  that is outside of these value ranges. Arithmetic operations **do
  not** round their resulting values to zero. If the values are too
  small, you will receive an exception. The arithmetic operations take
  place with double arithmetic in order to detect under flows.
* Numeric floating point constants are limited to a length of 30
  characters.
  <div class="preWrapperWide" markdown="1">
         -- this example will fail because the constant is too long:
      values 01234567890123456789012345678901e0;
  {: .Example xml:space="preserve"}
  
  </div>

* When mixed with other data types in expressions, the resulting data
  type follows the rules shown in [Numeric type promotion in
  expressions](sqlref_datatypes_numerictypes.html#NumericTypePromotion).
* See also [Storing values of one numeric data type in columns of
  another numeric data
  type](sqlref_datatypes_numerictypes.html#StoringValues).
* Constants always map to &nbsp;[`DOUBLE
  PRECISION`](sqlref_datatypes_doubleprecision.html); use a `CAST` to
  convert a constant to a `REAL`.

</div>
</section>

