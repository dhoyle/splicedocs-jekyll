---
title: Splice Machine Error Codes - Class 3B&#58; Invalid SAVEPOINT
summary: Summary of Splice Machine Class 3B Errors
keywords: 3B errors, error 3b
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class3b.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 3B: Invalid SAVEPOINT

<table>
                <caption>Error Class 3B: Invalid SAVEPOINT</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>3B001.S</code></td>
                        <td>Savepoint <span class="VarName">&lt;savepointName&gt;</span> does not  exist or is not active in the current transaction.</td>
                    </tr>
                    <tr>
                        <td><code>3B002.S</code></td>
                        <td>The maximum number of savepoints has been reached. </td>
                    </tr>
                    <tr>
                        <td><code>3B501.S</code></td>
                        <td>A SAVEPOINT with the passed name already exists in the current transaction.</td>
                    </tr>
                    <tr>
                        <td><code>3B502.S</code></td>
                        <td>A RELEASE or ROLLBACK TO SAVEPOINT was specified, but the savepoint does not exist.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

