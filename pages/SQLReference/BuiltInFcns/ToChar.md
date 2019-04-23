---
title: TO_CHAR built-in SQL function
summary: Built-in SQL function that formats a date value into a string
keywords: convert date to string
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_tochar.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TO_CHAR

The `TO_CHAR` function formats a date value into a string.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TO_CHAR( dateExpr, format );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateExpr
{: .paramName}

The date value that you want to format.
{: .paramDefnFirst}

*format*
{: .paramName}

A string that specifies the format you want applied to the `date`. You
can specify formats such as the following:
{: .paramDefnFirst}

<div class="paramList" markdown="1">
yyyy-mm-dd
{: .paramName}

mm/dd/yyyy
{: .paramName}

dd.mm.yy
{: .paramName}

dd-mm-yy
{: .paramName}

</div>
</div>
## Results

This function returns a string (`CHAR`) value.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES TO_CHAR(CURRENT_DATE, 'mm/dd/yyyy');
    1
    ----------------------------------------------------
    09/22/2014
    1 row selected
    
    splice> VALUES TO_CHAR(CURRENT_DATE, 'dd-mm-yyyy');
    1
    ----------------------------------------------------
    22-09-2014
    1 row selected
    
    splice> VALUES TO_CHAR(CURRENT_DATE, 'dd-mm-yy');
    1
    ----------------------------------------------------
    22-09-14
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
* [`TO_DATE`](sqlref_builtinfcns_date.html) function
* [`WEEK`](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

