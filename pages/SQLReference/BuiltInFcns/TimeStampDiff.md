---
title: TIMESTAMPDIFF built-in SQL function
summary: Built-in SQL function that finds an interval difference between two timestamps
keywords: date arithmetic, date math, timestamp diff, subtract timestamps
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_timestampdiff.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIMESTAMPDIFF   {#BuiltInFcns.TimeStamp}

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

* {: .CodeFont value="1"} SQL_TSI_FRAC_SECOND
* {: .CodeFont value="2"} SQL_TSI_SECOND
* {: .CodeFont value="3"} SQL_TSI_MINUTE
* {: .CodeFont value="4"} SQL_TSI_HOUR
* {: .CodeFont value="5"} SQL_TSI_DAY
* {: .CodeFont value="6"} SQL_TSI_WEEK,
* {: .CodeFont value="7"} SQL_TSI_MONTH
* {: .CodeFont value="8"} SQL_TSI_QUARTER
* {: .CodeFont value="9"} SQL_TSI_YEAR
{: .bullet}

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

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) data value
* [`HOUR`](sqlref_builtinfcns_hour.html) function
* [`MINUTE`](sqlref_builtinfcns_minute.html) function
* [`SECOND`](sqlref_builtinfcns_second.html) function
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TIMESTAMPADD`](sqlref_builtinfcns_timestampadd.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

