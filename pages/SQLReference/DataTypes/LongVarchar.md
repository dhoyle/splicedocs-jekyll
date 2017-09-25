---
title: LONG VARCHAR data type
summary: The LONG VARCHAR type allows storage of character strings with a maximum length of 32,700 characters. It is identical to VARCHAR, except that you cannot specify a maximum length when creating columns of this type.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_longvarchar.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LONG VARCHAR   {#DataTypes.LongVarchar}

The `LONG VARCHAR` type allows storage of character strings with a
maximum length of 32,670 characters. It is almost identical to
[`VARCHAR`](sqlref_datatypes_varchar.html), except that you cannot
specify a maximum length when creating columns of this type.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LONG VARCHAR
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.String
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    LONGVARCHAR
{: .FcnSyntax}

</div>
## Usage Notes

When you are converting from Java values to SQL values, no Java type
corresponds to `LONG VARCHAR`.

</div>
</section>

