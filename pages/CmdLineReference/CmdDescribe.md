---
title: Describe command
summary: Displays a description of a table or view.
keywords: table, view, describe table, describe view
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_describe.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Describe Command

The <span class="AppCommand">describe</span> command displays a
description of the specified table or view.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DESCRIBE { table-Name | view-Name }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
tableName
{: .paramName}

The name of the table whose description you want to see.
{: .paramDefnFirst}

viewName
{: .paramName}

The name of the view whose description you want to see.
{: .paramDefnFirst}

</div>
## Results

The <span class="AppCommand">describe</span> command results contains
the following columns:

<table summary="List of columns in the output of the describe command.">
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
                        <td><code>COLUMN_NAME</code></td>
                        <td>The name of the column</td>
                    </tr>
                    <tr>
                        <td><code>TYPE_NAME</code></td>
                        <td>The data type of the column</td>
                    </tr>
                    <tr>
                        <td><code>DECIMAL_DIGITS</code></td>
                        <td>The number of fractional digits</td>
                    </tr>
                    <tr>
                        <td><code>NUM_PREC_RADIX</code></td>
                        <td>The radix, which is typically either 10 or 2</td>
                    </tr>
                    <tr>
                        <td><code>COLUMN_SIZE</code></td>
                        <td>
                            <p class="noSpaceAbove">The column size:</p>
                            <ul>
                                <li>For char or date types, this is the maximum number of characters</li>
                                <li>For numeric or decimal types, this is the precision</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>COLUMN_DEF</code></td>
                        <td>The default value for the column</td>
                    </tr>
                    <tr>
                        <td><code>CHAR_OCTE</code></td>
                        <td>Maximum number of bytes in the column</td>
                    </tr>
                    <tr>
                        <td><code>IS_NULL</code></td>
                        <td>Whether (YES) or not (NO) the column can contain null values</td>
                    </tr>
                </tbody>
            </table>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> describe T_DETAIL;
    COLUMN_NAME                 |TYPE_NAME|DEC |NUM |COLUM |COLUMN_DEF|CHAR_OCTE |IS_NULL
    --------------------------------------------------------------------------------------------------
    TRANSACTION_HEADER_KEY      |BIGINT   |0   |10  |19    |NULL      |NULL      |NO
    TRANSACTION_DETAIL_KEY      |BIGINT   |0   |10  |19    |NULL      |NULL      |NO
    CUSTOMER_MASTER_ID          |BIGINT   |0   |10  |19    |NULL      |NULL      |YES
    TRANSACTION_DT              |DATE     |0   |10  |10    |NULL      |NULL      |NO
    ORIGINAL_SKU_CATEGORY_ID    |INTEGER  |0   |10  |10    |NULL      |NULL      |YES
    
    5 rows selected
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

