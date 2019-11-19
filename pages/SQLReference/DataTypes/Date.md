---
title: DATE data type
summary: The DATE data type provides for storage of a year-month-day in the range supported by java.sql.Date.
keywords:
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_date.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DATE

The `DATE` data type provides for storage of a year-month-day in the
range supported by *java.sql.Date*.

{% include splice_snippets/datedisplaynote.md %}{: .noteIcon}

## Syntax

<div class="fcnWrapperWide" markdown="1">

    DATE
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.sql.Date
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">

    DATE
{: .FcnSyntax}

</div>
## Usage Notes

Here are several notes about using the `DATE` data type:

* Dates, [timestamps](sqlref_builtinfcns_timestamp.html) must not be
  mixed with one another in expressions.
* Any value that is recognized by the *java.sql.Date* method is
  permitted in a column of the corresponding SQL date/time data type.
  Splice Machine supports the following formats for `DATE`:
  <div class="fcnWrapperWide" markdown="1">
      yyyy-mm-dd
      mm/dd/yyyy
      dd.mm.yyyy
  {: .FcnSyntax xml:space="preserve"}

  </div>

* The first of the three formats above is the *java.sql.Date* format.
* The year must always be expressed with four digits, while months and
  days may have either one or two digits.
* Splice Machine also accepts strings in the locale specific date-time
  format, using the locale of the database server. If there is an
  ambiguity, the built-in formats above take precedence.

Please see *[Working With Date and Time
Values](developers_fundamentals_dates.html)* in the
for information about using simple arithmetic with `DATE` values.

## Examples

<div class="preWrapper" markdown="1">

    VALUES DATE('1994-02-23');
    VALUES '1993-09-01';
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
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
