---
title: NOW built-in SQL function
summary: Built-in SQL function that returns the current date and time as a TIMESTAMP value
keywords: current date, current time
toc: false
compatible_level: 2.7
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_now.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NOW

The `NOW` function returns the current date and time as a
[`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    NOW();
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

Returns the current date and time as a
[`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value.

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
* [`QUARTER`](sqlref_builtinfcns_quarter.html) function
* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TO_CHAR`](sqlref_builtinfcns_char.html) function
* [`TO_DATE`](sqlref_builtinfcns_date.html) function
* [`WEEK`](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

