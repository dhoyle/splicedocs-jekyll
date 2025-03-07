---
title: Splice Machine Error Codes - Class XCL&#58; Execution exceptions
summary: Summary of Splice Machine Class XCL Errors
keywords: XCL errors, error xcl
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxcl.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XCL: Execution exceptions

<table>
                <caption>Error Class XCL: Execution exceptions</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XCL01.S</code></td>
                        <td>Result set does not return rows. Operation <span class="VarName">&lt;operationName&gt;</span> not permitted. </td>
                    </tr>
                    <tr>
                        <td><code>XCL05.S</code></td>
                        <td>Activation closed, operation <span class="VarName">&lt;operationName&gt;</span> not permitted.</td>
                    </tr>
                    <tr>
                        <td><code>XCL07.S</code></td>
                        <td>Cursor '<span class="VarName">&lt;cursorName&gt;</span>' is closed. Verify that autocommit is OFF.</td>
                    </tr>
                    <tr>
                        <td><code>XCL08.S</code></td>
                        <td>Cursor '<span class="VarName">&lt;cursorName&gt;</span>' is not on a row.</td>
                    </tr>
                    <tr>
                        <td><code>XCL09.S</code></td>
                        <td>An Activation was passed to the '<span class="VarName">&lt;methodName&gt;</span>' method that does not match the PreparedStatement.</td>
                    </tr>
                    <tr>
                        <td><code>XCL10.S</code></td>
                        <td>A PreparedStatement has been recompiled and the parameters have changed. If you are using JDBC you must prepare the statement again.  </td>
                    </tr>
                    <tr>
                        <td><code>XCL12.S</code></td>
                        <td>An attempt was made to put a data value of type '<span class="VarName">&lt;datatypeName&gt;</span>' into a data value of type '<span class="VarName">&lt;datatypeName&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XCL13.S</code></td>
                        <td>The parameter position '<span class="VarName">&lt;parameterPosition&gt;</span>' is out of range.  The number of parameters for this prepared  statement is '<span class="VarName">&lt;number&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XCL14.S</code></td>
                        <td>The column position '<span class="VarName">&lt;columnPosition&gt;</span>' is out of range.  The number of columns for this ResultSet is '<span class="VarName">&lt;number&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XCL15.S</code></td>
                        <td>A ClassCastException occurred when calling the compareTo() method on an object '<span class="VarName">&lt;object&gt;</span>'.  The parameter to compareTo() is of class '<span class="VarName">&lt;className&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XCL16.S</code></td>
                        <td>ResultSet not open. Operation '<span class="VarName">&lt;operation&gt;</span>' not permitted. Verify that autocommit is OFF.</td>
                    </tr>
                    <tr>
                        <td><code>XCL18.S</code></td>
                        <td>Stream or LOB value cannot be retrieved more than once</td>
                    </tr>
                    <tr>
                        <td><code>XCL19.S</code></td>
                        <td>Missing row in table '<span class="VarName">&lt;tableName&gt;</span>' for key '<span class="VarName">&lt;key&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XCL20.S</code></td>
                        <td>Catalogs at version level '<span class="VarName">&lt;versionNumber&gt;</span>' cannot be upgraded to version level '<span class="VarName">&lt;versionNumber&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XCL21.S</code></td>
                        <td>You are trying to execute a Data Definition statement (CREATE, DROP, or ALTER) while preparing a different statement. This is not allowed. It can happen if you execute a Data Definition statement from within a static initializer of a Java class that is being used from within a SQL statement.</td>
                    </tr>
                    <tr>
                        <td><code>XCL22.S</code></td>
                        <td>Parameter <span class="VarName">&lt;parameterName&gt;</span> cannot be registered as an OUT parameter because it is an IN parameter. </td>
                    </tr>
                    <tr>
                        <td><code>XCL23.S</code></td>
                        <td>SQL type number '<span class="VarName">&lt;type&gt;</span>' is not a supported type by registerOutParameter().</td>
                    </tr>
                    <tr>
                        <td><code>XCL24.S</code></td>
                        <td>Parameter <span class="VarName">&lt;parameterName&gt;</span> appears to be an output parameter, but it has not been so designated by registerOutParameter().  If it is not an output parameter, then it has to be set to type <span class="VarName">&lt;type&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XCL25.S</code></td>
                        <td>Parameter <span class="VarName">&lt;parameterName&gt;</span> cannot be registered to be of type <span class="VarName">&lt;type&gt;</span> because it maps to type <span class="VarName">&lt;type&gt;</span> and they are incompatible.</td>
                    </tr>
                    <tr>
                        <td><code>XCL26.S</code></td>
                        <td>Parameter <span class="VarName">&lt;parameterName&gt;</span> is not an output parameter.</td>
                    </tr>
                    <tr>
                        <td><code>XCL27.S</code></td>
                        <td>Return output parameters cannot be set.</td>
                    </tr>
                    <tr>
                        <td><code>XCL30.S</code></td>
                        <td>An IOException was thrown when reading a '<span class="VarName">&lt;value&gt;</span>' from an InputStream.</td>
                    </tr>
                    <tr>
                        <td><code>XCL31.S</code></td>
                        <td>Statement closed.</td>
                    </tr>
                    <tr>
                        <td><code>XCL33.S</code></td>
                        <td>The table cannot be defined as a dependent of table <span class="VarName">&lt;tableName&gt;</span> because of delete rule restrictions. (The relationship is self-referencing and a self-referencing relationship already exists with the SET NULL delete rule.) </td>
                    </tr>
                    <tr>
                        <td><code>XCL34.S</code></td>
                        <td>The table cannot be defined as a dependent of table <span class="VarName">&lt;tableName&gt;</span> because of delete rule restrictions. (The relationship forms a cycle of two or more tables that cause the table to be delete-connected to itself (all other delete rules in the cycle would be CASCADE)).  </td>
                    </tr>
                    <tr>
                        <td><code>XCL35.S</code></td>
                        <td>The table cannot be defined as a dependent of table <span class="VarName">&lt;tableName&gt;</span> because of delete rule restrictions. (The relationship causes the table to be delete-connected to the indicated table through multiple relationships and the delete rule of the existing relationship is SET NULL.).  </td>
                    </tr>
                    <tr>
                        <td><code>XCL36.S</code></td>
                        <td>The delete rule of foreign key must be <span class="VarName">&lt;value&gt;</span>. (The referential constraint is self-referencing and an existing self-referencing constraint has the indicated delete rule (NO ACTION, RESTRICT or CASCADE).)</td>
                    </tr>
                    <tr>
                        <td><code>XCL37.S</code></td>
                        <td>The delete rule of foreign key must be <span class="VarName">&lt;value&gt;</span>. (The referential constraint is self-referencing and the table is dependent in a relationship with a delete rule of CASCADE.)</td>
                    </tr>
                    <tr>
                        <td><code>XCL38.S</code></td>
                        <td>the delete rule of foreign key  must be <span class="VarName">&lt;ruleName&gt;</span>. (The relationship would cause the table to be delete-connected to the same table through multiple relationships and such relationships must have the same delete rule (NO ACTION, RESTRICT or CASCADE).) </td>
                    </tr>
                    <tr>
                        <td><code>XCL39.S</code></td>
                        <td>The delete rule of foreign key cannot be CASCADE. (A self-referencing constraint exists with a delete rule of SET NULL, NO ACTION or RESTRICT.) </td>
                    </tr>
                    <tr>
                        <td><code>XCL40.S</code></td>
                        <td>The delete rule of foreign key cannot be CASCADE. (The relationship would form a cycle that would cause a table to be delete-connected to itself. One of the existing delete rules in the cycle is not CASCADE, so this relationship may be definable if the delete rule is not CASCADE.) </td>
                    </tr>
                    <tr>
                        <td><code>XCL41.S</code></td>
                        <td>the delete rule of foreign key can not be CASCADE. (The relationship would cause another table to be delete-connected to the same table through multiple paths with different delete rules or with delete rule equal to SET NULL.) </td>
                    </tr>
                    <tr>
                        <td><code>XCL42.S</code></td>
                        <td>CASCADE</td>
                    </tr>
                    <tr>
                        <td><code>XCL43.S</code></td>
                        <td>SET NULL</td>
                    </tr>
                    <tr>
                        <td><code>XCL44.S</code></td>
                        <td>RESTRICT</td>
                    </tr>
                    <tr>
                        <td><code>XCL45.S</code></td>
                        <td>NO ACTION</td>
                    </tr>
                    <tr>
                        <td><code>XCL46.S</code></td>
                        <td>SET DEFAULT</td>
                    </tr>
                    <tr>
                        <td><code>XCL47.S</code></td>
                        <td>Use of '<span class="VarName">&lt;value&gt;</span>' requires database to be upgraded from version <span class="VarName">&lt;versionNumber&gt;</span> to version <span class="VarName">&lt;versionNumber&gt;</span> or later.</td>
                    </tr>
                    <tr>
                        <td><code>XCL48.S</code></td>
                        <td> TRUNCATE TABLE is not permitted on '<span class="VarName">&lt;value&gt;</span>' because unique/primary key constraints on this table are referenced by enabled foreign key constraints from other tables. </td>
                    </tr>
                    <tr>
                        <td><code>XCL49.S</code></td>
                        <td> TRUNCATE TABLE is not permitted on '<span class="VarName">&lt;value&gt;</span>' because it has an enabled DELETE trigger (<span class="VarName">&lt;value&gt;</span>).</td>
                    </tr>
                    <tr>
                        <td><code>XCL50.S</code></td>
                        <td>Upgrading the database from a previous version is not supported.  The database being accessed is at version level '<span class="VarName">&lt;versionNumber&gt;</span>', this software is at version level '<span class="VarName">&lt;versionNumber&gt;</span>'.    </td>
                    </tr>
                    <tr>
                        <td><code>XCL51.S</code></td>
                        <td>The requested function can not reference tables in SESSION schema.</td>
                    </tr>
                    <tr>
                        <td><code>XCL52.S</code></td>
                        <td>The statement has been cancelled or timed out.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

