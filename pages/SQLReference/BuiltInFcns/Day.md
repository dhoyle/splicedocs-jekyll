---
title: DAY built-in SQL function
summary: Built-in SQL function that returns the day part of a date
keywords: day part, day function
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_day.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DAY

The `DAY` function returns the day part of a value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DAY ( expression )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

An expression that can be any of the following:
{: .paramDefnFirst}

* {: .nested value="1"} A &nbsp;[`LONG VARCHAR`](sqlref_datatypes_longvarchar.html) value.
{: .bulletNested}

</div>
## Results

The returned result is an integer value in the range `1` to `31`.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL` value.

## Examples

Get the current date:

<div class="preWrapper" markdown="1">
    splice> VALUES(CURRENT_DATE);
    1
    --------
    2015-10-25

    1 row selected
{: .Example xml:space="preserve"}

</div>
Now get the current day only:

<div class="preWrapper" markdown="1">
    splice> VALUES(DAY(CURRENT_DATE));
    1
    --------
    25

    1 row selected
{: .Example xml:space="preserve"}

</div>
Get the day number for each player's birthdate:

<div class="preWrapper" markdown="1">
    splice> select Day(Birthdate) AS "Day-of-Birth"
       FROM Players
       WHERE ID < 20
       ORDER BY "Day-of-Birth";
    Day-of-Bir&
    -----------
    1
    2
    5
    6
    11
    12
    13
    15
    16
    17
    20
    21
    21
    21
    22
    24
    27
    30
    30

    19 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also


* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`CURRENT_TIME`](sqlref_builtinfcns_currenttime.html)
* [`DATE` type](sqlref_datatypes_date.html)
* [`DATE` function](sqlref_builtinfcns_date.html) 
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
