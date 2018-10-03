---
title: CURRENT_DATE (CURRENT DATE) built-in SQL function
summary: Built-in SQL function that returns the current date
keywords: current date
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_currentdate.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CURRENT_DATE

`CURRENT_DATE` returns the current date.

This function returns the same value if it is executed more than once in
a single statement, which means that the value is fixed, even if there
is a long delay between fetching rows in a cursor.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CURRENT_DATE
{: .FcnSyntax}

</div>
or, alternately

<div class="fcnWrapperWide" markdown="1">
    CURRENT DATE
{: .FcnSyntax}

</div>
## Results

A &nbsp;[`DATE`](sqlref_builtinfcns_date.html) value.

## Examples

The following query finds all players older that 33 years (as of Nov. 9,
2015) on the Cards baseball team:
{: .body}

<div class="preWrapper" markdown="1">
    splice> SELECT displayName, birthDate
       FROM Players
       WHERE (BirthDate+(33 * 365.25)) <= CURRENT_DATE AND Team='Cards';
    DISPLAYNAME             |BIRTHDATE
    -----------------------------------
    Yuri Milleton           |1982-07-13
    Jonathan Pearlman       |1982-05-28
    David Janssen           |1979-08-10
    Jason Larrimore         |1978-10-23
    Tam Croonster           |1980-12-19
    Alex Wister             |1981-08-30
    Robert Cohen            |1975-09-05
    Mitch Brandon           |1980-06-06

    8 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

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
