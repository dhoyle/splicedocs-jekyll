---
title: Boolean Expressions
summary: Syntax for and examples of Boolean expressions in Splice Machine SQL.
keywords: where, logical, constraint, exists, not exists
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_expressions_boolean.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Boolean Expressions

Boolean expressions are allowed in &nbsp;[`CONSTRAINT
clause`](sqlref_clauses_constraint.html) for more information. Boolean
expressions in a `WHERE` clause have a highly liberal syntax; see `WHERE
clause`, for example.

A Boolean expression can include zero or more Boolean operators.

## Syntax

The following table shows the syntax for the Boolean operators

<table summary="Boolean operators">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Operator</th>
                        <th>Syntax</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>AND, OR, NOT</code></td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">{
   Expression AND Expression
 | Expression OR  Expression
 | NOT Expression
}</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Comparisons </td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">Expression
{
   &lt;
 | =
 | &gt;
 | &lt;=
 | &gt;=
 | &lt;&gt;
}</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><code>IS NULL,<br />IS NOT NULL</code></td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell">Expression IS [ NOT ] NULL</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><code>LIKE</code></td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">CharacterExpression
 [ NOT ] LIKE CharacterExpression
   WithWildCard [ ESCAPE 'escapeCharacter']</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><code>BETWEEN</code></td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">Expression [ NOT ] BETWEEN Expression AND Expression</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><code>IN</code></td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">{
  Expression [ NOT ] IN <a href="sqlref_queries_tablesubquery.html">TableSubquery</a> |
  Expression [ NOT ] IN
 ( Expression [, Expression ]* )
}</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><code>EXISTS</code></td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell">[NOT] EXISTS <a href="sqlref_queries_tablesubquery.html">TableSubquery</a></pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantified comparison</td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">Expression ComparisonOperator
  {
   ALL |
   ANY |
   SOME
  }
  <a href="sqlref_queries_tablesubquery.html">TableSubquery</a></pre>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
## Examples

The following example presents examples of the Boolean operators.

<table style="" summary="Examples of Boolean expressions">
                <col width="150px" />
                <col />
                <thead>
                    <tr>
                        <th>Operator</th>
                        <th>Explanation and Example</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>AND, OR, NOT</code></td>
                        <td>Evaluate any operand(s) that are boolean expressions:
						<div class="preWrapper"><pre class="ExampleCell" xml:space="preserve">(orig_airport = 'SFO') OR (dest_airport = 'GRU')
	-- returns true</pre></div></td>
                    </tr>
                    <tr>
                        <td>Comparisons </td>
                        <td><code>&lt;, =, &gt;, &lt;=, &gt;=, &lt;&gt;</code> are applicable to all of the built-in types.
						<div class="preWrapper"><pre class="ExampleCell" xml:space="preserve">DATE('1998-02-26') &lt; DATE('1998-03-01')
	-- returns true</pre></div><p class="noteNote">Splice Machine also accepts the != operator, which is not included in the SQL standard.</p></td>
                    </tr>
                    <tr>
                        <td><code>IS NULL,<br />IS NOT NULL</code></td>
                        <td>Test whether the result of an expression is null or not.
					<div class="preWrapper"><pre class="ExampleCell">WHERE MiddleName IS NULL</pre></div></td>
                    </tr>
                    <tr>
                        <td><code>LIKE</code></td>
                        <td>
                            <p>Attempts to match a character expression to a character pattern, which is a character string that includes one or more wildcards.
					</p>
                            <p><code>%</code> matches any number (zero or more) of characters in the corresponding position in first character expression.</p>
                            <p><code>_</code> matches one character in the corresponding position in the character expression.</p>
                            <p>Any other character matches only that character in the corresponding position in the character expression.</p>
                            <div class="preWrapper"><pre class="ExampleCell">city LIKE 'Sant_'</pre>
                            </div>
                            <p>To treat % or _ as constant characters, escape the character with an optional escape character, which you specify with the ESCAPE clause.</p>
                            <div class="preWrapper"><pre class="ExampleCell">SELECT a FROM tabA WHERE a LIKE '%=_' ESCAPE '='</pre>
                            </div>
                            <p class="noteNote">When <code>LIKE</code> comparisons are used, Splice Machine compares one character at a time for non-metacharacters. This is different than the way Splice Machine processes <code>=</code> comparisons. The comparisons with the <code>=</code> operator compare the entire character string on left side of the <code>=</code> operator with the entire character string on the right side of the <code>=</code> operator.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>BETWEEN</code></td>
                        <td>Tests whether the first operand is between the second and third operands. The second operand must be less than the third operand. Applicable only to types to which <code>&lt;=</code> and <code>&gt;=</code> can be applied.
						<div class="preWrapper"><pre class="ExampleCell" xml:space="preserve">WHERE booking_date
  BETWEEN DATE('1998-02-26')
  AND DATE('1998-03-01')</pre></div><p class="noteNote">Using the <code>BETWEEN</code> operator is logically equivalent to specifying that you want to select values that are greater than or equal to the first operand and less than or equal to the second operand: <code>col between X and Y</code> is equivalent to <code>col &gt;= X and col &lt;= Y</code>. Which means that the result set will be empty if your second operand is less than your first.</p></td>
                    </tr>
                    <tr>
                        <td><code>IN</code></td>
                        <td>Operates on table subquery or list of values. Returns <code>TRUE</code> if the left expression's value is in the result of the table subquery or in the list of values. Table subquery can return multiple rows but must return a single column.
						<div class="preWrapper"><pre class="ExampleCell" xml:space="preserve">WHERE booking_date NOT IN
 (SELECT booking_date
  FROM HotelBookings
  WHERE rooms_available = 0)</pre></div></td>
                    </tr>
                    <tr>
                        <td><code>EXISTS</code></td>
                        <td>Operates on a table subquery. Returns <code>TRUE</code> if the table subquery returns any rows, and <code>FALSE</code> if it returns no rows. A table subquery can return multiple columns and rows.
						<div class="preWrapper"><pre class="ExampleCell" xml:space="preserve">WHERE EXISTS
 (SELECT *
  FROM Flights
  WHERE dest_airport = 'SFO'
  AND orig_airport = 'GRU')</pre></div></td>
                    </tr>
                    <tr>
                        <td>Quantified comparison</td>
                        <td>
                            <p>A quantified comparison is a comparison operator (<code>&lt;, =, &gt;, &lt;=, &gt;=, &lt;&gt;</code>) with <code>ALL</code> or <code>ANY</code> or <code>SOME</code> applied.
						</p>
                            <p>Operates on table subqueries, which can return multiple rows but must return a single column. </p>
                            <p>If <code>ALL</code> is used, the comparison must be true for all values returned by the table subquery. If <code>ANY</code> or <code>SOME</code> is used, the comparison must be true for at least one value of the table subquery. <code>ANY</code> and <code>SOME</code> are equivalent.</p>
                            <div class="preWrapper"><pre class="ExampleCell" xml:space="preserve">WHERE normal_rate &lt; ALL
  (SELECT budget/550 FROM Groups) </pre>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
## See Also

* [`CONSTRAINT`](sqlref_clauses_constraint.html) clause
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>

