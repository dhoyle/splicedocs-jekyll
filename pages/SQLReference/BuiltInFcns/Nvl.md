---
title: NVL built-in SQL function
summary: Built-in SQL function that returns its first non-null argument. VALUE is a synonym for NVL in Splice Machine.
keywords: non-null
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_nvl.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NVL

The `NVL` function returns the first non-`NULL` expression from a
list of expressions.

You can also use `NVL` as a variety of a `CASE` expression. For
example:

<div class="preWrapperWide" markdown="1">
    NVL( expresssion_1, expression_2,...expression_n);
{: .Example xml:space="preserve"}

</div>
is equivalent to:

<div class="preWrapperWide" markdown="1">
    CASE WHEN expression_1 IS NOT NULL THEN expression_1
       ELSE WHEN expression_1 IS NOT NULL THEN expression_2
     ...
       ELSE expression_n;
{: .Example xml:space="preserve"}

</div>
## Syntax

<div class="fcnWrapperWide" markdown="1">
    NVL ( expression1, expression2 [, expressionN]* )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression1
{: .paramName}

An expression.
{: .paramDefnFirst}

expression1
{: .paramName}

An expression.
{: .paramDefnFirst}

expressionN
{: .paramName}

You can specify more than two arguments; **you MUST specify at least two
arguments**.
{: .paramDefnFirst}

</div>
## Usage

`VALUE` is a synonym for `NVL` that is accepted by Splice Machine,
but is not recognized by the SQL standard.

## Results

The result is `NULL` only if all of the arguments are `NULL`.

An error occurs if all of the parameters of the function call are
dynamic.

## Example

<div class="preWrapperWide" markdown="1">

       -- create table with three different integer types
    splice> SELECT ID, FldGames, PassedBalls, WildPitches, Pickoffs,
       NVL(PassedBalls, WildPitches, Pickoffs) as "FirstNonNull"
       FROM Fielding
       WHERE FldGames>50
       ORDER BY ID;
    ID    |FLDGA&|PASSE&|WILDP&|PICKO&|First&
    -----------------------------------------
    1     |142   |4     |20    |0     |4
    2     |131   |NULL  |NULL  |NULL  |NULL
    3     |99    |NULL  |NULL  |NULL  |NULL
    4     |140   |NULL  |NULL  |NULL  |NULL
    5     |142   |NULL  |NULL  |NULL  |NULL
    6     |88    |NULL  |NULL  |NULL  |NULL
    7     |124   |NULL  |NULL  |NULL  |NULL
    8     |51    |NULL  |NULL  |NULL  |NULL
    9     |93    |NULL  |NULL  |NULL  |NULL
    10    |79    |NULL  |NULL  |NULL  |NULL
    39    |73    |NULL  |NULL  |0     |0
    40    |52    |NULL  |NULL  |0     |0
    41    |70    |NULL  |NULL  |2     |2
    42    |55    |NULL  |NULL  |0     |0
    43    |77    |NULL  |NULL  |0     |0
    46    |67    |NULL  |NULL  |0     |0
    49    |134   |4     |34    |2     |4
    50    |119   |NULL  |NULL  |NULL  |NULL
    51    |147   |NULL  |NULL  |NULL  |NULL
    52    |148   |NULL  |NULL  |NULL  |NULL
    53    |152   |NULL  |NULL  |NULL  |NULL
    54    |64    |NULL  |NULL  |NULL  |NULL
    55    |93    |NULL  |NULL  |NULL  |NULL
    56    |147   |NULL  |NULL  |NULL  |NULL
    57    |85    |NULL  |NULL  |NULL  |NULL
    58    |62    |NULL  |NULL  |NULL  |NULL
    59    |64    |NULL  |NULL  |NULL  |NULL
    62    |53    |1     |11    |0     |1
    64    |59    |NULL  |NULL  |NULL  |NULL
    81    |76    |NULL  |NULL  |0     |0
    82    |71    |NULL  |NULL  |1     |1
    84    |68    |NULL  |NULL  |0     |0
    92    |81    |NULL  |NULL  |3     |3

    33 rows selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>
