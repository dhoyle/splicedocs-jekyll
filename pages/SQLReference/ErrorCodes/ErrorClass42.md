---
title: Splice Machine Error Codes - Class 42&#58; Syntax Error or Access Rule Violation
summary: Summary of Splice Machine Class 42 Errors
keywords: 42 errors, error 42
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class42.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 42: Syntax Error or Access Rule Violation

<table>
                <caption>Error Class 42: Syntax Error or Access Rule Violation</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>42000</code></td>
                        <td>Syntax error or access rule violation; see additional errors for details.</td>
                    </tr>
                    <tr>
                        <td><code>42500</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission on table '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42501</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission on table '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>' for grant.</td>
                    </tr>
                    <tr>
                        <td><code>42502</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission on column '<span class="VarName">&lt;columnName&gt;</span>' of table '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42503</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission on column '<span class="VarName">&lt;columnName&gt;</span>' of table '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>' for grant.</td>
                    </tr>
                    <tr>
                        <td><code>42504</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission on <span class="VarName">&lt;objectName&gt;</span> '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42505</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission on <span class="VarName">&lt;objectName&gt;</span> '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>' for grant.</td>
                    </tr>
                    <tr>
                        <td><code>42506</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' is not the owner of <span class="VarName">&lt;objectName&gt;</span> '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42507</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' can not perform the operation in schema '<span class="VarName">&lt;schemaName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42508</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' can not create schema '<span class="VarName">&lt;schemaName&gt;</span>'. Only database owner could issue this statement.</td>
                    </tr>
                    <tr>
                        <td><code>42509</code></td>
                        <td>Specified grant or revoke operation is not allowed on object '<span class="VarName">&lt;objectName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>4250A</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionName&gt;</span> permission on object '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;objectName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>4250B</code></td>
                        <td>Invalid database authorization property '<span class="VarName">&lt;value&gt;</span>=<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>4250C</code></td>
                        <td>User(s) '<span class="VarName">&lt;authorizationID&gt;</span>' must not be in both read-only and full-access authorization lists.</td>
                    </tr>
                    <tr>
                        <td><code>4250D</code></td>
                        <td>Repeated user(s) '<span class="VarName">&lt;authorizationID&gt;</span>' in access list '<span class="VarName">&lt;listName&gt;</span>';</td>
                    </tr>
                    <tr>
                        <td><code>4250E</code></td>
                        <td>Internal Error: invalid <span class="VarName">&lt;authorizationID&gt;</span> id in statement permission list.</td>
                    </tr>
                    <tr>
                        <td><code>4251A</code></td>
                        <td>Statement <span class="VarName">&lt;value&gt;</span> can only be issued by database owner.</td>
                    </tr>
                    <tr>
                        <td><code>4251B</code></td>
                        <td>PUBLIC is reserved and cannot be used as a user identifier or role name.</td>
                    </tr>
                    <tr>
                        <td><code>4251C</code></td>
                        <td>Role <span class="VarName">&lt;authorizationID&gt;</span> cannot be granted to <span class="VarName">&lt;authorizationID&gt;</span> because this would create a circularity.</td>
                    </tr>
                    <tr>
                        <td><code>4251D</code></td>
                        <td>Only the database owner can perform this operation.</td>
                    </tr>
                    <tr>
                        <td><code>4251E</code></td>
                        <td>No one can view the '<span class="VarName">&lt;tableName&gt;</span>'.'<span class="VarName">&lt;columnName&gt;</span>' column.</td>
                    </tr>
                    <tr>
                        <td><code>4251F</code></td>
                        <td>You cannot drop the credentials of the database owner.</td>
                    </tr>
                    <tr>
                        <td><code>4251G</code></td>
                        <td>Please set derby.authentication.builtin.algorithm to a valid message digest algorithm. The current authentication scheme is too weak to be used by NATIVE authentication.</td>
                    </tr>
                    <tr>
                        <td><code>4251H</code></td>
                        <td>Invalid NATIVE authentication specification. Please set derby.authentication.provider to a value of the form NATIVE:$credentialsDB or NATIVE:$credentialsDB:LOCAL (at the system level).</td>
                    </tr>
                    <tr>
                        <td><code>4251I</code></td>
                        <td>Authentication cannot be performed because the credentials database '<span class="VarName">&lt;databaseName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>4251J</code></td>
                        <td>The value for the property '<span class="VarName">&lt;propertyName&gt;</span>' is formatted badly.</td>
                    </tr>
                    <tr>
                        <td><code>4251K</code></td>
                        <td>The first credentials created must be those of the DBO.</td>
                    </tr>
                    <tr>
                        <td><code>4251L</code></td>
                        <td>The derby.authentication.provider property specifies '<span class="VarName">&lt;dbName&gt;</span>' as the name of the credentials database. This is not a valid name for a database.</td>
                    </tr>
                    <tr>
                        <td><code>4251M</code></td>
                        <td>User '<span class="VarName">&lt;authorizationID&gt;</span>' does not have <span class="VarName">&lt;permissionType&gt;</span> permission to analyze table '<span class="VarName">&lt;schemaName&gt;</span>'.<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42601</code></td>
                        <td>In an ALTER TABLE statement, the column '<span class="VarName">&lt;columnName&gt;</span>' has been specified as NOT NULL and either the DEFAULT clause was not specified or was specified as DEFAULT NULL.</td>
                    </tr>
                    <tr>
                        <td><code>42601.S.372</code></td>
                        <td>ALTER TABLE statement cannot add an IDENTITY column to a table.</td>
                    </tr>
                    <tr>
                        <td><code>42605</code></td>
                        <td>The number of arguments for function '<span class="VarName">&lt;functionName&gt;</span>' is incorrect.</td>
                    </tr>
                    <tr>
                        <td><code>42606</code></td>
                        <td>An invalid hexadecimal constant starting with '<span class="VarName">&lt;number&gt;</span>' has been detected.</td>
                    </tr>
                    <tr>
                        <td><code>42610</code></td>
                        <td>All the arguments to the COALESCE/VALUE function cannot be parameters. The function needs at least one argument that is not a parameter.</td>
                    </tr>
                    <tr>
                        <td><code>42611</code></td>
                        <td>The length, precision, or scale attribute for column, or type mapping '<span class="VarName">&lt;value&gt;</span>' is not valid. </td>
                    </tr>
                    <tr>
                        <td><code>42613</code></td>
                        <td>Multiple or conflicting keywords involving the '<span class="VarName">&lt;clause&gt;</span>' clause are present.</td>
                    </tr>
                    <tr>
                        <td><code>42621</code></td>
                        <td>A check constraint or generated column that is defined with '<span class="VarName">&lt;value&gt;</span>' is invalid.</td>
                    </tr>
                    <tr>
                        <td><code>42622</code></td>
                        <td>The name '<span class="VarName">&lt;name&gt;</span>' is too long. The maximum length is '<span class="VarName">&lt;number&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42734</code></td>
                        <td>Name '<span class="VarName">&lt;name&gt;</span>' specified in context '<span class="VarName">&lt;context&gt;</span>' is not unique.</td>
                    </tr>
                    <tr>
                        <td><code>42802</code></td>
                        <td>The number of values assigned is not the same as the number of specified or implied columns.</td>
                    </tr>
                    <tr>
                        <td><code>42803</code></td>
                        <td>An expression containing the column '<span class="VarName">&lt;columnName&gt;</span>' appears in the SELECT list and is not part of a GROUP BY clause.</td>
                    </tr>
                    <tr>
                        <td><code>42815.S.713</code></td>
                        <td>The replacement value for '<span class="VarName">&lt;value&gt;</span>' is invalid.</td>
                    </tr>
                    <tr>
                        <td><code>42815.S.171</code></td>
                        <td>The data type, length or value of arguments '<span class="VarName">&lt;value&gt;</span>' and '<span class="VarName">&lt;value&gt;</span>' is incompatible.</td>
                    </tr>
                    <tr>
                        <td><code>42818</code></td>
                        <td>Comparisons between '<span class="VarName">&lt;type&gt;</span>' and '<span class="VarName">&lt;type&gt;</span>' are not supported. Types must be comparable. String types must also have matching collation. If collation does not match, a possible solution is to cast operands to force them to the default collation (e.g. SELECT name FROM myTable WHERE CAST(name AS VARCHAR(128)) = 'T1')</td>
                    </tr>
                    <tr>
                        <td><code>42820</code></td>
                        <td>The floating point literal '<span class="VarName">&lt;string&gt;</span>' contains more than 30 characters.</td>
                    </tr>
                    <tr>
                        <td><code>42821</code></td>
                        <td>Columns of type '<span class="VarName">&lt;type&gt;</span>' cannot hold values of type '<span class="VarName">&lt;type&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42824</code></td>
                        <td>An operand of LIKE is not a string, or the first operand is not a column.</td>
                    </tr>
                    <tr>
                        <td><code>42831</code></td>
                        <td>'<span class="VarName">&lt;columnName&gt;</span>' cannot be a column of a primary key or unique key because it can contain null values.</td>
                    </tr>
                    <tr>
                        <td><code>42831.S.1</code></td>
                        <td>'<span class="VarName">&lt;columnName&gt;</span>' cannot be a column of a primary key because it can contain null values.</td>
                    </tr>
                    <tr>
                        <td><code>42834</code></td>
                        <td>SET NULL cannot be specified because FOREIGN KEY '<span class="VarName">&lt;key&gt;</span>'  cannot contain null values.  </td>
                    </tr>
                    <tr>
                        <td><code>42837</code></td>
                        <td>ALTER TABLE '<span class="VarName">&lt;tableName&gt;</span>' specified attributes for column '<span class="VarName">&lt;columnName&gt;</span>' that are not compatible with the existing column.</td>
                    </tr>
                    <tr>
                        <td><code>42846</code></td>
                        <td>Cannot convert types '<span class="VarName">&lt;type&gt;</span>' to '<span class="VarName">&lt;type&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42877</code></td>
                        <td>A qualified column name '<span class="VarName">&lt;columnName&gt;</span>' is not allowed in the ORDER BY clause.</td>
                    </tr>
                    <tr>
                        <td><code>42878</code></td>
                        <td>The ORDER BY clause of a SELECT UNION statement only supports unqualified column references and column position numbers. Other expressions are not currently supported.</td>
                    </tr>
                    <tr>
                        <td><code>42879</code></td>
                        <td>The ORDER BY clause may not contain column '<span class="VarName">&lt;columnName&gt;</span>', since the query specifies DISTINCT and that column does not appear in the query result.</td>
                    </tr>
                    <tr>
                        <td><code>4287A</code></td>
                        <td>The ORDER BY clause may not specify an expression, since the query specifies DISTINCT.</td>
                    </tr>
                    <tr>
                        <td><code>4287B</code></td>
                        <td>In this context, the ORDER BY clause may only specify a column number.</td>
                    </tr>
                    <tr>
                        <td><code>42884</code></td>
                        <td>No authorized routine named '<span class="VarName">&lt;routineName&gt;</span>' of type '<span class="VarName">&lt;type&gt;</span>' having compatible arguments was found.</td>
                    </tr>
                    <tr>
                        <td><code>42886</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' parameter '<span class="VarName">&lt;value&gt;</span>' requires a parameter marker '?'.</td>
                    </tr>
                    <tr>
                        <td><code>42894</code></td>
                        <td>DEFAULT value or IDENTITY attribute value is not valid for column '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>428C1</code></td>
                        <td>Only one identity column is allowed in a table.</td>
                    </tr>
                    <tr>
                        <td><code>428EK</code></td>
                        <td>The qualifier for a declared global temporary table name must be SESSION.</td>
                    </tr>
                    <tr>
                        <td><code>428C2</code></td>
                        <td>DELETE ROWS is not supported for ON '<span class="VarName">&lt;txnMode&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>428C3</code></td>
                        <td>Temporary table columns cannot be referenced by foreign keys.</td>
                    </tr>
                    <tr>
                        <td><code>428C4</code></td>
                        <td>Attempt to add temporary table, '<span class="VarName">&lt;txnMode&gt;</span>', as a view dependency.</td>
                    </tr>
                    <tr>
                        <td><code>42903</code></td>
                        <td>Invalid use of an aggregate function.</td>
                    </tr>
                    <tr>
                        <td><code>42908</code></td>
                        <td>The CREATE VIEW statement does not include a column list.</td>
                    </tr>
                    <tr>
                        <td><code>42909</code></td>
                        <td>The CREATE TABLE statement does not include a column list.</td>
                    </tr>
                    <tr>
                        <td><code>42915</code></td>
                        <td>Foreign  Key '<span class="VarName">&lt;key&gt;</span>' is invalid because '<span class="VarName">&lt;value&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42916</code></td>
                        <td>Synonym '<span class="VarName">&lt;synonym2&gt;</span>' cannot be created for '<span class="VarName">&lt;synonym1&gt;</span>' as it would result in a circular synonym chain.</td>
                    </tr>
                    <tr>
                        <td><code>42939</code></td>
                        <td>An object cannot be created with the schema name '<span class="VarName">&lt;schemaName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>4293A</code></td>
                        <td>A role cannot be created with the name '<span class="VarName">&lt;authorizationID&gt;</span>', the SYS prefix is reserved.</td>
                    </tr>
                    <tr>
                        <td><code>42962</code></td>
                        <td>Long column type column or parameter '<span class="VarName">&lt;columnName&gt;</span>' not permitted in declared global temporary tables or procedure definitions. </td>
                    </tr>
                    <tr>
                        <td><code>42995</code></td>
                        <td>The requested function does not apply to global temporary tables.</td>
                    </tr>
                    <tr>
                        <td><code>42X01</code></td>
                        <td>Syntax error: <span class="VarName">&lt;error&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42X02</code></td>
                        <td><span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42X03</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' is in more than one table in the FROM list.</td>
                    </tr>
                    <tr>
                        <td><code>42X04</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' is either not in any table in the FROM list or appears within a join specification and is outside the scope of the join specification or appears in a HAVING clause and is not in the GROUP BY list. If this is a CREATE or ALTER TABLE  statement then '<span class="VarName">&lt;columnName&gt;</span>' is not a column in the target table.</td>
                    </tr>
                    <tr>
                        <td><code>42X05</code></td>
                        <td>Table/View '<span class="VarName">&lt;objectName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>42X06</code></td>
                        <td>Too many result columns specified for table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X07</code></td>
                        <td>Null is only allowed in a VALUES clause within an INSERT statement.</td>
                    </tr>
                    <tr>
                        <td><code>42X08</code></td>
                        <td>The constructor for class '<span class="VarName">&lt;className&gt;</span>' cannot be used as an external virtual table because the class does not implement '<span class="VarName">&lt;constructorName&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42X09</code></td>
                        <td>The table or alias name '<span class="VarName">&lt;tableName&gt;</span>' is used more than once in the FROM list.</td>
                    </tr>
                    <tr>
                        <td><code>42X10</code></td>
                        <td>'<span class="VarName">&lt;tableName&gt;</span>' is not an exposed table name in the scope in which it appears.</td>
                    </tr>
                    <tr>
                        <td><code>42X12</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears more than once in the CREATE TABLE statement.  </td>
                    </tr>
                    <tr>
                        <td><code>42X13</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears more than once times in the column list of an INSERT statement. </td>
                    </tr>
                    <tr>
                        <td><code>42X14</code></td>
                        <td>'<span class="VarName">&lt;columnName&gt;</span>' is not a column in table or VTI '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X15</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears in a statement without a FROM list.</td>
                    </tr>
                    <tr>
                        <td><code>42X16</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears multiple times in the SET clause of an UPDATE statement.</td>
                    </tr>
                    <tr>
                        <td><code>42X17</code></td>
                        <td>In the Properties list of a FROM clause, the value '<span class="VarName">&lt;value&gt;</span>' is not valid as a joinOrder specification. Only the values FIXED and UNFIXED are valid.  </td>
                    </tr>
                    <tr>
                        <td><code>42X19</code></td>
                        <td>The WHERE or HAVING clause or CHECK CONSTRAINT definition is a '<span class="VarName">&lt;value&gt;</span>' expression.  It must be a BOOLEAN expression.</td>
                    </tr>
                    <tr>
                        <td><code>42X20</code></td>
                        <td>Syntax error; integer literal expected.</td>
                    </tr>
                    <tr>
                        <td><code>42X23</code></td>
                        <td>Cursor <span class="VarName">&lt;cursorName&gt;</span> is not updatable.</td>
                    </tr>
                    <tr>
                        <td><code>42X24</code></td>
                        <td>Column <span class="VarName">&lt;columnName&gt;</span> is referenced in the HAVING clause but is not in the GROUP BY list.</td>
                    </tr>
                    <tr>
                        <td><code>42X25</code></td>
                        <td>The '<span class="VarName">&lt;functionName&gt;</span>' function is not allowed on the type.</td>
                    </tr>
                    <tr>
                        <td><code>42X26</code></td>
                        <td>The class '<span class="VarName">&lt;className&gt;</span>' for column '<span class="VarName">&lt;columnName&gt;</span>' does not exist or is inaccessible. This can happen if the class is not public.</td>
                    </tr>
                    <tr>
                        <td><code>42X28</code></td>
                        <td>Delete table '<span class="VarName">&lt;tableName&gt;</span>' is not target of cursor '<span class="VarName">&lt;cursorName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X29</code></td>
                        <td>Update table '<span class="VarName">&lt;tableName&gt;</span>' is not the target of cursor '<span class="VarName">&lt;cursorName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X30</code></td>
                        <td>Cursor '<span class="VarName">&lt;cursorName&gt;</span>' not found. Verify that autocommit is OFF.</td>
                    </tr>
                    <tr>
                        <td><code>42X31</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' is not in the FOR UPDATE list of cursor '<span class="VarName">&lt;cursorName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X32</code></td>
                        <td>The number of columns in the derived column list must match the number of columns in table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X33</code></td>
                        <td>The derived column list contains a duplicate column name '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X34</code></td>
                        <td>There is a ? parameter in the select list.  This is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42X35</code></td>
                        <td>It is not allowed for both operands of '<span class="VarName">&lt;value&gt;</span>' to be ? parameters.</td>
                    </tr>
                    <tr>
                        <td><code>42X36</code></td>
                        <td>The '<span class="VarName">&lt;operator&gt;</span>' operator is not allowed to take a ? parameter as an operand.</td>
                    </tr>
                    <tr>
                        <td><code>42X37</code></td>
                        <td>The unary '<span class="VarName">&lt;operator&gt;</span>' operator is not allowed on the '<span class="VarName">&lt;type&gt;</span>' type.</td>
                    </tr>
                    <tr>
                        <td><code>42X38</code></td>
                        <td>'SELECT *' only allowed in EXISTS and NOT EXISTS subqueries.</td>
                    </tr>
                    <tr>
                        <td><code>42X39</code></td>
                        <td>Subquery is only allowed to return a single column.</td>
                    </tr>
                    <tr>
                        <td><code>42X40</code></td>
                        <td>A NOT statement has an operand that is not boolean . The operand of NOT must evaluate to TRUE, FALSE, or UNKNOWN. </td>
                    </tr>
                    <tr>
                        <td><code>42X41</code></td>
                        <td>In the Properties clause of a FROM list, the property '<span class="VarName">&lt;propertyName&gt;</span>' is not valid (the property was being set to '<span class="VarName">&lt;value&gt;</span>'). </td>
                    </tr>
                    <tr>
                        <td><code>42X42</code></td>
                        <td>Correlation name not allowed for column '<span class="VarName">&lt;columnName&gt;</span>' because it is part of the FOR UPDATE list.</td>
                    </tr>
                    <tr>
                        <td><code>42X43</code></td>
                        <td>The ResultSetMetaData returned for the class/object '<span class="VarName">&lt;className&gt;</span>' was null. In order to use this class as an external virtual table, the ResultSetMetaData cannot be null. </td>
                    </tr>
                    <tr>
                        <td><code>42X44</code></td>
                        <td>Invalid length '<span class="VarName">&lt;number&gt;</span>' in column specification.</td>
                    </tr>
                    <tr>
                        <td><code>42X45</code></td>
                        <td><span class="VarName">&lt;type&gt;</span> is an invalid type for argument number <span class="VarName">&lt;value&gt;</span> of <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42X46</code></td>
                        <td>There are multiple functions named '<span class="VarName">&lt;functionName&gt;</span>'. Use the full signature or the specific name.</td>
                    </tr>
                    <tr>
                        <td><code>42X47</code></td>
                        <td>There are multiple procedures named '<span class="VarName">&lt;procedureName&gt;</span>'. Use the full signature or the specific name.</td>
                    </tr>
                    <tr>
                        <td><code>42X48</code></td>
                        <td>Value '<span class="VarName">&lt;value&gt;</span>' is not a valid precision for <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42X49</code></td>
                        <td>Value '<span class="VarName">&lt;value&gt;</span>' is not a valid integer literal.</td>
                    </tr>
                    <tr>
                        <td><code>42X50</code></td>
                        <td>No method was found that matched the method call <span class="VarName">&lt;methodName&gt;</span>.<span class="VarName">&lt;value&gt;</span>(<span class="VarName">&lt;value&gt;</span>), tried all combinations of object and primitive types and any possible type conversion for any  parameters the method call may have. The method might exist but it is not public and/or static, or the parameter types are not method invocation convertible.</td>
                    </tr>
                    <tr>
                        <td><code>42X51</code></td>
                        <td>The class '<span class="VarName">&lt;className&gt;</span>' does not exist or is inaccessible. This can happen if the class is not public.</td>
                    </tr>
                    <tr>
                        <td><code>42X52</code></td>
                        <td>Calling  method ('<span class="VarName">&lt;methodName&gt;</span>') using a receiver of the Java primitive type '<span class="VarName">&lt;type&gt;</span>' is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42X53</code></td>
                        <td>The LIKE predicate can only have 'CHAR' or 'VARCHAR' operands. Type '<span class="VarName">&lt;type&gt;</span>' is not permitted.</td>
                    </tr>
                    <tr>
                        <td><code>42X54</code></td>
                        <td>The Java method '<span class="VarName">&lt;methodName&gt;</span>' has a ? as a receiver.  This is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42X55</code></td>
                        <td>Table name '<span class="VarName">&lt;tableName&gt;</span>' should be the same as '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X56</code></td>
                        <td>The number of columns in the view column list does not match the number of columns in the underlying query expression in the view definition for '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X57</code></td>
                        <td>The getColumnCount() for external virtual table '<span class="VarName">&lt;tableName&gt;</span>' returned an invalid value '<span class="VarName">&lt;value&gt;</span>'.  Valid values are greater than or equal to 1. </td>
                    </tr>
                    <tr>
                        <td><code>42X58</code></td>
                        <td>The number of columns on the left and right sides of the <span class="VarName">&lt;tableName&gt;</span> must be the same.</td>
                    </tr>
                    <tr>
                        <td><code>42X59</code></td>
                        <td>The number of columns in each VALUES constructor must be the same.</td>
                    </tr>
                    <tr>
                        <td><code>42X60</code></td>
                        <td>Invalid value '<span class="VarName">&lt;value&gt;</span>' for insertMode property specified for table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X61</code></td>
                        <td>Types '<span class="VarName">&lt;type&gt;</span>' and '<span class="VarName">&lt;type&gt;</span>' are not <span class="VarName">&lt;value&gt;</span> compatible.</td>
                    </tr>
                    <tr>
                        <td><code>42X62</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' is not allowed in the '<span class="VarName">&lt;schemaName&gt;</span>' schema.</td>
                    </tr>
                    <tr>
                        <td><code>42X63</code></td>
                        <td>The USING clause did not return any results. No parameters can be set. </td>
                    </tr>
                    <tr>
                        <td><code>42X64</code></td>
                        <td>In the Properties list, the invalid value '<span class="VarName">&lt;value&gt;</span>' was specified for the useStatistics property. The only valid values are TRUE or FALSE. </td>
                    </tr>
                    <tr>
                        <td><code>42X65</code></td>
                        <td>Index '<span class="VarName">&lt;index&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>42X66</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears more than once in the CREATE INDEX statement.</td>
                    </tr>
                    <tr>
                        <td><code>42X68</code></td>
                        <td>No field '<span class="VarName">&lt;fieldName&gt;</span>' was found belonging to class '<span class="VarName">&lt;className&gt;</span>'.  It may be that the field exists, but it is not public, or that the class does not exist or is not public.</td>
                    </tr>
                    <tr>
                        <td><code>42X69</code></td>
                        <td>It is not allowed to reference a field ('<span class="VarName">&lt;fieldName&gt;</span>') using a referencing expression of the Java primitive type '<span class="VarName">&lt;type&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X70</code></td>
                        <td>The number of columns in the table column list does not match the number of columns in the underlying query expression in the table definition for '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X71</code></td>
                        <td>Invalid data type '<span class="VarName">&lt;datatypeName&gt;</span>' for column '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X72</code></td>
                        <td>No static field '<span class="VarName">&lt;fieldName&gt;</span>' was found belonging to class '<span class="VarName">&lt;className&gt;</span>'.  The field might exist, but it is not public and/or static, or the class does not exist or the class is not public.  </td>
                    </tr>
                    <tr>
                        <td><code>42X73</code></td>
                        <td>Method resolution for signature <span class="VarName">&lt;value&gt;</span>.<span class="VarName">&lt;value&gt;</span>(<span class="VarName">&lt;value&gt;</span>) was ambiguous. (No single maximally specific method.)</td>
                    </tr>
                    <tr>
                        <td><code>42X74</code></td>
                        <td>Invalid CALL statement syntax.</td>
                    </tr>
                    <tr>
                        <td><code>42X75</code></td>
                        <td>No constructor was found with the signature <span class="VarName">&lt;value&gt;</span>(<span class="VarName">&lt;value&gt;</span>).  It may be that the parameter types are not method invocation convertible.</td>
                    </tr>
                    <tr>
                        <td><code>42X76</code></td>
                        <td>At least one column, '<span class="VarName">&lt;columnName&gt;</span>', in the primary key being added is nullable. All columns in a primary key must be non-nullable.</td>
                    </tr>
                    <tr>
                        <td><code>42X77</code></td>
                        <td>Column position '<span class="VarName">&lt;columnPosition&gt;</span>' is out of range for the query expression.</td>
                    </tr>
                    <tr>
                        <td><code>42X78</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' is not in the result of the query expression.</td>
                    </tr>
                    <tr>
                        <td><code>42X79</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears more than once in the result of the query expression.</td>
                    </tr>
                    <tr>
                        <td><code>42X80</code></td>
                        <td>VALUES clause must contain at least one element. Empty elements are not allowed. </td>
                    </tr>
                    <tr>
                        <td><code>42X81</code></td>
                        <td>A query expression must return at least one column.</td>
                    </tr>
                    <tr>
                        <td><code>42X82</code></td>
                        <td>The USING clause returned more than one row. Only single-row ResultSets are permissible.</td>
                    </tr>
                    <tr>
                        <td><code>42X83</code></td>
                        <td>The constraints on column '<span class="VarName">&lt;columnName&gt;</span>' require that it be both nullable and not nullable.</td>
                    </tr>
                    <tr>
                        <td><code>42X84</code></td>
                        <td>Index '<span class="VarName">&lt;index&gt;</span>' was created to enforce constraint '<span class="VarName">&lt;constraintName&gt;</span>'.  It can only be dropped by dropping the constraint.</td>
                    </tr>
                    <tr>
                        <td><code>42X85</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>'is required to be in the same schema as table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X86</code></td>
                        <td>ALTER TABLE failed. There is no constraint '<span class="VarName">&lt;constraintName&gt;</span>' on table '<span class="VarName">&lt;tableName&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42X87</code></td>
                        <td>At least one result expression (THEN or ELSE) of the '<span class="VarName">&lt;expression&gt;</span>' expression must not be a '?'. </td>
                    </tr>
                    <tr>
                        <td><code>42X88</code></td>
                        <td>A conditional has a non-Boolean operand. The operand of a conditional must evaluate to TRUE, FALSE, or UNKNOWN.  </td>
                    </tr>
                    <tr>
                        <td><code>42X89</code></td>
                        <td>Types '<span class="VarName">&lt;type&gt;</span>' and '<span class="VarName">&lt;type&gt;</span>' are not type compatible. Neither type is assignable to the other type.  </td>
                    </tr>
                    <tr>
                        <td><code>42X90</code></td>
                        <td>More than one primary key constraint specified for table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X91</code></td>
                        <td>Constraint name '<span class="VarName">&lt;constraintName&gt;</span>' appears more than once in the CREATE TABLE statement. </td>
                    </tr>
                    <tr>
                        <td><code>42X92</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears more than once in a constraint's column list.</td>
                    </tr>
                    <tr>
                        <td><code>42X93</code></td>
                        <td>Table '<span class="VarName">&lt;tableName&gt;</span>' contains a constraint definition with column '<span class="VarName">&lt;columnName&gt;</span>' which is not in the table.</td>
                    </tr>
                    <tr>
                        <td><code>42X94</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>42X96</code></td>
                        <td>The database class path contains an unknown jar file '<span class="VarName">&lt;fileName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42X98</code></td>
                        <td>Parameters are not allowed in a VIEW definition.</td>
                    </tr>
                    <tr>
                        <td><code>42X99</code></td>
                        <td>Parameters are not allowed in a TABLE definition.</td>
                    </tr>
                    <tr>
                        <td><code>42XA0</code></td>
                        <td>The generation clause for column '<span class="VarName">&lt;columnName&gt;</span>' has data type '<span class="VarName">&lt;datatypeName&gt;</span>', which cannot be assigned to the column's declared data type.</td>
                    </tr>
                    <tr>
                        <td><code>42XA1</code></td>
                        <td>The generation clause for column '<span class="VarName">&lt;columnName&gt;</span>' contains an aggregate. This is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42XA2</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' cannot appear in a GENERATION CLAUSE because it may return unreliable results.</td>
                    </tr>
                    <tr>
                        <td><code>42XA3</code></td>
                        <td>You may not override the value of generated column '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42XA4</code></td>
                        <td>The generation clause for column '<span class="VarName">&lt;columnName&gt;</span>' references other generated columns. This is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42XA5</code></td>
                        <td>Routine '<span class="VarName">&lt;routineName&gt;</span>' may issue SQL and therefore cannot appear in a GENERATION CLAUSE.</td>
                    </tr>
                    <tr>
                        <td><code>42XA6</code></td>
                        <td>'<span class="VarName">&lt;columnName&gt;</span>' is a generated column. It cannot be part of a foreign key whose referential action for DELETE is SET NULL or SET DEFAULT, or whose referential action for UPDATE is CASCADE.</td>
                    </tr>
                    <tr>
                        <td><code>42XA7</code></td>
                        <td>'<span class="VarName">&lt;columnName&gt;</span>' is a generated column. You cannot change its default value.</td>
                    </tr>
                    <tr>
                        <td><code>42XA8</code></td>
                        <td>You cannot rename '<span class="VarName">&lt;columnName&gt;</span>' because it is referenced by the generation clause of column '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42XA9</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' needs an explicit datatype. The datatype can be omitted only for columns with generation clauses.</td>
                    </tr>
                    <tr>
                        <td><code>42XAA</code></td>
                        <td>The NEW value of generated column '<span class="VarName">&lt;columnName&gt;</span>' is mentioned in the BEFORE action of a trigger. This is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42XAB</code></td>
                        <td>NOT NULL is allowed only if you explicitly declare a datatype.</td>
                    </tr>
                    <tr>
                        <td><code>42XAC</code></td>
                        <td>'INCREMENT BY' value can not be zero.</td>
                    </tr>
                    <tr>
                        <td><code>42XAE</code></td>
                        <td>'<span class="VarName">&lt;argName&gt;</span>' value out of range of datatype '<span class="VarName">&lt;datatypeName&gt;</span>'. Must be between '<span class="VarName">&lt;minValue&gt;</span>' and '<span class="VarName">&lt;maxValue&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42XAF</code></td>
                        <td>Invalid 'MINVALUE' value '<span class="VarName">&lt;minValue&gt;</span>'. Must be smaller than 'MAXVALUE: <span class="VarName">&lt;maxValue&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42XAG</code></td>
                        <td>Invalid 'START WITH' value '<span class="VarName">&lt;startValue&gt;</span>'. Must be between '<span class="VarName">&lt;minValue&gt;</span>' and '<span class="VarName">&lt;maxValue&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42XAH</code></td>
                        <td>A NEXT VALUE FOR expression may not appear in many contexts, including WHERE, ON, HAVING, ORDER BY, DISTINCT, CASE, GENERATION, and AGGREGATE clauses as well as WINDOW functions and CHECK constraints.</td>
                    </tr>
                    <tr>
                        <td><code>42XAI</code></td>
                        <td>The statement references the following sequence more than once: '<span class="VarName">&lt;sequenceName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42XAJ</code></td>
                        <td>The CREATE SEQUENCE statement has a redundant '<span class="VarName">&lt;clauseName&gt;</span>' clause.</td>
                    </tr>
                    <tr>
                        <td><code>42Y00</code></td>
                        <td>Class '<span class="VarName">&lt;className&gt;</span>' does not implement com.splicemachine.db.iapi.db.AggregateDefinition and thus cannot
					be used as an aggregate expression.</td>
                    </tr>
                    <tr>
                        <td><code>42Y01</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is invalid.</td>
                    </tr>
                    <tr>
                        <td><code>42Y03.S.0</code></td>
                        <td>'<span class="VarName">&lt;statement&gt;</span>' is not recognized as a function or procedure.</td>
                    </tr>
                    <tr>
                        <td><code>42Y03.S.1</code></td>
                        <td>'<span class="VarName">&lt;statement&gt;</span>' is not recognized as a procedure.</td>
                    </tr>
                    <tr>
                        <td><code>42Y03.S.2</code></td>
                        <td>'<span class="VarName">&lt;statement&gt;</span>' is not recognized as a function.</td>
                    </tr>
                    <tr>
                        <td><code>42Y04</code></td>
                        <td>Cannot create a procedure or function with EXTERNAL NAME '<span class="VarName">&lt;name&gt;</span>' because it is not a list separated by periods. The expected format is &lt;full java path&gt;.&lt;method name&gt;.</td>
                    </tr>
                    <tr>
                        <td><code>42Y05</code></td>
                        <td>There is no Foreign Key named '<span class="VarName">&lt;key&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y07</code></td>
                        <td>Schema '<span class="VarName">&lt;schemaName&gt;</span>' does not exist</td>
                    </tr>
                    <tr>
                        <td><code>42Y08</code></td>
                        <td>Foreign key constraints are not allowed on system tables.</td>
                    </tr>
                    <tr>
                        <td><code>42Y09</code></td>
                        <td>Void methods are only allowed within a CALL statement.</td>
                    </tr>
                    <tr>
                        <td><code>42Y10</code></td>
                        <td>A table constructor that is not in an INSERT statement has all ? parameters in one of its columns.  For each column, at least one of the rows must have a non-parameter.</td>
                    </tr>
                    <tr>
                        <td><code>42Y11</code></td>
                        <td>A join specification is required with the '<span class="VarName">&lt;clauseName&gt;</span>' clause.</td>
                    </tr>
                    <tr>
                        <td><code>42Y12</code></td>
                        <td>The ON clause of a JOIN is a '<span class="VarName">&lt;expressionType&gt;</span>' expression.  It must be a BOOLEAN expression.</td>
                    </tr>
                    <tr>
                        <td><code>42Y13</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' appears more than once in the CREATE VIEW statement.</td>
                    </tr>
                    <tr>
                        <td><code>42Y16</code></td>
                        <td>No public static method '<span class="VarName">&lt;methodName&gt;</span>' was found in class '<span class="VarName">&lt;className&gt;</span>'. The method might exist, but it is not public, or it is not static. </td>
                    </tr>
                    <tr>
                        <td><code>42Y22</code></td>
                        <td>Aggregate <span class="VarName">&lt;aggregateType&gt;</span> cannot operate on type <span class="VarName">&lt;type&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42Y23</code></td>
                        <td>Incorrect JDBC type info returned for column <span class="VarName">&lt;colunmName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42Y24</code></td>
                        <td>View '<span class="VarName">&lt;viewName&gt;</span>' is not updatable. (Views are currently not updatable.) </td>
                    </tr>
                    <tr>
                        <td><code>42Y25</code></td>
                        <td>'<span class="VarName">&lt;tableName&gt;</span>' is a system table.  Users are not allowed to modify the contents of this table.</td>
                    </tr>
                    <tr>
                        <td><code>42Y26</code></td>
                        <td>Aggregates are not allowed in the GROUP BY list.</td>
                    </tr>
                    <tr>
                        <td><code>42Y27</code></td>
                        <td>Parameters are not allowed in the trigger action.</td>
                    </tr>
                    <tr>
                        <td><code>42Y29</code></td>
                        <td>The SELECT list of a non-grouped query contains at least one invalid expression. When the SELECT list contains at least one aggregate then all entries must be valid aggregate expressions.</td>
                    </tr>
                    <tr>
                        <td><code>42Y30</code></td>
                        <td>The SELECT list of a grouped query contains at least one invalid expression. If a SELECT list has a GROUP BY, the list may only contain valid grouping expressions and valid aggregate expressions.  </td>
                    </tr>
                    <tr>
                        <td><code>42Y32</code></td>
                        <td>Aggregator class '<span class="VarName">&lt;className&gt;</span>' for aggregate '<span class="VarName">&lt;aggregateName&gt;</span>' on type <span class="VarName">&lt;type&gt;</span> does not implement
						com.splicemachine.db.iapi.sql.execute.ExecAggregator.
					</td>
                    </tr>
                    <tr>
                        <td><code>42Y33</code></td>
                        <td>Aggregate <span class="VarName">&lt;aggregateName&gt;</span> contains one or more aggregates.</td>
                    </tr>
                    <tr>
                        <td><code>42Y34</code></td>
                        <td>Column name '<span class="VarName">&lt;columnName&gt;</span>' matches more than one result column in table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y35</code></td>
                        <td>Column reference '<span class="VarName">&lt;reference&gt;</span>' is invalid. When the SELECT list contains at least one aggregate then all entries must be valid aggregate expressions.  </td>
                    </tr>
                    <tr>
                        <td><code>42Y36</code></td>
                        <td>Column reference '<span class="VarName">&lt;reference&gt;</span>' is invalid, or is part of an invalid expression.  For a SELECT list with a GROUP BY, the columns and expressions being selected may only contain valid grouping expressions and valid aggregate expressions.</td>
                    </tr>
                    <tr>
                        <td><code>42Y37</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' is a Java primitive and cannot be used with this operator.</td>
                    </tr>
                    <tr>
                        <td><code>42Y38</code></td>
                        <td>insertMode = replace is not permitted on an insert where the target table, '<span class="VarName">&lt;tableName&gt;</span>', is referenced in the SELECT.</td>
                    </tr>
                    <tr>
                        <td><code>42Y39</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' may not appear in a CHECK CONSTRAINT definition because it may return non-deterministic results.</td>
                    </tr>
                    <tr>
                        <td><code>42Y40</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' appears multiple times in the UPDATE OF column list for trigger '<span class="VarName">&lt;triggerName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y41</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' cannot be directly invoked via EXECUTE STATEMENT because it is part of a trigger.</td>
                    </tr>
                    <tr>
                        <td><code>42Y42</code></td>
                        <td>Scale '<span class="VarName">&lt;scaleValue&gt;</span>' is not a valid scale for a <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42Y43</code></td>
                        <td>Scale '<span class="VarName">&lt;scaleValue&gt;</span>' is not a valid scale with precision of '<span class="VarName">&lt;precision&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y44</code></td>
                        <td>Invalid key '<span class="VarName">&lt;key&gt;</span>' specified in the Properties list of a FROM list. The case-sensitive keys that are currently supported are '<span class="VarName">&lt;key&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42Y45</code></td>
                        <td>VTI '<span class="VarName">&lt;value&gt;</span>' cannot be bound because it is a special trigger VTI and this statement is not part of a trigger action or WHEN clause.</td>
                    </tr>
                    <tr>
                        <td><code>42Y46</code></td>
                        <td>Invalid Properties list in FROM list.  There is no index '<span class="VarName">&lt;index&gt;</span>' on table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y47</code></td>
                        <td>Invalid Properties list in FROM list.  The hint useSpark needs (true/false) and does not support '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y48</code></td>
                        <td>Invalid Properties list in FROM list.  Either there is no named constraint '<span class="VarName">&lt;constraintName&gt;</span>' on table '<span class="VarName">&lt;tableName&gt;</span>' or the constraint does not have a backing index.</td>
                    </tr>
                    <tr>
                        <td><code>42Y49</code></td>
                        <td>Multiple values specified for property key '<span class="VarName">&lt;key&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42Y50</code></td>
                        <td>Properties list for table '<span class="VarName">&lt;tableName&gt;</span>' may contain values for index or for constraint but not both.</td>
                    </tr>
                    <tr>
                        <td><code>42Y55</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' cannot be performed on '<span class="VarName">&lt;value&gt;</span>' because it does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>42Y56</code></td>
                        <td>Invalid join strategy '<span class="VarName">&lt;strategyValue&gt;</span>' specified in Properties list on table '<span class="VarName">&lt;tableName&gt;</span>'. The currently supported values for a join strategy are: <span class="VarName">&lt;supportedStrategyNames&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42Y58</code></td>
                        <td>NumberFormatException occurred when converting value '<span class="VarName">&lt;value&gt;</span>' for optimizer override '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y59</code></td>
                        <td>Invalid value, '<span class="VarName">&lt;value&gt;</span>', specified for hashInitialCapacity override. Value must be greater than 0.</td>
                    </tr>
                    <tr>
                        <td><code>42Y60</code></td>
                        <td>Invalid value, '<span class="VarName">&lt;value&gt;</span>', specified for hashLoadFactor override. Value must be greater than 0.0 and less than or equal to 1.0.</td>
                    </tr>
                    <tr>
                        <td><code>42Y61</code></td>
                        <td>Invalid value, '<span class="VarName">&lt;value&gt;</span>', specified for hashMaxCapacity override. Value must be greater than 0.</td>
                    </tr>
                    <tr>
                        <td><code>42Y62</code></td>
                        <td>'<span class="VarName">&lt;statement&gt;</span>' is not allowed on '<span class="VarName">&lt;viewName&gt;</span>' because it is a view.</td>
                    </tr>
                    <tr>
                        <td><code>42Y63</code></td>
                        <td>Hash join requires an optimizable equijoin predicate on a column in the selected index or heap.  An optimizable equijoin predicate does not exist on any column in table or index '<span class="VarName">&lt;index&gt;</span>'. Use the 'index' optimizer override to specify such an index or the heap on table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y64</code></td>
                        <td>bulkFetch value of '<span class="VarName">&lt;value&gt;</span>' is invalid. The minimum value for bulkFetch is 1.</td>
                    </tr>
                    <tr>
                        <td><code>42Y65</code></td>
                        <td>bulkFetch is not permitted on '<span class="VarName">&lt;joinType&gt;</span>' joins.</td>
                    </tr>
                    <tr>
                        <td><code>42Y66</code></td>
                        <td>bulkFetch is not permitted on updatable cursors. </td>
                    </tr>
                    <tr>
                        <td><code>42Y67</code></td>
                        <td>Schema '<span class="VarName">&lt;schemaName&gt;</span>' cannot be dropped.</td>
                    </tr>
                    <tr>
                        <td><code>42Y69</code></td>
                        <td>No valid execution plan was found for this statement. This is usually because an infeasible join strategy was chosen, or because an index was chosen which prevents the chosen join strategy from being used.</td>
                    </tr>
                    <tr>
                        <td><code>42Y70</code></td>
                        <td>The user specified an illegal join order. This could be caused by a join column from an inner table being passed as a parameter to an external virtual table.</td>
                    </tr>
                    <tr>
                        <td><code>42Y71</code></td>
                        <td>System function or procedure '<span class="VarName">&lt;procedureName&gt;</span>' cannot be dropped.</td>
                    </tr>
                    <tr>
                        <td><code>42Y82</code></td>
                        <td>System generated stored prepared statement '<span class="VarName">&lt;statement&gt;</span>' that cannot be dropped using DROP STATEMENT. It is part of a trigger. </td>
                    </tr>
                    <tr>
                        <td><code>42Y83</code></td>
                        <td>An untyped null is not permitted as an argument to aggregate <span class="VarName">&lt;aggregateName&gt;</span>.  Please cast the null to a suitable type.</td>
                    </tr>
                    <tr>
                        <td><code>42Y84</code></td>
                        <td>'<span class="VarName">&lt;value&gt;</span>' may not appear in a DEFAULT definition.</td>
                    </tr>
                    <tr>
                        <td><code>42Y85</code></td>
                        <td>The DEFAULT keyword is only allowed in a VALUES clause when the VALUES clause appears within an INSERT statement.</td>
                    </tr>
                    <tr>
                        <td><code>42Y90</code></td>
                        <td>FOR UPDATE is not permitted in this type of statement.  </td>
                    </tr>
                    <tr>
                        <td><code>42Y91</code></td>
                        <td>The USING clause is not permitted in an EXECUTE STATEMENT for a trigger action.</td>
                    </tr>
                    <tr>
                        <td><code>42Y92</code></td>
                        <td><span class="VarName">&lt;triggerName&gt;</span> triggers may only reference <span class="VarName">&lt;value&gt;</span> transition variables/tables.</td>
                    </tr>
                    <tr>
                        <td><code>42Y93</code></td>
                        <td>Illegal REFERENCING clause: only one name is permitted for each type of transition variable/table.</td>
                    </tr>
                    <tr>
                        <td><code>42Y94</code></td>
                        <td>An AND or OR has a non-boolean operand. The operands of AND and OR must evaluate to TRUE, FALSE, or UNKNOWN.  </td>
                    </tr>
                    <tr>
                        <td><code>42Y95</code></td>
                        <td>The '<span class="VarName">&lt;operatorName&gt;</span>' operator with a left operand type of '<span class="VarName">&lt;operandType&gt;</span>' and a right operand type of '<span class="VarName">&lt;operandType&gt;</span>' is not supported.</td>
                    </tr>
                    <tr>
                        <td><code>42Y96</code></td>
                        <td>Invalid Sort Strategy: '<span class="VarName">&lt;sortStrategy&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Y97</code></td>
                        <td>Invalid escape character at line '<span class="VarName">&lt;lineNumber&gt;</span>', column '<span class="VarName">&lt;columnName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Z02</code></td>
                        <td>Multiple DISTINCT aggregates are not supported at this time.</td>
                    </tr>
                    <tr>
                        <td><code>42Z07</code></td>
                        <td>Aggregates are not permitted in the ON clause.</td>
                    </tr>
                    <tr>
                        <td><code>42Z08</code></td>
                        <td>Bulk insert replace is not permitted on '<span class="VarName">&lt;value&gt;</span>' because it has an enabled trigger (<span class="VarName">&lt;value&gt;</span>).</td>
                    </tr>
                    <tr>
                        <td><code>42Z15</code></td>
                        <td>Invalid type specified for column '<span class="VarName">&lt;columnName&gt;</span>'. The type of a column may not be changed.  </td>
                    </tr>
                    <tr>
                        <td><code>42Z16</code></td>
                        <td>Only columns of type VARCHAR, CLOB, and BLOB may have their length altered. </td>
                    </tr>
                    <tr>
                        <td><code>42Z17</code></td>
                        <td>Invalid length specified for column '<span class="VarName">&lt;columnName&gt;</span>'. Length must be greater than the current column length.</td>
                    </tr>
                    <tr>
                        <td><code>42Z18</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' is part of a foreign key constraint '<span class="VarName">&lt;constraintName&gt;</span>'. To alter the length of this column, you should drop the constraint first, perform the ALTER TABLE, and then recreate the constraint.</td>
                    </tr>
                    <tr>
                        <td><code>42Z19</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' is being referenced by at least one foreign key constraint '<span class="VarName">&lt;constraintName&gt;</span>'. To alter the length of this column, you should drop referencing constraints, perform the ALTER TABLE and then recreate the constraints. </td>
                    </tr>
                    <tr>
                        <td><code>42Z20</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' cannot be made nullable. It is part of a primary key or unique constraint, which cannot have any nullable columns.</td>
                    </tr>
                    <tr>
                        <td><code>42Z20.S.1</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' cannot be made nullable. It is part of a primary key, which cannot have any nullable columns.</td>
                    </tr>
                    <tr>
                        <td><code>42Z21</code></td>
                        <td>Invalid increment specified for identity focr column '<span class="VarName">&lt;columnName&gt;</span>'. Increment cannot be zero.  </td>
                    </tr>
                    <tr>
                        <td><code>42Z22</code></td>
                        <td>Invalid type specified for identity column '<span class="VarName">&lt;columnName&gt;</span>'. The only valid types for identity columns are BIGINT, INT and SMALLINT.</td>
                    </tr>
                    <tr>
                        <td><code>42Z23</code></td>
                        <td>Attempt to modify an identity column '<span class="VarName">&lt;columnName&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42Z24</code></td>
                        <td>Overflow occurred in identity value for column '<span class="VarName">&lt;columnName&gt;</span>' in table '<span class="VarName">&lt;tableName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Z25</code></td>
                        <td>INTERNAL ERROR identity counter. Update was called without arguments with current value \= NULL.</td>
                    </tr>
                    <tr>
                        <td><code>42Z26</code></td>
                        <td>A column, '<span class="VarName">&lt;columnName&gt;</span>', with an identity default cannot be made nullable.</td>
                    </tr>
                    <tr>
                        <td><code>42Z27</code></td>
                        <td>A nullable column, '<span class="VarName">&lt;columnName&gt;</span>', cannot be modified to have identity default.</td>
                    </tr>
                    <tr>
                        <td><code>42Z50</code></td>
                        <td>INTERNAL ERROR: Unable to generate code for <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42Z53</code></td>
                        <td>INTERNAL ERROR: Type of activation to generate for node choice <span class="VarName">&lt;value&gt;</span> is unknown.</td>
                    </tr>
                    <tr>
                        <td><code>42Z60</code></td>
                        <td><span class="VarName">&lt;value&gt;</span> not allowed unless database property <span class="VarName">&lt;propertyName&gt;</span> has value '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Z70</code></td>
                        <td>Binding directly to an XML value is not allowed; try using XMLPARSE.</td>
                    </tr>
                    <tr>
                        <td><code>42Z71</code></td>
                        <td>XML values are not allowed in top-level result sets; try using XMLSERIALIZE.</td>
                    </tr>
                    <tr>
                        <td><code>42Z72</code></td>
                        <td>Missing SQL/XML keyword(s) '<span class="VarName">&lt;keywords&gt;</span>' at line <span class="VarName">&lt;lineNumber&gt;</span>, column <span class="VarName">&lt;columnNumber&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42Z73</code></td>
                        <td>Invalid target type for XMLSERIALIZE: '<span class="VarName">&lt;typeName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Z74</code></td>
                        <td>XML feature not supported: '<span class="VarName">&lt;featureName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42Z75</code></td>
                        <td>XML query expression must be a string literal.</td>
                    </tr>
                    <tr>
                        <td><code>42Z76</code></td>
                        <td>Multiple XML context items are not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42Z77</code></td>
                        <td>Context item must have type 'XML'; '<span class="VarName">&lt;value&gt;</span>' is not allowed.</td>
                    </tr>
                    <tr>
                        <td><code>42Z79</code></td>
                        <td>Unable to determine the parameter type for XMLPARSE; try using a CAST.</td>
                    </tr>
                    <tr>
                        <td><code>42Z90</code></td>
                        <td>Class '<span class="VarName">&lt;className&gt;</span>' does not return an updatable ResultSet.</td>
                    </tr>
                    <tr>
                        <td><code>42Z91</code></td>
                        <td>subquery</td>
                    </tr>
                    <tr>
                        <td><code>42Z92</code></td>
                        <td>repeatable read</td>
                    </tr>
                    <tr>
                        <td><code>42Z93</code></td>
                        <td>Constraints '<span class="VarName">&lt;constraintName&gt;</span>' and '<span class="VarName">&lt;constraintName&gt;</span>' have the same set of columns, which is not allowed. </td>
                    </tr>
                    <tr>
                        <td><code>42Z97</code></td>
                        <td>Renaming column '<span class="VarName">&lt;columnName&gt;</span>' will cause check constraint '<span class="VarName">&lt;constraintName&gt;</span>' to break.</td>
                    </tr>
                    <tr>
                        <td><code>42Z99</code></td>
                        <td>String or Hex literal cannot exceed 64K.</td>
                    </tr>
                    <tr>
                        <td><code>42Z9A</code></td>
                        <td>read uncommitted</td>
                    </tr>
                    <tr>
                        <td><code>42Z9B</code></td>
                        <td>The external virtual table interface does not support BLOB or CLOB columns. '<span class="VarName">&lt;value&gt;</span>' column '<span class="VarName">&lt;value&gt;</span>'. </td>
                    </tr>
                    <tr>
                        <td><code>42Z9D.S.1</code></td>
                        <td>Procedures that modify SQL data are not allowed in BEFORE triggers.</td>
                    </tr>
                    <tr>
                        <td><code>42Z9D</code></td>
                        <td>'<span class="VarName">&lt;statement&gt;</span>' statements are not allowed in '<span class="VarName">&lt;triggerName&gt;</span>' triggers.</td>
                    </tr>
                    <tr>
                        <td><code>42Z9E</code></td>
                        <td>Constraint '<span class="VarName">&lt;constraintName&gt;</span>' is not a <span class="VarName">&lt;value&gt;</span> constraint.</td>
                    </tr>
                    <tr>
                        <td><code>42Z9F</code></td>
                        <td>Too many indexes (<span class="VarName">&lt;index&gt;</span>) on the table <span class="VarName">&lt;tableName&gt;</span>. The limit is <span class="VarName">&lt;number&gt;</span>.  </td>
                    </tr>
                    <tr>
                        <td><code>42ZA0</code></td>
                        <td>Statement too complex. Try rewriting the query to remove complexity. Eliminating many duplicate expressions or breaking up the query and storing interim results in a temporary table can often help resolve this error.</td>
                    </tr>
                    <tr>
                        <td><code>42ZA1</code></td>
                        <td>Invalid SQL in Batch: '<span class="VarName">&lt;batch&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42ZA2</code></td>
                        <td>Operand of LIKE predicate with type <span class="VarName">&lt;type&gt;</span> and collation <span class="VarName">&lt;value&gt;</span> is not compatable with LIKE pattern operand with type <span class="VarName">&lt;type&gt;</span> and collation <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>42ZA3</code></td>
                        <td>The table will have collation type <span class="VarName">&lt;type&gt;</span> which is different than the collation of the schema <span class="VarName">&lt;type&gt;</span> hence this operation is not supported .</td>
                    </tr>
                    <tr>
                        <td><code>42ZB1</code></td>
                        <td>Parameter style SPLICE_JDBC_RESULT_SET is only allowed for table functions.</td>
                    </tr>
                    <tr>
                        <td><code>42ZB2</code></td>
                        <td>Table functions can only have parameter style SPLICE_JDBC_RESULT_SET.</td>
                    </tr>
                    <tr>
                        <td><code>42ZB3</code></td>
                        <td>XML is not allowed as the datatype of a user-defined aggregate or of a column returned by a table function.</td>
                    </tr>
                    <tr>
                        <td><code>42ZB4</code></td>
                        <td>'<span class="VarName">&lt;schemaName&gt;</span>'.<span class="VarName">&lt;functionName&gt;</span>' does not identify a table function.</td>
                    </tr>
                    <tr>
                        <td><code>42ZB5</code></td>
                        <td>Class '<span class="VarName">&lt;className&gt;</span>' implements VTICosting but does not provide a public, no-arg constructor.</td>
                    </tr>
                    <tr>
                        <td><code>42ZB6</code></td>
                        <td>A scalar value is expected, not a row set returned by a table function.</td>
                    </tr>
                    <tr>
                        <td><code>42ZC0</code></td>
                        <td>Window '<span class="VarName">&lt;windowName&gt;</span>' is not defined.</td>
                    </tr>
                    <tr>
                        <td><code>42ZC1</code></td>
                        <td>Only one window is supported.</td>
                    </tr>
                    <tr>
                        <td><code>42ZC2</code></td>
                        <td>Window function is illegal in this context: '<span class="VarName">&lt;clauseName&gt;</span>' clause</td>
                    </tr>
                    <tr>
                        <td><code>42ZC3</code></td>
                        <td>A user defined aggregate may not have the name of an aggregate defined by the SQL Standard or the name of a builtin Derby function having one argument: '<span class="VarName">&lt;aggregateName&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>42ZC4</code></td>
                        <td>User defined aggregate '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;aggregateName&gt;</span>' is bound to external class '<span class="VarName">&lt;className&gt;</span>'. The parameter types of that class could not be resolved.</td>
                    </tr>
                    <tr>
                        <td><code>42ZC6</code></td>
                        <td>User defined aggregate '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;aggregateName&gt;</span>' was declared to have this input Java type: '<span class="VarName">&lt;javaDataType&gt;</span>'. This does not extend the following actual bounding input Java type: '<span class="VarName">&lt;javaDataType&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42ZC7</code></td>
                        <td>User defined aggregate '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;aggregateName&gt;</span>' was declared to have this return Java type: '<span class="VarName">&lt;javaDataType&gt;</span>'. This does not extend the following actual bounding return Java type: '<span class="VarName">&lt;javaDataType&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>42ZC8</code></td>
                        <td>Implementing class '<span class="VarName">&lt;className&gt;</span>' for user defined aggregate '<span class="VarName">&lt;schemaName&gt;</span>'.'<span class="VarName">&lt;aggregateName&gt;</span>' could not be instantiated or was malformed. Detailed message follows: <span class="VarName">&lt;detailedMessage&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>43001</code></td>
                        <td>The truncate function was provided a null operand.</td>
                    </tr>
                    <tr>
                        <td><code>43002</code></td>
                        <td>The truncate function was provided an operand which it does not know how to handle: '<span class="VarName">&lt;operand&gt;</span>'. It requires a DATE, TIMESTAMP, INTEGER or DECIMAL type.</td>
                    </tr>
                    <tr>
                        <td><code>43003</code></td>
                        <td>The truncate function expects a right-side argument of type CHAR for an operand of type DATE or TIMESTAMP but got: '<span class="VarName">&lt;truncValue&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>43004</code></td>
                        <td>The truncate function expects a right-side argument of type INTEGER for an operand of type DECIMAL but got: '<span class="VarName">&lt;truncValue&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>43005</code></td>
                        <td>The truncate function got an invalid right-side trunc value for operand type DATE: '<span class="VarName">&lt;truncValue&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>43006</code></td>
                        <td>The truncate function got an unknown right-side trunc value for operand type '<span class="VarName">&lt;operand&gt;</span>': '<span class="VarName">&lt;truncValue&gt;</span>'. Acceptable values are: '<span class="VarName">&lt;acceptableValues&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>44001</code></td>
                        <td><span class="VarName">&lt;dateOrTimestamp&gt;</span>s cannot be multiplied or divided. The operation is undefined.</td>
                    </tr>
                    <tr>
                        <td><code>44002</code></td>
                        <td><span class="VarName">&lt;dateOrTimestamp&gt;</span>s cannot be added. The operation is undefined.</td>
                    </tr>
                    <tr>
                        <td><code>44003</code></td>
                        <td>Timestamp '<span class="VarName">&lt;dateOrTimestamp&gt;</span>' is out of range (~ from 0000-00-00 00:00:00 GMT to 9999-12-31 23:59:59 GMT).</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>
