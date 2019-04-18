---
title: Splice Machine Error Codes - Class XSCB&#58; Store - BTree
summary: Summary of Splice Machine Class XSCB Errors
keywords: XCSB errors, error XCSB
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxscb.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSCB: Store - BTree

<table>
                <caption>Error Class XSCB: Store - BTree</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSCB0.S</code></td>
                        <td>Could not create container.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB1.S</code></td>
                        <td>Container <span class="VarName">&lt;containerName&gt;</span> not found.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB2.S</code></td>
                        <td>The required property <span class="VarName">&lt;propertyName&gt;</span> not found in the property list given to createConglomerate() for a btree secondary index.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB3.S</code></td>
                        <td>Unimplemented feature.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB4.S</code></td>
                        <td>A method on a btree open scan has been called prior to positioning the scan on the first row (i.e. no next() call has been made yet).  The current state of the scan is (<span class="VarName">&lt;value&gt;</span>).</td>
                    </tr>
                    <tr>
                        <td><code>XSCB5.S</code></td>
                        <td>During logical undo of a btree insert or delete the row could not be found in the tree.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB6.S</code></td>
                        <td>Limitation: Record of a btree secondary index cannot be updated or inserted due to lack of space on the page.  Use the parameters derby.storage.pageSize and/or derby.storage.pageReservedSpace to work around this limitation.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB7.S</code></td>
                        <td>An internal error was encountered during a btree scan - current_rh is null = <span class="VarName">&lt;value&gt;</span>, position key is null = <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB8.S</code></td>
                        <td>The btree conglomerate <span class="VarName">&lt;value&gt;</span> is closed.</td>
                    </tr>
                    <tr>
                        <td><code>XSCB9.S</code></td>
                        <td>Reserved for testing.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

