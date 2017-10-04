---
title: SQL Limitations
summary: Summarizes numerous value limitations in Splice Machine SQL.
keywords: limits, column limits, table limits, identifier length, numeric limitations, string limitations, xml limitations, maximum limits in database
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sqllimitations.html
folder: SQLReference
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SQL Limitations

This topic specifies limitations for various values in Splice Machine
SQL:

* [Database Value Limitations](#Database)
* [Date, Time, and TimeStamp Limitations](#DATE)
* [Identifier Length Limitations](#Identifier)
* [Numeric Limitations](#Numeric)
* [String Limitations](#String)
* [XML Limitations](#XML)

## Database Value Limitations   {#Database}

The following table lists limitations on various database values
in Splice Machine.

<table summary="Database value limitations in Splice Machine">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Limit</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Maximum columns in a table</td>
                        <td class="CodeFont">{{splvar_limit_MaxColumnsInTable}}
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum columns in a view</td>
                        <td class="CodeFont">{{splvar_limit_MaxColumnsInView}}
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum number of parameters in a stored procedure</td>
                        <td class="CodeFont">{{splvar_limit_MaxParamsInStoredProc}}
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum indexes on a table</td>
                        <td class="CodeFont">{{splvar_limit_MaxIndexesOnTable}}<span class="bodyFont"> or storage capacity</span>
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum tables referenced in an SQL statement or a view</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum elements in a select list</td>
                        <td class="CodeFont">{{splvar_limit_MaxElementsSelect}}
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum predicates in a <code>WHERE</code> or <code>HAVING</code> clause</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum number of columns in a <code>GROUP BY</code> clause</td>
                        <td class="CodeFont">{{splvar_limit_MaxElementsGroupBy}}
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum number of columns in an <code>ORDER BY</code> clause</td>
                        <td class="CodeFont">{{splvar_limit_MaxElementsOrderBy}}
                        </td>
                    </tr>
                    <tr>
                        <td>Maximum number of prepared statements</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum declared cursors in a program</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum number of cursors opened at one time</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum number of constraints on a table</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum level of subquery nesting</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum number of subqueries in a single statement</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum number of rows changed in a unit of work</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum constants in a statement</td>
                        <td>Storage capacity</td>
                    </tr>
                    <tr>
                        <td>Maximum depth of cascaded triggers</td>
                        <td class="CodeFont">{{splvar_limit_MaxTriggerRecursion}}
                        </td>
                    </tr>
                </tbody>
            </table>
## Date, Time, and TimeStamp Limitations   {#DATE}

The following table lists limitations on date, time, and timestamp
values in Splice Machine.

<table summary="Date and time value limitations in Splice Machine">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Limit</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Smallest <code>DATE</code> value</td>
                        <td><code>0001-01-01</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>DATE</code> value</td>
                        <td><code>9999-12-31</code></td>
                    </tr>
                    <tr>
                        <td>Smallest <code>TIME</code> value</td>
                        <td><code>00:00:00</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>TIME</code> value</td>
                        <td><code>24:00:00</code></td>
                    </tr>
                    <tr>
                        <td>Smallest <code>TIMESTAMP</code> value</td>
                        <td><code>1677-09-21-00.12.44.000000</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>TIMESTAMP</code> value</td>
                        <td><code>2262-04-11-23.47.16.999999</code></td>
                    </tr>
                </tbody>
            </table>
## Identifier Length Limitations   {#Identifier}

The following table lists limitations on identifier lengths in Splice
Machine.

<table summary="Identifier length limitations in Splice Machine">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Identifier</th>
                        <th>Maximum Number of Characters Allowed</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Constraint name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Correlation name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Cursor name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Data source column name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Data source index name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Data source name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Savepoint name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Schema name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Unqualified column name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Unqualified function name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Unqualified index name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Unqualified procedure name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Parameter name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Unqualified trigger name</td>
                        <td><code>128</code></td>
                    </tr>
                    <tr>
                        <td>Unqualified table name, view name, stored procedure name</td>
                        <td><code>128</code></td>
                    </tr>
                </tbody>
            </table>
## Numeric Limitations   {#Numeric}

The following lists limitations on the numeric values in Splice Machine.

<table summary="Numeric value limitations in Splice Machine">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Limit</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Smallest <code>INTEGER</code></td>
                        <td><code>-2,147,483,648</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>INTEGER</code></td>
                        <td><code>2,147,483,647</code></td>
                    </tr>
                    <tr>
                        <td>Smallest <code>BIGINT</code></td>
                        <td><code>-9,223,372,036,854,775,808</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>BIGINT</code></td>
                        <td><code>9,223,372,036,854,775,807</code></td>
                    </tr>
                    <tr>
                        <td>Smallest <code>SMALLINT</code></td>
                        <td><code>-32,768</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>SMALLINT</code></td>
                        <td><code>32,767</code></td>
                    </tr>
                    <tr>
                        <td>Largest decimal precision</td>
                        <td><code>31</code></td>
                    </tr>
                    <tr>
                        <td>Smallest <code>DOUBLE</code></td>
                        <td><code>-1.79769E+308</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>DOUBLE</code></td>
                        <td><code>1.79769E+308</code></td>
                    </tr>
                    <tr>
                        <td>Smallest positive <code>DOUBLE</code></td>
                        <td><code>2.225E-307</code></td>
                    </tr>
                    <tr>
                        <td>Largest negative <code>DOUBLE</code></td>
                        <td><code>-2.225E-307</code></td>
                    </tr>
                    <tr>
                        <td>Smallest <code>REAL</code></td>
                        <td><code>-3.402E+38</code></td>
                    </tr>
                    <tr>
                        <td>Largest <code>REAL</code></td>
                        <td><code>3.402E+38</code></td>
                    </tr>
                    <tr>
                        <td>Smallest positive <code>REAL</code></td>
                        <td><code>1.175E-37</code></td>
                    </tr>
                    <tr>
                        <td>Largest negative <code>REAL</code></td>
                        <td><code>-1.175E-37</code></td>
                    </tr>
                </tbody>
            </table>
## String Limitations   {#String}

The following table lists limitations on string values in Splice
Machine.

<table summary="String value limitations in Splice Machine">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Maximum Limit</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Length of <code>CHAR</code></td>
                        <td><code>254</code> characters</td>
                    </tr>
                    <tr>
                        <td>Length of <code>VARCHAR</code></td>
                        <td><code>32,672</code> characters</td>
                    </tr>
                    <tr>
                        <td>Length of <code>LONG VARCHAR</code></td>
                        <td><code>32,670</code> characters</td>
                    </tr>
                    <tr>
                        <td>Length of <code>CLOB</code>*</td>
                        <td><code>2,147,483,647</code> characters</td>
                    </tr>
                    <tr>
                        <td>Length of <code>BLOB</code>*</td>
                        <td><code>2,147,483,647</code> characters</td>
                    </tr>
                    <tr>
                        <td>Length of character constant</td>
                        <td><code>32,672</code>
                        </td>
                    </tr>
                    <tr>
                        <td>Length of concatenated character string</td>
                        <td><code>2,147,483,647</code>
                        </td>
                    </tr>
                    <tr>
                        <td>Length of concatenated binary string</td>
                        <td><code>2,147,483,647</code>
                        </td>
                    </tr>
                    <tr>
                        <td>Number of hex constant digits</td>
                        <td><code>16,336</code>
                        </td>
                    </tr>
                    <tr>
                        <td>Length of <code>DOUBLE</code> value constant</td>
                        <td><code>30</code> characters</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="indented">
                                <p colspan="2">* If you're using our 32-bit ODBC driver, <code>CLOB</code> and <code>BLOB</code> objects are limited to <code>512 MB</code> in size, instead of <code>2 GB</code> , due to address space limitations.</p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

