---
title: TIMESTAMP data type
summary: The TIMESTAMP&#160;data type stores a combined DATE and TIME value, and allows a fractional-seconds value of up to nine digits.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_timestamp.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TIMESTAMP   {#DataTypes.TimeStamp}

The `TIMESTAMP` data type stores a combined
[`TIME`](sqlref_builtinfcns_time.html) value that permits fractional
seconds values of up to nine digits.

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
Values](developers_fundamentals_dates.html)* in the *Developer's Guide*
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
format, using the locale of the database server. If there is an
ambiguity, the built-in formats shown above take precedence.

At this time,dates in [`TimeStamp`](#) values only work correctly when
limited to this range of date values:    `1678-01-01 to 2261-12-31`
{: .noteRelease}

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* *[Working with Dates](developers_fundamentals_dates.html)* in the
  *Developer's Guide*

</div>
</section>

