---
title: Splice Machine Error Codes - Class 01&#58; Warning
summary: Summary of Splice Machine Class 01 Errors
keywords: 01 errors, error 01
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class01.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 01: Warning Messages

<table>
                <caption>Error Class 01: Warnings</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>01001</code></td>
                        <td>An attempt to update or delete an already deleted row was made: No row was updated or deleted.</td>
                    </tr>
                    <tr>
                        <td><code>01003</code></td>
                        <td>Null values were eliminated from the argument of a column function.</td>
                    </tr>
                    <tr>
                        <td><code>01006</code></td>
                        <td>Privilege not revoked from user <span class="VarName">&lt;authorizationID&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>01007</code></td>
                        <td>Role <span class="VarName">&lt;authorizationID&gt;</span> not revoked from authentication id <span class="VarName">&lt;authorizationID&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>01008</code></td>
                        <td>WITH ADMIN OPTION of role <span class="VarName">&lt;authorizationID&gt;</span> not revoked from authentication id <span class="VarName">&lt;authorizationID&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>01009</code></td>
                        <td>Generated column <span class="VarName">&lt;columnName&gt;</span> dropped from table <span class="VarName">&lt;tableName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>0100E</code></td>
                        <td>XX Attempt to return too many result sets. </td>
                    </tr>
                    <tr>
                        <td><code>01500</code></td>
                        <td>The constraint <span class="VarName">&lt;constraintName&gt;</span> on table <span class="VarName">&lt;tableName&gt;</span> has been dropped.</td>
                    </tr>
                    <tr>
                        <td><code>01501</code></td>
                        <td>The view <span class="VarName">&lt;viewName&gt;</span> has been dropped.</td>
                    </tr>
                    <tr>
                        <td><code>01502</code></td>
                        <td>The trigger <span class="VarName">&lt;triggerName&gt;</span> on table <span class="VarName">&lt;tableName&gt;</span> has been dropped.</td>
                    </tr>
                    <tr>
                        <td><code>01503</code></td>
                        <td>The column <span class="VarName">&lt;columnName&gt;</span> on table <span class="VarName">&lt;tableName&gt;</span> has been modified by adding a not null constraint.</td>
                    </tr>
                    <tr>
                        <td><code>01504</code></td>
                        <td>The new index is a duplicate of an existing index: <span class="VarName">&lt;indexName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>01505</code></td>
                        <td>The value <span class="VarName">&lt;valueName&gt;</span> may be truncated.</td>
                    </tr>
                    <tr>
                        <td><code>01522</code></td>
                        <td>The newly defined synonym '<span class="VarName">&lt;synonymName&gt;</span>' resolved to the object '<span class="VarName">&lt;objectName&gt;</span>' which is currently undefined.</td>
                    </tr>
                    <tr>
                        <td><code>01J01</code></td>
                        <td>Database '<span class="VarName">&lt;databaseName&gt;</span>' not created, connection made to existing database instead.</td>
                    </tr>
                    <tr>
                        <td><code>01J02</code></td>
                        <td>Scroll sensitive cursors are not currently implemented.</td>
                    </tr>
                    <tr>
                        <td><code>01J04</code></td>
                        <td>The class '<span class="VarName">&lt;className&gt;</span>' for column '<span class="VarName">&lt;columnName&gt;</span>' does not implement java.io.Serializable or java.sql.SQLData. Instances must implement one of these interfaces to allow them to be stored.</td>
                    </tr>
                    <tr>
                        <td><code>01J05</code></td>
                        <td>Database upgrade succeeded. The upgraded database is now ready for use. Revalidating stored prepared statements failed. See next exception for details of failure.</td>
                    </tr>
                    <tr>
                        <td><code>01J06</code></td>
                        <td>ResultSet not updatable. Query does not qualify to generate an updatable ResultSet.</td>
                    </tr>
                    <tr>
                        <td><code>01J07</code></td>
                        <td>ResultSetHoldability restricted to ResultSet.CLOSE_CURSORS_AT_COMMIT for a global transaction.</td>
                    </tr>
                    <tr>
                        <td><code>01J08</code></td>
                        <td>Unable to open resultSet type <span class="VarName">&lt;resultSetType&gt;</span>. ResultSet type <span class="VarName">&lt;resultSetType&gt;</span> opened.</td>
                    </tr>
                    <tr>
                        <td><code>01J10</code></td>
                        <td>Scroll sensitive result sets are not supported by server; remapping to forward-only cursor</td>
                    </tr>
                    <tr>
                        <td><code>01J12</code></td>
                        <td>Unable to obtain message text from server. See the next exception. The stored procedure SYSIBM.SQLCAMESSAGE is not installed on the server. Please contact your database administrator.</td>
                    </tr>
                    <tr>
                        <td><code>01J13</code></td>
                        <td>Number of rows returned (<span class="VarName">&lt;number&gt;</span>) is too large to fit in an integer; the value returned will be truncated.</td>
                    </tr>
                    <tr>
                        <td><code>01J14</code></td>
                        <td>SQL authorization is being used without first enabling authentication.</td>
                    </tr>
                    <tr>
                        <td><code>01J15</code></td>
                        <td>Your password will expire in <span class="VarName">&lt;remainingDays&gt;</span> day(s). Please use the SYSCS_UTIL.SYSCS_MODIFY_PASSWORD procedure to change your password in database '<span class="VarName">&lt;databaseName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>01J16</code></td>
                        <td>Your password is stale. To protect the database, you should update your password soon. Please use the SYSCS_UTIL.SYSCS_MODIFY_PASSWORD procedure to change your password in database '<span class="VarName">&lt;databaseName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>01J17</code></td>
                        <td>Statistics are unavailable or out of date for one or more tables involved in this query.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

