---
title: BIGINT data type
summary: The BIGINT data type provides 8 bytes of storage for integer values.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_bigint.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# BIGINT

The `BIGINT` data type provides 8 bytes of storage for integer values.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    BIGINT
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Long
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    BIGINT
{: .FcnSyntax}

</div>
## Notes

Here are several usage notes for the `BIGINT` data type:

* The minimum value is `-9223372036854775808`
  (`java.lang.Long.MIN_VALUE`)
* The maximum value is `9223372036854775807 `
  (`java.lang.Long.MAX_VALUE`)
* When mixed with other data types in expressions, the resulting data
  type follows the rules shown in [Numeric type promotion in
  expressions](sqlref_datatypes_numerictypes.html#NumericTypePromotion).
* An attempt to put an integer value of a larger storage size into a
  location of a smaller size fails if the value cannot be stored in the
  smaller-size location. Integer types can always successfully be placed
  in approximate numeric values, although with the possible loss of some
  precision. `BIGINTs` can be stored in `DECIMALs` if the `DECIMAL`
  precision is large enough for the value.

## Example

<div class="preWrapper" markdown="1">
    9223372036854775807
{: .Example}

</div>
</div>
</section>

