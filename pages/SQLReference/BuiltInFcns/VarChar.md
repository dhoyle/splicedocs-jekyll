---
title: VARCHAR built-in SQL function
summary: Built-in SQL function that returns a varying-length character string
keywords: 
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_varchar.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# VARCHAR   {#BuiltInFcns.VarChar}

The `VARCHAR` function returns a varying-length character string
representation of a character string.

## Character to varchar syntax

<div class="fcnWrapperWide" markdown="1">
    VARCHAR (CharacterStringExpression ) 
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
CharacterStringExpression
{: .paramName}

An expression whose value must be of a character-string data type with a
maximum length of `32,672` bytes.
{: .paramDefnFirst}

</div>
## Datetime to varchar syntax

<div class="fcnWrapperWide" markdown="1">
    VARCHAR (DatetimeExpression ) 
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
DatetimeExpression
{: .paramName}

An expression whose value must be of a date, time, or timestamp data
type.
{: .paramDefnFirst}

</div>
## Example

The <span class="AppCommand">Position</span> column in our <span
class="AppCommand">Players</span> table is defined as `CHAR(2)`. The
following query show hows to access positon values as `VARCHAR`s:

<div class="preWrapper" markdown="1">
    splice> SELECT VARCHAR(Position)
       FROM Players
       WHERE ID < 11;
    1
    ----
    C
    1B
    2B
    SS
    3B
    LF
    CF
    RF
    OF
    RF
    
    10 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`VARCHAR`](sqlref_datatypes_varchar.html) data type

</div>
</section>

