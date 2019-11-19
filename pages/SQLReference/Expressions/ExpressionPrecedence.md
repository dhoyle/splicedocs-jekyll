---
title: Expression Precedence
summary: Specifies operator precedence in Splice Machine SQL expressions.
keywords:  constant, null, scalar subquery, unary, concatenation, binary, operators, operator precedence, comparison, quantified comparisons, logical, parentheses
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_expressions_precedence.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Expression Precedence

The precedence of operations from highest to lowest is:

* `(), ?,` Constant (including sign), `NULL`, *ColumnReference*,
  *ScalarSubquery*, `CAST`
* `LENGTH, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP`, and other
  built-ins
* unary `+` and `-`
* `*, /, ||` (concatenation)
* binary `+` and `-`
* comparisons, quantified comparisons, `EXISTS, IN, IS NULL, LIKE,
  BETWEEN, IS`
* `NOT`
* `AND`
* `OR`

You can explicitly specify precedence by placing expressions within
parentheses. An expression within parentheses is evaluated before any
operations outside the parentheses are applied to it.

## Example

<div class="preWrapper" markdown="1">
    (3+4)*9
    (age < 16 OR age > 65) AND employed = TRUE
{: .Example}

</div>
</div>
</section>

