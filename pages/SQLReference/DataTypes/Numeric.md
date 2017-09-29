---
title: NUMERIC data type
summary: The  NUMERIC data type provides an exact numeric in which the precision and scale can be arbitrarily sized. You can use NUMERIC&#160;and DECIMAL&#160;interchangeably.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_numeric.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NUMERIC Data Type

`NUMERIC` is a synonym for the
[`DECIMAL`](sqlref_datatypes_decimal.html) data type and behaves the
same way. The documentation below is a mirror of the documentation for
the `DECIMAL` data type.

`NUMERIC` provides an exact numeric in which the precision and scale can
be arbitrarily sized. You can specify the *precision* (the total number
of digits, both to the left and the right of the decimal point) and the
*scale* (the number of digits of the fractional component). The amount
of storage required depends on the precision you specify.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    NUMERIC [(precision [, scale ])]
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
precision
{: .paramName}

Must be between `1` and `31`. If not specified, the default precision is
`5`.
{: .paramDefnFirst}

scale
{: .paramName}

Must be less than or equal to the precision. If not specified, the
default scale is `0`.
{: .paramDefnFirst}

</div>
## Usage Notes

Here are several notes about using the `NUMERIC` data type:

* An attempt to put a numeric value into a `NUMERIC` is allowed as long
  as any non-fractional precision is not lost. When truncating trailing
  digits from a `NUMERIC` value, Splice Machine rounds down. For
  example:
  <div class="preWrapperWide" markdown="1">
        -- this cast loses only fractional precision
      values cast (1.798765 AS numeric(5,2));
      1
      --------
      1.79
      	-- this cast does not fit:
      values cast (1798765 AS numeric(5,2));
      ERROR 22003: The resulting value is outside the range for the data type DECIMAL/NUMERIC(5,2).
  {: .Example xml:space="preserve"}
  
  </div>

* When mixed with other data types in expressions, the resulting data
  type follows the rules shown in [Storing values of one numeric data
  type in columns of another numeric data
  type](sqlref_datatypes_numerictypes.html#StoringValues).
* When two numeric values are mixed in an expression, the scale and
  precision of the resulting value follow the rules shown in [Scale for
  decimal arithmetic](sqlref_datatypes_numerictypes.html#Scale).
* Integer constants too big for `BIGINT` are made `NUMERIC` constants.

## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.math.BigDecimal
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    NUMERIC
{: .FcnSyntax xml:space="preserve"}

</div>
## Examples

<div class="preWrapper" markdown="1">
    
    VALUES 123.456;
    VALUES 0.001;
{: .Example xml:space="preserve"}

</div>
</div>
</section>

