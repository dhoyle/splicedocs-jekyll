---
title: DECFLOAT built-in SQL function
summary: Built-in SQL function that returns a decimal floating-point representation of a value of a different data type. representation of a value
keywords: convert to decimal floating-point
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_decfloat.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DECFLOAT

The `DECFLOAT` function returns a decimal floating-point representation of a value of a different data type.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DECFLOAT ( NumericExpression | StringExpression | DecimalCharacter )
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
NumericExpression
{: .paramName}

An expression that returns a value of any built-in numeric data type.
{: .paramDefnFirst}

StringExpression
{: .paramName}

An expression that returns a value that is a character-string or Unicode graphic-string representation of a number with a length not greater than the maximum length of a character constant. The data type of string-expression must not be CLOB or DBCLOB (SQLSTATE 42884). Leading and trailing blanks are removed from the string. The resulting substring is folded to uppercase and must conform to the rules for forming an integer, decimal, floating-point, or decimal floating-point constant (SQLSTATE 22018) and not be greater than 42 bytes (SQLSTATE 42820).
{: .paramDefnFirst}

DecimalCharacter
{: .paramName}

Specifies the single-byte character constant used to delimit the decimal digits in the character expression from the whole part of the number. The character cannot be a digit, plus (+), minus (-), or blank, and it can appear at most once in the character expression.
{: .paramDefnFirst}

</div>
## Results

The result is the same number that would result from CAST(StringExpression AS DECFLOAT) or CAST(NumericExpression AS DECFLOAT). Leading and trailing blanks are removed from the string.

The result of the function is a decimal floating-point number with the implicitly or explicitly specified number of digits of precision. If the first argument can be null, the result can be null; if the first argument is null, the result is the null value.

If necessary, the source is rounded to the precision of the target. The CURRENT DECFLOAT ROUNDING MODE special register determines the rounding mode.

## Example

Use the DECFLOAT function in order to force a DECFLOAT data type to be returned in a select-list for the EDLEVEL column (data type = SMALLINT) in the EMPLOYEE table. The EMPNO column should also appear in the select list.

<div class="preWrapper" markdown="1">
    SELECT EMPNO, DECFLOAT(EDLEVEL)
    FROM EMPLOYEE
{: .Example xml:space="preserve"}

</div>

## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)

</div>
</section>
