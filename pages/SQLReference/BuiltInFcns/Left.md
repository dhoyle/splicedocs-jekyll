---
title: LEFT built-in SQL function
summary: Built-in SQL function that returns the leftmost n characters from a string.
keywords: fixed-length character string
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_left.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LEFT

The `LEFT` function returns the leftmost n characters from a string.

## Syntax

```
LEFT( string, n )
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

This function takes as arguments a string from which you want to extract a substring, starting with the first (leftmost) character in the string, and an integer that specifies the number of characters that you want to extract.

If there are less characters in the `string` than are specified in `n`, the entire `string` is returned (no padding is applied to the result).

## Examples

```
splice> VALUES( LEFT( 'Splice Machine', 6 ) );
1
--------------
Splice

splice> VALUES( LEFT( 'Splice Machine', 3 ) );
1
--------------
Spl


splice> VALUES( LEFT( 'Splice Machine', 32 ) );
1
------------------------
Splice Machine
```
{: .Example xml:space="preserve"}


</div>
</section>
