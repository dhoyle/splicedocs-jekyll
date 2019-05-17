---
title: About Numeric Types
summary: Summarized information about using numeric data types in your database and procedures.
keywords: numeric data types
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_numerictypes.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# About Numeric Data Types

This section contains the reference documentation for the numeric data
types built into Splice Machine SQL:

<table summary="Links to and descriptions of the available numeric data types">
    <col />
    <col />
    <tr>
        <th>
        Data Type</th>
        <th>
        Description</th>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_bigint.html">BIGINT</a>
        </td>
        <td>
            <p>The <code>BIGINT</code> data type provides 8 bytes of storage for integer values.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_decimal.html">DECIMAL</a>
        </td>
        <td>
            <p>The  <code>DECIMAL</code> data type provides an exact numeric in which the precision and scale can be arbitrarily sized. </p>
            <p>You can use <code>DECIMAL</code> and <code>NUMERIC</code> interchangeably.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_double.html">DOUBLE</a>
        </td>
        <td>
            <p>The <code>DOUBLE</code> data type provides 8-byte storage for numbers
		using IEEE floating-point notation. </p>
            <p><code>DOUBLE PRECISION</code> can be used synonymously with <code>DOUBLE</code>.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_doubleprecision.html">DOUBLE PRECISION</a>
        </td>
        <td>
            <p>The <code>DOUBLE PRECISION</code> data type provides 8-byte storage for numbers
		using IEEE floating-point notation.</p>
            <p><code>DOUBLE</code> can be used synonymously with <code>DOUBLE PRECISION</code>.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_float.html">FLOAT</a>
        </td>
        <td>
            <p>The <code>FLOAT</code> data type is an alias for either a <code>REAL</code> or <code>DOUBLE PRECISION</code>
		data type, depending on the precision you specify.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_integer.html">INTEGER</a>
        </td>
        <td>
            <p><code>INTEGER</code> provides 4 bytes of storage for integer values.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_numeric.html">NUMERIC</a>
        </td>
        <td>
            <p>The  <code>NUMERIC</code>data type provides an exact numeric in which the precision and scale can be arbitrarily sized. </p>
            <p>You can use <code>NUMERIC</code> and <code>DECIMAL</code> interchangeably.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_real.html">REAL</a>
        </td>
        <td>
            <p>The <code>REAL</code> data type provides 4 bytes of storage for numbers using
		IEEE floating-point notation. </p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_smallint.html">SMALLINT</a>
        </td>
        <td>
            <p>The <code>SMALLINT</code> data type provides 2 bytes of storage.</p>
        </td>
    </tr>
    <tr>
        <td class="CodeFont"><a href="sqlref_datatypes_tinyint.html">TINYINT</a>
        </td>
        <td>
            <p>The <code>TINYINT</code> data type provides 1 byte of storage.</p>
        </td>
    </tr>
</table>
## Using Numeric Types

Numeric types include the following types, which provide storage of
varying sizes:

<table summary="Storage required for numeric types">
    <col />
    <col />
    <thead>
        <tr>
            <th>Numeric Type</th>
            <th>Data Types</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Integer numerics</em></td>
            <td>
                <p><a href="sqlref_datatypes_tinyint.html"><code>TINYINT</code></a> (1 byte)</p>
                <p><a href="sqlref_datatypes_smallint.html"><code>SMALLINT</code></a> (2 bytes)</p>
                <p><a href="sqlref_datatypes_integer.html"><code>INTEGER</code></a> (4 bytes)</p>
                <p><a href="sqlref_datatypes_bigint.html"><code>BIGINT</code></a> (8 bytes)</p>
            </td>
        </tr>
        <tr>
            <td><em>Floating-point (also called approximate) numerics</em></td>
            <td>
                <p><a href="sqlref_datatypes_real.html"><code>REAL</code></a> (4 bytes)</p>
                <p><a href="sqlref_datatypes_doubleprecision.html"><code>DOUBLE PRECISION</code></a> (8 bytes)</p>
                <p><a href="sqlref_datatypes_real.html"><code>REAL</code></a>)</p>
            </td>
        </tr>
        <tr>
            <td><em>Exact numerics</em></td>
            <td>
                <p><a href="sqlref_datatypes_decimal.html"><code>DECIMAL</code></a> (storage based on precision)</p>
                <p><a href="sqlref_datatypes_decimal.html"><code>DECIMAL</code></a></p>
            </td>
        </tr>
    </tbody>
</table>
### Numeric Type Promotion in Expressions   {#NumericTypePromotion}

The following table shows the result type of numeric expressions based
on the mix of numeric data types in the expressions.

<table summary="Result types for mixed numeric operations">
    <col />
    <col />
    <thead>
        <tr>
            <th>Largest Type That Appears in Expression
        </th>
            <th>Resulting Type of Expression
        </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>DOUBLE PRECISION</code></td>
            <td><code>DOUBLE PRECISION</code></td>
        </tr>
        <tr>
            <td><code>REAL</code></td>
            <td><code>DOUBLE PRECISION</code></td>
        </tr>
        <tr>
            <td><code>DECIMAL</code></td>
            <td><code>DECIMAL</code></td>
        </tr>
        <tr>
            <td><code>BIGINT</code></td>
            <td><code>BIGINT</code></td>
        </tr>
        <tr>
            <td><code>INTEGER</code></td>
            <td><code>BIGINT</code></td>
        </tr>
        <tr>
            <td><code>SMALLINT</code></td>
            <td><code>BIGINT</code></td>
        </tr>
        <tr>
            <td><code>TINYINT</code></td>
            <td><code>BIGINT</code></td>
        </tr>
    </tbody>
</table>
For example:

