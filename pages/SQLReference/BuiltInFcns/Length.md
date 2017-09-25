---
title: LENGTH built-in SQL function
summary: Built-in SQL function that computes the length of a character or bit string expression
keywords: len, length
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_length.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LENGTH   {#BuiltInFcns.Length}

The `LENGTH` function returns the number of characters in a character
string expression or bit string expression.

Since all built-in data types are implicitly converted to strings, this
function can act on all built-in data types.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LENGTH ( { CharacterExpression | BitExpression } )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

A character string expression.
{: .paramDefnFirst}

BitExpression
{: .paramName}

A bit string expression.
{: .paramDefnFirst}

</div>
## Results

The result data type is an integer value.

## Examples

The following three examples show the values returned by the
LENGTH function for string, integer, and bit string values.
{: .body}

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName, LENGTH(DisplayName) "NameLen"
       FROM Players
       WHERE ID < 11
       ORDER BY "NameLen";
    DISPLAYNAME             |NameLen
    ------------------------------------
    Greg Brown              |10
    John Purser             |11
    Bob Cranker             |11
    Billy Bopper            |12
    Mitch Duffer            |12
    Jason Minman            |12
    Buddy Painter           |13
    Norman Aikman           |13
    Alex Paramour           |13
    Harry Pennello          |14
    
    10 rows selected
    
    
    splice> SELECT ID,
       LENGTH(CAST(ID AS SMALLINT)) "SMALLINT",
       LENGTH(CAST(ID AS INT)) "INT",
       LENGTH(CAST(ID AS BIGINT)) "BIGINT",
       LENGTH(CAST(ID AS DECIMAL)) "DECIMAL5",
       LENGTH(CAST(ID AS DECIMAL(15,10))) "DECIMAL15",
       LENGTH(CAST(ID AS DECIMAL(30,25))) "DECIMAL30"
       FROM Players
       WHERE ID<11;
    ID    |SMALLINT   |INT        |BIGINT     |DECIMAL5   |DECIMAL15  |DECIMAL30
    ------------------------------------------------------------------------------
    1     |2          |4          |8          |3          |8          |16
    2     |2          |4          |8          |3          |8          |16
    3     |2          |4          |8          |3          |8          |16
    4     |2          |4          |8          |3          |8          |16
    5     |2          |4          |8          |3          |8          |16
    6     |2          |4          |8          |3          |8          |16
    7     |2          |4          |8          |3          |8          |16
    8     |2          |4          |8          |3          |8          |16
    9     |2          |4          |8          |3          |8          |16
    10    |2          |4          |8          |3          |8          |16
    
    10 rows selected
    
    
    splice> VALUES LENGTH(X'FF'),
       LENGTH(X'FFFF'),
       LENGTH(X'FFFFFFFF'),
       LENGTH(X'FFFFFFFFFFFFFFFF');
    -----------
    1
    2
    4
    8
    
    4 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
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

