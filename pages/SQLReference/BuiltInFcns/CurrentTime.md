---
title: CURRENT_TIME built-in SQL function
summary: Built-in SQL function that returns the current time
keywords: current time
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_currenttime.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_TIME

`CURRENT_TIME` returns the current time.

This function returns the same value if it is executed more than once in
a single statement, which means that the value is fixed, even if there
is a long delay between fetching rows in a cursor.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_TIME
{: .FcnSyntax}

</div>
or, alternately

<div class="fcnWrapperWide" markdown="1">
    CURRENT TIME
{: .FcnSyntax}

</div>
## Results

A time value.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES CURRENT_TIME;
    1
    --------
    11:02:57
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

