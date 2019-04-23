---
title: BOOLEAN data type
summary: The BOOLEAN data type provides 1 byte of storage for logical values.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_boolean.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# BOOLEAN

The `BOOLEAN` data type provides 1 byte of storage for logical values.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    BOOLEAN
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.Boolean
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    BOOLEAN
{: .FcnSyntax}

</div>
## Usage Notes

Here are several usage notes for the `BOOLEAN` data type:

* The legal values are `true`, `false`, and `null`.
* `BOOLEAN` values can be cast to and from character type values.
* For comparisons and ordering operations, `true` sorts higher than
  `false`.

## Examples

<div class="preWrapper" markdown="1">
    
    values true;
    values false;
    values cast (null as boolean);
{: .Example xml:space="preserve"}

</div>
</div>
</section>

