---
title: STDDEV_POP built-in SQL Function
summary: Built-in SQL function that computes population standard deviation.
keywords: population, standard deviation, DISTINCT
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_stddevpop.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# STDDEV_POP

The `STDDEV_POP()` function returns the population standard deviation of
a set of numeric values.

It returns `NULL` if no matching row is found.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    STDDEV_POP ( [ DISTINCT | ALL ] expression )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
DISTINCT
{: .paramName}

If this qualifier is specified, duplicates are eliminated
{: .paramDefnFirst}

ALL
{: .paramName}

If this qualifier is specified, all duplicates are retained. This is the
default value.
{: .paramDefnFirst}

expression
{: .paramName}

An expression that evaluates to a numeric data
type: [`SMALLINT`](sqlref_builtinfcns_smallint.html).
{: .paramDefnFirst}

The expression can contain multiple column references or expressions,
but it cannot contain another aggregate or subquery, and it must
evaluate to an ANSI SQL numeric data type. This means that you can call
methods that evaluate to ANSI SQL data types.
{: .paramDefn}

If an expression evaluates to `NULL`, the aggregate skips that value.
{: .paramDefn}

</div>
## Results

This function returns a double-precision number.

If the input expression consists of a single value, the result of the
function is `NULL`, not `0`.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Example

The following example shows computing the average, population standard
deviation, and sample standard deviation from our Salaries table:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SELECT AVG(Salary) as AvgSalary, STDDEV_POP(Salary) AS PopStdDev, STDDEV_SAMP(Salary) As SampStdDev FROM Salaries;
    AVGSALARY           |POPSTDDEV             |SAMPSTDDEV
    ------------------------------------------------------------------
    2949737             |4694155.715951055     |4719325.63212163
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

