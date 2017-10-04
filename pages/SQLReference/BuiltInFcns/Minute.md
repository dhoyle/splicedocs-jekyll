---
title: MINUTE built-in SQL function
summary: Built-in SQL function that returns the minute part of a value
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_minute.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MINUTE

The `MINUTE` function returns the minute part of a value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    MINUTE ( expression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

An expression that can be a time, timestamp, or a valid character string representation of a time or timestamp.
{: .paramDefnFirst}

</div>
## Results

The returned result is an integer value in the range `0` to `59`.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL`value.

## Example

<div class="preWrapper" markdown="1">
    splice> VALUES( NOW, HOUR(NOW), MINUTE(NOW), SECOND(NOW) );
    1                            |2          |3          |4
    ----------------------------------------------------------------------------
    2015-11-12 17:48:55.217      |17         |48         |55.217

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) data value
* [`HOUR`](sqlref_builtinfcns_hour.html) function
* [`SECOND`](sqlref_builtinfcns_second.html) function
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TIMESTAMPADD`](sqlref_builtinfcns_timestampadd.html) function
* [`TIMESTAMPDIFF`](sqlref_builtinfcns_timestampdiff.html) function

</div>
</section>
