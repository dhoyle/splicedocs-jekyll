---
title: CASE Expression
summary: Syntax for and examples of CASE expressions in Splice Machine SQL.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_expressions_case.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CASE Expression

The `CASE` expression can be used for conditional expressions in Splice
Machine.

## Syntax

You can place a `CASE` expression anywhere an expression is allowed. It
chooses an expression to evaluate based on a boolean test.

<div class="fcnWrapperWide" markdown="1">
    CASE leftExpression
      WHEN rightExpression THEN thenExpression
      [ WHEN rightExpression2 THEN thenExpression2 ]...
        ELSE elseExpression
    END
{: .FcnSyntax xml:space="preserve"}
</div>

<div class="fcnWrapperWide" markdown="1">
    CASE
      WHEN leftExpression = rightExpression THEN thenExpression
      [ WHEN leftExpression = rightExpression2 THEN thenExpression2 ]...
        ELSE elseExpression
    END
{: .FcnSyntax xml:space="preserve"}
</div>

<div class="paramList" markdown="1">

leftExpression
{: .paramName}

An expression.
{: .paramDefnFirst}

thenExpression
{: .paramName}

An expression.
{: .paramDefnFirst}

elseExpression
{: .paramName}

An expression.
{: .paramDefnFirst}

term
{: .paramName}

An expression to be matched.
{: .paramDefnFirst}
</div>

## Usage

In both forms of the `CASE` expression, the following must be true:

* _thenExpression_ and _elseExpression_ must be type compatible.
* _leftExpression_ and _rightExpression_ must be type compatible.

Note that any of the expressions can be a sub-select expression, as shown in the final example, below.

## Examples


<div class="preWrapper" markdown="1">
    splice> CREATE TABLE t (c INT);
    splice> INSERT INTO t VALUES 5,6,6,78;
    splice> CREATE TABLE y (c INT);
    splice> INSERT INTO y VALUES 1,2,3,4;
    splice> SELECT CASE MOD(c,2) WHEN 0 THEN (SELECT COUNT(*) FROM y) ELSE 0 END FROM t;
    1
    --------------------
    4
    0
    4
    4

    4 rows selected


    splice> SELECT CASE WHEN 1=1 then 99 ELSE 0 END FROM t;
    1
    -----------
    99
    99
    99
    99

    4 rows selected
{: .Example xml:space="preserve"}
</div>

</div>
</section>
