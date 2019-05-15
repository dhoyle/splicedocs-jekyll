---
title: SYSSTATEMENTS system table
summary: System table that describes the prepared statements in the database.
keywords: Prepared statements table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysstatements.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSTATEMENTS System Table

The `SYSSTATEMENTS` table describes the prepared statements in the
database. It belongs to the `SYS` schema.

The table contains one row per stored prepared statement.

The following table shows the contents of the `SYS.SYSSTATEMENTS` system
table.

<table>
    <caption>SYSSTATEMENTS system table</caption>
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Length</th>
            <th>Nullable</th>
            <th>Contents</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>STMTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the statement</td>
        </tr>
        <tr>
            <td><code>STMTNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Name of the statement</td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The schema in which the statement resides</td>
        </tr>
        <tr>
            <td><code>TYPE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Always <code>'S'</code></td>
        </tr>
        <tr>
            <td><code>VALID</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Whether or not the statement is valid</td>
        </tr>
        <tr>
            <td><code>TEXT</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>32,700</code></td>
            <td><code>NO</code></td>
            <td>Text of the statement</td>
        </tr>
        <tr>
            <td><code>LASTCOMPILED</code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>YES</code></td>
            <td>Time that the statement was compiled</td>
        </tr>
        <tr>
            <td><code>COMPILATIONSCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>ID of the schema containing the statement</td>
        </tr>
        <tr>
            <td><code>USINGTEXT</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>32,700</code></td>
            <td><code>YES</code></td>
            <td>Text of the <code>USING</code> clause of the <code>CREATE STATEMENT</code> and <code>ALTER STATEMENT</code> statements</td>
        </tr>
    </tbody>
</table>

## Usage Example and Restrictions

Here's an example of using this table:

```
SELECT * FROM SYS.SYSSTATEMENTS;
```
{: .Example}

{% include splice_snippets/systableaccessnote.md %}

## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>
