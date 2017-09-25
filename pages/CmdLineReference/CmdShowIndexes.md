---
title: Show Indexes command
summary: Displays information about the indexes defined on a table, a database, or a schema.
keywords: indices, index, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showindexes.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Indexes

The <span class="AppCommand">show indexes</span> command displays all of
the indexes in the database, the indexes in the specified schema, or the
indexes on the specified table.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW INDEXES [ IN schemaName | FROM tableName ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

If you supply a schema name, only the indexes in that schema are
displayed.
{: .paramDefnFirst}

tableName
{: .paramName}

If you supply a table name, only the indexes on that table are
displayed.
{: .paramDefnFirst}

</div>
### Results

The <span class="AppCommand">show indexes</span> command results
contains the following columns:

<table summary="Results of the show indexes command">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Column Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>TABLE_NAME</code></td>
                        <td>The name of the table.</td>
                    </tr>
                    <tr>
                        <td><code>INDEX_NAME</code></td>
                        <td>The name of the index.</td>
                    </tr>
                    <tr>
                        <td><code>COLUMN_NAME</code></td>
                        <td>The name of the column.</td>
                    </tr>
                    <tr>
                        <td><code>ORDINAL</code></td>
                        <td>The position of the column in the index.</td>
                    </tr>
                    <tr>
                        <td><code>NON_UNIQUE</code></td>
                        <td>Whether this is a unique or non-unique index.</td>
                    </tr>
                    <tr>
                        <td><code>TYPE</code></td>
                        <td>The index type</td>
                    </tr>
                    <tr>
                        <td><code>ASC_</code></td>
                        <td>Indicates if this is an ascending (A) or descending (D) index.</td>
                    </tr>
                    <tr>
                        <td><code>CONGLOM_NO</code></td>
                        <td>The conglomerate number, which points to the corresponding table in HBase.</td>
                    </tr>
                </tbody>
            </table>
### Examples

<div class="preWrapperWide" markdown="1">
    splice> show indexes from my_table;
    TABLE_NAME    |INDEX_NAME       |COLUMN_NAME   |ORDINAL&|NON_UNIQUE|TYPE |ASC&|CONGLOM_NO
    -----------------------------------------------------------------------------------------
    MY_TABLE      |I1               |ID            |1       |true      |BTREE|A   |1937
    MY_TABLE      |I1               |STATE_CD      |2       |true      |BTREE|A   |1937
    MY_TABLE      |I1               |CITY          |3       |true      |BTREE|A   |1937
    MY_TABLE      |I2               |ID            |1       |true      |BTREE|D   |1953
    MY_TABLE      |I2               |STATE_CD      |2       |true      |BTREE|D   |1953
    MY_TABLE      |I2               |CITY          |3       |true      |BTREE|D   |1953
    MY_TABLE      |I3               |ID            |1       |true      |BTREE|D   |1969
    MY_TABLE      |I3               |STATE_CD      |2       |true      |BTREE|A   |1969
    MY_TABLE      |I3               |CITY          |3       |true      |BTREE|D   |1969
    MY_TABLE      |I4               |LATITUDE      |1       |true      |BTREE|D   |1985
    MY_TABLE      |I4               |STATE_CD      |2       |true      |BTREE|A   |1985
    MY_TABLE      |I4               |ID            |3       |true      |BTREE|A   |1985
    MY_TABLE      |I5               |ID            |1       |true      |BTREE|A   |2001
    MY_TABLE      |I5               |ID            |2       |true      |BTREE|D   |2001
    
    14 rows selected
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

