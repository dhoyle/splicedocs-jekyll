---
title: INITCAP built-in SQL function
summary: Built-in SQL function that converts the first letter of every word to uppercase, and all remaining characters in the word to lowercase. 
keywords: convert case, string function
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_initcap.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# INITCAP

The `INITCAP` function converts the first letter of each word in a
string to uppercase, and converts any remaining characters in each word
to lowercase. Words are delimited by white space characters, or by
characters that are not alphanumeric.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    INITCAP( charExpression );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
charExpression
{: .paramName}

The string to be converted. This can be a `CHAR` or `VARCHAR` data type,
or another type that gets implicitly converted.
{: .paramDefnFirst}

</div>
## Results

The returned string has the same data type as the input
`charExpression`.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES( INITCAP('this is a test') );
    1
    ---------------------------------------------------------------------
    This Is A Test
    1 row selected
    
    splice> VALUES( INITCAP('tHIS iS a test') );
    1
    ---------------------------------------------------------------------
    This Is A Test
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
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
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

