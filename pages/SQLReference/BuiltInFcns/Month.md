---
title: MONTH built-in SQL function
summary: Built-in SQL function that returns the month part of a value
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_month.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MONTH

The `MONTH` function returns the month part of a value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    MONTH ( expression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression
{: .paramName}

An expression that can be a time, timestamp, or a valid character string representation of a time or timestamp.
{: .paramDefnFirst}

</div>
## Results

The returned result is an integer value in the range `1` to `12`.

If the argument can be `NULL`, the result can be `NULL`; if the argument
is `NULL`, the result is the `NULL` value.

## Examples

Get the current date:

<div class="preWrapper" markdown="1">
    splice> VALUES(CURRENT_DATE);
    1
    --------
    2014-05-15
{: .Example xml:space="preserve"}

</div>
Now get the current month only:

<div class="preWrapper" markdown="1">
    splice> VALUES(MONTH(CURRENT_DATE));
    1
    --------
    5
{: .Example xml:space="preserve"}

</div>
Get the month of one week from now:

<div class="preWrapper" markdown="1">
    splice> VALUES(MONTH(CURRENT_DATE+7));
    1
    --------
    5
{: .Example xml:space="preserve"}

</div>
Select all players who were born in December:

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName, Team, BirthDate
       FROM Players
       WHERE MONTH(BirthDate)=12;
    DISPLAYNAME             |TEAM      |BIRTHDATE
    ----------------------------------------------
    Greg Brown              |Giants    |1983-12-24
    Reed Lister             |Giants    |1986-12-16
    Cameron Silliman        |Cards     |1988-12-21
    Edward Erdman           |Cards     |1985-12-21
    Taylor Trantula         |Cards     |1987-12-17
    Tam Croonster           |Cards     |1980-12-19

    6 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DATE`](sqlref_builtinfcns_date.html) function
* [`DAY`](sqlref_builtinfcns_day.html) function
* [`EXTRACT`](sqlref_builtinfcns_extract.html) function
* [`LASTDAY`](sqlref_builtinfcns_day.html) function
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
