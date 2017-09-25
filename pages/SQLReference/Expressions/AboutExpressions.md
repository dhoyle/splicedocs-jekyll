---
title: About Expressions in Splice Machine SQL
summary: Introduction to and summary of expression syntax and rules
keywords: expressions overview, exists, order by, update, values, where
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_about.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# About Expressions   {#Expressions.AboutExpressions}

Syntax for many statements and expressions includes the term
*Expression*, or a term for a specific kind of expression such as
<var>TableSubquery</var>. Expressions are allowed in these specified
places within statements.

Some locations allow only a specific type of expression or one with a
specific property. If not otherwise specified, an expression is
permitted anywhere the word *Expression* appears in the syntax. This
includes:

* [`ORDER BY` clause](sqlref_clauses_orderby.html)
* [`SelectExpression`](sqlref_expressions_select.html)
* [`UPDATE` statement](sqlref_statements_update.html) (SET portion)
* [`VALUES` Expression](sqlref_expressions_values.html)
* [`WHERE` clause](sqlref_clauses_where.html)

Of course, many other statements include these elements as building
blocks, and so allow expressions as part of these elements.

The following tables list all the possible SQL expressions and indicate
where the expressions are allowed.

## General Expressions

General expressions are expressions that might result in a value of any
type. The following table lists the types of general expressions.

<table summary="Types of general expressions in Splice Machine SQL">
                <col />
                <col />
                <thead>
                    <tr>
                        <th style="vertical-align:top"><strong>Expression Type</strong>
                        </th>
                        <th style="vertical-align:top"><strong>Explanation</strong>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="vertical-align:top">Column reference</td>
                        <td style="vertical-align:top">A <a href="sqlref_identifiers_types.html#ColumnName"><var>column-Name</var></a> that 					references the value of the column made visible to the expression containing the Column reference.
					<p>You must qualify the <var>column-Name</var> by the table name or correlation name if it is ambiguous.</p><p>The qualifier of a <var>column-Name</var> must be the correlation name, if a correlation name is given to a table that is in a <a href="sqlref_expressions_select.html"><code>SelectExpressions</code></a>, <code>UPDATE</code> statements, and the <code>WHERE</code> clauses of data manipulation statements.</p></td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top">Constant</td>
                        <td style="vertical-align:top">Most built-in data types typically have constants associated with them (as shown in the Data types section). </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top"><code>NULL</code>
                        </td>
                        <td style="vertical-align:top"><code>NULL</code> is an untyped constant representing the unknown value.
					<p>Allowed in <a href="sqlref_builtinfcns_cast.html"><code>CAST</code></a> expressions or in <code>INSERT VALUES</code> lists and <code>UPDATE SET</code> clauses. Using it in a <code>CAST</code> expression gives it a specific data type.</p></td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top">Dynamic parameter</td>
                        <td style="vertical-align:top">A dynamic parameter is a parameter to an SQL statement for which the value is not specified when the statement is created. Instead, the statement has a question mark (?) as a placeholder for each dynamic parameter. 	See <a href="sqlref_expressions_dynamicparams.html">Dynamic parameters</a>.
					<p>Dynamic parameters are permitted only in prepared statements. You must specify values for them before the prepared statement is executed. The values specified must match the types expected.</p><p>Allowed anywhere in an expression where the data type can be easily deduced. See <a href="sqlref_expressions_dynamicparams.html">Dynamic parameters</a>.</p></td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top"><code>CAST</code> expression</td>
                        <td style="vertical-align:top">Allows you to specify the type of NULL or of a dynamic parameter or convert a value to another type. See <a href="sqlref_builtinfcns_cast.html"><code>CAST</code> function</a>.</td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top">Scalar subquery</td>
                        <td style="vertical-align:top">Subquery that returns a single row with a single column. See <em><a href="sqlref_queries_scalarsubquery.html">ScalarSubquery</a>.</em></td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top">Table subquerry</td>
                        <td style="vertical-align:top">Subquery that returns more than one column and more than one row. See <em><a href="sqlref_queries_tablesubquery.html">TableSubquery</a>.</em><p>Allowed as a tableExpression in a FROM clause and with EXISTS, IN, and quantified comparisons.</p></td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top">Conditional expression</td>
                        <td style="vertical-align:top">A conditional expression chooses an expression to evaluate based on a boolean test. Conditional expressions include the <a href="sqlref_builtinfcns_coalesce.html"><code>COALESCE</code> function</a>.</td>
                    </tr>
                </tbody>
            </table>
## Boolean Expressions

[Boolean expressions](sqlref_expressions_boolean.html) are expressions
that result in boolean values. Most general expressions can result in
boolean values. Boolean expressions commonly used in a WHERE clause are
made of operands operated on by SQL operators.

## Numeric Expressions

Numeric expressions are expressions that result in numeric values. Most
of the general expressions can result in numeric values. Numeric values
have one of the following types:

* {: .CodeFont value="1"} BIGINT
* {: .CodeFont value="2"} DECIMAL
* {: .CodeFont value="3"} DOUBLE PRECISION
* {: .CodeFont value="4"} INTEGER
* {: .CodeFont value="5"} REAL
* {: .CodeFont value="6"} SMALLINT

