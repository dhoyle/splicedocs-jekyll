---
title: WEEK built-in SQL function
summary: Built-in SQL function that returns an integer representation of the week from a date expression
keywords: date math, date arithmetic
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_week.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# WEEK

The `WEEK` function returns an integer value representing the week of
the year from a date expression.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    WEEK( dateExpr );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateExpr
{: .paramName}

The date-time expression from which you wish to extract information.
{: .paramDefnFirst}

</div>
## Results

The returned week number is in the range `1` to `53`.

## Examples

<div class="preWrapper" markdown="1">
    splice> SELECT BirthDate, Week(BirthDate) "BirthWeek"
       FROM Players
       WHERE ID < 15;
    BIRTHDATE |BIRTHWEEK
    ----------------------
    1987-03-27|13
    1988-04-20|16
    1990-10-30|44
    1987-01-21|4
    1991-01-15|3
    1982-01-05|1
    1981-07-02|27
    1983-04-13|15
    1983-12-24|51
    1983-11-06|44
    1990-06-16|24
    1977-08-30|35
    1990-03-22|12
    1982-10-12|41
    
    14 rows selected
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
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html) function
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html) function
* [`NEXTDAY`](sqlref_builtinfcns_day.html) function
* [`NOW`](sqlref_builtinfcns_now.html) function
* [`QUARTER`](sqlref_builtinfcns_quarter.html) function
* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TO_CHAR`](sqlref_builtinfcns_char.html) function
* [`TO_DATE`](sqlref_builtinfcns_date.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

