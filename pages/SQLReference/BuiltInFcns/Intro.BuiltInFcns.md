---
title: Built-in SQL functions in Splice Machine
summary: Summary of built-in SQL functions in Splice Machine
keywords: built-in functions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_intro.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Built-in SQL Functions

This section contains the reference documentation for the SQL Functions
that are built into Splice Machine, which are grouped into the following
subsections:

* [Conversion Functions](#conversion)
* [Current Session Functions](#session)
* [Date and Time Functions](#datetime)
* [Miscellaneous Functions](#misc)
* [Numeric Functions](#numeric)
* [String Functions](#string)
* [Trigonometric Functions](#trig)
* [Window and Aggregate Functions](#window)

## Conversion Functions  {#conversion}

These are the built-in conversion functions:

<table summary="Summary of built-in conversion functions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_bigint.html">BIGINT</a></td>
            <td>Returns a 64-bit integer representation of a number or character string in the form of an integer constant.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_cast.html">CAST</a></td>
            <td>Converts a value from one data type to another and provides a data type to a dynamic parameter (?) or a NULL value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_char.html">CHAR</a></td>
            <td>Returns a fixed-length character string representation.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_double.html">DOUBLE</a></td>
            <td>Returns a floating-point number</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_integer.html">INTEGER</a></td>
            <td>Returns an integer representation of a number or character string in the form of an integer constant.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_smallint.html">SMALLINT</a></td>
            <td>Returns a small integer representation of a number or character string in the form of a small integer constant.    </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_tinyint.html">TINYINT</a></td>
            <td>Returns a tiny integer representation of a number or character string in the form of a tiny integer constant.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_char.html">TO_CHAR</a></td>
            <td>Formats a date value into a string.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_date.html">TO_DATE</a></td>
            <td>Formats a date string according to a formatting specification, and returns a date value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_char.html">VARCHAR</a></td>
            <td>Returns a varying-length character string representation of a character string.</td>
        </tr>
    </tbody>
</table>

## Current Session Functions  {#session}

These are the built-in current session functions:

<table summary="Summary of Splice Machine SQL Built-in Session Functions.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currentrole.html">CURRENT_ROLE</a>
            </td>
            <td>Returns a list of role names for the current user.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currentschema.html">CURRENT SCHEMA</a>
            </td>
            <td>
            Returns the schema name used to qualify unqualified database object references.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currentuser.html">CURRENT_USER</a>
            </td>
            <td>Depending on context, returns the authorization identifier of either the user who created the SQL session or the owner of the schema.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_groupuser.html">GROUP_USER</a>
            </td>
            <td>Returns the groups to which the current user belongs.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_sessionuser.html">SESSION_USER</a>
            </td>
            <td>Depending on context, returns the authorization identifier of either the user who created the SQL session or the owner of the schema.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_user.html">USER</a>
            </td>
            <td>Depending on context, returns the authorization identifier of either the user who created the SQL session or the owner of the schema.</td>
        </tr>
    </tbody>
</table>

## Date and Time Functions  {#datetime}

These are the built-in date and time functions:

<table summary="Summary of Splice Machine SQL Built-in Date and Time functions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_addmonths.html">ADD_MONTHS</a>
            </td>
            <td>Returns the date resulting from adding a number of months added to a specified date.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currentdate.html">CURRENT_DATE</a>
            </td>
            <td>
            Returns the current date.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currenttime.html">CURRENT_TIME</a>
            </td>
            <td>
            Returns the current time;
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_currenttimestamp.html">CURRENT_TIMESTAMP</a>
            </td>
            <td>
            Returns the current timestamp;
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_date.html">DATE</a>
            </td>
            <td>
            Returns a date from a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_day.html">DAY</a>
            </td>
            <td>
            Returns the day part of a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_extract.html">EXTRACT</a>
            </td>
            <td>Extracts various date and time components from a date expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_hour.html">HOUR</a>
            </td>
            <td>
            Returns the hour part of a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_day.html">LAST_DAY</a>
            </td>
            <td>Returns the date of the last day of the specified month.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_minute.html">MINUTE</a>
            </td>
            <td>
            Returns the minute part of a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_month.html">MONTH</a>
            </td>
            <td>
            Returns the numeric month part of a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_monthbetween.html">MONTH_BETWEEN</a>
            </td>
            <td>Returns the number of months between two dates.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_monthname.html">MONTHNAME</a>
            </td>
            <td>
            Returns the string month part of a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_day.html">NEXT_DAY</a>
            </td>
            <td>Returns the date of the next specified day of the week after a specified date. </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_now.html">NOW</a>
            </td>
            <td>Returns the current date and time as a timestamp value. </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_quarter.html">QUARTER</a>
            </td>
            <td>
            Returns the quarter number (1-4) from a date expression.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_second.html">SECOND</a>
            </td>
            <td>
            Returns the seconds part of a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_time.html">TIME</a>
            </td>
            <td>
            Returns a time from a value.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_timestamp.html">TIMESTAMP</a>
            </td>
            <td>
            Returns a timestamp from a value or a pair of values.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_timestampadd.html">TIMESTAMPADD</a>
            </td>
            <td>Adds the value of an interval to a timestamp value and returns the sum as a new timestamp</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_timestampdiff.html">TIMESTAMPDIFF</a>
            </td>
            <td>Finds the difference between two timestamps, in terms of the specfied interval.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_char.html">TO_CHAR</a>
            </td>
            <td>Formats a date value into a string.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_date.html">TO_DATE</a>
            </td>
            <td>Formats a date string according to a formatting specification, and returns a date value.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_truncate.html">TRUNC <span class="bodyFont">or</span> TRUNCATE</a>
            </td>
            <td>Truncates numeric, date, and timestamp values.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_week.html">WEEK</a>
            </td>
            <td>
            Returns the year part of a value.
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_year.html">YEAR</a>
            </td>
            <td>
            Returns the year part of a value.
            </td>
        </tr>
    </tbody>
</table>

## Miscellaneous Functions  {#misc}

These are the built-in miscellaneous functions:

<table summary="Summary of Splice Machine SQL Miscellaneous Functions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_coalesce.html">COALESCE</a>
            </td>
            <td>
            Takes two or more compatible arguments and Returns the first argument that is not null.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_nullif.html">NULLIF</a>
            </td>
            <td>
            Returns NULL if the two arguments are equal, and it Returns the first argument if they are not equal.
        </td>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_nvl.html">NVL</a>
            </td>
            <td>
            Takes two or more compatible arguments and Returns the first argument that is not null.
        </td>
        </tr>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_rownumber.html">ROWID</a>
            </td>
            <td>A <em>pseudocolumn</em> that uniquely defines a single row in a database table. </td>
        </tr>
    </tbody>
</table>

## Numeric Functions  {#numeric}

These are the built-in numeric functions:

<table summary="Summary of Splice Machine SQL Numeric Functions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_abs.html">ABS <span class="bodyFont">or</span> ABSVAL</a></td>
            <td>Returns the absolute value of a numeric expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_ceil.html">CEIL <span class="bodyFont">or</span> CEILING</a></td>
            <td>Round the specified number up, and return the smallest number that is greater than or equal to the specified number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_exp.html">EXP</a></td>
            <td>Returns <em>e</em> raised to the power of the specified number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_floor.html">FLOOR</a></td>
            <td>Rounds the specified number down, and Returns the largest number that is less than or equal to the specified number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_ln.html">LN <span class="bodyFont">or</span> LOG</a></td>
            <td>Return the natural logarithm (base e) of the specified number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_log10.html">LOG10</a></td>
            <td>Returns the base-10 logarithm of the specified number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_mod.html">MOD</a></td>
            <td>Returns the remainder (modulus) of one number divided by another.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_rand.html">RAND</a></td>
            <td>Returns a random number given a seed number</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_random.html">RANDOM</a></td>
            <td>Returns a random number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_round.html">ROUND</a></td>
            <td>Rounds the specified number to the specified number of decimal places.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_sign.html">SIGN</a></td>
            <td>Returns the sign of the specified number.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_sqrt.html">SQRT</a></td>
            <td>Returns the square root of a floating point number; </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_truncate.html">TRUNC <span class="bodyFont">or</span> TRUNCATE</a></td>
            <td>Truncates numeric, date, and timestamp values.</td>
        </tr>
    </tbody>
</table>

## String Functions  {#string}

These are the built-in string functions:

<table summary="Summary of Splice Machine SQL String Functions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_concat.html">Concatenate</a>
            </td>
            <td>Concatenates a character string value onto the end of another character string. Can also be used on bit string values.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_initcap.html">INITCAP</a>
            </td>
            <td>Converts the first letter of each word in a string to uppercase, and converts any remaining characters in each word to lowercase.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_instr.html">INSTR</a>
            </td>
            <td>Returns the index of the first occurrence of a substring in a string.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_lcase.html">LCASE <span class="bodyFont">or</span> LOWER</a>
            </td>
            <td>
            Takes a character expression as a parameter and Returns a string in which all alpha characters have been converted to lowercase.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_length.html">LENGTH</a>
            </td>
            <td>
            Applied to either a character string expression or a bit string expression and Returns the number of characters in the result.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_locate.html">LOCATE</a>
            </td>
            <td>
            Used to search for a string within another string. 
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_ltrim.html">LTRIM</a>
            </td>
            <td>
            Removes blanks from the beginning of a character string expression.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_regexplike.html">REGEXP_LIKE</a>
            </td>
            <td>Returns true if a string matches a regular expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_repeat.html">REPEAT</a>
            </td>
            <td>Returns a string by concatenating a specified string onto itself a specified number of times.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_replace.html">REPLACE</a>
            </td>
            <td>Replaces all occurrences of a substring with another substring</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_rtrim.html">RTRIM</a>
            </td>
            <td>Removes blanks from the end of a character string expression.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_substr.html">SUBSTR</a>
            </td>
            <td>
            Return a portion of string beginning at the specified position for the number of characters specified or rest of the string.
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_trim.html">TRIM</a>
            </td>
            <td>
            Takes a character expression and Returns that expression with leading and/or trailing pad characters removed. 
        </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_ucase.html">UCASE <span class="bodyFont">or</span> UPPER</a>
            </td>
            <td>
            Takes a character expression as a parameter and Returns a string in which all alpha characters have been converted to uppercase.
        </td>
        </tr>
    </tbody>
</table>

## Trigonometric Functions  {#trig}

These are the built-in trigonometric functions:

<table summary="Summary of  Splice Machine SQL Trigonometric Functions">
                <col />
                <col />
                <tr>
                    <th>
                    Function Name
                </th>
                    <th>
                    Description
                </th>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_acos.html">ACOS</a>
                    </td>
                    <td>Returns the arc cosine of a specified number.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_asin.html">ASIN</a>
                    </td>
                    <td>Returns the arc sine of a specified number.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_atan.html">ATAN</a>
                    </td>
                    <td>Returns the arc tangent of a specified number.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_atan2.html">ATAN2</a>
                    </td>
                    <td>Returns the arctangent, in radians, of the quotient of the two arguments.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_cos.html">COS</a>
                    </td>
                    <td>
                    Returns the cosine of a specified number.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_cosh.html">COSH</a>
                    </td>
                    <td>
                    Returns the hyperbolic cosine of a specified number.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_cot.html">COT</a>
                    </td>
                    <td>
                    Returns the cotangens of a specified number.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_degrees.html">DEGREES</a>
                    </td>
                    <td>
                    Converts a specified number from radians to degrees.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_pi.html">PI</a>
                    </td>
                    <td>
                    Returns a value that is closer than any other value to pi.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_radians.html">RADIANS</a>
                    </td>
                    <td>
                    Converts a specified number from degrees to radians.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_sin.html">SIN</a>
                    </td>
                    <td>
                    Returns the sine of a specified number.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_sinh.html">SINH</a>
                    </td>
                    <td>
                    Returns the hyperbolic sine of a specified number.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_tan.html">TAN</a>
                    </td>
                    <td>
                    Returns the tangent of a specified number.
                </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_builtinfcns_tanh.html">TANH</a>
                    </td>
                    <td>
                    Returns the hyperbolic tangent of a specified number
                </td>
                </tr>
            </table>

## Window and Aggregate Functions  {#window}

These are the built-in window and aggregate functions: 

<table summary="Summary of Splice Machine SQL Window and Aggregate Functions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="sqlref_builtinfcns_avg.html"><code>AVG</code></a>
            </td>
            <td>Returns the average computed over a subset (partition) of a table.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_count.html"><code>COUNT</code></a>
            </td>
            <td>Returns the number of rows in a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_denserank.html"><code>DENSE_RANK</code></a>
            </td>
            <td>Returns the ranking of a row within a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_firstvalue.html"><code>FIRST_VALUE</code></a>
            </td>
            <td>Returns the first value within  a partition..</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_lag.html"><code>LAG</code></a>
            </td>
            <td>Returns the value of an expression evaluated at a specified offset number of rows <em>before</em> the current row in a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_lastvalue.html"><code>LAST_VALUE</code></a>
            </td>
            <td>Returns the last value within a partition..</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_lead.html"><code>LEAD</code></a>
            </td>
            <td>Returns the value of an expression evaluated at a specified offset number of rows <em>after</em> the current row in a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_max.html"><code>MAX</code></a>
            </td>
            <td>Returns the maximum value computed over a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_min.html"><code>MIN</code></a>
            </td>
            <td>Returns the minimum value computed over a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_rank.html"><code>RANK</code></a>
            </td>
            <td>Returns the ranking of a row within a subset of a table.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_rownumber.html"><code>ROW_NUMBER</code></a>
            </td>
            <td>Returns the row number of a row within a partition.</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_stddevpop.html"><code>STDDEV_POP</code></a>
            </td>
            <td>Returns the population standard deviation of a set of numeric values</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_stddevsamp.html"><code>STDDEV_SAMP</code></a>
            </td>
            <td>Returns the sample standard deviation of a set of numeric values</td>
        </tr>
        <tr>
            <td><a href="sqlref_builtinfcns_sum.html"><code>SUM</code></a>
            </td>
            <td>Returns the sum of a value calculated over a partition.</td>
        </tr>
    </tbody>
</table>

{% include splice_snippets/githublink.html %}
</div>
</section>
