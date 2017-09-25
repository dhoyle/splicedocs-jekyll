---
title: INTEGER data type
summary: The INTEGER data type provides 4 bytes of storage for integer values.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_integer.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# INTEGER Data Type   {#DataTypes.Integer}

The `INTEGER` data type provides 4 bytes of storage for integer values.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    { INTEGER | INT }
{: .FcnSyntax}

</div>
## Corresponding Compile-Time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Integer
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    INTEGER
{: .FcnSyntax}

</div>
## Minimum Value

<div class="fcnWrapperWide" markdown="1">
    -2147483648  (java.lang.Integer.MIN_VALUE)
{: .FcnSyntax}

</div>
## Maximum Value

<div class="fcnWrapperWide" markdown="1">
    2147483647 (java.lang.Integer.MAX_VALUE)
{: .FcnSyntax}

</div>
## Usage Notes

When mixed with other data types in expressions, the resulting data type
follows the rules shown in [Numeric type promotion in
expressions](sqlref_datatypes_numerictypes.html#NumericTypePromotion).

See also [Storing values of one numeric data type in columns of another
numeric data type](sqlref_datatypes_numerictypes.html#StoringValues).

## Examples

<div class="preWrapper" markdown="1">
    3453
    425
{: .Example}

</div>
</div>
</section>

