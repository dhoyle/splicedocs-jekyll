---
title: LCASE (or LOWER) built-in SQL function
summary: Built-in SQL function that converts a character expression to lowercase
keywords: lowercase, string function
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_lcase.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LCASE or LOWER

`LCASE` or `LOWER` returns a string in which all alphabetic characters
in the input character expression have been converted to lowercase.

`LOWER` and `LCASE` follow the database locale unless you specify the `Locale` parameter.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LCASE or LOWER ( CharacterExpression [, Locale ] )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
CharacterExpression
{: .paramName}

A &nbsp;[`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) data type, or any
built-in type that is implicitly converted to a string (but not a bit
expression).
{: .paramDefnFirst}

{% include splice_snippets/localeparam.md %}

</div>
## Results

If the *CharacterExpression* evaluates to `NULL`, this function returns `NULL`.

In general, the type, length, and maximum length of the returned value are the same as the length and maximum length of the *CharacterExpression*. However, the data type, length, and maximum length of the result can be different if you're using a `locale` value that differs from the default locale of your database.

This is because a single character may convert into multiple characters, when a location value is involved. For example, if you're applying this function to a `CHAR` value and the resulting value length exceeds the limits of a `CHAR` value, the result will be a `VARCHAR` value. Similarly, converting a `VARCHAR` value may result in a `LONG VARCHAR` value, and converting a `LONG VARCHAR` value may results in a `CLOB` value.

## Examples

<div class="preWrapper" markdown="1">

    splice> SELECT LCASE(DisplayName)
       FROM Players
       WHERE ID < 11;
    1
    ------------------------
    buddy painter
    billy bopper
    john purser
    bob cranker
    mitch duffer
    norman aikman
    alex paramour
    harry pennello
    greg brown
    jason minman

    10 rows selected
{: .Example xml:space="preserve"}

</div>


<div class="preWrapper" markdown="1">

    splice> SELECT LOWER( DisplayName, 'en_US' )
       FROM Players
       WHERE ID < 11;
    1
    ------------------------
    buddy painter
    billy bopper
    john purser
    bob cranker
    mitch duffer
    norman aikman
    alex paramour
    harry pennello
    greg brown
    jason minman

    10 rows selected
{: .Example xml:space="preserve"}

</div>

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
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
