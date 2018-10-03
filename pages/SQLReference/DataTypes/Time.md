---
title: TIME data type
summary: The TIME data type provides for storage of a time-of-day value.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_time.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIME

The `TIME` data type provides for storage of a time-of-day value.
{% include splice_snippets/timedisplaynote.md %}{: .noteIcon}

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
  format, using the time zone for the server to which you are connected. If there is an
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

* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html)
* [`CURRENT_TIME`](sqlref_builtinfcns_currenttime.html)
* [`CURRENT_TIMESTAMP`](sqlref_builtinfcns_currenttimestamp.html)
* [`DATE` type](sqlref_datatypes_date.html)
* [`DATE` function](sqlref_builtinfcns_date.html) 
* [`DAY`](sqlref_builtinfcns_day.html) 
* [`EXTRACT`](sqlref_builtinfcns_extract.html) 
* [`LASTDAY`](sqlref_builtinfcns_day.html) 
* [`MONTH`](sqlref_builtinfcns_month.html)
* [`MONTH_BETWEEN`](sqlref_builtinfcns_monthbetween.html)
* [`MONTHNAME`](sqlref_builtinfcns_monthname.html) 
* [`NEXTDAY`](sqlref_builtinfcns_day.html) 
* [`NOW`](sqlref_builtinfcns_now.html)
* [`QUARTER`](sqlref_builtinfcns_quarter.html)
* [`TIME` function](sqlref_datatypes_time.html)
* [`TIMESTAMP` type](sqlref_datatypes_timestamp.html) 
* [`TIMESTAMP` function](sqlref_builtinfcns_timestamp.html) 
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* [Working with Dates](developers_fundamentals_dates.html)

</div>
</section>
