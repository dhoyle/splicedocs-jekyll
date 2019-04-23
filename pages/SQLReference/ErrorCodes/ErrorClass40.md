---
title: Splice Machine Error Codes - Class 40&#58; Transaction Rollback
summary: Summary of Splice Machine Class 40 Errors
keywords: 40 errors, error 40
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class40.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 40: Transaction Rollback

<table>
                <caption>Error Class 40: Transaction Rollback</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>40001</code></td>
                        <td>A lock could not be obtained due to a deadlock, cycle of locks and waiters is:
					<span class="VarName">&lt;lockCycle&gt;</span>. The selected victim is XID : <span class="VarName">&lt;transactionID&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>40XC0</code></td>
                        <td>Dead statement. This may be caused by catching a transaction severity error inside this statement.</td>
                    </tr>
                    <tr>
                        <td><code>40XD0</code></td>
                        <td>Container has been closed.</td>
                    </tr>
                    <tr>
                        <td><code>40XD1</code></td>
                        <td>Container was opened in read-only mode.</td>
                    </tr>
                    <tr>
                        <td><code>40XD2</code></td>
                        <td>Container <span class="VarName">&lt;containerName&gt;</span> cannot be opened; it either has been dropped or does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>40XL1</code></td>
                        <td>A lock could not be obtained within the time requested</td>
                    </tr>
                    <tr>
                        <td><code>40XL1.T.1</code></td>
                        <td>A lock could not be obtained within the time requested.  The lockTable dump is: <span class="VarName">&lt;tableDump&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>40XT0</code></td>
                        <td>An internal error was identified by RawStore module.</td>
                    </tr>
                    <tr>
                        <td><code>40XT1</code></td>
                        <td>An exception was thrown during transaction commit.</td>
                    </tr>
                    <tr>
                        <td><code>40XT2</code></td>
                        <td>An exception was thrown during rollback of a SAVEPOINT.</td>
                    </tr>
                    <tr>
                        <td><code>40XT4</code></td>
                        <td>An attempt was made to close a transaction that was still active. The transaction has been aborted.</td>
                    </tr>
                    <tr>
                        <td><code>40XT5</code></td>
                        <td>Exception thrown during an internal transaction.</td>
                    </tr>
                    <tr>
                        <td><code>40XT6</code></td>
                        <td>Database is in quiescent state, cannot activate transaction.  Please wait for a moment till it exits the quiescent state.</td>
                    </tr>
                    <tr>
                        <td><code>40XT7</code></td>
                        <td>Operation is not supported in an internal transaction.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

