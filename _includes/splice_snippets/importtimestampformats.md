 <div markdown="1">
Splice Machine uses the following Java date and time pattern letters to
construct timestamps:

<table summary="Timestamp format pattern letter descriptions">
                <col />
                <col />
                <col style="width: 330px;" />
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
                        <td class="CodeFont">
                            <p>S, SS, SSS, SSSS, SSSSS or SSSSSS<span class="important">*</span></p>
                            <p><span class="important">*</span><span class="bodyFont">Specify </span>SSSSSS <span class="bodyFont">to allow a variable number (any number) of digits after the decimal point.</span></p>
                        </td>
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

The standard Java library does not support microsecond precision, so you
**cannot** specify millisecond (`S`) values in a custom timestamp format
and import such values with the desired precision.
{: .noteNote}

### Timestamps and Importing Data at Different Locations

Note that timestamp values are relative to the geographic location at
which they are imported, or more specifically, relative to the timezone
setting and daylight saving time status where the data is imported.

This means that timestamp values from the same data file may appear
differently after being imported in different timezones.

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

