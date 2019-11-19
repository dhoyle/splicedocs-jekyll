---
title: DIGITS built-in SQL function
summary: Built-in SQL function that returns a character string representation of a number.
keywords: digits, character string
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_digits.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DIGITS

The `DIGITS` function returns a fixed-length character string representation of a numeric value.

## Syntax

```
DIGITS( val )
```
{: .FcnSyntax xml:space="preserve"}

<div class="paramList" markdown="1">
val
{: .paramName}

The value that you want converted into a string representation. This can be a numeric, `CHAR`, or `VARCHAR` value.
{: .paramDefnFirst}

</div>

## Results

This function converts the input `val` into a fixed-length string.

The length of the output string is determined by the data type of the `val` argument, as show in the following table:

<table>
  <col />
  <col />
  <thead>
    <tr>
        <td>Input Value Type</td>
        <td>Length of Result String</td>
    </tr>
  </thead>
    <tr>
        <td>TINYINT,<br />SMALLINT</td>
        <td class="CodeFont">5</td>
    </tr>
    <tr>
        <td>INT</td>
        <td class="CodeFont">10</td>
    </tr>
    <tr>
        <td>BIGINT</td>
        <td class="CodeFont">19</td>
    </tr>
    <tr>
        <td>DECIMAL</td>
        <td>The precision of the DECIMAL value.</td>
    </tr>
    <tr>
        <td>FLOAT with precision <= 23, <br />REAL</td>
        <td class="CodeFont">23</td>
    </tr>
    <tr>
        <td>FLOAT with precision > 23, <br />DOUBLE</td>
        <td class="CodeFont">52</td>
    </tr>
    <tr>
        <td>CHAR, <br />VARCHAR</td>
        <td><code>31</code><br />
            ( The value is converted to DECIMAL(31,6) )</td>
    </tr>
  <tbody>
  </tbody>
</table>

The return value is left-padded with `0`'s if the number of digits is less than the fixed-length of the result string.

## Examples

```
splice> VALUES( DIGITS( 12345 ) );
1
--------------
0000012345

splice> VALUES( DIGITS( 123.45 ) );
1
--------------
12345


splice> VALUES( DIGITS( '12345' ) );
1
------------------------
0000000000000000000012345000000

splice> VALUES( DIGITS( '123.45' ) );
1
------------------------
0000000000000000000000123450000
```
{: .Example xml:space="preserve"}


</div>
</section>
