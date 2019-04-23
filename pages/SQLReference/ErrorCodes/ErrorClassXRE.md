---
title: Splice Machine Error Codes - Class XRE&#58; Replication Exceptions
summary: Summary of Splice Machine Class XRE Errors
keywords: XRE errors, error XRE
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxre.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XRE: Replication Exceptions

<table>
                <caption>Error Class XRE: Replication Exceptions</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XRE00</code></td>
                        <td>This LogFactory module does not support replicatiosn.</td>
                    </tr>
                    <tr>
                        <td><code>XRE01</code></td>
                        <td>The log received from the master is corrupted.</td>
                    </tr>
                    <tr>
                        <td><code>XRE02</code></td>
                        <td>Master and Slave at different versions. Unable to proceed with Replication.</td>
                    </tr>
                    <tr>
                        <td><code>XRE03</code></td>
                        <td>Unexpected replication error. See derby.log for details.</td>
                    </tr>
                    <tr>
                        <td><code>XRE04.C.1</code></td>
                        <td>Could not establish a connection to the peer of the replicated database '<span class="VarName">&lt;dbname&gt;</span>' on address '<span class="VarName">&lt;hostname&gt;</span>:<span class="VarName">&lt;portname&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XRE04.C.2</code></td>
                        <td>Connection lost for replicated database '<span class="VarName">&lt;dbname&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XRE05.C</code></td>
                        <td>The log files on the master and slave are not in synch for replicated database '<span class="VarName">&lt;dbname&gt;</span>'. The master log instant is <span class="VarName">&lt;masterfile&gt;</span>:<span class="VarName">&lt;masteroffset&gt;</span>, whereas the slave log instant is <span class="VarName">&lt;slavefile&gt;</span>:<span class="VarName">&lt;slaveoffset&gt;</span>. This is FATAL for replication - replication will be stopped.</td>
                    </tr>
                    <tr>
                        <td><code>XRE06</code></td>
                        <td>The connection attempts to the replication slave for the database <span class="VarName">&lt;dbname&gt;</span> exceeded the specified timeout period.</td>
                    </tr>
                    <tr>
                        <td><code>XRE07</code></td>
                        <td>Could not perform operation because the database is not in replication master mode.</td>
                    </tr>
                    <tr>
                        <td><code>XRE08</code></td>
                        <td>Replication slave mode started successfully for database '<span class="VarName">&lt;dbname&gt;</span>'. Connection refused because the database is in replication slave mode. </td>
                    </tr>
                    <tr>
                        <td><code>XRE09.C</code></td>
                        <td>Cannot start replication slave mode for database '<span class="VarName">&lt;dbname&gt;</span>'. The database has already been booted.</td>
                    </tr>
                    <tr>
                        <td><code>XRE10</code></td>
                        <td>Conflicting attributes specified. See reference manual for attributes allowed in combination with replication attribute '<span class="VarName">&lt;attribute&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XRE11.C</code></td>
                        <td>Could not perform operation '<span class="VarName">&lt;command&gt;</span>' because the database '<span class="VarName">&lt;dbname&gt;</span>' has not been booted.</td>
                    </tr>
                    <tr>
                        <td><code>XRE12</code></td>
                        <td>Replication network protocol error for database '<span class="VarName">&lt;dbname&gt;</span>'. Expected message type '<span class="VarName">&lt;expectedtype&gt;</span>', but received type '<span class="VarName">&lt;expectedtype&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XRE20.D</code></td>
                        <td>Failover performed successfully for database '<span class="VarName">&lt;dbname&gt;</span>', the database has been shutdown.</td>
                    </tr>
                    <tr>
                        <td><code>XRE21.C</code></td>
                        <td>Error occurred while performing failover for database '<span class="VarName">&lt;dbname&gt;</span>', Failover attempt was aborted.</td>
                    </tr>
                    <tr>
                        <td><code>XRE22.C</code></td>
                        <td>Replication master has already been booted for database '<span class="VarName">&lt;dbname&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>XRE23</code></td>
                        <td>Replication master cannot be started since unlogged operations are in progress, unfreeze to allow unlogged operations to complete and restart replication</td>
                    </tr>
                    <tr>
                        <td><code>XRE40</code></td>
                        <td>Could not perform operation because the database is not in replication slave mode.</td>
                    </tr>
                    <tr>
                        <td><code>XRE41.C</code></td>
                        <td>Replication operation 'failover' or 'stopSlave' refused on the slave database because the connection with the master is working. Issue the 'failover' or 'stopMaster' operation on the master database instead.</td>
                    </tr>
                    <tr>
                        <td><code>XRE42.C</code></td>
                        <td>Replicated database '<span class="VarName">&lt;dbname&gt;</span>' shutdown.</td>
                    </tr>
                    <tr>
                        <td><code>XRE43</code></td>
                        <td>Unexpected error when trying to stop replication slave mode. To stop repliation slave mode, use operation 'stopSlave' or 'failover'.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

