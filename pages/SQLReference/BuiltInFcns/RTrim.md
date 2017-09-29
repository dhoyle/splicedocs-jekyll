---
title: RTRIM built-in SQL function
summary: Built-in SQL function that removes blanks from the end of a character expression
keywords: right trim, string functions
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_rtrim.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# RTRIM

`RTRIM` removes blanks from the end of a character string expression.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RTRIM(CharacterExpression)
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

A &nbsp;[`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) data type, any
built-in type that is implicitly converted to a string.
{: .paramDefnFirst}

</div>
## Results

A character string expression. If the *CharacterExpression* evaluates to
`NULL`, this function returns `NULL`.

## Examples

<div class="preWrapper" markdown="1">
    
    splice> VALUES RTRIM('     Space Case      ');
    1
    -------------
         Space Case	--- This is the string '   Space Case'
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
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

