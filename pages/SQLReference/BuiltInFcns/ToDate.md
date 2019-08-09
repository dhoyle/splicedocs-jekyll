---
title: TO_DATE built-in SQL function
summary: Built-in SQL function that formats a date string and returns a DATE value
keywords: convert string to date, todate, date format
toc: false
compatible_version: 2.8
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_todate.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TO_DATE

The <code>TO_DATE</code> function formats a date string according to a formatting
specification, and returns a &nbsp;[<code>DATE</code>](sqlref_builtinfcns_date.html)
values do not store time components.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TO_DATE( dateStrExpr, formatStr );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
dateStrExpr
{: .paramName}

A string expression that contains a date that is formatted according to
the format string.
{: .paramDefnFirst}

formatStr
{: .paramName}

A string that specifies the format you want applied to the <code>dateStr</code>.
See the [Date and Time Formats](#Date) section below for more
information about format specification.
{: .paramDefnFirst}

</div>
## Results

The result is always a &nbsp;[<code>DATE</code>](sqlref_builtinfcns_date.html) value.

{% include splice_snippets/datetimeformats.md %}

## Examples of Using <code>TO_DATE</code>

Here are several simple examples:

<div class="preWrapperWide" markdown="1">
    splice> VALUES TO_DATE('2015-01-01', 'YYYY-MM-dd');
    1
    ----------
    2015-01-01
    1 row selected

    splice> VALUES TO_DATE('01-01-2015', 'MM-dd-YYYY');
    1
    ----------
    2015-01-01
    1 row selected

    splice> VALUES (TO_DATE('01-01-2015', 'MM-dd-YYYY') + 30);
    1
    ----------
    2015-01-31
    1

    splice> VALUES (TO_DATE('2015-126', 'MM-DDD'));
    1
    ----------
    2015-05-06
    1 row selected

    splice> VALUES (TO_DATE('2015-026', 'MM-DDD'));
    1
    ----------
    2015-01-26

    splice> VALUES (TO_DATE('2015-26', 'MM-DD'));
    1
    ----------
    2015-01-26
    1 row selected
{: .Example xml:space="preserve"}

</div>
And here is an example that shows two interesting aspects of using
<code>TO_DATE</code>. In this example, the input includes the literal <code>T</code> ), which
means that the format pattern must delimit that letter with single
quotes. Since we're delimiting the entire pattern in single quotes, we
then have to escape those marks and specify <code>''T''</code> in our parsing
pattern.

And because this example specifies a time zone (Z) in the parsing
pattern but not in the input string, the timezone information is not
preserved. In this case, that means that the parsed date is actually a
day earlier than intended:

<div class="preWrapperWide" markdown="1">
    splice> VALUES TO_DATE('2013-06-18T01:03:30.000-0800','yyyy-MM-dd''T''HH:mm:ss.SSSZ');
    1
    ----------
    2013-06-17
{: .Example xml:space="preserve"}

</div>
The solution is to explicitly include the timezone for your locale in
the input string:

<div class="preWrapperWide" markdown="1">
    splice> VALUES TO_DATE('2013-06-18T01:03:30.000-08:00','yyyy-MM-dd''T''HH:mm:ss.SSSZ');
    1
    ----------
    2013-06-18
{: .Example xml:space="preserve"}

</div>
## See Also

* [<code>CURRENT_DATE</code>](sqlref_builtinfcns_currentdate.html) function
* [<code>DATE</code>](sqlref_builtinfcns_date.html) data type
* [<code>DATE</code>](sqlref_builtinfcns_date.html) function
* [<code>DAY</code>](sqlref_builtinfcns_day.html) function
* [<code>EXTRACT</code>](sqlref_builtinfcns_extract.html) function
* [<code>LASTDAY</code>](sqlref_builtinfcns_day.html) function
* [<code>MONTH</code>](sqlref_builtinfcns_month.html) function
* [<code>MONTH_BETWEEN</code>](sqlref_builtinfcns_monthbetween.html) function
* [<code>MONTHNAME</code>](sqlref_builtinfcns_monthname.html) function
* [<code>NEXTDAY</code>](sqlref_builtinfcns_day.html) function
* [<code>NOW</code>](sqlref_builtinfcns_now.html) function
* [<code>QUARTER</code>](sqlref_builtinfcns_quarter.html) function
* [<code>TIME</code>](sqlref_builtinfcns_time.html) data type
* [<code>TIMESTAMP</code>](sqlref_builtinfcns_timestamp.html) function
* [<code>TO_CHAR</code>](sqlref_builtinfcns_char.html) function
* [<code>WEEK</code>](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>
