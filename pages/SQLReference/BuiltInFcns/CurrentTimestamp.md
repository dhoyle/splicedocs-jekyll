---
title: CURRENT_TIMESTAMP built-in SQL function
summary: Built-in SQL function that returns the current timestamp
keywords: current timestamp
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_currenttimestamp.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_TIMESTAMP

`CURRENT_TIMESTAMP` returns the current timestamp.

This function returns the same value if it is executed more than once in
a single statement, which means that the value is fixed, even if there
is a long delay between fetching rows in a cursor.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_TIMESTAMP
{: .FcnSyntax}

</div>
or, alternately

<div class="fcnWrapperWide" markdown="1">
    CURRENT TIMESTAMP
{: .FcnSyntax}

</div>
## Results

A timestamp value.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES CURRENT_TIMESTAMP;
    1
    -----------------------------
    2015-11-19 11:03:44.095
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

