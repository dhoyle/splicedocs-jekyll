---
title: ADD_MONTHS built-in SQL function
summary: Built-in SQL function that adds a number of months to a date
keywords: date math, adding months
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_addmonths.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ADD_MONTHS

The `ADD_MONTHS` function returns the date resulting from adding a
number of months added to a specified date.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ADD_MONTHS(Date source, int numOfMonths);
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
source
{: .paramName}

The source date. This can be a [`DATE`](sqlref_datetypes_date.html) value, or any value that can be
implicitly converted to `DATE`.
{: .paramDefnFirst}

numOfMonths
{: .paramName}

An integer value that specifies the number of months to add to the
source date.
{: .paramDefnFirst}

</div>
## Results

The returned string always has data type `DATE`.

If date is the last day of the month or if the resulting month has fewer
days than the day component of date, then the result is the last day of
the resulting month. Otherwise, the result has the same day component as
date.

## Examples

<div class="preWrapperWide" markdown="1">
    splice> VALUES(ADD_MONTHS(CURRENT_DATE,5));
    1
    ----------
    2015-02-22
    1 row selected

    splice> VALUES(ADD_MONTHS(CURRENT_DATE,-5));
    1
    ----------
    2014-04-22
    1 row selected

    splice> VALUES(ADD_MONTHS(DATE(CURRENT_TIMESTAMP),-5));
    1
    ----------
    2014-04-22
    1 row selected

    splice> VALUES(ADD_MONTHS(DATE('2014-01-31'),1));
    1
    ----------
    2014-02-28
    1 row selected
{: .Example xml:space="preserve"}

</div>

## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`CURRENT_TIME`](sqlref_builtinfcns_currenttime.html)
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
