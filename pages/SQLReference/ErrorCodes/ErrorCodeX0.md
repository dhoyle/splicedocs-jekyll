---
title: Splice Machine Error Codes - Class X0&#58; Execution exceptions
summary: Summary of Splice Machine Class X0 Errors
keywords: X0 errors, error X0
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classx0.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class X0 - Execution exceptions

<table>
                <caption>Error Class X0: Execution exceptions</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>X0A00.S</code></td>
                        <td>The select list mentions column '<span class="VarName">&lt;columnName&gt;</span>' twice. This is not allowed in queries with GROUP BY or HAVING clauses. Try aliasing one of the conflicting columns to a unique name.</td>
                    </tr>
                    <tr>
                        <td><code>X0X02.S</code></td>
                        <td>Table '<span class="VarName">&lt;tableName&gt;</span>' cannot be locked in '<span class="VarName">&lt;mode&gt;</span>' mode.</td>
                    </tr>
                    <tr>
                        <td><code>X0X03.S</code></td>
                        <td>Invalid transaction state - held cursor requires same isolation level</td>
                    </tr>
                    <tr>
                        <td><code>X0X05.S</code></td>
                        <td>Table/View '<span class="VarName">&lt;tableName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>X0X07.S</code></td>
                        <td>Cannot remove jar file '<span class="VarName">&lt;fileName&gt;</span>' because it is on your derby.database.classpath '<span class="VarName">&lt;classpath&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0X0D.S</code></td>
                        <td>Invalid column array length '<span class="VarName">&lt;columnArrayLength&gt;</span>'. To return generated keys, column array must be of length 1 and contain only the identity column.</td>
                    </tr>
                    <tr>
                        <td><code>X0X0E.S</code></td>
                        <td>Table '<span class="VarName">&lt;columnPosition&gt;</span>' does not have an auto-generated column at column position '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0X0F.S</code></td>
                        <td>Table '<span class="VarName">&lt;columnName&gt;</span>' does not have an auto-generated column named '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0X10.S</code></td>
                        <td>The USING clause returned more than one row; only single-row ResultSets are permissible.</td>
                    </tr>
                    <tr>
                        <td><code>X0X11.S</code></td>
                        <td>The USING clause did not return any results so no parameters can be set. </td>
                    </tr>
                    <tr>
                        <td><code>X0X13.S</code></td>
                        <td>Jar file '<span class="VarName">&lt;fileName&gt;</span>' does not exist in schema '<span class="VarName">&lt;schemaName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0X14.S</code></td>
                        <td>The file '<span class="VarName">&lt;fileName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>X0X57.S</code></td>
                        <td>An attempt was made to put a Java value of type '<span class="VarName">&lt;type&gt;</span>' into a SQL value, but there is no corresponding SQL type.  The Java value is probably the result of a method call or field access.</td>
                    </tr>
                    <tr>
                        <td><code>X0X60.S</code></td>
                        <td>A cursor with name '<span class="VarName">&lt;cursorName&gt;</span>' already exists.</td>
                    </tr>
                    <tr>
                        <td><code>X0X61.S</code></td>
                        <td>The values for column '<span class="VarName">&lt;columnName&gt;</span>' in index '<span class="VarName">&lt;indexName&gt;</span>' and table '<span class="VarName">&lt;schemaName&gt;</span>.<span class="VarName">&lt;tableName&gt;</span>' do not match for row location <span class="VarName">&lt;location&gt;</span>.  The value in the index is '<span class="VarName">&lt;value&gt;</span>', while the value in the base table is '<span class="VarName">&lt;value&gt;</span>'.  The full index key, including the row location, is '<span class="VarName">&lt;indexKey&gt;</span>'.  The suggested corrective action is to recreate the index.</td>
                    </tr>
                    <tr>
                        <td><code>X0X62.S</code></td>
                        <td>Inconsistency found between table '<span class="VarName">&lt;tableName&gt;</span>' and index '<span class="VarName">&lt;indexName&gt;</span>'.  Error when trying to retrieve row location '<span class="VarName">&lt;rowLocation&gt;</span>' from the table.  The full index key, including the row location, is '<span class="VarName">&lt;indexKey&gt;</span>'. The suggested corrective action is to recreate the index.</td>
                    </tr>
                    <tr>
                        <td><code>X0X63.S</code></td>
                        <td>Got IOException '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0X67.S</code></td>
                        <td>Columns of type '<span class="VarName">&lt;type&gt;</span>' may not be used in CREATE INDEX, ORDER BY, GROUP BY, UNION, INTERSECT, EXCEPT or DISTINCT statements because comparisons are not supported for that type.</td>
                    </tr>
                    <tr>
                        <td><code>X0X81.S</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>X0X85.S</code></td>
                        <td>Index '<span class="VarName">&lt;indexName&gt;</span>' was not created because '<span class="VarName">&lt;indexType&gt;</span>' is not a valid index type.</td>
                    </tr>
                    <tr>
                        <td><code>X0X86.S</code></td>
                        <td>0 is an invalid parameter value for ResultSet.absolute(int row).</td>
                    </tr>
                    <tr>
                        <td><code>X0X87.S</code></td>
                        <td>ResultSet.relative(int row) cannot be called when the cursor is not positioned on a row.</td>
                    </tr>
                    <tr>
                        <td><code>X0X95.S</code></td>
                        <td>Operation '<span class="VarName">&lt;operationName&gt;</span>' cannot be performed on object '<span class="VarName">&lt;objectName&gt;</span>' because there is an open ResultSet dependent on that object.</td>
                    </tr>
                    <tr>
                        <td><code>X0X99.S</code></td>
                        <td>Index '<span class="VarName">&lt;indexName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y16.S</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' is not a view.  If it is a table, then use DROP TABLE instead.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y23.S</code></td>
                        <td>Operation '<span class="VarName">&lt;operationName&gt;</span>' cannot be performed on object '<span class="VarName">&lt;objectName&gt;</span>' because VIEW '<span class="VarName">&lt;viewName&gt;</span>' is dependent on that object.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y24.S</code></td>
                        <td>Operation '<span class="VarName">&lt;operationName&gt;</span>' cannot be performed on object '<span class="VarName">&lt;objectName&gt;</span>' because STATEMENT '<span class="VarName">&lt;statement&gt;</span>' is dependent on that object.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y25.S</code></td>
                        <td>Operation '<span class="VarName">&lt;operationName&gt;</span>' cannot be performed on object '<span class="VarName">&lt;objectName&gt;</span>' because <span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>' is dependent on that object.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y26.S</code></td>
                        <td>Index '<span class="VarName">&lt;indexName&gt;</span>' is required to be in the same schema as table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y28.S</code></td>
                        <td>Index '<span class="VarName">&lt;indexName&gt;</span>' cannot be created on system table '<span class="VarName">&lt;tableName&gt;</span>'.  Users cannot create indexes on system tables.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y29.S</code></td>
                        <td>Operation '<span class="VarName">&lt;operationName&gt;</span>' cannot be performed on object '<span class="VarName">&lt;objectName&gt;</span>' because TABLE '<span class="VarName">&lt;tableName&gt;</span>' is dependent on that object.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y30.S</code></td>
                        <td>Operation '<span class="VarName">&lt;operationName&gt;</span>' cannot be performed on object '<span class="VarName">&lt;objectName&gt;</span>' because ROUTINE '<span class="VarName">&lt;routineName&gt;</span>' is dependent on that object.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y32.S</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>' already exists in <span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y38.S</code></td>
                        <td>Cannot create index '<span class="VarName">&lt;indexName&gt;</span>' because table '<span class="VarName">&lt;tableName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y41.S</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is invalid because the referenced table <span class="VarName">&lt;tableName&gt;</span> has no primary key.  Either add a primary key to <span class="VarName">&lt;tableName&gt;</span> or explicitly specify the columns of a unique constraint that this foreign key references. </td>
                    </tr>
                    <tr>
                        <td><code>X0Y42.S</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is invalid: the types of the foreign key columns do not match the types of the referenced columns.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y43.S</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is invalid: the number of columns in <span class="VarName">&lt;value&gt;</span> (<span class="VarName">&lt;value&gt;</span>) does not match the number of columns in the referenced key (<span class="VarName">&lt;value&gt;</span>).</td>
                    </tr>
                    <tr>
                        <td><code>X0Y44.S</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is invalid: there is no unique or primary key constraint on table '<span class="VarName">&lt;tableName&gt;</span>' that matches the number and types of the columns in the foreign key.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y45.S</code></td>
                        <td>Foreign key constraint '<span class="VarName">&lt;constraintName&gt;</span>' cannot be added to or enabled on table <span class="VarName">&lt;tableName&gt;</span> because one or more foreign keys do not have matching referenced keys.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y46.S</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is invalid: referenced table <span class="VarName">&lt;tableName&gt;</span> does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y54.S</code></td>
                        <td>Schema '<span class="VarName">&lt;schemaName&gt;</span>' cannot be dropped because it is not empty.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y55.S</code></td>
                        <td>The number of rows in the base table does not match the number of rows in at least 1 of the indexes on the table. Index '<span class="VarName">&lt;indexName&gt;</span>' on table '<span class="VarName">&lt;schemaName&gt;</span>.<span class="VarName">&lt;tableName&gt;</span>' has <span class="VarName">&lt;number&gt;</span> rows, but the base table has <span class="VarName">&lt;number&gt;</span> rows.  The suggested corrective action is to recreate the index.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y56.S</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' is not allowed on the System table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y57.S</code></td>
                        <td>A non-nullable column cannot be added to table '<span class="VarName">&lt;tableName&gt;</span>' because the table contains at least one row. Non-nullable columns can only be added to empty tables.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y58.S</code></td>
                        <td>Attempt to add a primary key constraint to table '<span class="VarName">&lt;tableName&gt;</span>' failed because the table already has a constraint of that type.  A table can only have a single primary key constraint.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y59.S</code></td>
                        <td>Attempt to add or enable constraint(s) on table '<span class="VarName">&lt;tableName&gt;</span>' failed because the table contains <span class="VarName">&lt;rowName&gt;</span> row(s) that violate the following check constraint(s): <span class="VarName">&lt;constraintName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y63.S</code></td>
                        <td>The command on table '<span class="VarName">&lt;tableName&gt;</span>' failed because null data was found in the primary key or unique constraint/index column(s). All columns in a primary or unique index key must not be null.  </td>
                    </tr>
                    <tr>
                        <td><code>X0Y63.S.1</code></td>
                        <td>The command on table '<span class="VarName">&lt;tableName&gt;</span>' failed because null data was found in the primary key/index column(s). All columns in a primary key must not be null.  </td>
                    </tr>
                    <tr>
                        <td><code>X0Y66.S</code></td>
                        <td>Cannot issue commit in a nested connection when there is a pending operation in the parent connection.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y67.S</code></td>
                        <td>Cannot issue rollback in a nested connection when there is a pending operation in the parent connection.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y68.S</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>' already exists.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y69.S</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> is not supported in trigger <span class="VarName">&lt;triggerName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y70.S</code></td>
                        <td>INSERT, UPDATE and DELETE are not permitted on table <span class="VarName">&lt;tableName&gt;</span> because trigger <span class="VarName">&lt;triggerName&gt;</span> is active.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y71.S</code></td>
                        <td>Transaction manipulation such as SET ISOLATION is not permitted because trigger <span class="VarName">&lt;triggerName&gt;</span> is active.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y72.S</code></td>
                        <td>Bulk insert replace is not permitted on '<span class="VarName">&lt;value&gt;</span>' because it has an enabled trigger (<span class="VarName">&lt;value&gt;</span>).</td>
                    </tr>
                    <tr>
                        <td><code>X0Y77.S</code></td>
                        <td>Cannot issue set transaction isolation statement on a global transaction that is in progress because it would have implicitly committed the global transaction.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y78.S</code></td>
                        <td>Statement.executeQuery() cannot be called with a statement that returns a row count.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y78.S.1</code></td>
                        <td><span class="VarName">&lt;value&gt;</span>.executeQuery() cannot be called because multiple result sets were returned.  Use <span class="VarName">&lt;value&gt;</span>.execute() to obtain multiple results.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y78.S.2</code></td>
                        <td><span class="VarName">&lt;value&gt;</span>.executeQuery() was called but no result set was returned. Use <span class="VarName">&lt;value&gt;</span>.executeUpdate() for non-queries.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y79.S</code></td>
                        <td>Statement.executeUpdate() cannot be called with a statement that returns a ResultSet.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y80.S</code></td>
                        <td>ALTER table '<span class="VarName">&lt;tableName&gt;</span>' failed. Null data found in column '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y83.S</code></td>
                        <td>WARNING: While deleting a row from a table the index row for base table row <span class="VarName">&lt;rowName&gt;</span> was not found in index with conglomerate id <span class="VarName">&lt;id&gt;</span>.  This problem has automatically been corrected as part of the delete operation.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y84.T</code></td>
                        <td>Too much contention on sequence <span class="VarName">&lt;sequenceName&gt;</span>. This is probably caused by an uncommitted scan of the SYS.SYSSEQUENCES catalog. Do not query this catalog directly. Instead, use the SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE function to view the current value of a query generator.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y85.S</code></td>
                        <td>The Splice property '<span class="VarName">&lt;propertyName&gt;</span>' identifies a class which cannot be instantiated: '<span class="VarName">&lt;className&gt;</span>'. See the next exception for details.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y86.S</code></td>
                        <td>Splice could not obtain the locks needed to release the unused, preallocated values for the sequence '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;sequenceName&gt;</span>'. As a result, unexpected gaps may appear in this sequence.</td>
                    </tr>
                    <tr>
                        <td><code>X0Y87.S</code></td>
                        <td>There is already an aggregate or function with one argument whose name is '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;aggregateOrFunctionName&gt;</span>'.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

