---
title: CHAR data type
summary: The CHAR data type provides for fixed-length storage of strings.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_char.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CHAR

The `CHAR` data type provides for fixed-length storage of strings.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CHAR[ACTER] [(length)]
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
length
{: .paramName}

An unsigned integer literal designating the length in bytes. The default
*length* for a `CHAR` is `1`; the maximum size of *length* is `254`..
{: .paramDefnFirst}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.lang.String
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    CHAR
{: .FcnSyntax}

</div>
## Usage Notes

Here are several usage notes for the `CHAR` data type:

* Splice Machine inserts spaces to pad a string value shorter than the
  expected length, and truncates spaces from a string value longer than
  the expected length. Characters other than spaces cause an exception
  to be raised. When [comparison boolean
  operators](sqlref_expressions_boolean.html) are applied to `CHARs`,
  the shorter string is padded with spaces to the length of the longer
  string.
* When `CHARs` and `VARCHARs` are mixed in expressions, the shorter
  value is padded with spaces to the length of the longer value.
* The type of a string constant is `CHAR`.

## Examples

<div class="preWrapperWide" markdown="1">
    
       -- within a string constant use two single quotation marks
       -- to represent a single quotation mark or apostrophe
    VALUES 'hello this is Joe''s string';
    
       -- create a table with a CHAR field
    CREATE TABLE STATUS (
        STATUSCODE CHAR(2) NOT NULL
            CONSTRAINT PK_STATUS PRIMARY KEY,
        STATUSDESC VARCHAR(40) NOT NULL
    );    
{: .Example xml:space="preserve"}

</div>
</div>
</section>

