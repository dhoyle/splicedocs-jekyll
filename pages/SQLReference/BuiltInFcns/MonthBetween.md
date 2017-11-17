---
title: MONTH_BETWEEN built-in SQL function
summary: Built-in SQL function that returns the number of months between two dates
keywords: date arithmetic, months between two dates
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_monthbetween.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MONTH_BETWEEN

The `MONTH_BETWEEN` function returns the number of months between two
dates.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    MONTH_BETWEEN( date1, date2 );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
date1
{: .paramName}

The first date.
{: .paramDefnFirst}

date2
{: .paramName}

The second date
{: .paramDefnFirst}

</div>
## Results

If `date2` is later than `date1`, then the result is positive.

If `date2` is earlier than `date1`, then the result is negative.

If `date1` and `date2` are either the same days of the month or both
last days of months, then the result is always an integer.

## Examples

<div class="preWrapperWide" markdown="1">

    splice> VALUES(MONTH_BETWEEN(CURRENT_DATE, DATE('2015-8-15')));
    1
    ----------------------
    3.0

    splice> SELECT MIN(BirthDate) "Oldest",
       MAX(Birthdate) "Youngest",
       MONTH_BETWEEN(MIN(Birthdate), MAX(BirthDate)) "Months Between"
       FROM Players;
    Oldest     |Youngest   |Months Between
    --------------------------------------------
    1975-07-14 |1992-10-19 |207.0

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
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html) function
* [`NEXTDAY`](sqlref_builtinfcns_day.html) function
* [`NOW`](sqlref_builtinfcns_now.html) function
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
