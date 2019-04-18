---
title: CAST built-in SQL function
summary: Built-in SQL function that converts values (expressions) from one data type to another
keywords: casting types, type conversion
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_cast.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CAST

The `CAST` function converts a value from one data type to another and
provides a data type to a dynamic parameter or a `NULL` value.

`CAST` expressions are permitted anywhere expressions are permitted.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CAST ( [ Expression | NULL | ? ]
      AS Datatype)
{: .FcnSyntax xml:space="preserve"}

</div>
The data type to which you are casting an expression is the *target
type*. The data type of the expression from which you are casting is the
*source type*.

## CAST conversions among ANSI SQL data types

The following table shows valid explicit conversions between source
types and target types for SQL data types. This table shows which
explicit conversions between data types are valid. The first column on
the table lists the source data types. The first row lists the target
data types. A "Y" indicates that a conversion from the source to the
target is valid. For example, the first cell in the second row lists the
source data type SMALLINT. The remaining cells on the second row
indicate the whether or not you can convert SMALLINT to the target data
types that are listed in the first row of the table.

<table summary="ANSI SQL data type CAST conversions matrix">
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>TYPES</th>
                        <th style="vertical-align:bottom;">B<br />O<br />O<br />L<br />E<br />A<br />N</th>
                        <th style="vertical-align:bottom;">T<br />I<br />N<br />Y<br />I<br />N<br />T</th>
                        <th style="vertical-align:bottom;">S<br />M<br />A<br />L<br />L<br />I<br />N<br />T</th>
                        <th style="vertical-align:bottom;">I<br />N<br />T<br />E<br />G<br />E<br />R</th>
                        <th style="vertical-align:bottom;">B<br />I<br />G<br />I<br />N<br />T</th>
                        <th style="vertical-align:bottom;">D<br />E<br />C<br />I<br />M<br />A<br />L</th>
                        <th style="vertical-align:bottom;">R<br />E<br />A<br />L</th>
                        <th style="vertical-align:bottom;">D<br />O<br />U<br />B<br />L<br />E</th>
                        <th style="vertical-align:bottom;">F<br />L<br />O<br />A<br />T</th>
                        <th style="vertical-align:bottom;">C<br />H<br />A<br />R</th>
                        <th style="vertical-align:bottom;">V<br />A<br />R<br />C<br />H<br />A<br />R</th>
                        <th style="vertical-align:bottom;">L<br />O<br />N<br />G<br /><br />V<br />A<br />R<br />C<br />H<br />A<br />R</th>
                        <th style="vertical-align:bottom;">C<br />L<br />O<br />B</th>
                        <th style="vertical-align:bottom;">B<br />L<br />O<br />B<br /></th>
                        <th style="vertical-align:bottom;">D<br />A<br />T<br />E</th>
                        <th style="vertical-align:bottom;">T<br />I<br />M<br />E</th>
                        <th style="vertical-align:bottom;">T<br />I<br />M<br />E<br />S<br />T<br />A<br />M<br />P</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>BOOLEAN</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>TINYINT</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>SMALLINT</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>INTEGER</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>BIGINT</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>DECIMAL</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>REAL</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>DOUBLE</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>FLOAT</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>CHAR</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                    </tr>
                    <tr>
                        <td>VARCHAR</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                    </tr>
                    <tr>
                        <td>LONG VARCHAR</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>CLOB</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>BLOB</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>DATE</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>TIME</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>TIMESTAMP</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>Y</td>
                        <td>Y</td>
                        <td>Y</td>
                    </tr>
                </tbody>
            </table>
If a conversion is valid, CASTs are allowed. Size incompatibilities
between the source and target types might cause runtime errors.

## Type Categories

This section lists information about converting specific data types. The
Splice Machine ANSI SQL data types are categorized as follows:
{: .body}

<table summary="SQL data type categories">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Category</th>
                        <th>Data Types</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>logical</em></td>
                        <td><code>BOOLEAN</code>
                        </td>
                    </tr>
                    <tr>
                        <td><em>numeric</em></td>
                        <td>
                            <p>Exact numeric: <code>TINYINT, SMALLINT, INTEGER, BIGINT, DECIMAL, NUMERIC</code></p>
                            <p>Approximate numeric: <code>FLOAT, REAL, DOUBLE PRECISION</code></p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>string</em></td>
                        <td>
                            <p>Character string: <code>CLOB, CHAR, VARCHAR, LONG VARCHAR</code></p>
                            <p>Bit string: <code>BLOB</code></p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>date and time</em></td>
                        <td><code>DATE, TIME, TIMESTAMP</code>
                        </td>
                    </tr>
                </tbody>
            </table>
## Conversion Notes

This section lists additional information about casting of certain data
types.
{: .body}

### Applying Multiple Conversions

As shown in the above table, you cannot convert freely among all types.
For example, you cannot `CAST`an `INTEGER` value to a `VARCHAR` value.
However, you may be able to achieve your conversion by using multiple
`CAST` operations.

