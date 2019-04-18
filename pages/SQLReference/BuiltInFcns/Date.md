---
title: DATE built-in SQL function
summary: Built-in SQL function that returns a date value from an expression
keywords: date value, date format, date function
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_date.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DATE

The `DATE` function returns a date from a value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DATE ( expression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

An expression that can be any of the following:
{: .paramDefnFirst}

* {: .nested value="1"} A &nbsp;[`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) value, which
  must represent a valid date in the form `yyyynnn`, where `yyyy` is a
  four-digit year value, and `nnn` is a three-digit day value in the
  range 001 to 366.
{: .nested}

</div>
## Results

The returned result is governed by the following rules:

* If the argument can be `NULL`, the result can be `NULL`; if the
  argument is `NULL`, the result is the `NULL` value.
* If the argument is a date, timestamp, or valid string representation
  of a date or timestamp, the result is the date part of the value.
* If the argument is a number, the result is the date that is `n-1` days
  after January 1, 1970, where `n` is the integral part of the number.
* If the argument is a string with a length of 7, the result is a string
  representation of the date.

## Examples

This example results in an internal representation of '1988-12-25'.

<div class="preWrapper" markdown="1">
    splice> VALUES DATE('1988-12-25');
{: .Example xml:space="preserve"}

</div>
This example results in an internal representation of '1972-02-28'.

<div class="preWrapper" markdown="1">
    splice> VALUES DATE(789);
{: .Example xml:space="preserve"}

</div>
This example illustrates using date arithmetic with the `DATE` function:

<div class="preWrapperWide" markdown="1">
    splice> select Birthdate - DATE('11/22/1963') AS "DaysSinceJFK" FROM Players WHERE ID < 20;
    DaysSinceJ&
    -----------
    8526
    8916
    9839
    8461
    9916
    6619
    6432
    7082
    7337
    7289
    9703
    5030
    9617
    6899
    9404
    7446
    7609
    9492
    9172

    19 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`CURRENT_TIME`](sqlref_builtinfcns_currenttime.html)
* [`DATE` type](sqlref_datatypes_date.html)
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
* [`TIMESTAMP` type](sqlref_builtinfcns_timestamp.html) 
* [`TIMESTAMP` function](sqlref_builtinfcns_timestamp.html) 
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* [Working with Dates](developers_fundamentals_dates.html)

</div>
</section>
