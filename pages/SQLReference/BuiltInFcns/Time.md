---
title: TIME built-in SQL function
summary: Built-in SQL function that returns the time part of a value
keywords: date arithmetic, time function, time format
compatible_level: 2.7
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
{% include splice_snippets/timedisplaynote.md %}{: .noteIcon}

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

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`CURRENT_TIME`](sqlref_builtinfcns_currenttime.html)
* [`DATE` type](sqlref_datatypes_date.html)
* [`DATE` function](sqlref_builtinfcns_date.html) 
* [`DAY`](sqlref_builtinfcns_day.html) 
* [`EXTRACT`](sqlref_builtinfcns_extract.html) 
* [`LASTDAY`](sqlref_builtinfcns_day.html) 
* [`MONTH`](sqlref_builtinfcns_month.html)
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html)
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html) 
* [`NEXTDAY`](sqlref_builtinfcns_day.html) 
* [`NOW`](sqlref_builtinfcns_now.html)
* [`QUARTER`](sqlref_builtinfcns_quarter.html)
* [`TIME` type](sqlref_datatypes_time.html)
* [`TIME` function](sqlref_datatypes_time.html)
* [`TIMESTAMP` type](sqlref_datatypes_timestamp.html) 
* [`TIMESTAMP` function](sqlref_builtinfcns_timestamp.html) 
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* [Working with Dates](developers_fundamentals_dates.html)

</div>
</section>
