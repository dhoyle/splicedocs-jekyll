---
title: CURRENT_TIME built-in SQL function
summary: Built-in SQL function that returns the current time
keywords: current time
toc: false
compatible_version: 2.7
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_currenttime.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_TIME

`CURRENT_TIME` returns the current time.

<div class="noteNote" markdown="1">
This function returns the same value if it is executed more than once in
a single statement, which means that the value is fixed, even if there
is a long delay between fetching rows in a cursor.

{% include splice_snippets/timedisplaynote.md %}
</div>

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_TIME
{: .FcnSyntax}

</div>
or, alternately

<div class="fcnWrapperWide" markdown="1">
    CURRENT TIME
{: .FcnSyntax}

</div>
## Results

A time value.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES CURRENT_TIME;
    1
    --------
    11:02:57

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`CURRENT_TIMESTAMP`](sqlref_builtinfcns_currenttimestamp.html)
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
