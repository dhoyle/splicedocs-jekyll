---
title: EXTRACT built-in SQL function
summary: Built-in SQL function that extracts information (parts) from date and time values
keywords: date values, time values, extracting date values, extracting time values
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_extract.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# EXTRACT

You can use the `EXTRACT` built-in function can use to extract specific
information from date and time values.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    EXTRACT( infoType FROM dateExpr );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
infoType
{: .paramName}

The value (information) that you want to extract and return from the
date-time expression. This can be one of the following values:
{: .paramDefnFirst}

<div class="paramListNested" markdown="1">
`YEAR`
{: .paramName}

The four-digit year value is extracted from the date-time expression.
{: .paramDefnFirst}

`QUARTER`
{: .paramName}

The single digit (`1-4`) quarter number is extracted from the date-time
expression.
{: .paramDefnFirst}

`MONTH`
{: .paramName}

The month number (`1-12`) is extracted from the date-time expression.
{: .paramDefnFirst}

`MONTHNAME`
{: .paramName}

The full month name (e.g. `September`) is extracted from the date-time
expression.
{: .paramDefnFirst}

`WEEK`
{: .paramName}

The week-of-year number (1 is the first week) is extracted from the
date-time expression.
{: .paramDefnFirst}

`WEEKDAY`
{: .paramName}

The day-of-week number (`1-7`, with Monday as `1` and Sunday as `7`) is
extracted from the date-time expression.
{: .paramDefnFirst}

`WEEKDAYNAME`
{: .paramName}

The day-of-week name (e.g. `Tuesday`)  is extracted from the date-time
expression.
{: .paramDefnFirst}

`DAYOFYEAR`
{: .paramName}

The numeric day-of-year (`0-366`) is extracted from the date-time
expression.
{: .paramDefnFirst}

`DAY`
{: .paramName}

The numeric day-of-month (`0-31`) is extracted from the date-time
expression.
{: .paramDefnFirst}

`HOUR`
{: .paramName}

The numeric hour (`0-23`) is extracted from the date-time expression.
{: .paramDefnFirst}

Note that Splice Machine &nbsp;[`DATE`](sqlref_builtinfcns_date.html) values
do not include time information and will not work correctly with this
*infoType*.
{: .paramDefn}

`MINUTE`
{: .paramName}

The numeric minute (`0-59`) is extracted from the date-time expression.
{: .paramDefnFirst}

Note that Splice Machine &nbsp;[`DATE`](sqlref_builtinfcns_date.html) values
do not include time information and will not work correctly with this
*infoType*.
{: .paramDefn}

`SECOND`
{: .paramName}

The numeric second (`0-59`) is extracted from the date-time expression.
{: .paramDefnFirst}

Note that Splice Machine &nbsp;[`DATE`](sqlref_builtinfcns_date.html) values
do not include time information and will not work correctly with this
*infoType*.
{: .paramDefn}

</div>
dateExpr
{: .paramName}

The date-time expression from which you wish to extract information.
{: .paramDefnFirst}

Note that Splice Machine &nbsp;[`DATE`](sqlref_builtinfcns_date.html) values
do not include time information and thus will not produce correct values
if you specify `HOUR`, `MINUTE`, or `SECOND` infoTypes.
{: .paramDefn}

</div>
## Examples

<div class="preWrapper" markdown="1">

    splice> SELECT Birthdate,
       EXTRACT (Quarter FROM Birthdate) "Quarter",
       EXTRACT (Week FROM Birthdate) "Week",
       EXTRACT(WeekDay FROM Birthdate) "Weekday"
       FROM Players
       WHERE ID < 20
       ORDER BY "Quarter";
    BIRTHDATE |Quarter    |Week       |Weekday
    ----------------------------------------------
    1987-03-27|1          |13         |5
    1987-01-21|1          |4          |3
    1991-01-15|1          |3          |2
    1982-01-05|1          |1          |2
    1990-03-22|1          |12         |4
    1989-01-01|1          |52         |7
    1988-04-20|2          |16         |3
    1983-04-13|2          |15         |3
    1990-06-16|2          |24         |6
    1984-04-11|2          |15         |3
    1981-07-02|3          |27         |4
    1977-08-30|3          |35         |2
    1989-08-21|3          |34         |1
    1984-09-21|3          |38         |5
    1990-10-30|4          |44         |2
    1983-12-24|4          |51         |6
    1983-11-06|4          |44         |7
    1982-10-12|4          |41         |2
    1989-11-17|4          |46         |5

    19 rows selected

    splice> values EXTRACT(monthname FROM '2009-09-02 11:22:33.04');
    1
    --------------
    September


    splice> values EXTRACT(weekdayname FROM '2009-11-07 11:22:33.04');
    1
    --------------
    Saturday
    1 row selected

    splice> values EXTRACT(dayofyear FROM '2009-02-01 11:22:33.04');
    1
    -----------
    32
    1 row selected

    splice> values EXTRACT(hour FROM '2009-07-02 11:22:33.04');
    1
    -----------
    11
    1 row selected

    splice> values EXTRACT(minute FROM '2009-07-02 11:22:33.04');
    1
    -----------
    22
    1 row selected

    splice> values EXTRACT(second FROM '2009-07-02 11:22:33.04');
    1
    -----------
    33

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DATE`](sqlref_builtinfcns_date.html) function
* [`DAY`](sqlref_builtinfcns_day.html) function
* [`LASTDAY`](sqlref_builtinfcns_day.html) function
* [`MONTH`](sqlref_builtinfcns_month.html) function
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html) function
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
