---
title: TO_TIMESTAMP built-in SQL function
summary: Built-in SQL function that formats a datetime string and returns a TIME value
keywords: convert string to timestamp, timestamp format
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_totimestamp.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TO_TIMESTAMP

The `TO_TIMESTAMP` function parses a datetime string according to a formatting
specification, and returns a &nbsp;[`TIMESTAMP`](sqlref_datatypes_timestamp.html)
value. Note that the input string must represent a timestamp and _must_ match the formatting specification string.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TO_TIMESTAMP( timestampStrExpr, formatStr );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
timestampStrExpr
{: .paramName}

A string expression that contains a time that is formatted according to
the format string.
{: .paramDefnFirst}

formatStr
{: .paramName}

A string that specifies the format you want applied to the <code>timeStr</code>.
See the [Date and Time Formats](#Date) section below for more
information about format specification.
{: .paramDefnFirst}

</div>

## Results

The result is always a &nbsp;[`TIMESTAMP`](sqlref_datatypes_timestamp.html) value.

{% include splice_snippets/datetimeformats.md %}

## Usage Notes

You can supply a string formatted as a date or time to `TO_TIMESTAMP`; it will translate that value into a timestamp.

Note that our examples use lowercase year (e.g. `yyyy`) and day (e.g. `dd`) formats; __not__ uppercase (e.g. `YYYY` or `DD`) formats. It's easy to get confused, so remember:

The uppercase `YYYY` format, which is not commonly used, specifies week year, which means that you _must_ also specify a week-of-week-based-year (`w`) format value.

Similarly, the uppercase `D` format, also uncommon, specifies day-of-the-year, not the day of the month.


## Examples of Using `TO_TIMESTAMP`

Here are examples:

```
splice> VALUES TO_TIMESTAMP( '2019-08-09 14:44:24', 'yyyy-MM-dd HH:mm:ss' );
1
-----------------------------
2019-08-09 14:44:24.0

splice> VALUES TO_TIMESTAMP('11:44', 'HH:mm');
1
----------
1970-01-01 11:44:00.0
```
{: .Example xml:space="preserve"}


The following example that shows two interesting aspects of using
`TO_TIMESTAMP`. In this example, the input includes the literal `T` ), which
means that the format pattern must delimit that letter with single
quotes. Since we're delimiting the entire pattern in single quotes, we
then have to escape those marks and specify `''T''` in our parsing
pattern.

Note that when you specify a zone offset (`Z`) or time zone (`z`), Splice Machine interprets the timestamp in its given zone, and then adjusts the time to the time zone setting of the operating system. This means that when a timestamp value specified in the Easter time zone is parsed on an operating system based in the Pacific time zone, it will be adjusted back by three hours; for example:

```
splice> VALUES TO_TIMESTAMP('2013-06-18T01:03:30.000EDT','yyyy-MM-dd''T''HH:mm:ss.SSSz');
1
-----------
2013-06-17 22:03:30.0
```
{: .Example xml:space="preserve"}

## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DATE`](sqlref_builtinfcns_date.html)
* [`DAY`](sqlref_builtinfcns_day.html)
* [`EXTRACT`](sqlref_builtinfcns_extract.html)
* [`LASTDAY`](sqlref_builtinfcns_day.html)
* [`MONTH`](sqlref_builtinfcns_month.html)
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html)
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html)
* [`NEXTDAY`](sqlref_builtinfcns_day.html)
* [`NOW`](sqlref_builtinfcns_now.html)
* [`QUARTER`](sqlref_builtinfcns_quarter.html)
* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html)
* [`TO_CHAR`](sqlref_builtinfcns_char.html)
* [`TO_DATE`](sqlref_builtinfcns_todate.html)
* [`TO_TIME`](sqlref_builtinfcns_totime.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>
