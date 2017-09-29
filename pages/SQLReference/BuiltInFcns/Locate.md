---
title: LOCATE built-in SQL function
summary: Built-in SQL function that searches for a string within another string
keywords: find substring
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_locate.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LOCATE

The `LOCATE` function is used to search for a string (the
*needle*) within another string (the *haystack*). If the desired string
is found, `LOCATE` returns the index at which it is found. If the
desired string is not found, `LOCATE` returns 0.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LOCATE(CharacterExpression1, CharacterExpression2
            [, StartPosition] )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
CharacterExpression1
{: .paramName}

A character expression that specifies the string to search **for** in
*CharacterExpression2*, sometimes called the needle.
{: .paramDefnFirst}

CharacterExpression2
{: .paramName}

A character expression that specifies the string in which to search,
sometimes called the haystack.
{: .paramDefnFirst}

StartPosition
{: .paramName}

(Optional). Specifies the position in *CharacterExpression2* at which
the search is to start. This defaults to the start of
*CharacterExpression2*, which is the value `1`.
{: .paramDefnFirst}

</div>
## Results

The return type for `LOCATE` is an integer that indicates the index
position within the second argument at which the first argument was
first located. Index positions start with 1.

* If the first argument is not found in the second argument, `LOCATE`
  returns `0`.
* If the first argument is an empty string (`''`), `LOCATE` returns the
  value of the third argument (or `1` if it was not provided), even if
  the second argument is also an empty string.
* If a `NULL` value is passed for either of the CharacterExpression
  arguments, `NULL` is returned

## Examples

<div class="preWrapperWide" markdown="1">
    splice> SELECT DisplayName, LOCATE('Pa', DisplayName, 3) "Position"
       FROM Players
       WHERE (INSTR(DisplayName, 'Pa') > 0)
       ORDER BY DisplayName;
    DISPLAYNAME             |Position
    ------------------------------------
    Alex Paramour           |6
    Buddy Painter           |7
    Jeremy Packman          |8
    Pablo Bonjourno         |0
    Paul Kaster             |0
    
    5 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LOCATE`](#) function
* [`LTRIM`](sqlref_builtinfcns_ltrim.html) function
* [`REGEX_LIKE`](sqlref_builtinfcns_regexplike.html) operator
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

