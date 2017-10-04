---
title: TIMESTAMPADD built-in SQL function
summary: Built-in SQL function that adds an interval value to a timestamp value
keywords: date arithmetic, date math, timestamp math, add timestamps
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_timestampadd.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIMESTAMPADD

The `TIMESTAMPADD` function adds the value of an interval to a timestamp
value and returns the sum as a new timestamp. You can supply a negative
interval value to substract from a timestamp.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIMESTAMPADD ( interval, count, timeStamp1 )
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

count
{: .paramName}

An integer specifying the number of times the interval is to be added to
the timestamp. Use a negative integer value to subtract.
{: .paramDefnFirst}

timeStamp1
{: .paramName}

The [timestamp](sqlref_builtinfcns_timestamp.html) value to which the
count of intervals is added.
{: .paramDefnFirst}

If you use a `datetime` column inside the `TIMESTAMPADD` function in a
`WHERE` clause, the optimizer cannot use indexes on that column. We
strongly recommend not doing this!
{: .noteNote}

</div>
## Results

The `TIMESTAMPADD` function returns a
[timestamp](sqlref_builtinfcns_timestamp.html) value that is the result
of adding *count intervals* to *timeStamp1*.

## Examples

The following example displays the current timestamp, and the timestamp
value two months from now:

<div class="preWrapperWide" markdown="1">
    splice> VALUES ( CURRENT_TIMESTAMP, TIMESTAMPADD(SQL_TSI_MONTH, 2, CURRENT_TIMESTAMP ));
    1                            |2
    -----------------------------------------------------------
    2015-11-23 13:54:16.728      |2016-01-23 13:54:16.728

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) data value
* [`HOUR`](sqlref_builtinfcns_hour.html) function
* [`MINUTE`](sqlref_builtinfcns_minute.html) function
* [`SECOND`](sqlref_builtinfcns_second.html) function
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TIMESTAMPDIFF`](sqlref_builtinfcns_timestampdiff.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>
