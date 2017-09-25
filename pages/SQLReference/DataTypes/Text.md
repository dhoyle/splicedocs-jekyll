---
title: TEXT data type
summary: The TEXT data type is used for varying-length character strings that can be up to 2,147,483,647 characters long.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_text.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TEXT

A `TEXT` (character large object) value can be up to 2,147,483,647
characters long. A `TEXT` object is used to store unicode
character-based data, such as large documents in any character set.

Note that, in Splice Machine, `TEXT` is a synonym for `CLOB`, and that
the documentation for the [`CLOB`](sqlref_datatypes_clob.html) data type
functionally matches the documentation for this topic. Splice Machine
simply translates `TEXT` into `CLOB`.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TEXT [ ( length [{K |M |G}] ) ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
length
{: .paramName}

An unsigned integer constant that specifies the number of characters in
the `TEXT` unless you specify one of the suffixes you see below, which
change the meaning of the *length* value. If you do not specify a length
value, it defaults to two giga-characters (2,147,483,647).
{: .paramDefnFirst}

K
{: .paramName}

If specified, indicates that the length value is in multiples of 1024
(kilo-characters).
{: .paramDefnFirst}

M
{: .paramName}

If specified, indicates that the length value is in multiples of
1024*1024 (mega-characters).
{: .paramDefnFirst}

G
{: .paramName}

If specified, indicates that the length value is in multiples of
1024*1024*1024 (giga-characters).
{: .paramDefnFirst}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.sql.Clob
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    CLOB
{: .FcnSyntax}

</div>
## Usage Notes

Use the *getClob* method on the *java.sql.ResultSet* to retrieve a
`CLOB` handle to the underlying data.

There are a number of restrictions on using `BLOB`and `CLOB` /
`TEXT` objects, which we refer to as LOB-types:

* LOB-types cannot be compared for equality (`=`) and non-equality
  (`!=`, `<>`).
* LOB-typed values cannot be ordered, so `<, <=, >, >=` tests are not
  supported.
* LOB-types cannot be used in indexes or as primary key columns.
* `DISTINCT`, `GROUP BY`, and `ORDER BY` clauses are also prohibited on
  LOB-types.
* LOB-types cannot be involved in implicit casting as other base-types.

## Example

<div class="preWrapperWide" markdown="1">
    CREATE TABLE myTable( txtCol TEXT(65535));
{: .Example xml:space="preserve"}

</div>
</div>
</section>

