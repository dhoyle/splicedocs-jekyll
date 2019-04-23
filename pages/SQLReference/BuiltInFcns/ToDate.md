---
title: TO_DATE built-in SQL function
summary: Built-in SQL function that formats a date string and returns a DATE value
keywords: convert string to date, todate, date format
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_todate.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TO_DATE

The `TO_DATE` function formats a date string according to a formatting
specification, and returns a &nbsp;[`DATE`](sqlref_builtinfcns_date.html)
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

A string that specifies the format you want applied to the `dateStr`.
See the [Date and Time Formats](#Date) section below for more
information about format specification.
{: .paramDefnFirst}

</div>
## Results

The result is always a &nbsp;[`DATE`](sqlref_builtinfcns_date.html) value.

## Date and Time Formats   {#Date}

Splice Machine supports date and time format specifications based on the
Java [SimpleDateFormat][1]{: target="_blank"} class.

Date and time value formats are used for both parsing input values and
for formatting output values. For example, the format specification
`yyyy-MM-dd HH:mm:ssZ` parses or formats values like `2014-03-02
11:47:44-0800`.

The remainder of this topic describes format specifications in these
sections:

* [Pattern Specifications](#Pattern) contains a table showing details
  for all of the pattern letters you can use.
* [Presentation Types](#Presenta) describes how certain pattern letters
  are interpreted for parsing and/or formatting.
* [Examples](#Presenta) contains a number of examples that will help you
  understand how to use formats.

### Pattern Specifications   {#Pattern}

You can specify formatting or parsing patterns for date-time values
using the pattern letters shown in the following table. Note that
pattern letters are typically repeated in a format specification. For
example, `YYYY` or `YY`. Refer to the next section for specific
information about multiple pattern letters in the different
[presentation types](#Presenta).

<table summary="Formatting and parsing patterns for date-time values">
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Pattern Letter</th>
                        <th>Meaning</th>
                        <th>Presentation Type</th>
                        <th>Example</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>G</code></td>
                        <td>Era designator</td>
                        <td><em>Text</em></td>
                        <td><code>BC</code></td>
                    </tr>
                    <tr>
                        <td><code>y</code></td>
                        <td>Year</td>
                        <td><em>Year</em></td>
                        <td><code>2015 <span class="bodyFont">-or-</span> 15</code></td>
                    </tr>
                    <tr>
                        <td><code>Y</code></td>
                        <td>Week year</td>
                        <td><em>Year</em></td>
                        <td><code>2011 <span class="bodyFont">-or-</span> 11</code></td>
                    </tr>
                    <tr>
                        <td><code>M</code></td>
                        <td>Month in year</td>
                        <td><em>Month</em></td>
                        <td><code>July <span class="bodyFont">-or-</span> Jul <span class="bodyFont">-or-</span> 07</code></td>
                    </tr>
                    <tr>
                        <td><code>w</code></td>
                        <td>Week in year</td>
                        <td><em>Number</em></td>
                        <td><code>27</code></td>
                    </tr>
                    <tr>
                        <td><code>W</code></td>
                        <td>Week in month</td>
                        <td><em>Number</em></td>
                        <td><code>3</code></td>
                    </tr>
                    <tr>
                        <td><code>D</code></td>
                        <td>Day in year</td>
                        <td><em>Number</em></td>
                        <td class="CodeFont">
                            <p>212</p>
                            <p>A common usage error is to mistakenly specify <code>DD</code> for the day field:</p>
                            <ul>
                                <li>use <code>dd</code> to specify day of month</li>
                                <li>use <code>DD</code> to specify the day of the year</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>d</code></td>
                        <td>Day in month</td>
                        <td><em>Number</em></td>
                        <td class="CodeFont">
                            <p>13</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>F</code></td>
                        <td>Day of week in month</td>
                        <td><em>Number</em></td>
                        <td><code>2</code></td>
                    </tr>
                    <tr>
                        <td><code>E</code></td>
                        <td>Day name in week</td>
                        <td><em>Text</em></td>
                        <td><code>Tuesday <span class="bodyFont">-or-</span> Tue</code></td>
                    </tr>
                    <tr>
                        <td><code>u</code></td>
                        <td>Day number of week<br />(<code>1</code>=Monday, <code>7</code>=Sunday)</td>
                        <td><em>Number</em></td>
                        <td><code>4</code></td>
                    </tr>
                    <tr>
                        <td><code>a</code></td>
                        <td>AM / PM marker</td>
                        <td><em>Text</em></td>
                        <td><code>PM</code></td>
                    </tr>
                    <tr>
                        <td><code>H</code></td>
                        <td>Hour in day <br />(<code>0 - 23</code>)</td>
                        <td><em>Number</em></td>
                        <td><code>23</code></td>
                    </tr>
                    <tr>
                        <td><code>k</code></td>
                        <td>Hour in day<br /><code>(1 - 24)</code></td>
                        <td><em>Number</em></td>
                        <td><code>24</code></td>
                    </tr>
                    <tr>
                        <td><code>K</code></td>
                        <td>Hour in AM/PM<br />(<code>0 - 11</code>)</td>
                        <td><em>Number</em></td>
                        <td><code>11</code></td>
                    </tr>
                    <tr>
                        <td><code>h</code></td>
                        <td>Hour in AM/PM<br />(<code>1 - 12</code>)</td>
                        <td><em>Number</em></td>
                        <td><code>12</code></td>
                    </tr>
                    <tr>
                        <td><code>m</code></td>
                        <td>Minute in hour</td>
                        <td><em>Number</em></td>
                        <td><code>33</code></td>
                    </tr>
                    <tr>
                        <td><code>s</code></td>
                        <td>Second in minute</td>
                        <td><em>Number</em></td>
                        <td><code>55</code></td>
                    </tr>
                    <tr>
                        <td><code>S</code></td>
                        <td>Millisecond</td>
                        <td><em>Number</em></td>
                        <td><code>959</code></td>
                    </tr>
                    <tr>
                        <td><code>z</code></td>
                        <td>Time zone</td>
                        <td><em>General time zone</em></td>
                        <td><code>Pacific Standard Time <span class="bodyFont">-or-</span> PST <span class="bodyFont">-or-</span> GMT-08:00</code></td>
                    </tr>
                    <tr>
                        <td><code>Z</code></td>
                        <td>Time zone</td>
                        <td><em>RFC 822 time zone</em></td>
                        <td><code>-0800</code></td>
                    </tr>
                    <tr>
                        <td><code>X</code></td>
                        <td>Time zone</td>
                        <td><em>ISO 8601 time zone</em></td>
                        <td><code>-08 <span class="bodyFont">-or-</span> -0800 <span class="bodyFont">-or-</span> -08:00</code></td>
                    </tr>
                    <tr>
                        <td><code>'</code></td>
                        <td>Escape char for text</td>
                        <td><em>Delimiter</em></td>
                        <td><code> </code></td>
                    </tr>
                    <tr>
                        <td><code>''</code></td>
                        <td>Single quote</td>
                        <td><em>Literal</em></td>
                        <td><code>'</code></td>
                    </tr>
                </tbody>
            </table>
### Presentation Types   {#Presenta}

How a presentation type is interpreted for certain pattern letters
depends on the number of repeated letters in the pattern. In some cases,
as noted in the following table, other factors can influence how the
pattern is interpreted.

<table summary="Presentation types for date-time values">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Presentation Type</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Text</em></td>
                        <td>
                            <p>For formatting, if the number of pattern letters is 4 or more, the full form is used. Otherwise, a short or abbreviated form is used, if available. </p>
                            <p>For parsing, both forms are accepted, independent of the number of pattern letters.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Number</em></td>
                        <td>
                            <p>For formatting, the number of pattern letters is the minimum number of digits, and shorter numbers are zero-padded to this amount.</p>
                            <p>For parsing, the number of pattern letters is ignored unless it's needed to separate two adjacent fields.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Year<br />(for Gregorian calendar)</em></td>
                        <td>
                            <p>For formatting, if the number of pattern letters is 2, the year is truncated to 2 digits; otherwise it is interpreted as a number.</p>
                            <p>For parsing, if the number of pattern letters is more than 2, the year is interpreted literally, regardless of the number of digits; e.g.:</p>
                            <ul>
                                <li> if you use the pattern <code>MM/dd/yyyy</code>, the value <code>01/11/12</code> parses to <code>January 11, 12 A.D.</code></li>
                                <li> if you use the pattern <code>MM/dd/yy</code>, the value <code>01/11/12</code> parses to <code>January 11, 2012.</code></li>
                            </ul>
                            <p>If the number of pattern letters is one or two,  (<code>y</code> or <code>yy</code>), the abbreviated year is interpreted as relative to a century; this is done by adjusting dates to be within 80 years before and 20 years after the current date.  </p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Year<br />(other calendar systems)</em></td>
                        <td>
                            <p>Calendar-system specific forms are applied. </p>
                            <p>For both formatting and parsing, if the number of pattern letters is 4 or more, a calendar specific long form is used. Otherwise, a calendar specific short or abbreviated form is used.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Month</em></td>
                        <td>If the number of pattern letters is 3 or more, the month is interpreted as text; otherwise, it is interpreted as a number.</td>
                    </tr>
                    <tr>
                        <td><em>General time zone</em></td>
                        <td>
                            <p>Time zones are interpreted as text if they have names. </p>
                            <p>For time zones representing a GMT offset value, the following syntax is used:</p>
                            <div class="indented">
                                <p><code>GMT Sign Hours : Minutes</code></p>
                            </div>
                            <p>where:</p>
                            <div class="indented">
                                <p><code>Sign</code> is <code>+</code> or <code>-</code></p>
                                <p><code>Hours</code> is either <code>Digit</code> or <code>Digit Digit</code>, between <code>0</code> and <code>23</code>. </p>
                                <p><code>Minutes</code> is <code>Digit Digit</code> and must be between <code>00</code> and <code>59</code>. </p>
                            </div>
                            <p>For parsing, RFC 822 time zones are also accepted.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>RFC 822 time zone</em></td>
                        <td>
                            <p>For formatting, use the RFC 822 4-digit time zone format is used:</p>
                            <div class="indented">
                                <p><code>Sign TwoDigitHours Minutes</code></p>
                            </div>
                            <p><code>TwoDigitHours</code> must be between <code>00</code> and <code>23</code>.</p>
                            <p>For parsing General time zones are also accepted.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>ISO 8601 time zone</em></td>
                        <td>
                            <p>The number of pattern letters designates the format for both formatting and parsing as follows:</p>
                            <div class="preWrapper"><pre xml:space="preserve">  Sign TwoDigitHours Z
| Sign TwoDigitHours Minutes Z
| Sign TwoDigitHours : Minutes Z</pre>
                            </div>
                            <p>For formatting:</p>
                            <ul>
                                <li> if the offset value from GMT is 0, <code>Z</code> value is produced</li>
                                <li>if the number of pattern letters is 1, any fraction of an hour is ignored</li>
                            </ul>
                            <p>For parsing, Z is parsed as the UTC time zone designator. Note that General time zones <em>are not accepted</em>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Delimiter</em></td>
                        <td>Use the single quote to escape characters in text strings.</td>
                    </tr>
                    <tr>
                        <td><em>Literal</em></td>
                        <td>
                            <p>You can include literals in your format specification by enclosing the character(s) in single quotes. </p>
                            <p>Note that you must escape single quotes to include them as literals, e.g. use <code>''T''</code> to include the literal string <code>'T'</code>.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
### Formatting Examples   {#Presenta}

The following table contains a number of examples of date time formats:

<table summary="Examples of date and time patterns">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Date and Time Pattern</th>
                        <th>Result</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>"yyyy.MM.dd G 'at' HH:mm:ss z"</code></td>
                        <td><span class="Example">2001.07.04 AD at 12:08:56 PDT</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"EEE, MMM d, ''yy"</code></td>
                        <td><span class="Example">Wed, Jul 4, '01</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"h:mm a"</code></td>
                        <td><span class="Example">12:08 PM</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"hh 'o''clock' a, zzzz"</code></td>
                        <td><span class="Example">12 o'clock PM, Pacific Daylight Time</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"K:mm a, z"</code></td>
                        <td><span class="Example">0:08 PM, PDT</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"yyyyy.MMMMM.dd GGG hh:mm aaa"</code></td>
                        <td><span class="Example">02001.July.04 AD 12:08 PM</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"EEE, d MMM yyyy HH:mm:ss Z"</code></td>
                        <td><span class="Example">Wed, 4 Jul 2001 12:08:56 -0700</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"yyMMddHHmmssZ"</code></td>
                        <td><span class="Example">010704120856-0700</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"yyyy-MM-dd'T'HH:mm:ss.SSSZ"</code></td>
                        <td><span class="Example">2001-07-04T12:08:56.235-0700</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"yyyy-MM-dd'T'HH:mm:ss.SSSXXX"</code></td>
                        <td><span class="Example">2001-07-04T12:08:56.235-07:00</span>
                        </td>
                    </tr>
                    <tr>
                        <td><code>"YYYY-'W'ww-u"</code></td>
                        <td><span class="Example">2001-W27-3</span>
                        </td>
                    </tr>
                </tbody>
            </table>
## Examples of Using `TO_DATE`

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
`TO_DATE`. In this example, the input includes the literal `T`), which
means that the format pattern must delimit that letter with single
quotes. Since we're delimiting the entire pattern in single quotes, we
then have to escape those marks and specify `''T''` in our parsing
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
* [`TO_CHAR`](sqlref_builtinfcns_char.html) function
* [`WEEK`](sqlref_builtinfcns_week.html) function
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>



[1]: http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html#rfc822timezone
