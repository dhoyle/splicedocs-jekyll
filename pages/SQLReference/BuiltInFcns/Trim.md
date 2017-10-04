---
title: TRIM built-in SQL function
summary: Built-in SQL function that removes leading and/or trailing pad characters from a character expression
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_trim.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TRIM

The `TRIM` function that takes a character expression and returns that
expression with leading and/or trailing pad characters removed. Optional
parameters indicate whether leading, or trailing, or both leading and
trailing pad characters should be removed, and specify the pad character
that is to be removed.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TRIM( [ trimOperands ] trimSource)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
trimOperands
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    {  { trimType [trimCharacter]  FROM
      |  trimCharacter FROM
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
trimCharacter
{: .paramName}

A character expression that specifies which character to trim from the
source. If this is specified, it must evaluate to either `NULL` or to a
character string whose length is exactly one. If left unspecified, it
defaults to the space character (`' '`).
{: .paramDefnFirst}

trimType
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    {LEADING | TRAILING | BOTH}
{: .FcnSyntax xml:space="preserve"}

</div>
If this value is not specified, the default value of `BOTH` is used.
{: .paramDefnFirst}

</div>
trimSource
{: .paramName}

The character expression to be trimmed
{: .paramDefnFirst}

</div>
## Results

If either *trimCharacter* or *trimSource* evaluates to `NULL`, the result of the `TRIM`
 function is `NULL`. Otherwise, the result is defined as follows:

* If *trimType* is `LEADING`, the result will be the *trimSource* value with all leading occurrences of *trimCharacter* removed.
* If *trimType* is `TRAILING`, the result will be the *trimSource* value with all trailing occurrences of *trimCharacter* removed.
* If *trimType* is `BOTH`, the result will be the *trimSource* value with all leading AND trailing occurrences of *trimCharacter* removed.

If trimSource's data type is `CHAR` or `VARCHAR`, the return type of the `TRIM` function will be `VARCHAR`. Otherwise the return type of the `TRIM` function will be `CLOB`.

## Examples

<div class="preWrapperWide" markdown="1">

    splice> VALUES TRIM('      Space Case   ');
    1
    -----------
    Space Case	--- This is the string 'Space Case'

    splice> VALUES TRIM(BOTH ' ' FROM '      Space Case   ');
    1
    -----------
    Space Case	--- This is the string 'Space Case'

    splice> VALUES TRIM(TRAILING ' ' FROM '     Space Case     ');
    1
    -----------
         Space Case	--- This is the string '     Space Case'

    splice> VALUES TRIM(CAST NULL AS CHAR(1) FROM '     Space Case     ');
    1
    -----------
    NULL

    splice> VALUES TRIM('o' FROM 'VooDoo');
    1
    ----------
    VooD

       -- results in an error because trimCharacter can only be 1 character
    splice> VALUES TRIM('Do' FROM 'VooDoo');
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
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>
