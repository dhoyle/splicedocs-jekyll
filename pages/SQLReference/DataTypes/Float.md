---
title: FLOAT data type
summary: The FLOAT data type is an alias for either a REAL or DOUBLE PRECISION  data type, depending on the precision you specify.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_float.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# FLOAT

The `FLOAT` data type is an alias for either a &nbsp;[`DOUBLE
PRECISION`](sqlref_datatypes_doubleprecision.html) data type, depending
on the precision you specify.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    FLOAT [ (precision) ]
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
precision
{: .paramName}

The default precision for `FLOAT` is `52`, which is equivalent to
`DOUBLE PRECISION`.
{: .paramDefnFirst}

A precision of `23` or less makes `FLOAT` equivalent to `REAL`.
{: .paramDefn}

A precision of `24` or greater makes `FLOAT` equivalent to `DOUBLE
PRECISION`.
{: .paramDefn}

If you specify a precision of `0`, you get an error. If you specify a
negative precision, you get a syntax error.
{: .paramDefn}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    REAL or DOUBLE
{: .FcnSyntax}

</div>
## Usage Notes

If you are using a precision of `24` or greater, the limits of `FLOAT`
are similar to the limits of `DOUBLE`.

If you are using a precision of `23` or less, the limits of `FLOAT` are
similar to the limits of `REAL`.

Data defined with type &nbsp;[`double`](sqlref_builtinfcns_double.html) at
this time. Note that this does not cause a loss of precision, though the
data may require slightly more space.
{: .noteRelease}

</div>
</section>

