---
title: UCASE (or UPPER) built-in SQL function
summary: Built-in SQL function that converts all lowercase alphabetic characters in an expression into uppercase.
keywords: convert to uppercase
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_ucase.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LN or UPPER

`UCASE` or `UPPER` returns a string in which all alphabetic characters
in the input character expression have been converted to uppercase.

`UPPER` and `UCASE` follow the database locale.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    UCASE or UPPER ( CharacterExpression ) 
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

A &nbsp;[`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) data type, or any
built-in type that is implicitly converted to a string (but not a bit
expression).
{: .paramDefnFirst}

</div>
## Results

The data type of the result is as follows:

* If the *CharacterExpression* evaluates to `NULL`, this function
  returns `NULL`.
* If the *CharacterExpression* is of type
 &nbsp;[`CHAR`](sqlref_builtinfcns_char.html).
* If the *CharacterExpression* is of type
 &nbsp;[`LONG VARCHAR`](sqlref_datatypes_longvarchar.html).
* Otherwise, the return type is
 &nbsp;[`VARCHAR`](sqlref_datatypes_varchar.html).

The length and maximum length of the returned value are the same as the
length and maximum length of the parameter.

## Example

To return the names of players, use the following clause:

<div class="preWrapper" markdown="1">
    
    splice> SELECT UCASE(DisplayName)
       FROM Players
       WHERE ID < 11;
    1
    ------------------------
    BUDDY PAINTER
    BILL BOPPER
    JOHN PURSER
    BOB CRANKER 
    MITCH DUFFER 
    NORMAN AIKMAN 
    ALEX PARAMOUR 
    HARRY PENNELLO
    GREG BROWN
    JASON MINMAN
    
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
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function

</div>
</section>

