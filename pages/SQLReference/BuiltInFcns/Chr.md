---
title: CHR built-in SQL function
summary: Built-in SQL function that returns the ASCII character equivalent of a numeric value, as a single byte value.
keywords: fixed-length character string
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_chr.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CHR

The `CHR` function returns the ASCII character equivalent of a numeric ASCII code value, as a single byte value.

## Syntax

```
CHR( number)
```
{: .FcnSyntax xml:space="preserve"}


<div class="paramList" markdown="1">
number
{: .paramName}

The ASCII code value for a character.
{: .paramDefnFirst}

</div>

## Results

This function takes as an argument a numeric value, or any value that can be implicitly converted to numeric, and returns a character. The character returned is described in the following table:

<table>
   <col />
   <col />
   <thead>
      <tr>
        <td>Value of <code>number</code></td>
        <td>Returned value</td>
      </tr>
   </thead>
   <tbody>
    <tr>
        <td><code>0 - 255</code></td>
        <td>The ASCII character corresponding to the value of <code>number</code>.</td>
    </tr>
    <tr>
        <td><code>&gt; 255</code></td>
        <td>The ASCII character corresponding to the value of <code>number mod 256</code>.</td>
    </tr>
    <tr>
        <td><code>&lt; 0</code></td>
        <td>The ASCII character corresponding to the value <code>255</code>.</td>
    </tr>
    <tr>
        <td><code>null</code></td>
        <td><code>null</code></td>
    </tr>
   </tbody>
</table>

## Examples

```
splice> VALUES( Chr(65) );
1
----
A

splice> VALUES( Chr(321) );
1
----
A

splice> VALUES( Chr(null) );
1
----
NULL
```
{: .Example xml:space="preserve"}


</div>
</section>
