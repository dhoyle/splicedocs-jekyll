---
title: About Join Operations
summary: An overview of the different kinds of joins available in Splice Machine SQL.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_joinops_about.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# About Join Operations

The `JOIN` operations, which are among the possible *[`FROM`
clause](sqlref_clauses_from.html)*, perform joins between two tables.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    JOIN Operation
{: .FcnSyntax}

</div>
The following table describes the `JOIN` operations:

<table summary="Splice Machine SQL Join operations">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Join Operation</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>INNER JOIN</code></td>
                        <td>Specifies a join between two tables with an explicit join clause.</td>
                    </tr>
                    <tr>
                        <td><code>LEFT OUTER JOIN</code></td>
                        <td>Specifies a
					join between two tables with an explicit join clause, preserving unmatched rows from the first table.</td>
                    </tr>
                    <tr>
                        <td><code>RIGHT OUTER JOIN</code></td>
                        <td>Specifies a
					join between two tables with an explicit join clause, preserving unmatched rows from the second table.</td>
                    </tr>
                    <tr>
                        <td><code>CROSS JOIN</code></td>
                        <td>Specifies a join that produces the Cartesian product of two tables. It has no explicit join clause.</td>
                    </tr>
                    <tr>
                        <td><code>NATURAL JOIN</code></td>
                        <td>
                            <p>Specifies an inner or outer join between two tables. It has no explicit join clause. Instead, one is created implicitly using the common columns from the two tables.</p>
                            <p class="noteNote">Splice Machine does not currently support <code>NATURAL SELF JOIN</code> operations.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
In all cases, you can specify additional restrictions on one or both of
the tables being joined in outer join clauses or in the &nbsp;[`WHERE`
clause](sqlref_clauses_where.html).

## Usage

Note that you can also perform a join between two tables using an
explicit equality test in a &nbsp;[`WHERE` clause](sqlref_clauses_where.html),
such as:

<div class="preWrapper" markdown="1">
    WHERE t1.col1 = t2.col2.
{: .Example}

</div>
## See Also

* [`FROM`](sqlref_clauses_from.html) clause
* [JOIN operations](sqlref_joinops_intro.html) 
* [`TABLE`](sqlref_expressions_table.html) expressions
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>

