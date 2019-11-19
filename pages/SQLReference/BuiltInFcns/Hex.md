---
title: HEX built-in SQL function
summary: Built-in SQL function that returns a hexadecimal representation of a value as a character string.
keywords: digits, character string, hex, hexadecimal
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_hex.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# HEX

The `HEX` function returns a returns a hexadecimal representation of a value as a character string: each character in the input string is converted into its two-character hexadecimal representation.

## Syntax

```
HEX( val )
```
{: .FcnSyntax xml:space="preserve"}

<div class="paramList" markdown="1">
val
{: .paramName}

The value that you want converted into a string representation. This must be a `CHAR` or `VARCHAR` value.
{: .paramDefnFirst}

</div>

## Results

This function converts the input `val` into a hexadecimal string by converting each character in the input string into its hexadecimal representation.

The length of the output string is the 2 times the length of the `val` string.

## Examples

```
splice> VALUES HEX('000020');
1
--------------
303030303230

1 row selected

splice> VALUES HEX('B');
1
--------------
42
```
{: .Example xml:space="preserve"}


</div>
</section>
