---
title: REPEAT built-in SQL function
summary: Built-in SQL function that generates a character string by repeating a string value a specified number of times.
keywords: repeat
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_repeat.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# REPEAT

The `REPEAT` function returns a string created by concatenating a character string value a specified number of times.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    REPEAT ( stringToRepeat, numOfRepeats )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
stringToRepeat
{: .paramName}

An expression that specifies the string to be repeated. The expression must represent a value that is of type `CHAR`, `VARCHAR`, or `LONG VARCHAR`.
{: .paramDefnFirst}

If this value is `null`, the `REPEAT` function returns `null`.
{: .paramDefn}

numOfRepeats
{: .paramName}

A non-negative integer value that specifies the number of times to concatenate `stringToRepeat` to form the resulting value.
{: .paramDefnFirst}

If this value is `0` and `stringToRepeat` is non-null, then the `REPEAT` function returns the empty string.
{: .paramDefn}

</div>

## Results

The data type of the result is the same as the type of the `stringToRepeat` argument. The width of the resuls is calculated as follows:

* If `numOfRepeats` is a known constant at bind time, the width of the result is:
  <div class="indented" markdown="1">
     (maxWidth of `stringToRepeat`) * `numOfRepeats`
  </div>

* If `numOfRepeats` is an expression whose value is either dynamic or unknown at bind time (e.g. a parameter), the width of the result is:
  <div class="indented" markdown="1">
     The maximum possible width of the type of the `stringToRepeat` argument.
  </div>

## Examples

We create a simple table for the examples in this section:
```
splice> CREATE TABLE t1 (a1 CHAR(5), b1 VARCHAR(5), c1 INT);
0 rows inserted/updated/deleted

splice> INSERT INTO t1 VALUES ('aaa', 'aaa', 3), ('bbbb', 'bbbb', 4);
2 rows inserted/updated/deleted
```
{: .Example}


#### Example 1: Repeat Count is a Constant

```
splice> select repeat(a1, 3) from t1;
----------------------------------------------------
aaa  aaa  aaa
bbbb bbbb bbbb

2 rows selected
```
{: .Example}

#### Example 2: Repeat Count is Parameterized

```
prepare q1 as 'select repeat(a1, ?) from t1';
splice> execute q1 using 'values (3)';
1
----------------------------------------------------
aaa  aaa  aaa
bbbb bbbb bbbb

2 rows selected
```
{: .Example}

#### Example 3: Both Arguments are Expressions

```
splice> select repeat('-' || a1 || b1 || '-', c1) from t1;
1
----------------------------------------------------
-aaa  aaa--aaa  aaa--aaa  aaa-
-bbbb bbbb--bbbb bbbb--bbbb bbbb--bbbb bbbb-

2 rows selected
```
{: .Example}

</div>
</section>
