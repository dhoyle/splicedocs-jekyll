---
title: INSTR built-in function
summary: Built-in SQL function that returns the index of the first occurrence of a substring within a string
keywords: find substring, instr
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_instr.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# INSTR

The `INSTR` function returns the index of the first occurrence of a
substring in a string.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    INSTR(str, substring)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
str
{: .paramName}

The string in which to search for the substring.
{: .paramDefnFirst}

substring
{: .paramName}

The substring to search for.
{: .paramDefnFirst}

</div>
## Results

Returns the index in `str` of the first occurrence of `substring`.

The first index is `1`.

If `substring` is not found, `INSTR` returns `0`.

## Examples

<div class="preWrapperWide" markdown="1">
    splice> SELECT DisplayName, INSTR(DisplayName, 'Pa') "Position"
       FROM Players
       WHERE (INSTR(DisplayName, 'Pa') > 0)
       ORDER BY DisplayName;
    DISPLAYNAME             |Position
    ------------------------------------
    Alex Paramour           |6
    Buddy Painter           |7
    Jeremy Packman          |8
    Pablo Bonjourno         |1
    Paul Kaster             |1
    
    5 rows selected
{: .Example}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LOCATE`](sqlref_builtinfcns_locate.html) function
* [`LTRIM`](sqlref_builtinfcns_ltrim.html) function
* [`REGEX_LIKE`](sqlref_builtinfcns_regexplike.html) operator
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

