---
title: CURRENT_TIMESTAMP built-in SQL function
summary: Built-in SQL function that returns the current timestamp
keywords: current timestamp
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_currenttimestamp.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_TIMESTAMP

`CURRENT_TIMESTAMP` returns the current timestamp.

<div class="noteNote" markdown="1">
This function returns the same value if it is executed more than once in
a single statement, which means that the value is fixed, even if there
is a long delay between fetching rows in a cursor.

{% include splice_snippets/timedisplaynote.md %}
</div>

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

## Timestamp Precision

Splice Machine uses a global property to define the precision (the number of decimal places in the seconds value) of timestamps returned by this function:

```
splice.function.currentTimestampPrecision
```
{: .Example}

You can set the value of this property to any value between `0` and `9`. The default value is `6`.

Use the SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY` system procedure to modify the value; for example:

```
splice> call SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY( 'splice.function.currentTimestampPrecision', '3' );
```
{: .Example}

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
* [`TIMESTAMP` type](sqlref_builtinfcns_timestamp.html) 
* [`TIMESTAMP` function](sqlref_builtinfcns_timestamp.html) 
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* [Working with Dates](developers_fundamentals_dates.html)
</div>
</section>
