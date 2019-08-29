---
title: SYSCOLUMNS system table
summary: System table that describes the columns within all tables in the current database.
keywords: columns descriptions table, autoincrement, columns, collect statistics
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syscolumns.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCOLUMNS System Table

The `SYSCOLUMNS` table describes the columns within all tables in the
current database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSCOLUMNS` system table.

<table>
    <caption>SYSCOLUMNS system table</caption>
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
            <td><code>REFERENCEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Identifier for table (join with
		<code>SYSTABLES.TABLEID</code>)</td>
        </tr>
        <tr>
            <td><code>COLUMNNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Column or parameter name</td>
        </tr>
        <tr>
            <td><code>COLUMNNUMBER</code></td>
            <td><code>INTEGER</code></td>
            <td><code>10</code></td>
            <td><code>NO</code></td>
            <td>The position of the column within the table</td>
        </tr>
        <tr>
            <td><code>COLUMNDATATYPE</code></td>
            <td><code>com.splicemachine.db.<br />catalog.TypeDescriptor</code></td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td><p>System type that describes precision, length, scale, nullability, type name, and storage type of data. For a user-defined type, this column can hold a <em>TypeDescriptor</em> that refers to the appropriate type alias in <code>SYS.SYSALIASES</code>.</p>
                <p>This class is not part of the public API.</p></td>
        </tr>
        <tr>
            <td><code>COLUMNDEFAULT</code></td>
            <td><code>java.io.Serializable</code>
            </td>
            <td><code>-1</code></td>
            <td><code>YES</code></td>
            <td>For tables, describes default value of the column. The <code>toString()</code> method on the object stored in the table returns the text of the default value as specified in the <code>CREATE TABLE</code> or <code>ALTER TABLE</code> statement.</td>
        </tr>
        <tr>
            <td><code>COLUMNDEFAULTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>YES</code></td>
            <td>Unique identifier for the default value</td>
        </tr>
        <tr>
            <td><code>AUTOINCREMENTVALUE</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>What the next value for column will be, if the column is
		an identity column</td>
        </tr>
        <tr>
            <td><code>AUTOINCREMENTSTART</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>Initial value of column (if specified), if it is an identity
		column</td>
        </tr>
        <tr>
            <td><code>AUTOINCREMENTINC</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>Amount column value is automatically incremented (if
		specified), if the column is an identity column</td>
        </tr>
        <tr>
            <td><code>COLLECTSTATS</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>YES</code></td>
            <td>Whether or not to collect statistics on the column.</td>
        </tr>
        <tr>
            <td><code>PARTITIONPOSITION</code></td>
            <td><code>INTEGER</code></td>
            <td><code>10</code></td>
            <td><code>YES</code></td>
            <td>This is used for external tables, to indicate the partitioning column position</td>
        </tr>
        <tr>
            <td><code>USEEXTRAPOLATION</code></td>
            <td><code>TINYINT</code></td>
            <td><code>3</code></td>
            <td><code>YES</code></td>
            <td>Whether or not to use statistics extrapolation on this column. A value of <code>1</code> indicates that extrapolation is enabled for the column; a value of <code>0</code> or <code>NULL</code> indicates that extrapolation is disabled.</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding [`SYSVW.SYSCOLUMNS` system view](sqlref_sysviews_syscolumnsview.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYSVW.SYSCOLUMNS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the [`SYSVW.SYSCOLUMNSVIEW` system view](sqlref_sysviews_syscolumnsview.html) instead.


## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSCOLUMNS;
```
{: .Example}


</div>
</section>
