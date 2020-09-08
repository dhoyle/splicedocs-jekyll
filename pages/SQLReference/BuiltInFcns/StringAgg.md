---
title: STRING_AGG built-in SQL function
summary: Built-in SQL function that concatenates multiple values into a single string value
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_stringagg.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# STRING_AGG

The `STRING_AGG` function concatenates multiple values into a single string value.

`STRING_AGG` takes an expression and a literal string (the separator) and aggregates the values returned by the expression into a single concatenated string of values separated by the specified separator.

`STRING_AGG` can be used anywhere an aggregate can be used (scalar aggregate, grouped aggregate, and window functions).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    STRING_AGG(expression,separator)
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="paramList" markdown="1">
expression
{: .paramName}

The expression for the values that will be concatenated.
{: .paramDefnFirst}

separator
{: .paramName}

The separator for the concatenated values.
{: .paramDefnFirst}



</div>

## Results

A concatenated string of the values returned by the expression, separated by the specified separator.


## Examples

For the following Products table:

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td><b>item_id</b></td>
            <td><b>item_name</b></td>
        </tr>
        <tr>
            <td>1</td>
            <td>Shirt A</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Shirt B</td>
        </tr>
    </tbody>
</table>

And the Stores table:

<table>
    <col />
    <col />
    <col />
    <tbody>
        <tr>
            <td><b>item_id</b></td>
            <td><b>item_name</b></td>
            <td><b>state_code</b></td>
        </tr>
        <tr>
            <td>1</td>
            <td>1</td>
            <td>CA</td>
        </tr>
        <tr>
            <td>2</td>
            <td>1</td>
            <td>CO</td>
        </tr>
        <tr>
            <td>3</td>
            <td>1</td>
            <td>AK</td>
        </tr>
        <tr>
            <td>4</td>
            <td>2</td>
            <td>GA</td>
        </tr>
        <tr>
            <td>5</td>
            <td>2</td>
            <td>AZ</td>
        </tr>
        <tr>
            <td>6</td>
            <td>2</td>
            <td>TX</td>
        </tr>
    </tbody>
</table>

Return a result where `state_code` is concatenated into single strings as follows:

<table>
    <col />
    <col />
    <col />
    <tbody>
        <tr>
            <td><b>item_id</b></td>
            <td><b>item_name</b></td>
            <td><b>state_code</b></td>
        </tr>
        <tr>
            <td>1</td>
            <td>Shirt A</td>
            <td>CA,CO,AK</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Shirt B</td>
            <td>GA,AZ,TX</td>
        </tr>
    </tbody>
</table>

<div class="preWrapper" markdown="1">
    SELECT
        [item_id],
        STRING_AGG([state_code], ', ') AS state_code
    FROM
        stores
    GROUP BY
        item_id;
{: .Example xml:space="preserve"}

</div>

Currently the ORDER BY clause is not supported, but you can simulate the ORDER BY clause using window funtions. For example:

<div class="preWrapper" markdown="1">
    create table b (i int, v varchar(10));

    select i, string_agg(v, ',' order by v) from b group by i; -- this doesn’t work

    select i, agg from (
    select i,
    lead(i) over (partition by i order by v asc) as l,
    string_agg(v, ',') over (partition by i order by v asc) as agg
    ) b where l is null;
{: .Example xml:space="preserve"}

</div>

Note that in the example above, the window function does not work properly if the grouping column has NULL values.


## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [Concatenation](sqlref_builtinfcns_concat.html) operator
* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`GROUPING`](sqlref_builtinfcns_grouping.html) function
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LOCATE`](sqlref_builtinfcns_locate.html) function
* [`MAX`](sqlref_builtinfcns_max.html) function
* [`MIN`](sqlref_builtinfcns_min.html) function
* [`REGEX_LIKE`](sqlref_builtinfcns_regexplike.html) operator
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`STDDEV_POP`](sqlref_builtinfcns_stddevpop.html) function
* [`STDDEV_SAMP`](sqlref_builtinfcns_stddevsamp.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function
* [`VARCHAR`](sqlref_builtinfcns_varchar.html) function


</div>
</section>
