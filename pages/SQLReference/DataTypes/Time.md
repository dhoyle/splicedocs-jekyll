---
title: TIME data type
summary: The TIME data type provides for storage of a time-of-day value.
keywords:
toc: false
compatible_version: 2.7
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_time.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIME

The `TIME` data type provides for storage of a time-of-day value.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIME
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.sql.Time
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    TIME
{: .FcnSyntax}

</div>
## Usage Notes

Here are several usage notes for the `TIME` data type:

* [timestamps](sqlref_builtinfcns_timestamp.html) cannot be mixed with
  one another in expressions except with a `CAST`.
* Any value that is recognized by the *java.sql.Time* method is
  permitted in a column of the corresponding SQL date/time data type.
  Splice Machine supports the following formats for `TIME`:
  <div class="fcnWrapperWide" markdown="1">
      hh:mm[:ss]
      hh.mm[.ss]
      hh[:mm] {AM | PM}
  {: .FcnSyntax}

  </div>

  The first of the three formats above is the *java.sql.Time* format.

* Hours may have one or two digits.
* Minutes and seconds, if present, must have two digits.
* Splice Machine also accepts strings in the locale specific date-time
  format, using the locale of the database server. If there is an
  ambiguity, the built-in formats above take precedence.

Please see *[Working With Date and Time
Values](developers_fundamentals_dates.html)* 
for information about using simple arithmetic with `TIME` values.

## Examples

<div class="preWrapper" markdown="1">
    VALUES TIME('15:09:02');
    VALUES '15:09:02';
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
* [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) function
* [`TO_CHAR`](sqlref_builtinfcns_char.html) function
* [`TO_DATE`](sqlref_builtinfcns_date.html) function
* [`WEEK`](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>
