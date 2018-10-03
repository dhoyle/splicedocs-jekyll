---
title: NOW built-in SQL function
summary: Built-in SQL function that returns the current date and time as a TIMESTAMP value
keywords: current date, current time
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_now.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NOW

The `NOW` function returns the current date and time as a &nbsp;&nbsp;[`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    NOW();
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

Returns the current date and time as a
[`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value.

{% include splice_snippets/timedisplaynote.md %}{: .noteIcon}

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES( NOW(), HOUR(NOW), MINUTE(NOW), SECOND(NOW) );
    1                            |2          |3          |4
    ----------------------------------------------------------------------------
    2015-11-12 17:48:55.217      |17         |48         |55.217

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
