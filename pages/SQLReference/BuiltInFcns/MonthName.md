---
title: MONTHNAME built-in SQL function
summary: Built-in SQL function that returns the month name from a date expression
keywords: month name, name of month
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_monthname.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MONTHNAME

The `MONTHNAME` function returns a character string containing month
name from a date expression.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    MONTHNAME( dateExpr );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateExpr
{: .paramName}

The date-time expression from which you wish to extract information.
{: .paramDefnFirst}

</div>
## Results

The returned month name is specific to the data source location; for
English, the returned name will be in the range `January` through
`December`, or `Jan.` through `Dec.` For a data source that uses German,
the returned name will be in the range `Januar` through `Dezember`.

## Examples

The following query displays the birth month of players:
{: .body}

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName, MONTHNAME(BirthDate) "Month"
       FROM Players
       WHERE ID<20
       ORDER BY MONTH(BirthDate);
    DISPLAYNAME             |Month
    ---------------------------------------
    Bob Cranker             |January
    Mitch Duffer            |January
    Norman Aikman           |January
    Jeremy Packman          |January
    Buddy Painter           |March
    Andy Sussman            |March
    Billy Bopper            |April
    Harry Pennello          |April
    Alex Darba              |April
    Kelly Tamlin            |June
    Alex Paramour           |July
    Mark Briste             |August
    Elliot Andrews          |August
    Joseph Arkman           |September
    John Purser             |October
    Craig McGawn            |October
    Jason Minman            |November
    Henry Socomy            |November
    Greg Brown              |December
    
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

