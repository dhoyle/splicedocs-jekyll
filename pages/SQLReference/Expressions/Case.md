---
title: CASE Expression
summary: Syntax for and examples of CASE expressions in Splice Machine SQL.
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_case.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CASE Expression   {#Expressions.Case}

The `CASE` expression can be used for conditional expressions in Splice
Machine.

## Syntax

You can place a `CASE` expression anywhere an expression is allowed. It
chooses an expression to evaluate based on a boolean test.

<div class="fcnWrapperWide" markdown="1">
    CASE
      WHEN booleanExpression THEN thenExpression
      [ WHEN booleanExpression
        THEN thenExpression ]...
        ELSE elseExpression
    END
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
*thenExpression* and *elseExpression*
{: .paramName}

Both are both that must be type-compatible. For built-in types, this
means that the types must be the same or a built-in broadening
conversion must exist between the types.
{: .paramDefnFirst}

</div>
## Example

<div class="preWrapper" markdown="1">
       -- returns 3
     CASE WHEN 1=1 THEN 3 ELSE 4 END;
    
      -- returns 7
     CASE
       WHEN 1 = 2 THEN 3
       WHEN 4 = 5 THEN 6
       ELSE 7
     END;
{: .Example xml:space="preserve"}

</div>
</div>
</section>

