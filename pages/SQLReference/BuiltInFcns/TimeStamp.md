---
title: TIMESTAMP built-in SQL function
summary: Built-in SQL function that returns a timestamp from a pair of values
keywords: timestamp function, timestamp format
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_timestamp.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIMESTAMP   {#BuiltInFcns.TimeStamp}

The `TIMESTAMP` function returns a timestamp from a value or a pair of
values.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIMESTAMP ( expression1 [, expression2 ] )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression1
{: .paramName}

If *expression2* is also specified, *expression1* must be a date or a
valid string representation of a date.
{: .paramDefnFirst}

If only *expression1* is specified, it must be one of the following:
{: .paramDefn}

* A [`DATE`](sqlref_builtinfcns_date.html) value
* A valid SQL string representation of a timestamp

expression2
{: .paramName}

(Optional). A time or a valid string representation of a time.
{: .paramDefnFirst}

</div>
## Results

The data type of the result depends on how the input expression(s) were
specified:

* If both *expression1* and *expression2* are specified, the result is a
  timestamp with the date specified by *expression1* and the time
  specified by *expression2*. The microsecond part of the timestamp is
  zero.
* If only *expression1* is specified and it is a timestamp, the result
  is that timestamp.
* If only *expression1* is specified and it is a string, the result is
  the timestamp represented by that string. If *expression1* is a string
  of length 14, the timestamp has a microsecond part of zero.

## Examples

This example converts date and time strings into a timestamp value:

<div class="preWrapper" markdown="1">
    splice> VALUES TIMESTAMP('2015-11-12', '19:02:43');
    1
    -----------------------------
    2015-11-12 19:02:43.0
    
    1 row selected
{: .Example}

</div>
This query shows the timestamp version of the birth date of each player
born in the final quarter of the year:

<div class="preWrapper" markdown="1">
    splice> SELECT TIMESTAMP(BirthDate)
       FROM Players
       WHERE MONTH(BirthDate) > 10
       ORDER BY BirthDate;
    1
    -----------------------------
    1980-12-19 00:00:00.0
    1983-11-06 00:00:00.0
    1983-11-28 00:00:00.0
    1983-12-24 00:00:00.0
    1984-11-22 00:00:00.0
    1985-11-07 00:00:00.0
    1985-11-26 00:00:00.0
    1985-12-21 00:00:00.0
    1986-11-13 00:00:00.0
    1986-11-24 00:00:00.0
    1986-12-16 00:00:00.0
    1987-11-12 00:00:00.0
    1987-11-16 00:00:00.0
    1987-12-17 00:00:00.0
    1988-12-21 00:00:00.0
    1989-11-17 00:00:00.0
    1991-11-15 00:00:00.0
    
    17 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DATE`](sqlref_builtinfcns_date.html) function
* [`DAY`](sqlref_builtinfcns_day.html) function
* [`EXTRACT`](sqlref_builtinfcns_extract.html) function
* [`LASTDAY`](sqlref_builtinfcns_day.html) function
* [`MONTH`](sqlref_builtinfcns_month.html) function
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html) function
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html) function
* [`NEXTDAY`](sqlref_builtinfcns_day.html) function
* [`NOW`](sqlref_builtinfcns_now.html) function
* [`QUARTER`](sqlref_builtinfcns_quarter.html) function
* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TO_CHAR`](sqlref_builtinfcns_char.html) function
* [`TO_DATE`](sqlref_builtinfcns_date.html) function
* [`WEEK`](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

