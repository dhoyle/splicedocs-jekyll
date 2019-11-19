---
title: TIMESTAMPDIFF built-in SQL function
summary: Built-in SQL function that finds an interval difference between two timestamps
keywords: date arithmetic, date math, timestamp diff, subtract timestamps
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_timestampdiff.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIMESTAMPDIFF

The `TIMESTAMPDIFF` function finds the difference between two
timestamps, in terms of the specfied interval.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIMESTAMPDIFF ( interval, timeStamp1, timeStamp2 )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
interval
{: .paramName}

One of the following timestamp interval constants:
{: .paramDefnFirst}

* `SQL_TSI_FRAC_SECOND`
* `SQL_TSI_SECOND`
* `SQL_TSI_MINUTE`
* `SQL_TSI_HOUR`
* `SQL_TSI_DAY`
* `SQL_TSI_WEEK`
* `SQL_TSI_MONTH`
* `SQL_TSI_QUARTER`
* `SQL_TSI_YEAR`
{: .bulletNested}

timeStamp1
{: .paramName}

The first [timestamp](sqlref_builtinfcns_timestamp.html) value.
{: .paramDefnFirst}

timeStamp2
{: .paramName}

The second [timestamp](sqlref_builtinfcns_timestamp.html) value.
{: .paramDefnFirst}

If you use a `datetime` column inside the `TIMESTAMPDIFF` function in a
`WHERE` clause, the optimizer cannot use indexes on that column. We
strongly recommend not doing this!
{: .noteNote}

</div>
## Results

The `TIMESTAMPDIFF` function returns an integer value representing the
count of intervals between the two timestamp values.

## Examples

These examples shows the number of years a player was born after Nov 22,
1963:.
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SELECT ID, BirthDate, TIMESTAMPDIFF(SQL_TSI_YEAR, Date('11/22/1963'), BirthDate) "YearsSinceJFK"
       FROM Players WHERE ID < 11
       ORDER BY Birthdate;
    ID    |BIRTHDATE |YearsSinceJFK
    --------------------------------------
    7     |1981-07-02|17
    6     |1982-01-05|18
    8     |1983-04-13|19
    10    |1983-11-06|19
    9     |1983-12-24|20
    4     |1987-01-21|23
    1     |1987-03-27|23
    2     |1988-04-20|24
    3     |1990-10-30|26
    5     |1991-01-15|27

    10 rows selected
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
* [`TIMESTAMPADD`](sqlref_builtinfcns_timestampadd.html) function
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* [Working with Dates](developers_fundamentals_dates.html)

</div>
</section>
