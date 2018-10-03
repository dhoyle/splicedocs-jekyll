---
title: TIMESTAMP data type
summary: The TIMESTAMP&#160;data type stores a combined DATE and TIME value, and allows a fractional-seconds value of up to nine digits.
keywords:
toc: false
compatible_version: 2.7
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_timestamp.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIMESTAMP

The `TIMESTAMP` data type represents a combined date and time value. Splice Machine stores timestamp values with up to 6 fractional second digits in databases, and allows you to specify literal timestamp values with up to 9 fractional second digits.

{% include splice_snippets/timedisplaynote.md %}{: .noteIcon}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TIMESTAMP
{: .FcnSyntax}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.sql.Timestamp
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    TIMESTAMP
{: .FcnSyntax}

</div>
## About Timestamp Formats

<div markdown="1">
Splice Machine uses the following Java date and time pattern letters to
construct timestamps:

<table summary="Timestamp format pattern letter descriptions">
                    <col />
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Pattern Letter</th>
                            <th>Description</th>
                            <th>Format(s)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>y</code></td>
                            <td>year</td>
                            <td><code>yy or yyyy</code></td>
                        </tr>
                        <tr>
                            <td><code>M</code></td>
                            <td>month</td>
                            <td><code>MM</code></td>
                        </tr>
                        <tr>
                            <td><code>d</code></td>
                            <td>day in month</td>
                            <td><code>dd</code></td>
                        </tr>
                        <tr>
                            <td><code>h</code></td>
                            <td>hour (0-12)</td>
                            <td><code>hh</code></td>
                        </tr>
                        <tr>
                            <td><code>H</code></td>
                            <td>hour (0-23)</td>
                            <td><code>HH</code></td>
                        </tr>
                        <tr>
                            <td><code>m</code></td>
                            <td>minute in hour</td>
                            <td><code>mm</code></td>
                        </tr>
                        <tr>
                            <td><code>s</code></td>
                            <td>seconds</td>
                            <td><code>ss</code></td>
                        </tr>
                        <tr>
                            <td><code>S</code></td>
                            <td>tenths of seconds</td>
                            <td><code>SSS (up to 6 decimal digits: SSSSSS)</code></td>
                        </tr>
                        <tr>
                            <td><code>z</code></td>
                            <td>time zone text</td>
                            <td><code>e.g. Pacific Standard time</code></td>
                        </tr>
                        <tr>
                            <td><code>Z</code></td>
                            <td>time zone, time offset</td>
                            <td><code>e.g. -0800</code></td>
                        </tr>
                    </tbody>
                </table>
The default timestamp format for Splice Machine imports is: `yyyy-MM-dd
HH:mm:ss`, which uses a 24-hour clock, does not allow for decimal digits
of seconds, and does not allow for time zone specification.

Please see *[Working With Date and Time
Values](developers_fundamentals_dates.html)*
for information about using simple arithmetic with `TIMESTAMP` values.

### Examples

The following tables shows valid examples of timestamps and their
corresponding format (parsing) patterns:

<table>
                    <col />
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Timestamp value</th>
                            <th>Format Pattern</th>
                            <th>Notes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>2013-03-23 09:45:00</code></td>
                            <td><code>yyyy-MM-dd HH:mm:ss</code></td>
                            <td>This is the default pattern.</td>
                        </tr>
                        <tr>
                            <td><code>2013-03-23 19:45:00.98-05</code></td>
                            <td><code>yyyy-MM-dd HH:mm:ss.SSZ</code></td>
                            <td>This pattern allows up to 2 decimal digits of seconds, and requires a time zone specification.</td>
                        </tr>
                        <tr>
                            <td><code>2013-03-23 09:45:00-07</code></td>
                            <td><code>yyyy-MM-dd HH:mm:ssZ</code></td>
                            <td>This patterns requires a time zone specification, but does not allow for decimal digits of seconds.</td>
                        </tr>
                        <tr>
                            <td><code>2013-03-23 19:45:00.98-0530</code></td>
                            <td><code>yyyy-MM-dd HH:mm:ss.SSZ</code></td>
                            <td>This pattern allows up to 2 decimal digits of seconds, and requires a time zone specification.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">
                                <p>2013-03-23 19:45:00.123</p>
                                <p>2013-03-23 19:45:00.12</p>
                            </td>
                            <td><code>yyyy-MM-dd HH:mm:ss.SSS</code></td>
                            <td>
                                <p>This pattern allows up to 3 decimal digits of seconds, but does not allow a time zone specification.</p>
                                <p>Note that if your data specifies more than 3 decimal digits of seconds, an error occurs.</p>
                            </td>
                        </tr>
                        <tr>
                            <td><code>2013-03-23 19:45:00.1298</code></td>
                            <td><code>yyyy-MM-dd HH:mm:ss.SSSS</code></td>
                            <td>This pattern allows up to 4 decimal digits of seconds, but does not allow a time zone specification.</td>
                        </tr>
                    </tbody>
                </table>
</div>
## Usage Notes

Dates, times, and timestamps cannot be mixed with one another in
expressions.

Splice Machine also accepts strings in the locale specific datetime
format, using the time zone for the server to which you are connected.  If there is an
ambiguity, the built-in formats shown above take precedence.

`TimeStamp` values range from '`01 Jan 0001 00:00:00 GMT`' &nbsp;&nbsp; to &nbsp;&nbsp; '`31 Dec 9999 23:59:59 GMT`'.

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
* [`TIME` type](sqlref_datatypes_time.html)
* [`TIME` function](sqlref_datatypes_time.html)
* [`TIMESTAMP` function](sqlref_builtinfcns_timestamp.html) 
* [`TO_CHAR`](sqlref_builtinfcns_char.html) 
* [`TO_DATE`](sqlref_builtinfcns_date.html)
* [`WEEK`](sqlref_builtinfcns_week.html)
* [Working with Dates](developers_fundamentals_dates.html)

</div>
</section>
