---
title: TIME built-in SQL function
summary: Built-in SQL function that returns the time part of a value
keywords: date arithmetic, time function, time format
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_time.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIME

The `TIME` function returns a time from a value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIME ( expression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

An expression that can be any of the following:
{: .paramDefnFirst}

* A &nbsp;[`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value
* A valid string representation of a time or timestamp
{: .bulletNested}

</div>
## Results

The returned result is governed by the following rules:

* If the argument can be `NULL`, the result can be `NULL`; if the
  argument is `NULL`, the result is the `NULL`value.
* If the argument is a time, the result is that time value.
* If the argument is a timestamp, the result is the time part of the
  timestamp.
* If the argument is a string, the result is the time represented by the
  string.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIME ( expression )
{: .FcnSyntax}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> VALUES TIME( CURRENT_TIMESTAMP );
    1
    --------
    18:53:13

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) data type

</div>
</section>
