---
title: SMALLINT data type
summary: The SMALLINT data type provides 2 bytes of storage.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_smallint.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SMALLINT   {#DataTypes.SmallInt}

The `SMALLINT` data type provides 2 bytes of storage.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SMALLINT
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Short
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    SMALLINT
{: .FcnSyntax}

</div>
## Usage Notes

Here are several usage notes for the `SMALLINT` data type:

* The minimum value is `-32768` (`java.lang.Short.MIN_VALUE`).
* The maximum value is ` 32767` (`java.lang.Short.MAX_VALUE`).
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

