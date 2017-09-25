---
title: NEXT_DAY built-in SQL function
summary: Built-in SQL function that returns the date of a specified day
keywords: date arithmetic
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_nextday.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NEXT_DAY

The `NEXT_DAY` function returns the date of the next specified day of
the week after a specified date.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    NEXT_DAY( source_date, day_of_week);
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
source_date
{: .paramName}

The source date.
{: .paramDefnFirst}

day_of_week
{: .paramName}

The day of the week. This is the case-insensitive name of a day in the
date language of your session. You can also specify day-name
abbreviations, in which case any characters after the recognized
abbreviation are ignored. For example, if you're using English, you can
use the following values (again, the case of the characters is ignored):
{: .paramDefnFirst}

<table summary="Day of week abbreviations">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Day Name</th>
                            <th>Abbreviation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>Sunday</code></td>
                            <td><code>Sun</code></td>
                        </tr>
                        <tr>
                            <td><code>Monday</code></td>
                            <td><code>Mon</code></td>
                        </tr>
                        <tr>
                            <td><code>Tuesday</code></td>
                            <td><code>Tue</code></td>
                        </tr>
                        <tr>
                            <td><code>Wednesday</code></td>
                            <td><code>Wed</code></td>
                        </tr>
                        <tr>
                            <td><code>Thursday</code></td>
                            <td><code>Thu</code></td>
                        </tr>
                        <tr>
                            <td><code>Friday</code></td>
                            <td><code>Fri</code></td>
                        </tr>
                        <tr>
                            <td><code>Saturday</code></td>
                            <td><code>Sat</code></td>
                        </tr>
                    </tbody>
                </table>
</div>
## Results

This function returns the date of the first weekday, as specified by
`day_of_week`, that is later than the specified date.

The return type is always `DATE`, regardless of the data type of the
`source_date` parameter.

The return value has the same hours, minutes, and seconds components as
does the `source_date` parameter value.

## Examples

<div class="preWrapper" markdown="1">
    splice> values (NEXT_DAY(CURRENT_DATE, 'tuesday'));
    1
    ----------
    2014-09-23
    1 row selected
    
    splice> values (NEXT_DAY(CURRENT_DATE, 'monday'));
    1
    ----------
    2014-09-29
    1 row selected
    
    SELECT DisplayName, BirthDate, NEXT_DAY(BirthDate, 'sunday') as "FirstSunday"
       FROM Players
       WHERE ID < 20;
    DISPLAYNAME             |BIRTHDATE |FirstSund&
    ----------------------------------------------
    Buddy Painter           |1987-03-27|1987-03-29
    Billy Bopper            |1988-04-20|1988-04-24
    John Purser             |1990-10-30|1990-11-04
    Bob Cranker             |1987-01-21|1987-01-25
    Mitch Duffer            |1991-01-15|1991-01-20
    Norman Aikman           |1982-01-05|1982-01-10
    Alex Paramour           |1981-07-02|1981-07-05
    Harry Pennello          |1983-04-13|1983-04-17
    Greg Brown              |1983-12-24|1983-12-25
    Jason Minman            |1983-11-06|1983-11-06
    Kelly Tamlin            |1990-06-16|1990-06-17
    Mark Briste             |1977-08-30|1977-09-04
    Andy Sussman            |1990-03-22|1990-03-25
    Craig McGawn            |1982-10-12|1982-10-17
    Elliot Andrews          |1989-08-21|1989-08-27
    Alex Darba              |1984-04-11|1984-04-15
    Joseph Arkman           |1984-09-21|1984-09-23
    Henry Socomy            |1989-11-17|1989-11-19
    Jeremy Packman          |1989-01-01|1989-01-01
    
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

