---
title: STRIP built-in SQL function
summary: Built-in SQL function that removes leading and/or trailing pad characters from a character expression
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_strip.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# STRIP

The `STRIP` function takes a character expression and returns that
expression with leading and/or trailing pad characters removed. Optional
parameters indicate whether leading, or trailing, or both leading and
trailing pad characters should be removed, and specify the pad character
that is to be removed.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    STRIP( stripSource { ',' striptype } { ',', stripCharacter } )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
stripSource
{: .paramName}

The character expression to be stripped
{: .paramDefnFirst}

stripType
{: .paramName}

Whether to strip from the left end, the right end, or both ends of the `stripSource` string. You can use the full or short identifiers:
{: .paramDefnFirst}

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td><code>LEADING</code> or <code>L</code></td>
            <td>Strip characters from the left side of the string.</td>
        </tr>
        <tr>
            <td><code>TRAILING</code> or <code>T</code></td>
            <td>Strip characters from the right side of the string.</td>
        </tr>
        <tr>
            <td><code>BOTH</code> or <code>B</code></td>
            <td>Strip characters from both the left and right sides of the string.</td>
        </tr>
    </tbody>
</table>

If this value is not specified, the default value of `BOTH` is used.
{: .paramDefn}

stripCharacter
{: .paramName}

A character expression that specifies which character to strip from the
source. If this is specified, it must evaluate to either `NULL` or to a
character string whose length is exactly one. If left unspecified, it
defaults to the space character (`' '`).
{: .paramDefnFirst}

</div>

## Results

If either *stripCharacter* or *stripSource* evaluates to `NULL`, the result of the `STRIP`
 function is `NULL`. Otherwise, the result is defined as follows:

* If *stripType* is `LEADING`, the result will be the *stripSource* value with all leading occurrences of *stripCharacter* removed.
* If *stripType* is `TRAILING`, the result will be the *stripSource* value with all trailing occurrences of *stripCharacter* removed.
* If *stripType* is `BOTH`, the result will be the *stripSource* value with all leading AND trailing occurrences of *stripCharacter* removed.

If stripSource's data type is `CHAR` or `VARCHAR`, the return type of the `STRIP` function will be `VARCHAR`. Otherwise the return type of the `STRIP` function will be `CLOB`.

## Examples

```
splice> values strip('   space case   ', b);
1
----------------
space case

splice> values strip('   space case   ', both);
1
----------------
space case

splice> values strip('   space case   ', L);
1
----------------
space case

splice> values strip('   space case   ', LEADING);
1
----------------
space case

splice> values strip('   space case   ', t);
1
----------------
   space case

splice> values strip('   space case   ', TRAILING);
1
----------------
   space case

splice> values strip( 'aabbccaa', b, 'a');
1
--------
bbcc

splice> values strip( 'aabbccaa', l, 'a');
1
--------
bbccaa

splice> values strip( 'aabbccaa', t, 'a');
1
--------
aabbcc
```
{: .Example}

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LOCATE`](sqlref_builtinfcns_locate.html) function
* [`LSTRIP`](sqlref_builtinfcns_lstrip.html) function
* [`REGEX_LIKE`](sqlref_builtinfcns_regexplike.html) operator
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`RSTRIP`](sqlref_builtinfcns_rstrip.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>
