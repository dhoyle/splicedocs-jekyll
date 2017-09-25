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
# CURRENT_DATE   {#BuiltInFcns.CurrentDate}

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

A [`DATE`](sqlref_builtinfcns_date.html) value.

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

* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DATE`](sqlref_builtinfcns_date.html) function
* [`DAY`](sqlref_builtinfcns_day.html) function
* [`EXTRACT`](sqlref_builtinfcns_extract.html) function
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

