---
title: HOUR built-in SQL function
summary: Built-in SQL function that returns the hour part of a date/time value.
keywords: extract hour part
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_hour.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# HOUR

The `HOUR` function returns the hour part of a value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    HOUR ( expression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

An expression that can be a time, timestamp, or a valid character string representation of a time or timestamp.
{: .paramDefnFirst}

</div>
## Results

The returned result is an integer value in the range `0` to `24`.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL`value.

## Example

<div class="preWrapper" markdown="1">
    splice> values ( NOW, HOUR(NOW), MINUTE(NOW), SECOND(NOW) );
    1                            |2          |3          |4
    ----------------------------------------------------------------------------
    2015-11-12 17:48:55.217      |17         |48         |55.217

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`TIME`](sqlref_builtinfcns_time.html) data value
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) data value
* [`MINUTE`](sqlref_builtinfcns_minute.html) function
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TIMESTAMPADD`](sqlref_builtinfcns_timestampadd.html) function
* [`TIMESTAMPDIFF` function](sqlref_builtinfcns_timestampdiff.html)

</div>
</section>
