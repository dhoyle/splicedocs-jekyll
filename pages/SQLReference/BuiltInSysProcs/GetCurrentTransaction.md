---
title: SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION built-in system procedure
summary: Built-in system procedure that displays summary information about the current transaction.
keywords: transactions, transaction information, get_current_transaction
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getcurrenttransaction.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION

The `SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION` system procedure displays
summary information about the current transaction.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling
`SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION` include these values:

<table summary=" summary=&quot;Columns in Get_Current_Transactions results display&quot;">
                <col />
                <col />
                <thead>
                    <tr>
                        <th> </th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Value</strong>
                        </td>
                        <td><strong>Description</strong>
                        </td>
                    </tr>
                    <tr>
                        <td><code>txnId</code></td>
                        <td>The ID of the current transaction</td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION();
    txnId
    ---------------------
    2081
    
    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

