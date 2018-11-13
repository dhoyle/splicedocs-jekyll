---
title: TINYINT data type
summary: The TINYINT data type provides 1 byte of storage for integer values.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_tinyint.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TINYINT

The `TINYINT` data type provides 1 byte of storage.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TINYINT
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Byte
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    TINYINT
{: .FcnSyntax}

</div>
## Usage Notes

Here are several usage notes for the `SMALLINT` data type:

* The minimum value is `-128` (`java.lang.Byte.MIN_VALUE`).
* The maximum value is  `127` (`java.lang.Byte.MAX_VALUE`).
* When mixed with other data types in expressions, the resulting data
  type follows the rules shown in [Numeric type promotion in
  expressions](sqlref_datatypes_numerictypes.html#NumericTypePromotion).
* See also [Storing values of one numeric data type in columns of
  another numeric data
  type](sqlref_datatypes_numerictypes.html#StoringValues).
* Constants in the appropriate format always map to `INTEGER` or
  `BIGINT`, depending on their length.

</div>
</section>