<div class="preWrapper" markdown="1">

       -- returns a double precision value
    VALUES 1 + 1.0e0;
       -- returns a decimal value
    VALUES 1 + 1.0;
       -- returns a bigint value
    VALUES CAST (1 AS INT) + CAST (1 AS INT);
{: .Example xml:space="preserve"}

</div>
### Storing Numeric Values   {#StoringValues}

An attempt to put a floating-point type of a larger storage size into a
location of a smaller size fails only if the value cannot be stored in
the smaller-size location. For example:

<div class="preWrapperWide" markdown="1">

    create table mytable (r REAL, d DOUBLE PRECISION);
       0 rows inserted/updated/deleted
    INSERT INTO mytable (r, d) values (3.4028236E38, 3.4028235E38);
       ERROR X0X41: The number '3.4028236E38' is outside the range for the data type REAL.
{: .Example}

</div>
You can store a floating point type in an `INTEGER` column; the
fractional part of the number is truncated. For example:

<div class="preWrapperWide" markdown="1">

    INSERT INTO mytable(integer_column) values (1.09e0);
       1 row inserted/updated/deleted
       SELECT integer_column
       FROM mytable;
    ---------------
       1
{: .Example}

</div>
Integer types can always be placed successfully in approximate numeric
values, although with the possible loss of some precision.

Integers can be stored in decimals if the `DECIMAL` precision is large
enough for the value. For example:

<div class="preWrapperWide" markdown="1">

    ij>
    insert into mytable (decimal_column) VALUES (55555555556666666666);
       ERROR X0Y21: The number '55555555556666666666' is outside the
       range of the target DECIMAL/NUMERIC(5,2) datatype.
{: .Example}

</div>
An attempt to put an integer value of a larger storage size into a
location of a smaller size fails if the value cannot be stored in the
smaller-size location. For example:

<div class="preWrapperWide" markdown="1">

    INSERT INTO mytable (int_column) values 2147483648;
       ERROR 22003: The resulting value is outside the range for the data type INTEGER.
{: .Example}

</div>
Splice Machine rounds down when truncating trailing digits from a
`NUMERIC` value.
{: .noteNote}

### Scale for Decimal Arithmetic   {#Scale}

SQL statements can involve arithmetic expressions that use decimal data
types of different *precisions* (the total number of digits, both to the
left and to the right of the decimal point) and *scales* (the number of
digits of the fractional component).

The precision and scale of the resulting decimal type depend on the
precision and scale of the operands.

Given an arithmetic expression that involves two decimal operands:

* *lp* stands for the precision of the left operand
* *rp* stands for the precision of the right operand
* *ls* stands for the scale of the left operand
* *rs* stands for the scale of the right operand

Use the following formulas to determine the scale of the resulting data
type for the following kinds of arithmetical expressions:

<table summary="Scale of results from arithmetical expressions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Operation</th>
            <th>Scale</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>multiplication</td>
            <td class="ItalicFont">ls + rs
    </td>
        </tr>
        <tr>
            <td>division</td>
            <td><em>38 - lp + ls - rs</em></td>
        </tr>
        <tr>
            <td><code>AVG()</code></td>
            <td><em>max(max(ls, rs), 4)</em></td>
        </tr>
        <tr>
            <td>all others</td>
            <td><em>max(ls, rs)</em></td>
        </tr>
    </tbody>
</table>
For example, the scale of the resulting data type of the following
expression is <span class="Example">34</span>:

```
11.0/1111.33          // 38 - 3 + 1 - 2 = 2
```
{: .Example}

Use the following formulas to determine the precision of the resulting
data type for the following kinds of arithmetical expressions:
{: .spaceAbove}

<table summary="Precision of numeric operations">
    <col />
    <col />
    <thead>
        <tr>
            <th>Operation</th>
            <th>Precision</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>multiplication
    </td>
            <td><em>lp + rp</em></td>
        </tr>
        <tr>
            <td>addition
    </td>
            <td><em>2 * (p - s) + s</em></td>
        </tr>
        <tr>
            <td>division
    </td>
            <td><em>lp - ls + rp + max(ls + rp - rs + 1, 4)</em></td>
        </tr>
        <tr>
            <td>all others
    </td>
            <td><em>max(lp - ls, rp - rs) + 1 + max(ls, rs)</em></td>
        </tr>
    </tbody>
</table>
## See Also

* [Data Type Compatability](sqlref_datatypes_compatability.html)
* [`BIGINT`](sqlref_datatypes_bigint.html) data type
* [`BLOB`](sqlref_datatypes_blob.html) data type
* [`BOOLEAN`](sqlref_datatypes_boolean.html) data type
* [`CHAR`](sqlref_datatypes_char.html) data type
* [`CLOB`](sqlref_datatypes_clob.html) data type
* [`DATE`](sqlref_datatypes_date.html) data type
* [`DECIMAL`](sqlref_datatypes_decimal.html) data type
* [`DOUBLE`](sqlref_datatypes_double.html) data type
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`FLOAT`](sqlref_datatypes_float.html) data type
* [`INTEGER`](sqlref_datatypes_integer.html) data type
* [`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) data type
* [`NUMERIC`](sqlref_datatypes_numeric.html) data type
* [`REAL`](sqlref_datatypes_real.html) data type
* [`SMALLINT`](sqlref_datatypes_smallint.html) data type
* [`TEXT`](sqlref_datatypes_text.html) data type
* [`TIME`](sqlref_datatypes_time.html) data type
* [`TIMESTAMP`](sqlref_datatypes_timestamp.html) data type
* [`TINYINT`](sqlref_datatypes_tinyint.html) data type
* [`VARCHAR`](sqlref_datatypes_varchar.html) data type

</div>
</section>
