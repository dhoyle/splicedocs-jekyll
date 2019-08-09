---
title: Summary of SQL Data Types
summary: A summary of the data types available in Splice Machine SQL.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_intro.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Data Types

The SQL type system is used by the language compiler to determine the
compile-time type of an expression and by the language execution system
to determine the runtime type of an expression, which can be a subtype
or implementation of the compile-time type.

Each type has associated with it values of that type. In addition,
values in the database or resulting from expressions can be `NULL`,
which means the value is missing or unknown. Although there are some
places where the keyword `NULL` can be explicitly used, it is not in
itself a value, because it needs to have a type associated with it.

This section contains the reference documentation for the Splice Machine
SQL Data Types, in the following subsections:

* [Character String Data Types](#Characte)
* [Date and Time Data Types](#Date)
* [Large Object Binary (LOB) Data Types](#Large)
* [Numeric Data Types](#Numeric)
* [Other Data Types](#Other)

## Character String Data Types   {#Characte}

These are the character string data types:

<table summary="Links to and descriptions of the available character string data types">
                <col />
                <col />
                <tr>
                    <th>
                    Data Type                </th>
                    <th>
                    Description
                </th>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_char.html">CHAR</a>
                    </td>
                    <td>
                        <p>The <code>CHAR</code> data type provides for fixed-length storage of strings.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_datatypes_longvarchar.html">LONG VARCHAR</a>
                    </td>
                    <td>
                        <p>The <code>LONG VARCHAR</code> type allows storage of character strings with a maximum length of 32,700 characters. It is identical to <code>VARCHAR</code>, except that you cannot specify a maximum length when creating columns of
					this type.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_datatypes_varchar.html">VARCHAR</a>
                    </td>
                    <td>The <code>VARCHAR</code> data type provides for variable-length storage of strings.</td>
                </tr>
            </table>
## Date and Time Data Types   {#Date}

These are the date and time data types:

<table summary="Links to and descriptions of the available date and time data types">
                <col />
                <col />
                <tr>
                    <th>
                    Data Type                </th>
                    <th>
                    Description
                </th>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_date.html">DATE</a>
                    </td>
                    <td>
                        <p>The <code>DATE</code> data type provides for storage of a year-month-day in the range supported by <em>java.sql.Date</em>. </p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_time.html">TIME</a>
                    </td>
                    <td>
                        <p>The <code>TIME</code> data type provides for storage of a time-of-day value.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_timestamp.html">TIMESTAMP</a>
                    </td>
                    <td>The <code>TIMESTAMP</code> data type stores a combined <code>DATE</code> and <code>TIME</code> value, and allows a fractional-seconds value of up to nine digits.</td>
                </tr>
            </table>
## Large Object Binary (LOB) Data Types   {#Large}

These are the LOB data types:

<table summary="Links to and descriptions of the available LOB data types">
                <col />
                <col />
                <tr>
                    <th>Data Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_datatypes_blob.html">BLOB</a>
                    </td>
                    <td>
                        <p>The <code>BLOB</code> (binary large object) data type is used for varying-length binary strings that can be up to 2,147,483,647 characters long.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_datatypes_clob.html">CLOB</a>
                    </td>
                    <td>
                        <p>The <code>CLOB</code> (character large object) data type is used for varying-length character strings that can be up to 2,147,483,647 characters long.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_datatypes_text.html"><code>TEXT</code></a>
                    </td>
                    <td>Exactly the same as <code>CLOB</code>.</td>
                </tr>
            </table>
## Numeric Data Types   {#Numeric}

These are the numeric data types:

<table summary="Links to and descriptions of the available numeric data types">
                <col />
                <col />
                <tr>
                    <th>
                    Data Type                </th>
                    <th>
                    Description
                </th>
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
## Other Data Types   {#Other}

These are the other data types:

<table summary="Links to and descriptions of primitive data types">
                <col />
                <col />
                <tr>
                    <th>
                    Data Type</th>
                    <th>
                    Description</th>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_datatypes_boolean.html">BOOLEAN</a>
                    </td>
                    <td>
                        <p>Provides 1 byte of storage for logical values.</p>
                    </td>
                </tr>
            </table>
## See Also

* [Argument Matching](sqlref_sqlargmatching.html)
* [Assignments](sqlref_datatypes_compatability.html)
* [`BIGINT`](sqlref_builtinfcns_bigint.html) data type
* [`BLOB`](sqlref_datatypes_blob.html) data type
* [`BOOLEAN`](sqlref_datatypes_boolean.html) data type
* [`CHAR`](sqlref_builtinfcns_char.html) data type
* [`CLOB`](sqlref_datatypes_clob.html) data type
* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DECIMAL`](sqlref_datatypes_decimal.html) data type
* [`DOUBLE`](sqlref_builtinfcns_double.html) data type
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type
* [`FLOAT`](sqlref_datatypes_float.html) data type
* [`INTEGER`](sqlref_builtinfcns_integer.html) data type
* [`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) data type
* [`NUMERIC`](sqlref_datatypes_numeric.html) data type
* [`REAL`](sqlref_datatypes_real.html) data type
* [`SMALLINT`](sqlref_builtinfcns_smallint.html) data type
* [`TEXT`](sqlref_datatypes_text.html) data type
* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) data type
* [`VARCHAR`](sqlref_datatypes_varchar.html) data type

</div>
</section>
