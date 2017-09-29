---
title: VARCHAR data type
summary: The VARCHAR&#160;data type provides for variable-length storage of strings.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_varchar.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# VARCHAR

The `VARCHAR` data type provides for variable-length storage of strings.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    { VARCHAR | CHAR VARYING | CHARACTER VARYING }(length)
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
length
{: .paramName}

An unsigned integer constant. The maximum length for a `VARCHAR` string
is `32,672` characters.
{: .paramDefnFirst}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.String
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    VARCHAR
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    VARCHAR(2048);
{: .Example xml:space="preserve"}

</div>
## Usage Notes

Here are several notes for the `VARCHAR` data type:

* Splice Machine does not pad a `VARCHAR` value whose length is less
  than specified.
* Splice Machine truncates spaces from a string value when a length
  greater than the `VARCHAR` expected is provided. Characters other than
  spaces are not truncated, and instead cause an exception to be raised.
* When [comparison boolean operators](sqlref_expressions_boolean.html)
  are applied to `VARCHARs`, the lengths of the operands are not
  altered, and spaces at the end of the values are ignored.
* When `CHARs` and `VARCHARs` are mixed in expressions, the shorter
  value is padded with spaces to the length of the longer value.
* The type of a string constant is `CHAR`, not `VARCHAR`.

</div>
</section>

