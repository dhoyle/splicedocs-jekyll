---
title: CURRENT SCHEMA built-in SQL function
summary: Built-in SQL function that returns the schema name that is used to qualify database references not already qualified
keywords: schema
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_currentschema.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT SCHEMA

`CURRENT SCHEMA` returns the schema name used to qualify unqualified
database object references.

`CURRENT SCHEMA` and `CURRENT SQLID` are synonyms.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT SCHEMA
{: .FcnSyntax xml:space="preserve"}

</div>
-- or, alternatively:

<div class="fcnWrapperWide" markdown="1">
    CURRENT SQLID
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The returned value is a string with a length of up to 128 characters.

## Examples

<div class="preWrapperWide" markdown="1">
    
    splice> VALUES(CURRENT SCHEMA);
    1
    -------------------------------------------------------
    SPLICE
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

