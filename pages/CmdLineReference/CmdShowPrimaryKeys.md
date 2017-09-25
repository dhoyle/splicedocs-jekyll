---
title: Show PrimaryKeys command
summary: Displays information about the primary keys in a table.
keywords: primary key, keys, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showprimarykeys.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show PrimaryKeys

The <span class="AppCommand">show primarykeys</span> command displays
all the primary keys in the specified table.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW PRIMARYKEYS FROM schemaName.tableName
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The schema name.
{: .paramDefnFirst}

tableName
{: .paramName}

The table name.
{: .paramDefnFirst}

</div>
### Results

The <span class="AppCommand">show primary keys</span> command results
contains the following columns:

<table summary="List of columns in the output of the show primary keys command.">
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
                        <td>The name of the table</td>
                    </tr>
                    <tr>
                        <td><code>COLUMN_NAME</code></td>
                        <td>The name of the column</td>
                    </tr>
                    <tr>
                        <td><code>KEY_SEQ</code></td>
                        <td>The order of the column within the primary key</td>
                    </tr>
                    <tr>
                        <td><code>PK_NAME</code></td>
                        <td>The unique name of the constraint</td>
                    </tr>
                </tbody>
            </table>
### Examples

<div class="preWrapperWide" markdown="1">
    splice> create table myTable(i int, j int, primary key (i,j));
    0 rows inserted/updated/deleted
    
    splice> show primarykeys from mySchema.myTable;
    TABLE_NAME  |COLUMN_NAME  |KEY_SEQ  |PK_NAME
    -------------------------------------------------------
    A           |I            |1        |SQL141120202723310
    A           |J            |2        |SQL141120202723310
    
    2 rows selected
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

