---
title: Introduction to Join Operators
summary: Summarizes the join operators available in Splice Machine SQL
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_joinops_intro.html
folder: SQLReference/JoinOps
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Join Operations

This section contains the reference documentation for the Splice Machine
SQL Join Operations, in the following topics:

<table summary="Summary table with links to and descriptions of join operation topics">
    <col />
    <col />
    <thead>
        <tr>
            <th>Topic</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="sqlref_joinops_about.html">About Join Operations</a>
            </td>
            <td>Overview of joins.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_joinops_innerjoin.html">INNER JOIN</a>
            </td>
            <td>Selects all rows from both tables as long as there is a match between the columns in both tables.
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_joinops_fulljoin.html">FULL OUTER JOIN</a>
            </td>
            <td>Combines the results of a LEFT OUTER JOIN and RIGHT OUTER JOIN, selecting rows from both tables even when there are no matching rows in the other table.
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_joinops_leftouterjoin.html">LEFT OUTER JOIN</a>
            </td>
            <td>
                <p>Returns all rows from the left table (table1), with the matching rows in the right table (table2). The result is <code>NULL</code> in the right side when there is no match.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_joinops_rightouterjoin.html">RIGHT OUTER JOIN</a>
            </td>
            <td>Returns all rows from the right table (table2), with the matching rows in the left table (table1). The result is <code>NULL</code> in the left side when there is no match.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_joinops_crossjoin.html">CROSS JOIN</a>
            </td>
            <td>Produces the Cartesian product of two tables: it produces rows that combine each row from the first table with each row from the second table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_joinops_naturaljoin.html">NATURAL JOIN</a>
            </td>
            <td> Creates an implicit join clause for you based on the common columns (those with the same name in both tables) in the two tables being joined. </td>
        </tr>
    </tbody>
</table>
{% include splice_snippets/githublink.html %}
</div>
</section>
