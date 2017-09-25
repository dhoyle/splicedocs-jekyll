---
title: Summary of SQL Clauses
summary: Summarizes the SQL clauses available in Splice Machine.
keywords: clauses, sql clauses
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_clauses_intro.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Clauses

This section contains the reference documentation for the Splice Machine
SQL Clauses, in the following topics:

<table summary="Links to and descriptions of SQL clauses">
                <col />
                <col />
                <tr>
                    <th>Clause</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_constraint.html">CONSTRAINT</a>
                    </td>
                    <td>Optional clause in <a href="sqlref_statements_altertable.html"><code>ALTER TABLE</code></a> statements that specifies a rule to which the data must conform. </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_except.html">EXCEPT</a>
                    </td>
                    <td>Takes the distinct rows in the results from one  a <a href="sqlref_expressions_select.html"><code>SELECT</code></a> statement.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_from.html">FROM</a>
                    </td>
                    <td>
                        <p>A clause in a <em><a href="sqlref_expressions_select.html">SelectExpression</a></em>that specifies the tables
from which the other clauses of the query can access columns for use in expressions. </p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_groupby.html">GROUP BY</a>
                    </td>
                    <td>
                        <p>Part of a <em><a href="sqlref_expressions_select.html">SelectExpression</a></em> that groups a result into subsets that have matching values for one or more columns.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_having.html">HAVING</a>
                    </td>
                    <td>
                        <p>Restricts the results of a <code>GROUP BY</code> clause in a <em><a href="sqlref_expressions_select.html">SelectExpression</a>.</em></p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_limitn.html">LIMIT n</a>
                    </td>
                    <td>Limits the number of results returned by a query.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_over.html">OVER</a>
                    </td>
                    <td>Used in window functions to define the window on which the function operates.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_orderby.html">ORDER BY</a>
                    </td>
                    <td>
                        <p>Allows you to specify the order in which rows appear in the result set.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_resultoffset.html">RESULT OFFSET<br /> and FETCH FIRST</a>
                    </td>
                    <td>Provide a way to skip the N
 first rows in a result set before starting to return any
 rows and/or to limit the number of rows returned in the result set. </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_topn.html">TOP n</a>
                    </td>
                    <td>Limits the number of results returned by a query.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_union.html">UNION</a>
                    </td>
                    <td>Combines the result sets from two queries into a single table that contains all matching rows.</td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_using.html">USING</a>
                    </td>
                    <td>
                        <p>Specifies which columns to test for equality when two tables are joined.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_where.html">WHERE</a>
                    </td>
                    <td>
                        <p>An optional part of a <a href="sqlref_statements_update.html"><code>UPDATE</code> statement</a> that lets you select rows based on a Boolean expression.</p>
                    </td>
                </tr>
                <tr>
                    <td class="CodeFont"><a href="sqlref_clauses_with.html">WITH</a>
                    </td>
                    <td>Allows you to name subqueries to make your queries more readable and/or to improve efficency.</td>
                </tr>
            </table>
{% include splice_snippets/githublink.html %}
</div>
</section>

