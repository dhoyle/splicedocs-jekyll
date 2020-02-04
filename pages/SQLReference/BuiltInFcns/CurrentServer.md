---
title: CURRENT SERVER built-in SQL function
summary: Built-in SQL function that returns the name of the current database.
keywords: SERVER
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_currentserver.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT SERVER

`CURRENT SERVER` returns the name used to qualify unqualified
database object references.

`CURRENT SERVER` and `CURRENT_SERVER` are synonyms.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT SERVER
{: .FcnSyntax xml:space="preserve"}

</div>
-- or, alternatively:

<div class="fcnWrapperWide" markdown="1">
    CURRENT_SERVER
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The returned value is a string of type CHAR(16).

## Examples

<div class="preWrapperWide" markdown="1">

    splice> VALUES(CURRENT SERVER);
    1
    -------------------------------------------------------
    mySpliceDb

    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>
