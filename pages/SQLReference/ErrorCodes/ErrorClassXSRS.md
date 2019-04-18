---
title: Splice Machine Error Codes - Class XSRS&#58; RawStore - protocol.Interface statement
summary: Summary of Splice Machine Class XSRS Errors
keywords: XSRS errors, error XSRS
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxsrs.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSRS: RawStore - protocol.Interface statement

<table>
                <caption>Error Class XSRS: RawStore - protocol.Interface statement</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSRS0.S</code></td>
                        <td>Cannot freeze the database after it is already frozen.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS1.S</code></td>
                        <td>Cannot backup the database to <span class="VarName">&lt;value&gt;</span>, which is not a directory.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS4.S</code></td>
                        <td>Error renaming file (during backup) from <span class="VarName">&lt;value&gt;</span> to <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS5.S</code></td>
                        <td>Error copying file (during backup) from <span class="VarName">&lt;path&gt;</span> to <span class="VarName">&lt;path&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS6.S</code></td>
                        <td>Cannot create backup directory <span class="VarName">&lt;directoryName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS7.S</code></td>
                        <td>Backup caught unexpected exception.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS8.S</code></td>
                        <td>Log Device can only be set during database creation time, it cannot be changed on the fly.</td>
                    </tr>
                    <tr>
                        <td><code>XSRS9.S</code></td>
                        <td>Record <span class="VarName">&lt;recordName&gt;</span> no longer exists</td>
                    </tr>
                    <tr>
                        <td><code>XSRSA.S</code></td>
                        <td>Cannot backup the database when unlogged operations are uncommitted. Please commit the transactions with backup blocking operations. </td>
                    </tr>
                    <tr>
                        <td><code>XSRSB.S</code></td>
                        <td>Backup cannot be performed in a transaction with uncommitted unlogged operations.</td>
                    </tr>
                    <tr>
                        <td><code>XSRSC.S</code></td>
                        <td>Cannot backup the database to <span class="VarName">&lt;directoryLocation&gt;</span>, it is a database directory.</td>
                    </tr>
                    <tr>
                        <td><code>XSRSD.S</code></td>
                        <td>Database backup is disabled. Contact your Splice Machine representative to enable.</td>
                    </tr>
                    <tr>
                        <td><code>XSRSE.S</code></td>
                        <td>Unable to enable the enterprise Manager. Enterprise services are disabled. Contact your Splice Machine representative to enable.</td>
                    </tr>
                    <tr>
                        <td><code>XSRSF.S</code></td>
                        <td>LDAP authentication is disabled. Contact your Splice Machine representative to enable.</td>
                    </tr>
                    <tr>
                        <td><code>XSRSG.S</code></td>
                        <td>SpliceMachine Enterprise services are disabled and so will not run on an encrypted host. Contact your Splice Machine representative to enable.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