For example, since you can convert an `INTEGER` value to a `CHAR` value,
and you can convert a `CHAR` value to a `VARCHAR` value, you can use
multiple `CAST` operations, as shown here:

<div class="preWrapper" markdown="1">
    CAST(CAST(123 AS CHAR(10)) AS VARCHAR(10));SELECT CAST(CAST(myId as CHAR(20)) as VARCHAR(20));
{: .Example}

</div>
### Conversions to and from logical types

These notes apply to converting logical values to strings and
vice-versa:
{: .body}

* A `BOOLEAN` value can be cast explicitly to any of the string types.
  The result is `'true'`, `'false'`, or `null`.
* Conversely, string types can be cast to `BOOLEAN`; however, an error
  is raised if the string value is not `'true'`, `'false'`, `'unknown'`,
  or `null`.
* Casting `'false'` to `BOOLEAN` results in a `null` value.

### Conversions from numeric types

A numeric type can be converted to any other numeric type. These notes
apply:
{: .body}

* If the target type cannot represent the non-fractional component
  without truncation, an exception is raised.
* If the target numeric cannot represent the fractional component
  (scale) of the source numeric, then the source is silently truncated
  to fit into the target. For example, casting `763.1234` as `INTEGER`
  yields `763`.

### Conversions from and to bit strings

Bit strings can be converted to other bit strings, but not to character
strings. Strings that are converted to bit strings are padded with
trailing zeros to fit the size of the target bit string. The `BLOB` type
is more limited and requires explicit casting. In most cases the `BLOB`
type cannot be cast to and from other types: you can cast a `BLOB` only
to another `BLOB`, but you can cast other bit string types to a `BLOB`.

### Conversions of date/time values

A date/time value can always be converted to and from a `TIMESTAMP`.

If a `DATE` is converted to a `TIMESTAMP`, the `TIME` component of the
resulting `TIMESTAMP` is always `00:00:00`.

If a `TIME` data value is converted to a `TIMESTAMP`, the `DATE`
component is set to the value of `CURRENT_DATE` at the time the `CAST`
is executed.

If a `TIMESTAMP` is converted to a `DATE`, the `TIME` component is
silently truncated.

If a `TIMESTAMP` is converted to a `TIME`, the `DATE` component is
silently truncated.

### Implicit Conversions and Joins
Splice Machine performs implicit type conversion when performing joins to allow joining of mismatched column types. Specifically, when joining a `CHAR` or `VARCHAR` column on a column of the following types, an attempt is made to convert the string value into that column's type:

* `BOOLEAN`
* `DATE`
* `TIME`
* `TIMESTAMP`

If any row in a query that involves implicit type conversion contains a column value cannot be converted to the desired type, the `join` fails, and the following error is thrown:

```
   ERROR 22007: The syntax of the string representation of a datetime value is incorrect
```


## Examples

Here are a few explicit type conversions:

<div class="preWrapper" markdown="1">
    splice> SELECT CAST (TotalBases AS BIGINT)
      FROM Batting;

       -- convert timestamps to text
    splice> INSERT INTO mytable (text_column)
      VALUES (CAST (CURRENT_TIMESTAMP AS VARCHAR(100)));

       -- you must cast NULL as a data type to use it
    splice> SELECT airline
      FROM Airlines
      UNION ALL
      VALUES (CAST (NULL AS CHAR(2)));

       -- cast a double as a decimal
    splice> SELECT CAST (FLYING_TIME AS DECIMAL(5,2))
      FROM FLIGHTS;

       -- cast a SMALLINT to a BIGINT
    splice> VALUES CAST (CAST (12 as SMALLINT) as BIGINT);
{: .Example xml:space="preserve"}

</div>


Here's an example of implicit conversion failures during attempted joins:

<div class="preWrapper" markdown="1">
    CREATE TABLE s1 (a1 INT, b1 VARCHAR(16));
    CREATE TABLE s2 (a2 INT, b2 DATE);
    CREATE TABLE s3 (a3 INT, b3 BOOLEAN);

    INSERT INTO s2 VALUES (2,'2018-11-11');
    INSERT INTO s3 VALUES (3,true);

    INSERT INTO s1 VALUES(1,'2018-11-11');
    SELECT a1 FROM s1 JOIN s2 ON  b1 = b2;
    A1
    -----------
    1

    INSERT INTO s1 VALUES(2,'foo');
    SELECT a1 FROM s1 JOIN s2 ON  b1 = b2;
    ERROR 22007: The syntax of the string representation of a datetime value is incorrect.

    DELETE FROM s1;
    INSERT INTO s1 VALUES (1,'1');
    SELECT a1 FROM s1 JOIN s3 ON  b1 = b3;
    A1
    -----------
    1

    INSERT INTO s1 VALUES (2,'foo');
    SELECT a1 FROM s1 JOIN s3 ON  b1 = b3;
    ERROR 22018: Invalid character string format for type BOOLEAN.
{: .Example xml:space="preserve"}
</div>

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)

</div>
</section>
