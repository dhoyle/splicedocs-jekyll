---
title: Splice Machine Error Codes - Class 25&#58; Invalid Transaction State
summary: Summary of Splice Machine Class 25 Errors
keywords: 25 errors, error 25
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class25.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 25: Invalid Transaction State

<table>
                <caption>Error Class 25: Invalid Transaction State</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>25001</code></td>
                        <td>Cannot close a connection while a transaction is still active.</td>
                    </tr>
                    <tr>
                        <td><code>25001.S.1</code></td>
                        <td>Invalid transaction state: active SQL transaction.</td>
                    </tr>
                    <tr>
                        <td><code>25501</code></td>
                        <td>Unable to set the connection read-only property in an active transaction.</td>
                    </tr>
                    <tr>
                        <td><code>25502</code></td>
                        <td>An SQL data change is not permitted for a read-only connection, user or database.</td>
                    </tr>
                    <tr>
                        <td><code>25503</code></td>
                        <td>DDL is not permitted for a read-only connection, user or database.</td>
                    </tr>
                    <tr>
                        <td><code>25505</code></td>
                        <td>A read-only user or a user in a read-only database is not permitted to disable read-only mode on a connection.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

