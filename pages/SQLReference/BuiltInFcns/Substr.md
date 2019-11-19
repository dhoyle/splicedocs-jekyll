---
title: SUBSTR built-in SQL function
summary: Built-in SQL function that extracts a portion of a character or bit string
keywords: substring
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_substr.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SUBSTR

The `SUBSTR` function extracts and returns a portion of a character
string or bit string expression, starting at the specified character or
bit position. You can specify the number of characters or bits you want
returned, or use the default length, which is to extract from the
specified starting position to the end of the string.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SUBSTR({ CharacterExpression },
    		StartPosition [, LengthOfSubstring ] )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

A `CHAR`, `VARCHAR`, or `LONG VARCHAR` data type or any built-in type
that is implicitly converted to a string (except a bit expression).
{: .paramDefnFirst}

StartPosition
{: .paramName}

An integer expression; for character expressions, this is the starting
character position of the returned substring. For bit expressions, this
is the bit position of the returned substring.
{: .paramDefnFirst}

The first character or bit has a *StartPosition* of 1. If you specify 0,
Splice Machine assumes that you mean 1.
{: .paramDefn}

If the *StartPosition* is positive, it refers to the position from the
start of the source expression (counting the first character as 1) to
the beginning of the substring you want extracted. The *StartPosition*
value cannot be a negative number.
{: .paramDefn}

LengthOfSubstring
{: .paramName}

An optional integer expression that specifies the length of the
extracted substring; for character expressions, this is number of
characters to return. For bit expressions, this is the number of bits to
return.
{: .paramDefnFirst}

If this value is not specified, then `SUBSTR` extracts a substring of
the expression from the *StartPosition* to the end of the source
expression.
{: .paramDefn}

If *LengthOfString* is specified, `SUBSTR` returns a `VARCHAR` or
`VARBIT` of length *LengthOfString* starting at the *StartPosition*.
{: .paramDefn}

The `SUBSTR` function returns an error if you specify a negative number
for the parameter *LengthOfString*.
{: .paramDefn}

</div>
## Results

For character string expressions, the result type is a
[`VARCHAR`](sqlref_datatypes_varchar.html) value.

The length of the result is the maximum length of the source type.

## Examples

The following query extracts the first four characters of each player's
name, and then extracts the remaining characters:

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName,
       SUBSTR(DisplayName, 1, 4) "1to4",
       SUBSTR(DisplayName, 4) "5ToEnd"
       FROM Players
       WHERE ID < 11;
    DISPLAYNAME             |1To4|5ToEnd
    ------------------------------------------------------
    Buddy Painter           |Budd|dy Painter
    Billy Bopper            |Bill|ly Bopper
    John Purser             |John|n Purser
    Bob Cranker             |Bob | Cranker
    Mitch Duffer            |Mitc|ch Duffer
    Norman Aikman           |Norm|man Aikman
    Alex Paramour           |Alex|x Paramour
    Harry Pennello          |Harr|ry Pennello
    Greg Brown              |Greg|g Brown
    Jason Minman            |Jaso|on Minman
    
    10 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LOCATE`](sqlref_builtinfcns_locate.html) function
* [`LTRIM`](sqlref_builtinfcns_ltrim.html) function
* [`REGEX_LIKE`](sqlref_builtinfcns_regexplike.html) operator
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

