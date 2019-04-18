---
title: SQL Limitations
summary: Summarizes numerous value limitations in Splice Machine SQL.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sqlsummary.html
folder: SQLReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine SQL Summary

This topic summarizes the SQL-99+ features in Splice Machine SQL and
some of the [SQL optimizations](#SQLOpti) that our database engine
performs.

## SQL Feature Summary   {#SQLFeat}

This table summarizes some of the ANSI SQL-99+ features available in
Splice Machine:

<table summary="Summary of SQL features available in Splice Machine.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Feature</th>
                        <th>Examples</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><em>Aggregation functions</em></td>
                        <td><code>AVG, COUNT, MAX, MIN, STDDEV_POP, STDDEV_SAMP, SUM</code></td>
                    </tr>
                    <tr>
                        <td><em>Conditional functions</em></td>
                        <td><code>CASE, searched CASE</code></td>
                    </tr>
                    <tr>
                        <td><em>Data Types</em></td>
                        <td class="CodeFont">
                            <p>INTEGER, REAL, CHARACTER, DATE, BOOLEAN, BIGINT</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>DDL</em></td>
                        <td><code>CREATE TABLE, CREATE SCHEMA, CREATE INDEX, ALTER TABLE, DELETE, UPDATE</code></td>
                    </tr>
                    <tr>
                        <td><em>DML</em></td>
                        <td><code>INSERT, DELETE, UPDATE, SELECT</code></td>
                    </tr>
                    <tr>
                        <td><em>Isolation Levels</em></td>
                        <td>Snapshot isolation</td>
                    </tr>
                    <tr>
                        <td><em>Joins</em></td>
                        <td><code>INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN</code></td>
                    </tr>
                    <tr>
                        <td><em>Predicates</em></td>
                        <td><code>IN, BETWEEN, LIKE, EXISTS</code></td>
                    </tr>
                    <tr>
                        <td><em>Privileges</em></td>
                        <td>Privileges for <code>SELECT, DELETE, INSERT, EXECUTE</code></td>
                    </tr>
                    <tr>
                        <td><em>Query Specification</em></td>
                        <td><code>SELECT DISTINCT, GROUP BY, HAVING</code></td>
                    </tr>
                    <tr>
                        <td><em>SET functions</em></td>
                        <td><code>UNION, ABS, MOD, ALL, CHECK</code></td>
                    </tr>
                    <tr>
                        <td><em>String functions</em></td>
                        <td><code>CHAR, Concatenation (||), INSTR, LCASE (LOWER), LENGTH,<br />LTRIM, REGEXP_LIKE, REPLACE, RTRIM, SUBSTR, UCASE (UPPER), VARCHAR</code></td>
                    </tr>
                    <tr>
                        <td><em>Sub-queries</em></td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>Transactions</em></td>
                        <td class="CodeFont">
                            <p class="noSpaceAbove">COMMIT, ROLLBACK</p>
                        </td>
                    </tr>
                    <tr>
                        <td><em>Triggers</em></td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>User-defined functions (UDFs)</em></td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td><em>Views</em></td>
                        <td>Including grouped views</td>
                    </tr>
                    <tr>
                        <td><em>Window functions</em></td>
                        <td><code>AVG, COUNT, DENSE_RANK, FIRST_VALUE, LAG, LAST_VALUE, LEAD, MAX, MIN, RANK, ROW_NUMBER, STDDEV_POP, STDDEV_SAMP, SUM</code></td>
                    </tr>
                </tbody>
            </table>
## SQL Optimizations   {#SQLOpti}

Splice Machine performs a number of SQL optimizations that enhance the
processing speed of your queries:

* typed columns
* sparse columns
* flexible schema
* secondary indices
* real-time asynchronous statistics
* cost-based optimizer

</div>
</section>
