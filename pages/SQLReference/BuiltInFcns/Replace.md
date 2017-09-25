---
title: REPLACE built-in SQL function
summary: Built-in SQL function that replaces all occurrences of a substring in a string
keywords: replace substrings
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_replace.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# REPLACE 

The `REPLACE` function replaces all occurrences of a substring within a
string and returns the new string.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    REPLACE(subjectStr, searchStr, replaceStr)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
subjectStr
{: .paramName}

The string you want modified. This can be a literal string or a
reference to a `char` or `varchar` value.
{: .paramDefnFirst}

searchStr
{: .paramName}

The substring to replace within *subjectStr*. This can be a literal
string or a reference to a `char` or `varchar` value.
{: .paramDefnFirst}

replaceStr
{: .paramName}

The replacement substring. This can be a literal string or a reference
to a `char` or `varchar` value.
{: .paramDefnFirst}

</div>
## Results

A string value.

## Examples

The first examples shows the players on each team with averages greater
than .300. The second example shows the result of replacing the team of
those players with averages greater than 0.300 who play on one team (the
Cards):

<div class="preWrapperWide" markdown="1">
    splice> SELECT DisplayName, Average, Team
       FROM Players JOIN Batting on Players.ID=Batting.ID
       WHERE Average > 0.300 AND Games>50;
    
    DISPLAYNAME             |AVERAGE  |TEAM
    ------------------------------------------
    Buddy Painter           |0.31777  |Giants
    John Purser             |0.31151  |Giants
    Kelly Tamlin            |0.30337  |Giants
    Stan Post               |0.30472  |Cards
    
    4 rows selected
    
    splice> SELECT DisplayName, Average,
        REPLACE(Team, 'Cards', 'Giants') "TRADED"
        FROM PLAYERS JOIN Batting ON Players.ID=Batting.ID
        WHERE Team='Cards' AND Average > 0.300 AND Games > 50;
    
    DISPLAYNAME             |AVERAGE  |TRADED
    ------------------------------------------
    Stan Post               |0.30472  |Giants
    
    1 row selected
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
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>

