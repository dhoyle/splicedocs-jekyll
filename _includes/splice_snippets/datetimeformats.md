## Date and Time Formats   {#Date}

Splice Machine supports date and time format specifications based on the
Java [DateTimeFormatter](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html){: target="_blank"} class.

Date and time value formats are used for both parsing input values and
pattern types. For example, the format specification
<code>yyyy-MM-dd HH:mm:ssZ</code> parses values like `2014-03-02
11:47:44-0800`.

The remainder of this topic describes format specifications in these
sections:

* [Pattern Specifications](#Pattern) contains a table showing details
  for all of the pattern letters you can use.
* [Pattern Types](#Presenta) describes how certain pattern letters
  are interpreted for parsing and/or formatting.
* [Examples](#Presenta) contains a number of examples that will help you
  understand how to use formats.

### Pattern Specifications   {#Pattern}

You can specify formatting or parsing patterns for date-time values
using the pattern letters shown in the following table. Note that
pattern letters are typically repeated in a format specification. For
example, <code>yyyy</code> or <code>yy</code>. Refer to the next section for specific
information about multiple pattern letters in the different
[pattern types](#Presenta).

<table summary="Formatting and parsing patterns for date-time values">
    <col width="15%" />
    <col width="30%" />
    <col width="20%" />
    <col width="35%" />
    <col />
    <col />
    <thead>
        <tr>
            <th>Pattern Letter</th>
            <th>Meaning</th>
            <th>Pattern Type</th>
            <th>Example(s)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>G</code></td>
            <td>Era</td>
            <td><em>Text</em></td>
            <td><code>AD; Anno Domini; A</code></td>
        </tr>
        <tr>
            <td><code>u</code></td>
            <td>Year</td>
            <td><em>Year</em></td>
            <td><code>2017; 17</code></td>
        </tr>
        <tr>
            <td><code>y</code></td>
            <td>Year-of-era</td>
            <td><em>Year</em></td>
            <td><code>2017; 17</code></td>
        </tr>
        <tr>
            <td><code>D</code></td>
            <td>Day-of-year</td>
            <td><em>Number</em></td>
            <td><code>189; 303</code></td>
        </tr>
        <tr>
            <td><code>M/L</code></td>
            <td>Month-of-year</td>
            <td><em>Number/text</em></td>
            <td><code>6; 06; Jun; June</code></td>
        </tr>
        <tr>
            <td><code>d</code></td>
            <td>Day-of-month</td>
            <td><em>Number</em></td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>Y</code></td>
            <td>Week-based-year</td>
            <td><em>year</em></td>
            <td><code>2017; 17</code></td>
        </tr>
        <tr>
            <td><code>w</code></td>
            <td>Week-of-week-based-year</td>
            <td><em>Number</em></td>
            <td><code>14; 51</code></td>
        </tr>
        <tr>
            <td><code>W</code></td>
            <td>Week-of-month</td>
            <td><em>Number</em></td>
            <td><code>7</code></td>
        </tr>
        <tr>
            <td><code>E</code></td>
            <td>Day-of-week</td>
            <td><em>Text</em></td>
            <td><code>Mon; Monday; M</code></td>
        </tr>
        <tr>
            <td><code>e/c</code></td>
            <td>Localized day-of-week</td>
            <td><em>Number/text</em></td>
            <td><code>1; 01; Mon; Monday; M</code></td>
        </tr>
        <tr>
            <td><code>F</code></td>
            <td>Week-of-month</td>
            <td><em>Number</em></td>
            <td><code>2</code></td>
        </tr>
        <tr>
            <td><code>a</code></td>
            <td>Am-Pm-of-Day</td>
            <td><em>Text</em></td>
            <td><code>PM</code></td>
        </tr>
        <tr>
            <td><code>h</code></td>
            <td>Clock-hour-of-am-pm (1-12)</td>
            <td><em>Number</em></td>
            <td><code>7; 12</code></td>
        </tr>
        <tr>
            <td><code>K</code></td>
            <td>Hour-of-am-pm (0-11)</td>
            <td><em>Number</em></td>
            <td><code>0; 11</code></td>
        </tr>
        <tr>
            <td><code>k</code></td>
            <td>Clock-hour-of-am-pm (1-24)</td>
            <td><em>Number</em></td>
            <td><code>1; 13</code></td>
        </tr>
        <tr>
            <td><code>H</code></td>
            <td>Hour-of-day (0-23)</td>
            <td><em>Number</em></td>
            <td><code>0; 11; 17</code></td>
        </tr>
        <tr>
            <td><code>m</code></td>
            <td>Minute-of-hour</td>
            <td><em>Number</em></td>
            <td><code>27</code></td>
        </tr>
        <tr>
            <td><code>s</code></td>
            <td>Second-of-minute</td>
            <td><em>Number</em></td>
            <td><code>48</code></td>
        </tr>
        <tr>
            <td><code>S</code></td>
            <td>Fraction-of-second</td>
            <td><em>Fraction</em></td>
            <td><code>978</code></td>
        </tr>
        <tr>
            <td><code>A</code></td>
            <td>Milli-of-day</td>
            <td><em>Number</em></td>
            <td><code>1234</code></td>
        </tr>
        <tr>
            <td><code>V</code></td>
            <td>Time-zone ID</td>
            <td><em>Zone-id</em></td>
            <td><code>America/San_Francisco; Z; -08:30</code></td>
        </tr>
        <tr>
            <td><code>z</code></td>
            <td>Time-zone name</td>
            <td><em>Zone-name</em></td>
            <td><code>Pacific Standard Time; PST</code></td>
        </tr>
        <tr>
            <td><code>O</code></td>
            <td>Localized zone-offset</td>
            <td><em>Offset-0</em></td>
            <td><code>GMT+7; GMT+07:00; UTC-07:00;</code></td>
        </tr>
        <tr>
            <td><code>X</code></td>
            <td>Zone-offset 'Z' for zero</td>
            <td><em>Offset-X</em></td>
            <td><code>Z; -07; -0730; -07:30; -073015; -07:30:15;</code></td>
        </tr>
        <tr>
            <td><code>x</code></td>
            <td>Zone-offset</td>
            <td><em>Offset-x</em></td>
            <td><code>+0000; -07; -0730; -07:30; -073015; -07:30:15;</code></td>
        </tr>
        <tr>
            <td><code>Z</code></td>
            <td>Zone-offset</td>
            <td><em>Offset-Z</em></td>
            <td><code>+0000; -0800; -08:00;</code></td>
        </tr>
        <tr>
            <td><code>p</code></td>
            <td>Pad next</td>
            <td><em>Pad modifier</em></td>
            <td><code>1</code></td>
        </tr>        <tr>
            <td><code>'</code></td>
            <td>Escape for text</td>
            <td><em>Delimiter</em></td>
            <td><code>&nbsp;</code></td>
        </tr>
        <tr>
            <td><code>''</code></td>
            <td>Single quote</td>
            <td><em>Literal</em></td>
            <td><code>'</code></td>
        </tr>
    </tbody>
</table>

The format characters `x`, `X`, and `Z` all allow the matching of any possible timezone offest, and all cause the same behavior.
{: .noteNote}

### Pattern Types   {#Presenta}

How a pattern type is interpreted for certain pattern letters
depends on the number of repeated letters in the pattern. In some cases,
as noted in the following table, other factors can influence how the
pattern is interpreted.

<table summary="Pattern types for date-time values">
    <col width="25%" />
    <col width="75%" />
    <thead>
        <tr>
            <th>Pattern Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Text</em></td>
            <td><p>The text style is determined based on the number of pattern letters used;</p>
                <ul>
                    <li>Less than 4 pattern letters will use the short form.</li>
                    <li>Exactly 4 pattern letters will use the full form.</li>
                    <li>Exactly 5 pattern letters will use the narrow form. Pattern letters <code>L</code>, <code>c</code>, and <code>q</code> specify the stand-alone form of the text styles.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>Number</em></td>
            <td><p>If the count of letters is one, then the value is parsed using the minimum number of digits and without padding. Otherwise, the count of digits is used as the width of the field, with the value zero-padded as necessary.</p>
                <p>The following pattern letters have constraints on the count of letters:</p>
                <ul>
                    <li>Only one letter of <code>c</code> and <code>F</code> can be specified.</li>
                    <li>Up to two letters of <code>d</code>, <code>H</code>, <code>h</code>, <code>K</code>, <code>k</code>, <code>m</code>, and <code>s</code> can be specified.</li>
                    <li>Up to three letters of <code>D</code> can be specified.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>Number/Text</em></td>
            <td>If the count of pattern letters is 3 or greater, use the Text rules above. Otherwise use the Number rules above.</td>
        </tr>
        <tr>
            <td><em>Fraction</em></td>
            <td>Specifying any number of fractional seconds ('S') will accept between 1 and 6 fractional seconds digits.</td>
        </tr>
        <tr>
            <td><em>Year</em></td>
            <td><p>The count of letters determines the minimum field width below which padding is used.</p>
                <ul>
                    <li>If the count of letters is two, then a reduced two digit form is used. This will parse using the base value of <code>2000</code> to <code>2099</code> inclusive.</li>
                    <li>If the count of letters is less than four (but not two), then the sign is only parsed for negative years. Otherwise, the sign is parse if the pad width is exceeded.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>ZoneId</em></td>
            <td>This specifies the time-zone ID, such as <code>Europe/Paris</code>. If the count of letters is two, then the time-zone ID is used. Any other count of letters results in a syntax error.</td>
        </tr>
        <tr>
            <td><em>Zone names</em></td>
            <td>This specifies the display name of the time-zone ID. If the count of letters is one, two or three, then the short name is used. If the count of letters is four, then the full name is used. Five or more letters results in a syntax error.</td>
        </tr>
        <tr>
            <td><em>Offset O</em></td>
            <td><p>This formats the localized offset based on the number of pattern letters.</p>
                <ul>
                    <li>One letter specifies the short form of the localized offset, which is localized offset text, such as <code>GMT</code>, with hour without leading zero, optional 2-digit minute and second if non-zero, and colon, for example <code>GMT+8</code>.</li>
                    <li>Four letters specifies the full form, which is localized offset text, such as <code>GMT</code>, with 2-digit hour and minute field, optional second field if non-zero, and colon, for example <code>GMT+08:00</code>.</li>
                    <li>Any other count of letters results in a syntax error.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>Offset Z</em></td>
            <td><p>This formats the offset based on the number of pattern letters.</p>
                <ul>
                    <li>One, two or three letters specifies the hour and minute, without a colon, such as <code>+0130</code>. This will be <code>+0000</code> when the offset is zero.</li>
                    <li>Four letters specifies the full form of localized offset, equivalent to four letters of Offset-O. This will be the corresponding localized offset text if the offset is zero.</li>
                    <li>Five letters specifies the hour, minute, with optional second if non-zero, with colon. It specifies <code>Z</code> if the offset is zero.</li>
                    <li>Six or more letters results in a syntax error.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>Optional section</em></td>
            <td>The optional section markers work exactly like calling <code>DateTimeFormatterBuilder.optionalStart()</code> and <code>DateTimeFormatterBuilder.optionalEnd()</code>.</td>
        </tr>
        <tr>
            <td><em>Pad modifier</em></td>
            <td>
                <p>Modifies the pattern that immediately follows to be padded with spaces. The pad width is determined by the number of pattern letters. This is the same as calling <code>DateTimeFormatterBuilder.padNext(int)</code>.</p>
                <p>For example, <code>ppH</code> specifies the hour-of-day padded on the left with spaces to a width of 2.</p>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <p>Any unrecognized letter is an error.</p>
                <p>Any non-letter character, other than <code>&#91;</code>, <code>&#93;</code>, <code>&#123;</code>, <code>&#125;</code>, <code>#</code> and the single quote is parsed. Despite this, it is recommended to use single quotes around all characters that you want to parse directly to ensure that future changes do not break your application.</p>
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
                <th>Example</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>"yyyy.MM.dd G 'at' HH:mm:ss z"</code></td>
                <td><span class="Example">2001.07.04 AD at 12:08:56 PDT</span></td>
            </tr>
            <tr>
                <td><code>"EEE, MMM d, ''yy"</code></td>
                <td><span class="Example">Wed, Jul 4, '01</span></td>
            </tr>
            <tr>
                <td><code>"h:mm a"</code></td>
                <td><span class="Example">12:08 PM</span></td>
            </tr>
            <tr>
                <td><code>"hh 'o''clock' a, zzzz"</code></td>
                <td><span class="Example">12 o'clock PM, Pacific Daylight Time</span></td>
            </tr>
            <tr>
                <td><code>"K:mm a, z"</code></td>
                <td><span class="Example">0:08 PM, PDT</span></td>
            </tr>
            <tr>
                <td><code>"yyyyy.MMMMM.dd GGG hh:mm aaa"</code></td>
                <td><span class="Example">02001.July.04 AD 12:08 PM</span></td>
            </tr>
            <tr>
                <td><code>"EEE, d MMM yyyy HH:mm:ss Z"</code></td>
                <td><span class="Example">Wed, 4 Jul 2001 12:08:56 -0700</span></td>
            </tr>
            <tr>
                <td><code>"yyMMddHHmmssZ"</code></td>
                <td><span class="Example">010704120856-0700</span></td>
            </tr>
            <tr>
                <td><code>"yyyy-MM-dd'T'HH:mm:ss.SSSZ"</code></td>
                <td><span class="Example">2001-07-04T12:08:56.235-0700</span></td>
            </tr>
            <tr>
                <td><code>"yyyy-MM-dd'T'HH:mm:ss.SSSXXX"</code></td>
                <td><span class="Example">2001-07-04T12:08:56.235-07:00</span></td>
            </tr>
            <tr>
                <td><code>"YYYY-'W'ww-e"</code></td>
                <td><span class="Example">2001-W27-3</span></td>
            </tr>
        </tbody>
    </table>
