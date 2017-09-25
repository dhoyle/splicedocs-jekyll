---
title: TRUNCATE (or TRUNC) built-in SQL function
summary: Built-in SQL function that truncates numeric, DATE,  and TIMESTAMP values.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_truncate.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# TRUNC or TRUNCATE

This topic describes the `TRUNCATE` built-in function, which you can use
to truncate numeric, date, and timestamp values. You can use the
abbreviation `TRUNC` interchangeably with the full name, `TRUNCATE`.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    TRUNCATE( number    [, numPlaces]  |
              date      [, truncPoint] |
              timestamp [, truncPoint] );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

An integer or decimal number to be truncated.
{: .paramDefnFirst}

date
{: .paramName}

A [`DATE`](sqlref_builtinfcns_date.html) value to be truncated.
{: .paramDefnFirst}

timestamp
{: .paramName}

A [`TIMESTAMP`](sqlref_builtinfcns_timestamp.html) value to be
truncated.
{: .paramDefnFirst}

numPlaces
{: .paramName}

An optional integer value that specifies the number of digits to
truncate (made zero) when applying this function to a *number*.
{: .paramDefnFirst}

* If this value is positive, that many of the least significant digits
  (to the right of the decimal point) are truncated:
  `truncate(123.456,2)` returns `123.450`.
* If this value is negative, that many of the least significant digits
  to the left of the decimal point are truncated:
  `truncate(123.456,-1)` returns `120.000`.
* If this value is zero, the decimal portion of the number is truncated:
  `truncate(123.456,0)` returns `123.000`.
* If this value is not specified, the decimal portion of the number is
  zero'ed, which means that `truncate(123.456)` returns `123.000`.

See the [Truncating Numbers](#Truncati) examples below.

truncPoint
{: .paramName}

An optional string that specifies the point at which to truncate
(zero) a date or timestamp value. This can be one of the following
values:
{: .paramDefnFirst}

<div class="paramList" markdown="1">
`YEAR` or `YR`
{: .paramName}

The year value is retained; other values are set to their minimum
values.
{: .paramDefnFirst}

`MONTH` or `MON` or `MO`
{: .paramName}

The year and month values are retained; other values are set to their
minimum values.
{: .paramDefnFirst}

`DAY`
{: .paramName}

The year, month, and day values are retained; other values are set to
their minimum values.
{: .paramDefnFirst}

`HOUR `or `HR`
{: .paramName}

The year, month, day, and hour values are retained; other values are set
to their minimum values.
{: .paramDefnFirst}

`MINUTE `or `MIN`
{: .paramName}

The year, month, day, hour, and minute values are retained; other values
are set to their minimum values.
{: .paramDefnFirst}

`SECOND `or `SEC`
{: .paramName}

The year, month, day, hour, minute, and second values are retained; the
milliseconds value is set to `0`.
{: .paramDefnFirst}

`MILLISECOND` or `MILLI`
{: .paramName}

All of the values, including year, month, day, hour, minute, second, and
milliseconds are retained.
{: .paramDefnFirst}

</div>
The default value, if nothing is specified, is `DAY`.
{: .paramDefn}

</div>
## Examples

### Truncating Numbers   {#Truncati}

<div class="preWrapper" markdown="1">
    splice> VALUES TRUNC(1234.456, 2);
    1
    ----------------------
    1234.450
    
    splice> VALUES TRUNCATE(123.456,-1);
    1
    ----------------------
    120.000
    
    splice> VALUES TRUNCATE(123.456,0);
    1
    ----------------------
    123.000
    
    splice> VALUES TRUNCATE(123.456);
    1
    ----------------------
    123.000
    
    splice> VALUES TRUNC(1234.456, 2);
    1
    ----------------------
    1234.450
    
    splice> VALUES TRUNCATE(123.456,-1);
    1
    ----------------------
    120.000
    
    splice> VALUES TRUNCATE(123.456,0);
    1
    ----------------------
    123.000
    1 row selected
    
    splice> VALUES TRUNCATE(123.456);
    1
    ----------------------
    123.000
    
    VALUES TRUNCATE(1234.6789, 1);
    -----------------------
    12345.6000
    
    VALUES TRUNCATE(12345.6789, 2);
    -----------------------
    12345.6700
    
    VALUES TRUNCATE(12345.6789, -1);
    -----------------------
    12340.0000
    
    VALUES TRUNCATE(12345.6789, 0);
    -----------------------
    12345.0000
    
    VALUES TRUNCATE(12345.6789);
    -----------------------
    12345.0000
{: .Example xml:space="preserve"}

</div>
### Truncating Dates

<div class="preWrapper" markdown="1">
    
    VALUES TRUNCATE(DATE('1988-12-26'), 'year');
    ----------------------
    1988-01-01
    
    VALUES TRUNCATE(DATE('1988-12-26'), 'month');
    ----------------------
    1988-12-01
    
    VALUES TRUNCATE(DATE('1988-12-26'), 'day');
    ----------------------
    1988-12-26
    
    VALUES TRUNCATE(DATE('1988-12-26'));
    ----------------------
    1988-12-26
    
    VALUES TRUNCATE(DATE('2011-12-26'), 'MONTH');
    ----------------------
    2011-12-01
{: .Example xml:space="preserve"}

</div>
### Truncating Timestamps

<div class="preWrapper" markdown="1">
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'year');
    ----------------------
    2000-01-01 00:00:00.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'month');
    ----------------------
    2000-06-01 00:00:00.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'day');
    ----------------------
    2000-06-07 00:00:00.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'hour');
    ----------------------
    2000-06-07 17:00:00.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'minute');
    ----------------------
    2000-06-07 17:12:00.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'second');
    ----------------------
    2000-06-07 17:12:30.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'), 'MONTH');
    ----------------------
    2011-12-01 00:00:00.0
    
    VALUES TRUNCATE(TIMESTAMP('2000-06-07 17:12:30.0'));
    ----------------------
    2011-12-26 00:00:00.0
{: .Example xml:space="preserve"}

</div>
</div>
</section>

