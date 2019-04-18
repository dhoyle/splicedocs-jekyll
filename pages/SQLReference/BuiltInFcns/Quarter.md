---
title: QUARTER built-in SQL function
summary: Built-in SQL function that returns an integer value representing the quarter of the year from a date expression
keywords: date arithmetic, date math
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_quarter.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# QUARTER

The `QUARTER` function returns an integer value representing the quarter
of the year from a date expression.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    QUARTER( dateExpr );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateExpr
{: .paramName}

The date-time expression from which you wish to extract information.
{: .paramDefnFirst}

</div>
## Results

The returned week number is in the range `1` to `4`. January 1 through
March 31 is Quarter `1`.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES QUARTER('2009-01-02 11:22:33.04');
    1
    -----------
    1
    1 row selected
    
    splice> SELECT DisplayName, BirthDate, Quarter(BirthDate) "Quarter"
       FROM Players
       WHERE ID<20
       ORDER BY "Quarter", BirthDate;
    DISPLAYNAME             |BIRTHDATE |Quarter
    -----------------------------------------------
    Norman Aikman           |1982-01-05|1
    Bob Cranker             |1987-01-21|1
    Buddy Painter           |1987-03-27|1
    Jeremy Packman          |1989-01-01|1
    Andy Sussman            |1990-03-22|1
    Mitch Duffer            |1991-01-15|1
    Harry Pennello          |1983-04-13|2
    Alex Darba              |1984-04-11|2
    Billy Bopper            |1988-04-20|2
    Kelly Tamlin            |1990-06-16|2
    Mark Briste             |1977-08-30|3
    Alex Paramour           |1981-07-02|3
    Joseph Arkman           |1984-09-21|3
    Elliot Andrews          |1989-08-21|3
    Craig McGawn            |1982-10-12|4
    Jason Minman            |1983-11-06|4
    Greg Brown              |1983-12-24|4
    Henry Socomy            |1989-11-17|4
    John Purser             |1990-10-30|4
    
    19 rows selected
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
* [`TIME`](sqlref_builtinfcns_time.html) data type
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TO_CHAR`](sqlref_builtinfcns_char.html) function
* [`TO_DATE`](sqlref_builtinfcns_date.html) function
* [`WEEK`](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

