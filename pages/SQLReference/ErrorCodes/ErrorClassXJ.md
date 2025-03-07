---
title: Splice Machine Error Codes - Class XJ&#58; Connectivity Errors
summary: Summary of Splice Machine Class XJ Errors
keywords: XJ errors, error XJ
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxj.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XJ: Connectivity Errors

<table>
                <caption>Error Class XJ: Connectivity Errors</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XJ004.C</code></td>
                        <td>Database '<span class="VarName">&lt;databaseName&gt;</span>' not found.</td>
                    </tr>
                    <tr>
                        <td><code>XJ008.S</code></td>
                        <td>Cannot rollback or release a savepoint when in auto-commit mode.</td>
                    </tr>
                    <tr>
                        <td><code>XJ009.S</code></td>
                        <td>Use of CallableStatement required for stored procedure call or use of output parameters: <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XJ010.S</code></td>
                        <td>Cannot issue savepoint when autoCommit is on.</td>
                    </tr>
                    <tr>
                        <td><code>XJ011.S</code></td>
                        <td>Cannot pass null for savepoint name.</td>
                    </tr>
                    <tr>
                        <td><code>XJ012.S</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' already closed.</td>
                    </tr>
                    <tr>
                        <td><code>XJ013.S</code></td>
                        <td>No ID for named savepoints.</td>
                    </tr>
                    <tr>
                        <td><code>XJ014.S</code></td>
                        <td>No name for un-named savepoints.</td>
                    </tr>
                    <tr>
                        <td><code>XJ015.M</code></td>
                        <td>Splice system shutdown.</td>
                    </tr>
                    <tr>
                        <td><code>XJ016.S</code></td>
                        <td>Method '<span class="VarName">&lt;methodName&gt;</span>' not allowed on prepared statement.</td>
                    </tr>
                    <tr>
                        <td><code>XJ017.S</code></td>
                        <td>No savepoint command allowed inside the trigger code.</td>
                    </tr>
                    <tr>
                        <td><code>XJ018.S</code></td>
                        <td>Column name cannot be null.</td>
                    </tr>
                    <tr>
                        <td><code>XJ020.S</code></td>
                        <td>Object type not convertible to TYPE '<span class="VarName">&lt;typeName&gt;</span>', invalid java.sql.Types value, or object was null.</td>
                    </tr>
                    <tr>
                        <td><code>XJ021.S</code></td>
                        <td>Type is not supported.</td>
                    </tr>
                    <tr>
                        <td><code>XJ022.S</code></td>
                        <td>Unable to set stream: '<span class="VarName">&lt;name&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XJ023.S</code></td>
                        <td>Input stream did not have exact amount of data as the requested length.</td>
                    </tr>
                    <tr>
                        <td><code>XJ025.S</code></td>
                        <td>Input stream cannot have negative length.</td>
                    </tr>
                    <tr>
                        <td><code>XJ028.C</code></td>
                        <td>The URL '<span class="VarName">&lt;urlValue&gt;</span>' is not properly formed.</td>
                    </tr>
                    <tr>
                        <td><code>XJ030.S</code></td>
                        <td>Cannot set AUTOCOMMIT ON when in a nested connection.</td>
                    </tr>
                    <tr>
                        <td><code>XJ040.C</code></td>
                        <td>Failed to start database '<span class="VarName">&lt;databaseName&gt;</span>' with class loader <span class="VarName">&lt;classLoader&gt;</span>, see the next exception for details.</td>
                    </tr>
                    <tr>
                        <td><code>XJ041.C</code></td>
                        <td>Failed to create database '<span class="VarName">&lt;databaseName&gt;</span>', see the next exception for details.</td>
                    </tr>
                    <tr>
                        <td><code>XJ042.S</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' is not a valid value for property '<span class="VarName">&lt;propertyName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XJ044.S</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' is an invalid scale.</td>
                    </tr>
                    <tr>
                        <td><code>XJ045.S</code></td>
                        <td>Invalid or (currently) unsupported isolation level, '<span class="VarName">&lt;levelName&gt;</span>', passed to Connection.setTransactionIsolation(). The currently supported values are java.sql.Connection.TRANSACTION_SERIALIZABLE, java.sql.Connection.TRANSACTION_REPEATABLE_READ, java.sql.Connection.TRANSACTION_READ_COMMITTED, and java.sql.Connection.TRANSACTION_READ_UNCOMMITTED.</td>
                    </tr>
                    <tr>
                        <td><code>XJ048.C</code></td>
                        <td>Conflicting boot attributes specified: <span class="VarName">&lt;attributes&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XJ049.C</code></td>
                        <td>Conflicting create attributes specified.</td>
                    </tr>
                    <tr>
                        <td><code>XJ04B.S</code></td>
                        <td>Batch cannot contain a command that attempts to return a result set.</td>
                    </tr>
                    <tr>
                        <td><code>XJ04C.S</code></td>
                        <td>CallableStatement batch cannot contain output parameters.</td>
                    </tr>
                    <tr>
                        <td><code>XJ056.S</code></td>
                        <td>Cannot set AUTOCOMMIT ON when in an XA connection.</td>
                    </tr>
                    <tr>
                        <td><code>XJ057.S</code></td>
                        <td>Cannot commit a global transaction using the Connection, commit processing must go thru XAResource interface.</td>
                    </tr>
                    <tr>
                        <td><code>XJ058.S</code></td>
                        <td>Cannot rollback a global transaction using the Connection, commit processing must go thru XAResource interface.</td>
                    </tr>
                    <tr>
                        <td><code>XJ059.S</code></td>
                        <td>Cannot close a connection while a global transaction is still active.</td>
                    </tr>
                    <tr>
                        <td><code>XJ05B.C</code></td>
                        <td>JDBC attribute '<span class="VarName">&lt;attributeName&gt;</span>' has an invalid value '<span class="VarName">&lt;value&gt;</span>', valid values are '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XJ05C.S</code></td>
                        <td>Cannot set holdability ResultSet.HOLD_CURSORS_OVER_COMMIT for a global transaction.</td>
                    </tr>
                    <tr>
                        <td><code>XJ061.S</code></td>
                        <td>The '<span class="VarName">&lt;methodName&gt;</span>' method is only allowed on scroll cursors.</td>
                    </tr>
                    <tr>
                        <td><code>XJ062.S</code></td>
                        <td>Invalid parameter value '<span class="VarName">&lt;value&gt;</span>' for ResultSet.setFetchSize(int rows).</td>
                    </tr>
                    <tr>
                        <td><code>XJ063.S</code></td>
                        <td>Invalid parameter value '<span class="VarName">&lt;value&gt;</span>' for Statement.setMaxRows(int maxRows).  Parameter value must be &gt;= 0.</td>
                    </tr>
                    <tr>
                        <td><code>XJ064.S</code></td>
                        <td>Invalid parameter value '<span class="VarName">&lt;value&gt;</span>' for setFetchDirection(int direction).</td>
                    </tr>
                    <tr>
                        <td><code>XJ065.S</code></td>
                        <td>Invalid parameter value '<span class="VarName">&lt;value&gt;</span>' for Statement.setFetchSize(int rows).</td>
                    </tr>
                    <tr>
                        <td><code>XJ066.S</code></td>
                        <td>Invalid parameter value '<span class="VarName">&lt;value&gt;</span>' for Statement.setMaxFieldSize(int max).</td>
                    </tr>
                    <tr>
                        <td><code>XJ067.S</code></td>
                        <td>SQL text pointer is null.</td>
                    </tr>
                    <tr>
                        <td><code>XJ068.S</code></td>
                        <td>Only executeBatch and clearBatch allowed in the middle of a batch.</td>
                    </tr>
                    <tr>
                        <td><code>XJ069.S</code></td>
                        <td>No SetXXX methods allowed in case of USING execute statement.</td>
                    </tr>
                    <tr>
                        <td><code>XJ070.S</code></td>
                        <td>Negative or zero position argument '<span class="VarName">&lt;argument&gt;</span>' passed in a Blob or Clob method.</td>
                    </tr>
                    <tr>
                        <td><code>XJ071.S</code></td>
                        <td>Negative length argument '<span class="VarName">&lt;argument&gt;</span>' passed in a BLOB or CLOB method.</td>
                    </tr>
                    <tr>
                        <td><code>XJ072.S</code></td>
                        <td>Null pattern or searchStr passed in to a BLOB or CLOB position method.</td>
                    </tr>
                    <tr>
                        <td><code>XJ073.S</code></td>
                        <td>The data in this BLOB or CLOB is no longer available.  The BLOB/CLOB's transaction may be committed, its connection closed or it has been freed.</td>
                    </tr>
                    <tr>
                        <td><code>XJ074.S</code></td>
                        <td>Invalid parameter value '<span class="VarName">&lt;value&gt;</span>' for Statement.setQueryTimeout(int seconds).</td>
                    </tr>
                    <tr>
                        <td><code>XJ076.S</code></td>
                        <td>The position argument '<span class="VarName">&lt;positionArgument&gt;</span>' exceeds the size of the BLOB/CLOB.</td>
                    </tr>
                    <tr>
                        <td><code>XJ077.S</code></td>
                        <td>Got an exception when trying to read the first byte/character of the BLOB/CLOB pattern using getBytes/getSubString.</td>
                    </tr>
                    <tr>
                        <td><code>XJ078.S</code></td>
                        <td>Offset '<span class="VarName">&lt;value&gt;</span>' is either less than zero or is too large for the current BLOB/CLOB.</td>
                    </tr>
                    <tr>
                        <td><code>XJ079.S</code></td>
                        <td>The length specified '<span class="VarName">&lt;number&gt;</span>' exceeds the size of the BLOB/CLOB.</td>
                    </tr>
                    <tr>
                        <td><code>XJ080.S</code></td>
                        <td>USING execute statement passed <span class="VarName">&lt;number&gt;</span> parameters rather than <span class="VarName">&lt;number&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XJ081.C</code></td>
                        <td>Conflicting create/restore/recovery attributes specified.</td>
                    </tr>
                    <tr>
                        <td><code>XJ081.S</code></td>
                        <td>Invalid value '<span class="VarName">&lt;value&gt;</span>' passed as parameter '<span class="VarName">&lt;parameterName&gt;</span>' to method '<span class="VarName">&lt;methodName&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>XJ085.S</code></td>
                        <td>Stream has already been read and end-of-file reached and cannot be re-used.</td>
                    </tr>
                    <tr>
                        <td><code>XJ086.S</code></td>
                        <td>This method cannot be invoked while the cursor is not on the insert row or if the concurrency of this ResultSet object is CONCUR_READ_ONLY.</td>
                    </tr>
                    <tr>
                        <td><code>XJ087.S</code></td>
                        <td>Sum of position('<span class="VarName">&lt;pos&gt;</span>') and length('<span class="VarName">&lt;length&gt;</span>') is greater than the size of the LOB plus one.</td>
                    </tr>
                    <tr>
                        <td><code>XJ088.S</code></td>
                        <td>Invalid operation: wasNull() called with no data retrieved.</td>
                    </tr>
                    <tr>
                        <td><code>XJ090.S</code></td>
                        <td>Invalid parameter: calendar is null.</td>
                    </tr>
                    <tr>
                        <td><code>XJ091.S</code></td>
                        <td>Invalid argument: parameter index <span class="VarName">&lt;indexNumber&gt;</span> is not an OUT or INOUT parameter.</td>
                    </tr>
                    <tr>
                        <td><code>XJ093.S</code></td>
                        <td>Length of BLOB/CLOB, <span class="VarName">&lt;number&gt;</span>, is too large.  The length cannot exceed <span class="VarName">&lt;number&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XJ095.S</code></td>
                        <td>An attempt to execute a privileged action failed.</td>
                    </tr>
                    <tr>
                        <td><code>XJ096.S</code></td>
                        <td>A resource bundle could not be found in the <span class="VarName">&lt;packageName&gt;</span> package for <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XJ097.S</code></td>
                        <td>Cannot rollback or release a savepoint that was not created by this connection.</td>
                    </tr>
                    <tr>
                        <td><code>XJ098.S</code></td>
                        <td>The auto-generated keys value <span class="VarName">&lt;value&gt;</span> is invalid</td>
                    </tr>
                    <tr>
                        <td><code>XJ099.S</code></td>
                        <td>The Reader/Stream object does not contain length characters</td>
                    </tr>
                    <tr>
                        <td><code>XJ100.S</code></td>
                        <td>The scale supplied by the registerOutParameter method does not match with the setter method. Possible loss of precision!</td>
                    </tr>
                    <tr>
                        <td><code>XJ103.S</code></td>
                        <td>Table name can not be null</td>
                    </tr>
                    <tr>
                        <td><code>XJ104.S</code></td>
                        <td>Shared key length is invalid: <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XJ105.S</code></td>
                        <td>DES key has the wrong length, expected length <span class="VarName">&lt;number&gt;</span>, got length <span class="VarName">&lt;number&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XJ106.S</code></td>
                        <td>No such padding </td>
                    </tr>
                    <tr>
                        <td><code>XJ107.S</code></td>
                        <td>Bad Padding</td>
                    </tr>
                    <tr>
                        <td><code>XJ108.S</code></td>
                        <td>Illegal Block Size</td>
                    </tr>
                    <tr>
                        <td><code>XJ110.S</code></td>
                        <td>Primary table name can not be null</td>
                    </tr>
                    <tr>
                        <td><code>XJ111.S</code></td>
                        <td>Foreign table name can not be null</td>
                    </tr>
                    <tr>
                        <td><code>XJ112.S</code></td>
                        <td>Security exception encountered, see next exception for details.</td>
                    </tr>
                    <tr>
                        <td><code>XJ113.S</code></td>
                        <td>Unable to open file <span class="VarName">&lt;fileName&gt;</span> : <span class="VarName">&lt;error&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XJ114.S</code></td>
                        <td>Invalid cursor name '<span class="VarName">&lt;cursorName&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>XJ115.S</code></td>
                        <td>Unable to open resultSet with requested holdability <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XJ116.S</code></td>
                        <td>No more than <span class="VarName">&lt;number&gt;</span> commands may be added to a single batch.</td>
                    </tr>
                    <tr>
                        <td><code>XJ117.S</code></td>
                        <td>Batching of queries not allowed by J2EE compliance.</td>
                    </tr>
                    <tr>
                        <td><code>XJ118.S</code></td>
                        <td>Query batch requested on a non-query statement.</td>
                    </tr>
                    <tr>
                        <td><code>XJ121.S</code></td>
                        <td>Invalid operation at current cursor position.</td>
                    </tr>
                    <tr>
                        <td><code>XJ122.S</code></td>
                        <td>No updateXXX methods were called on this row.</td>
                    </tr>
                    <tr>
                        <td><code>XJ123.S</code></td>
                        <td>This method must be called to update values in the current row or the insert row.</td>
                    </tr>
                    <tr>
                        <td><code>XJ124.S</code></td>
                        <td>Column not updatable.</td>
                    </tr>
                    <tr>
                        <td><code>XJ125.S</code></td>
                        <td>This method should only be called on ResultSet objects that are scrollable (type TYPE_SCROLL_INSENSITIVE).</td>
                    </tr>
                    <tr>
                        <td><code>XJ126.S</code></td>
                        <td>This method should not be called on sensitive dynamic cursors.</td>
                    </tr>
                    <tr>
                        <td><code>XJ128.S</code></td>
                        <td>Unable to unwrap for '<span class="VarName">&lt;value&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>XJ200.S</code></td>
                        <td>Exceeded maximum number of sections <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XJ202.S</code></td>
                        <td>Invalid cursor name '<span class="VarName">&lt;cursorName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XJ203.S</code></td>
                        <td>Cursor name '<span class="VarName">&lt;cursorName&gt;</span>' is already in use</td>
                    </tr>
                    <tr>
                        <td><code>XJ204.S</code></td>
                        <td>Unable to open result set with requested holdability <span class="VarName">&lt;holdValue&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XJ206.S</code></td>
                        <td>SQL text '<span class="VarName">&lt;value&gt;</span>' has no tokens.</td>
                    </tr>
                    <tr>
                        <td><code>XJ207.S</code></td>
                        <td>executeQuery method can not be used for update.</td>
                    </tr>
                    <tr>
                        <td><code>XJ208.S</code></td>
                        <td>Non-atomic batch failure.  The batch was submitted, but at least one exception occurred on an individual member of the batch. Use getNextException() to retrieve the exceptions for specific batched elements.</td>
                    </tr>
                    <tr>
                        <td><code>XJ209.S</code></td>
                        <td>The required stored procedure is not installed on the server.</td>
                    </tr>
                    <tr>
                        <td><code>XJ210.S</code></td>
                        <td>The load module name for the stored procedure on the server is not found.</td>
                    </tr>
                    <tr>
                        <td><code>XJ211.S</code></td>
                        <td>Non-recoverable chain-breaking exception occurred during batch processing. The batch is terminated non-atomically.</td>
                    </tr>
                    <tr>
                        <td><code>XJ212.S</code></td>
                        <td>Invalid attribute syntax: <span class="VarName">&lt;attributeSyntax&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XJ213.C</code></td>
                        <td>The traceLevel connection property does not have a valid format for a number.</td>
                    </tr>
                    <tr>
                        <td><code>XJ214.S</code></td>
                        <td>An IO Error occurred when calling free() on a CLOB or BLOB.</td>
                    </tr>
                    <tr>
                        <td><code>XJ215.S</code></td>
                        <td>You cannot invoke other java.sql.Clob/java.sql.Blob methods after calling the free() method or after the Blob/Clob's transaction has been committed or rolled back.</td>
                    </tr>
                    <tr>
                        <td><code>XJ216.S</code></td>
                        <td>The length of this BLOB/CLOB is not available yet. When a BLOB or CLOB is accessed as a stream, the length is not available until the entire stream has been processed.</td>
                    </tr>
                    <tr>
                        <td><code>XJ217.S</code></td>
                        <td>The locator that was supplied for this CLOB/BLOB is invalid</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

