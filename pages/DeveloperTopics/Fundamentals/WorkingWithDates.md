---
title: Working with Dates
summary: Provides an overview of working with dates and date arithmetic in Splice&#160;Machine.
keywords: date math, date arithmetic, date values, time values, timestamp, date format, date time
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_dates.html
folder: DeveloperTopics/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Working With Date and Time Values

This topic provides an overview of working with dates in Splice Machine, in these sections:

* [Date and Time Functions](#Functions)
* [Date Arithmetic](#Arithmetic)

For date and time values to work as expected in your database, you must
make sure that all nodes in your cluster are set to the same time zone;
otherwise the data you read from your database may differ when you
communicate with different servers! Please contact your system administrator if you have any questions about
this.
{: .noteIcon}

## Date and Time Functions {#Functions}

Here is a summary of the
 [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) functions included in
this release of Splice Machine:

<table summary="Summary of the date and time functions available in Splice Machine.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currentdate.html">CURRENT_DATE</a>
            </td>
            <td>Returns the current date as a <code>DATE</code> value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_date.html">DATE</a>
            </td>
            <td>Returns a <code>DATE</code> value from a <code>DATE</code> value, a <code>TIMESTAMP</code> value, a string representation of a date or timestamp value, or a numeric value representing elapsed days since January 1, 1970.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_day.html">DAY</a>
            </td>
            <td>Returns  an integer value between 1 and 31 representing the day portion of a <code>DATE</code> value, a <code>TIMESTAMP</code> value, or a string representation of a date or timestamp value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_extract.html">EXTRACT</a>
            </td>
            <td>Extracts various date and time components from a date expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_day.html">LAST_DAY</a>
            </td>
            <td>Returns a <code>DATE</code> value representing the date of the last day of the month that contains the input date.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_month.html">MONTH</a>
            </td>
            <td>Returns  an integer value between 1 and 12 representing the month portion of a <code>DATE</code> value, a <code>TIMESTAMP</code> value, or a string representation of a date or timestamp value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_monthbetween.html">MONTH_BETWEEN</a>
            </td>
            <td>Returns a decimal number representing the number of months between two dates.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_monthname.html">MONTHNAME</a>
            </td>
            <td>Returns the month name from a date expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_day.html">NEXT_DAY</a>
            </td>
            <td>Returns the date of the next specified day of the week after a specified date.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_now.html">NOW</a>
            </td>
            <td>Returns the current date and time as a <code>TIMESTAMP</code> value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_quarter.html">QUARTER</a>
            </td>
            <td>Returns the quarter number (1-4) from a date expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_timestamp.html">TIMESTAMP</a>
            </td>
            <td>Returns a timestamp value from a <code>TIMESTAMP</code> value, a string representation of a timestamp value, or a string of digits representing such a value. </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_timestampadd.html">TIMESTAMPADD</a>
            </td>
            <td>Adds the value of an interval to a <code>TIMESTAMP</code> value and returns the sum as a new timestamp.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_timestampdiff.html">TIMESTAMPDIFF</a>
            </td>
            <td>Finds the difference between two timestamps, in terms of the specfied interval.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_char.html">TO_CHAR</a>
            </td>
            <td>Returns string formed from a DATE value, using a format specification.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_date.html">TO_DATE</a>
            </td>
            <td>Returns a <code>DATE</code> value formed from an input string representation, using a format specification.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_week.html">WEEK</a>
            </td>
            <td>Returns the week number (1-53) from a date expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_year.html">YEAR</a>
            </td>
            <td>Returns  an integer value between 1 and 9999 representing the year portion of a <code>DATE</code> value, a <code>TIMESTAMP</code> value, or a string representation of a date or timestamp value.</td>
        </tr>
    </tbody>
</table>
## Date Arithmetic {#Arithmetic}

Splice Machine provides simple arithmetic operations addition and
subtraction on date and timestamp values. You can:

* find a future date value by adding an integer number of days to a date
  value
* find a past date value by subtracting an integer number of days from a
  date value
* subtract two date values to find the difference, in days, between
  those two values

Here's the syntax for these inline operations:

<div class="fcnWrapperWide" markdown="1">
       dateValue { "+" | "-" } numDays
    |  numDays   '+' dateValue
    |  dateValue '-' dateValue
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateValue
{: .paramName}

A [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value. This can be a
literal date value, a reference to a date value in a table, or the
result of a function that produces a date value as its result.
{: .paramDefnFirst}

numDays
{: .paramName}

An integer value expressing the number of days to add or subtract to a
date value.
{: .paramDefnFirst}

</div>
### Result Types

The result type of adding or subtracting a number of days to/from a date
value is a date value of the same type (`DATE` or `TIMESTAMP`) as the
`dateValue` operand.

The result type of subtracting one date value from another is the number
of days between the two dates. This can be a positive or negative
integer value.

### Notes

A few important notes about these operations:

* Adding a number of days to a date value is commutative, which means
  that the order of the `dateValue` and `numDays` operands is
  irrelevant.
* Subtraction of a number of days from a date value is not
  commutative: the left-side operand must be a date value.
* Attempting to add two date values produces an error, as does
  attempting to use a date value in a multiplication or division
  operation.

### Examples

This section presents several examples of using date arithmetic. We'll
first set up a simple table that stores a string value, a `DATE` value,
and a `TIMESTAMP` value, and we'll use those values in our example.

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE date_math (s VARCHAR(30), d DATE, t TIMESTAMP);
    0 rows inserted/updated/deleted

    splice> INSERT INTO date_math values ('2012-05-23 12:24:36', '1988-12-26', '2000-06-07 17:12:30');
    1 row inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
#### Example 1: Add a day to a date column and then to a timestamp column

<div class="preWrapperWide" markdown="1">
    splice> select d + 1 from date_math;
    1
    ----------
    1988-12-27
    1 row selected

    splice> select 1+t from date_math;
    1
    ----------
    2000-06-08 17:12:30.0
    1 row selected
{: .Example xml:space="preserve"}

</div>
#### Example 2: Subtract a day from a timestamp column

<div class="preWrapperWide" markdown="1">
    splice> select t - 1 from date_math;
    1
    -----------------------------
    2000-06-06 17:12:30.0
    1 row selected
{: .Example xml:space="preserve"}

</div>
#### Example 3: Subtract a date column from the result of the `CURRENT_DATE` function

<div class="preWrapperWide" markdown="1">
    splice> select current_date - d from date_math;
    1
    -----------
    9551
    1 row selected
{: .Example xml:space="preserve"}

</div>
#### Example 4: Additional examples using literal values

<div class="preWrapperWide" markdown="1">
    splice> values  date('2011-12-26') + 1;
    1
    ----------
    2011-12-27
    1 row selected

    splice> values  date('2011-12-26') - 1;
    1
    ----------
    2011-12-25
    1 row selected

    splice> values  timestamp('2011-12-26', '17:13:30') + 1;
    1
    -----------------------------
    2011-12-27 17:13:30.0
    1 row selected

    splice> values  timestamp('2011-12-26', '17:13:30') - 1;
    1
    -----------------------------
    2011-12-25 17:13:30.0
    1 row selected

    splice> values  date('2011-12-26') - date('2011-06-05');
    1
    -----------
    204
    1 row selected

    splice> values  date('2011-06-05') - date('2011-12-26');
    1
    -----------
    -204
    1 row selected


    splice> values  timestamp('2015-06-07', '05:06:00') - current_date;
    1
    -----------
    108
    1 row selected

    splice> values  timestamp('2011-06-05', '05:06:00') - date('2011-12-26');
    1
    -----------
    -203
    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

All of the following are in the *[SQL Reference
Manual](sqlref_intro.html)*:

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`DATE`](sqlref_builtinfcns_date.html)
* [`DATE`](sqlref_builtinfcns_date.html) 
* [`DAY`](sqlref_builtinfcns_day.html) 
* [`EXTRACT`](sqlref_builtinfcns_extract.html) 
* [`LASTDAY`](sqlref_builtinfcns_day.html) 
* [`MONTH`](sqlref_builtinfcns_month.html)
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html)
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html) 
* [`NEXTDAY`](sqlref_builtinfcns_day.html) 
* [`NOW`](sqlref_builtinfcns_now.html)
* [`QUARTER`](sqlref_builtinfcns_quarter.html)
* [`TIME`](sqlref_builtinfcns_time.html)
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) 
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)

</div>
</section>
