---
title: Splice Machine Error Codes - Class 08&#58; Connection Exception
summary: Summary of Splice Machine Class 08 Errors
keywords: 08 errors, error 08
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class08.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 08: Connection Exception

<table>
                <caption>Error Class 08: Connection Exception</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>08000</code></td>
                        <td>Connection closed by unknown interrupt.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.10</code></td>
                        <td>A connection could not be established because the security token is larger than the maximum allowed by the network protocol.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.11</code></td>
                        <td>A connection could not be established because the user id has a length of zero or is larger than the maximum allowed by the network protocol.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.12</code></td>
                        <td>A connection could not be established because the password has a length of zero or is larger than the maximum allowed by the network protocol.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.13</code></td>
                        <td>A connection could not be established because the external name (EXTNAM) has a length of zero or is larger than the maximum allowed by the network protocol.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.14</code></td>
                        <td>A connection could not be established because the server name (SRVNAM) has a length of zero or is larger than the maximum allowed by the network protocol.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.1</code></td>
                        <td>Required Splice DataSource property <span class="VarName">&lt;propertyName&gt;</span> not set.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.2</code></td>
                        <td><span class="VarName">&lt;error&gt;</span> : Error connecting to server <span class="VarName">&lt;serverName&gt;</span> on port <span class="VarName">&lt;portNumber&gt;</span> with message <span class="VarName">&lt;messageText&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.3</code></td>
                        <td>SocketException: '<span class="VarName">&lt;error&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.4</code></td>
                        <td>Unable to open stream on socket: '<span class="VarName">&lt;error&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.5</code></td>
                        <td>User id length (<span class="VarName">&lt;number&gt;</span>) is outside the range of 1 to <span class="VarName">&lt;number&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.6</code></td>
                        <td>Password length (<span class="VarName">&lt;value&gt;</span>) is outside the range of 1 to <span class="VarName">&lt;number&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.7</code></td>
                        <td>User id can not be null.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.8</code></td>
                        <td>Password can not be null.</td>
                    </tr>
                    <tr>
                        <td><code>08001.C.9</code></td>
                        <td>A connection could not be established because the database name '<span class="VarName">&lt;databaseName&gt;</span>' is larger than the maximum length allowed by the network protocol.</td>
                    </tr>
                    <tr>
                        <td><code>08003</code></td>
                        <td>No current connection.</td>
                    </tr>
                    <tr>
                        <td><code>08003.C.1</code></td>
                        <td>getConnection() is not valid on a closed PooledConnection.</td>
                    </tr>
                    <tr>
                        <td><code>08003.C.2</code></td>
                        <td>Lob method called after connection was closed</td>
                    </tr>
                    <tr>
                        <td><code>08003.C.3</code></td>
                        <td>The underlying physical connection is stale or closed.</td>
                    </tr>
                    <tr>
                        <td><code>08004</code></td>
                        <td>Connection refused : <span class="VarName">&lt;connectionName&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>08004.C.1</code></td>
                        <td>Connection authentication failure occurred.  Reason: <span class="VarName">&lt;reasonText&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.2</code></td>
                        <td>The connection was refused because the database <span class="VarName">&lt;databaseName&gt;</span> was not found.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.3</code></td>
                        <td>Database connection refused.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.4</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' cannot shut down database '<span class="VarName">&lt;databaseName&gt;</span>'. Only the database owner can perform this operation.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.5</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' cannot (re)encrypt database '<span class="VarName">&lt;databaseName&gt;</span>'. Only the database owner can perform this operation.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.6</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' cannot hard upgrade database '<span class="VarName">&lt;databaseName&gt;</span>'. Only the database owner can perform this operation.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.7</code></td>
                        <td>Connection refused to database '<span class="VarName">&lt;databaseName&gt;</span>' because it is in replication slave mode.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.8</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' cannot issue a replication operation on database '<span class="VarName">&lt;databaseName&gt;</span>'. Only the database owner can perform this operation.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.9</code></td>
                        <td>Missing permission for user '<span class="VarName">&lt;authorizationID&gt;</span>' to shutdown system [<span class="VarName">&lt;exceptionMsg&gt;</span>].</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.10</code></td>
                        <td>Cannot check system permission to create database '<span class="VarName">&lt;databaseName&gt;</span>' [<span class="VarName">&lt;exceptionMsg&gt;</span>].</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.11</code></td>
                        <td>Missing permission for user '<span class="VarName">&lt;authorizationID&gt;</span>' to create database '<span class="VarName">&lt;databaseName&gt;</span>' [<span class="VarName">&lt;exceptionMsg&gt;</span>].</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.12</code></td>
                        <td>Connection authentication failure occurred. Either the supplied credentials were invalid, or the database uses a password encryption scheme not compatible with the strong password substitution security mechanism. If this error started after upgrade, refer to the release note for DERBY-4483 for options.</td>
                    </tr>
                    <tr>
                        <td><code>08004.C.13</code></td>
                        <td>Username or password is null or 0 length.</td>
                    </tr>
                    <tr>
                        <td><code>08006.C</code></td>
                        <td>A network protocol error was encountered and the connection has been terminated: <span class="VarName">&lt;error&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>08006.C.1</code></td>
                        <td>An error occurred during connect reset and the connection has been terminated.  See chained exceptions for details.</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.2</code></td>
                        <td> SocketException: '<span class="VarName">&lt;error&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.3</code></td>
                        <td>A communications error has been detected: <span class="VarName">&lt;error&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.4</code></td>
                        <td>An error occurred during a deferred connect reset and the connection has been terminated.  See chained exceptions for details.</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.5</code></td>
                        <td>Insufficient data while reading from the network - expected a minimum of <span class="VarName">&lt;number&gt;</span> bytes and received only <span class="VarName">&lt;number&gt;</span> bytes.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.6</code></td>
                        <td>Attempt to fully materialize lob data that is too large for the JVM.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.8</code></td>
                        <td>com.splicemachine.db.jdbc.EmbeddedDriver is not registered with the JDBC driver manager</td>
                    </tr>
                    <tr>
                        <td><code>08006.C.9</code></td>
                        <td>Can't execute statement while in Restore Mode. Reboot database after restore operation is finished.</td>
                    </tr>
                    <tr>
                        <td><code>08006.D</code></td>
                        <td>Database '<span class="VarName">&lt;databaseName&gt;</span>' shutdown.</td>
                    </tr>
                    <tr>
                        <td><code>08006.D.1</code></td>
                        <td>Database '<span class="VarName">&lt;databaseName&gt;</span>' dropped.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

