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
