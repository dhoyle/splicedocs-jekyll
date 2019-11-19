---
title: RIGHT built-in SQL function
summary: Built-in SQL function that returns the rightmost n characters from a string.
keywords: fixed-length character string
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_right.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RIGHT

The `RIGHT` function returns the rightmost n characters from a string.

## Syntax

```
RIGHT( string, n )
```
{: .FcnSyntax xml:space="preserve"}

<div class="paramList" markdown="1">
string
{: .paramName}

The string from which you want to extract characters.
{: .paramDefnFirst}

n
{: .paramName}

An integer value that specifies the number of characters that you want to extract from `string`.
{: .paramDefnFirst}
</div>

## Results

This function takes as arguments a string from which you want to extract a substring, working backwards from the last (rightmost) character in the string, and an integer that specifies the number of characters that you want to extract.

If there are fewer characters in the `string` than are specified in `n`, the entire `string` is returned (no padding is applied to the result).

## Examples

```
splice> VALUES( RIGHT( 'Splice Machine', 6 ) );
1
---------------
achine

splice> VALUES( RIGHT( 'Splice Machine', 3 ) );
1
---------------
ine

splice> VALUES( RIGHT( 'Splice Machine', 32 ) );
1
---------------
Splice Machine
```
{: .Example xml:space="preserve"}


</div>
</section>