The following table lists the types of numeric expressions.

<table summary="Numeric expression types">
                <col />
                <col />
                <thead>
                    <tr>
                        <th style="vertical-align:top"><strong>Expression Type</strong>
                        </th>
                        <th style="vertical-align:top"><strong>Explanation</strong>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="vertical-align:top"> <code>+</code>, <code>-</code>, <code>*</code>, <code>/</code>,<br /> unary <code>+</code> and <code>-</code> expressions</td>
                        <td style="vertical-align:top">
                            <p>Evaluate the expected math operation on the operands. If both operands are the same type, the result type is not promoted, so the division operator on integers results in an integer that is the truncation of the actual numeric result. When types are mixed, they are promoted as described in the Data types section.
					</p>
                            <p>Unary <code>+</code> is a noop (i.e., +4 is the same as 4). </p>
                            <p>Unary <code>-</code> is the same as multiplying the value by -1, effectively changing its sign.</p>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top" class="CodeFont">AVG</td>
                        <td style="vertical-align:top"><a href="sqlref_builtinfcns_avg.html"><code>AVG</code></a> function</td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top" class="CodeFont">SUM</td>
                        <td style="vertical-align:top"><a href="sqlref_builtinfcns_sum.html"><code>SUM</code></a> function</td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top" class="CodeFont">LENGTH</td>
                        <td style="vertical-align:top"><a href="sqlref_builtinfcns_length.html"><code>LENGTH</code></a> function.</td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top" class="CodeFont">LOWER</td>
                        <td style="vertical-align:top"><a href="sqlref_builtinfcns_lcase.html"><code>LOWER</code></a> function.</td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top" class="CodeFont">COUNT</td>
                        <td style="vertical-align:top"><a href="sqlref_builtinfcns_count.html"><code>COUNT</code></a> function, including <code>COUNT(*).</code></td>
                    </tr>
                </tbody>
            </table>
## Character expressions

Character expressions are expressions that result in a `CHAR` or
`VARCHAR` value. Most general expressions can result in a `CHAR` or
`VARCHAR` value. The following table lists the types of character
expressions.

<table summary="Character expression types">
                <col />
                <col />
                <thead>
                    <tr>
                        <th style="vertical-align:top"><strong>Expression Type</strong>
                        </th>
                        <th style="vertical-align:top"><strong>Explanation</strong>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>A <code>CHAR</code> or <code>VARCHAR</code> value that uses wildcards. </td>
                        <td>The wildcards <code>%</code> and <code>_</code> make a character string a pattern against which the <code>LIKE</code> operator can look for a match.</td>
                    </tr>
                    <tr>
                        <td>Concatenation expression</td>
                        <td>In a concatenation expression, the concatenation operator, <code>||</code>, concatenates its right operand to the end of its left operand. Operates on character and bit strings. See <a href="sqlref_builtinfcns_concat.html">Concatenation operator</a>.</td>
                    </tr>
                    <tr>
                        <td>Built-in string functions</td>
                        <td>The built-in string functions act on a String and return a string. See <a href="sqlref_builtinfcns_ucase.html"><code>UCASE or UPPER function</code></a>.</td>
                    </tr>
                </tbody>
            </table>
## Date and Time Expressions

A date or time expression results in a `DATE`, `TIME`, or `TIMESTAMP`
value. Most of the general expressions can result in a date or time
value. The following table lists the types of date and time expressions.

<table summary="Date and time expression types">
                <col />
                <col />
                <thead>
                    <tr>
                        <th><strong>Expression Type</strong>
                        </th>
                        <th><strong>Explanation</strong>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>CURRENT_DATE</code></td>
                        <td>Returns the current date. See the <a href="sqlref_builtinfcns_currentdate.html"><code>CURRENT_DATE</code></a> function.</td>
                    </tr>
                    <tr>
                        <td><code>CURRENT_TIME</code></td>
                        <td>Returns the current time. See the <a href="sqlref_builtinfcns_currenttime.html"><code>CURRENT_TIME</code></a> function.</td>
                    </tr>
                    <tr>
                        <td><code>CURRENT_TIMESTAMP</code></td>
                        <td>Returns the current timestamp. See the <a href="sqlref_builtinfcns_currenttimestamp.html"><code>CURRENT_TIMESTAMP</code></a> function.</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [`AVG`](sqlref_builtinfcns_avg.html) function
* [`CAST`](sqlref_builtinfcns_cast.html) function
* [`COUNT`](sqlref_builtinfcns_count.html) function
* [`CURRENT_DATE`](sqlref_builtinfcns_currentdate.html) function
* [`CURRENT_TIME`](sqlref_builtinfcns_currenttime.html) function
* [`CURRENT_TIMESTAMP`](sqlref_builtinfcns_currenttimestamp.html)
  function
* [`Concatenation`](sqlref_builtinfcns_concat.html) operator
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LTRIM`](sqlref_builtinfcns_ltrim.html) function
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`SUM`](sqlref_builtinfcns_sum.html) function
* [`Select`](sqlref_expressions_select.html) expression
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UPDATE`](sqlref_statements_update.html) statement
* [`VALUES`](sqlref_expressions_values.html) expression
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>

