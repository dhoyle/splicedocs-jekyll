---
title: YEAR built-in SQL function
summary: Built-in SQL function that returns the year part of a value
keywords: date math, date arithmetic
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_year.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# YEAR

The `YEAR` function returns the year part of a value. The argument must
be a date, timestamp, or a valid character string representation of a
date or timestamp. The result of the function is an integer between `1`
and `9999`.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    YEAR ( expression )
{: .FcnSyntax}

</div>
## Usage

If the argument is `NULL`, the result is the `NULL` value.

## Examples

Get the current date:

<div class="preWrapper" markdown="1">
    splice> value(current_date);
    1
    --------
    2014-02-25
{: .Example xml:space="preserve"}

</div>
Now get the current year only:

<div class="preWrapper" markdown="1">
    splice> value(year(current_date));
    1
    --------
    2015
{: .Example xml:space="preserve"}

</div>
Now get the year value from 60 days ago:

<div class="preWrapper" markdown="1">
    splice> value(year(current_date-60));
    1
    --------
    2014
{: .Example xml:space="preserve"}

</div>
Select all players born in 1985 or 1989:

<div class="preWrapper" markdown="1">
    splice> SELECT DisplayName, Team, BirthDate
       FROM Players
       WHERE YEAR(BirthDate) IN (1985, 1989)
       ORDER BY BirthDate;
    DISPLAYNAME             |TEAM     |BIRTHDATE
    -----------------------------------------------
    Jeremy Johnson          |Cards    |1985-03-15
    Gary Kosovo             |Giants   |1985-06-12
    Michael Hillson         |Cards    |1985-11-07
    Mitch Canepa            |Cards    |1985-11-26
    Edward Erdman           |Cards    |1985-12-21
    Jeremy Packman          |Giants   |1989-01-01
    Nathan Nickels          |Giants   |1989-05-04
    Ken Straiter            |Cards    |1989-07-20
    Marcus Bamburger        |Giants   |1989-08-01
    George Goomba           |Cards    |1989-08-08
    Jack Hellman            |Cards    |1989-08-09
    Elliot Andrews          |Giants   |1989-08-21
    Henry Socomy            |Giants   |1989-11-17
    
    13 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
* [`DATE`](sqlref_builtinfcns_date.html) function
* [`DAY`](sqlref_builtinfcns_day.html) function
* [`LASTDAY`](sqlref_builtinfcns_day.html) function
* [`MONTH`](sqlref_builtinfcns_month.html) function
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html) function
* [`NEXTDAY`](sqlref_builtinfcns_day.html) function
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

