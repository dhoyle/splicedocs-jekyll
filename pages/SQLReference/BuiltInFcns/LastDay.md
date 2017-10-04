---
title: LAST_DAY built-in SQL function
summary: Built-in SQL function that returns the date of the last day of a month
keywords: last day of month
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_lastday.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# LAST_DAY

The `LAST_DAY` function returns the date of the last day of the month
that contains the input date.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    LAST_DAY ( dateExpression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateExpression
{: .paramName}

A date value.
{: .paramDefnFirst}

</div>
## Results

The return type is always &nbsp;[`DATE`](sqlref_builtinfcns_date.html),
regardless of the data type of the *dateExpression*.

## Examples

<div class="preWrapper" markdown="1">
    Examples:
    splice> values (LAST_DAY(CURRENT_DATE));
    1
    ----------
    2015-11-30
    
    splice> values (LAST_DAY(DATE(CURRENT_TIMESTAMP)));
    1
    ----------
    2015-11-30
    
    splice> SELECT DISPLAYNAME, BirthDate, LAST_DAY(BirthDate) "MonthEnd"
       FROM Players
       WHERE MONTH(BirthDate) IN (2, 5, 12);
    DISPLAYNAME             |BIRTHDATE |MonthEnd
    ----------------------------------------------
    Tam Croonster           |1980-12-19|1980-12-31
    Jack Peepers            |1981-05-31|1981-05-31
    Jason Martell           |1982-02-01|1982-02-28
    Kameron Fannais         |1982-05-24|1982-05-31
    Jonathan Pearlman       |1982-05-28|1982-05-31
    Greg Brown              |1983-12-24|1983-12-31
    Edward Erdman           |1985-12-21|1985-12-31
    Jonathan Wilson         |1986-05-14|1986-05-31
    Reed Lister             |1986-12-16|1986-12-31
    Larry Lintos            |1987-05-12|1987-05-31
    Taylor Trantula         |1987-12-17|1987-12-31
    Tim Lentleson           |1988-02-21|1988-02-29
    Cameron Silliman        |1988-12-21|1988-12-31
    Nathan Nickels          |1989-05-04|1989-05-31
    Tom Rather              |1990-05-29|1990-05-31
    Mo Grandosi             |1992-02-16|1992-02-29
    
    16 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
* [`DATE`](sqlref_builtinfcns_date.html) data type
* [`DATE`](sqlref_builtinfcns_date.html) function
* [`DAY`](sqlref_builtinfcns_day.html) function
* [`EXTRACT`](sqlref_builtinfcns_extract.html) function
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

