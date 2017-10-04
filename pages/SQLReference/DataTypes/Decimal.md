---
title: DECIMAL data type
summary: The  DECIMALdata type provides an exact numeric in which the precision and scale can be arbitrarily sized. You can use DECIMAL&#160;and NUMERIC&#160;interchangeably.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_decimal.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DECIMAL

The `DECIMAL` data type provides an exact numeric in which the precision
and scale can be arbitrarily sized. You can specify the *precision* (the
total number of digits, both to the left and the right of the decimal
point) and the *scale* (the number of digits of the fractional
component). The amount of storage required depends on the precision you
specify.

Note that `NUMERIC` is a synonym for `DECIMAL`, and that the
documentation for the &nbsp;[`NUMERIC`](sqlref_datatypes_numeric.html) data
type exactly matches the documentation for this topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
     { DECIMAL | DEC } [(precision [, scale])]
{: .FcnSyntax xml:space="preserve"}

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

Here are several notes about using the `DECIMAL` data type:

* An attempt to put a numeric value into a `DECIMAL` is allowed as long
  as any non-fractional precision is not lost. When truncating trailing
  digits from a `DECIMAL` value, Splice Machine rounds down. For
  example:
  <div class="preWrapperWide" markdown="1">
        -- this cast loses only fractional precision
      values cast (1.798765 AS decimal(5,2));
      1
      --------
      1.79
      	-- this cast does not fit:
      values cast (1798765 AS decimal(5,2));
      ERROR 22003: The resulting value is outside the range for the data type DECIMAL/NUMERIC(5,2).
  {: .Example xml:space="preserve"}
  
  </div>

* When mixed with other data types in expressions, the resulting data
  type follows the rules shown in [Storing values of one numeric data
  type in columns of another numeric data
  type](sqlref_datatypes_numerictypes.html#StoringValues).
* When two decimal values are mixed in an expression, the scale and
  precision of the resulting value follow the rules shown in [Scale for
  decimal arithmetic](sqlref_datatypes_numerictypes.html#Scale).
* Integer constants too big for `BIGINT` are made `DECIMAL` constants.

## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.math.BigDecimal
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    DECIMAL
{: .FcnSyntax}

</div>
## Examples

<div class="preWrapper" markdown="1">
    
    VALUES 123.456;
    VALUES 0.001;
{: .Example xml:space="preserve"}

</div>
</div>
</section>

