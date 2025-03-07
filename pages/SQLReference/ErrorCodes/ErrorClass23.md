---
title: Splice Machine Error Codes - Class 23&#58; Constraint Violation
summary: Summary of Splice Machine Class 23 Errors
keywords: 23 errors, error 23
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class23.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 23: Constraint Violation

<table>
                <caption>Error Class 23: Constraint Violation</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>23502</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' cannot accept a NULL value.</td>
                    </tr>
                    <tr>
                        <td><code>23503</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> on table '<span class="VarName">&lt;tableName&gt;</span>' caused a violation of foreign key constraint '<span class="VarName">&lt;constraintName&gt;</span>' for key <span class="VarName">&lt;keyName&gt;</span>.  The statement has been rolled back.</td>
                    </tr>
                    <tr>
                        <td><code>23505</code></td>
                        <td>The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by '<span class="VarName">&lt;value&gt;</span>' defined on '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>23513</code></td>
                        <td>The check constraint '<span class="VarName">&lt;constraintName&gt;</span>' was violated while performing an INSERT or UPDATE on table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

