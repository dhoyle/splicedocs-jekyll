---
title: Splice Machine Error Codes - Class XBM&#58; Monitor
summary: Summary of Splice Machine Class XBM Errors
keywords: XBM errors, error xbm
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_errcodes_classxbm.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XBM: Monitor

<table>
                <caption>Error Class XBM: Monitor</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XBM01.D</code></td>
                        <td>Startup failed due to an exception. See next exception for details. </td>
                    </tr>
                    <tr>
                        <td><code>XBM02.D</code></td>
                        <td>Startup failed due to missing functionality for <span class="VarName">&lt;value&gt;</span>. Please ensure your classpath includes the correct Splice software.</td>
                    </tr>
                    <tr>
                        <td><code>XBM05.D</code></td>
                        <td>Startup failed due to missing product version information for <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM06.D</code></td>
                        <td>Startup failed. An encrypted database cannot be accessed without the correct boot password.  </td>
                    </tr>
                    <tr>
                        <td><code>XBM07.D</code></td>
                        <td>Startup failed. Boot password must be at least 8 bytes long.</td>
                    </tr>
                    <tr>
                        <td><code>XBM08.D</code></td>
                        <td>Could not instantiate <span class="VarName">&lt;value&gt;</span> StorageFactory class <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0A.D</code></td>
                        <td>The database directory '<span class="VarName">&lt;directoryName&gt;</span>' exists. However, it does not contain the expected '<span class="VarName">&lt;servicePropertiesName&gt;</span>' file. Perhaps Splice was brought down in the middle of creating this database. You may want to delete this directory and try creating the database again.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0B.D</code></td>
                        <td>Failed to edit/write service properties file: <span class="VarName">&lt;errorMessage&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XBM0C.D</code></td>
                        <td>Missing privilege for operation '<span class="VarName">&lt;operation&gt;</span>' on file '<span class="VarName">&lt;path&gt;</span>': <span class="VarName">&lt;errorMessage&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XBM0G.D</code></td>
                        <td>Failed to start encryption engine. Please make sure you are running Java 2 and have downloaded an encryption provider such as jce and put it in your class path. </td>
                    </tr>
                    <tr>
                        <td><code>XBM0H.D</code></td>
                        <td>Directory <span class="VarName">&lt;directoryName&gt;</span> cannot be created.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0I.D</code></td>
                        <td>Directory <span class="VarName">&lt;directoryName&gt;</span> cannot be removed.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0J.D</code></td>
                        <td>Directory <span class="VarName">&lt;directoryName&gt;</span> already exists.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0K.D</code></td>
                        <td>Unknown sub-protocol for database name <span class="VarName">&lt;databaseName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0L.D</code></td>
                        <td>Specified authentication scheme class <span class="VarName">&lt;className&gt;</span> does implement the authentication interface <span class="VarName">&lt;interfaceName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0M.D</code></td>
                        <td>Error creating an instance of a class named '<span class="VarName">&lt;className&gt;</span>'. This class name was the value of the
						derby.authentication.provider property and was expected to be the name of an application-supplied
						implementation of com.splicemachine.db.authentication.UserAuthenticator. The underlying problem
					was: <span class="VarName">&lt;detail&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XBM0N.D</code></td>
                        <td>JDBC Driver registration with java.sql.DriverManager failed. See next exception for details. </td>
                    </tr>
                    <tr>
                        <td><code>XBM0P.D</code></td>
                        <td>Service provider is read-only. Operation not permitted. </td>
                    </tr>
                    <tr>
                        <td><code>XBM0Q.D</code></td>
                        <td>File <span class="VarName">&lt;fileName&gt;</span> not found. Please make sure that backup copy is the correct one and it is not corrupted.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0R.D</code></td>
                        <td>Unable to remove File <span class="VarName">&lt;fileName&gt;</span>.  </td>
                    </tr>
                    <tr>
                        <td><code>XBM0S.D</code></td>
                        <td>Unable to rename file '<span class="VarName">&lt;fileName&gt;</span>' to '<span class="VarName">&lt;fileName&gt;</span>'</td>
                    </tr>
                    <tr>
                        <td><code>XBM0T.D</code></td>
                        <td>Ambiguous sub-protocol for database name <span class="VarName">&lt;databaseName&gt;</span>.   </td>
                    </tr>
                    <tr>
                        <td><code>XBM0U.S</code></td>
                        <td>No class was registered for identifier <span class="VarName">&lt;identifierName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0V.S</code></td>
                        <td>An exception was thrown while loading class <span class="VarName">&lt;className&gt;</span> registered for identifier <span class="VarName">&lt;identifierName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0W.S</code></td>
                        <td>An exception was thrown while creating an instance of class <span class="VarName">&lt;className3&gt;</span> registered for identifier <span class="VarName">&lt;identifierName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0X.D</code></td>
                        <td>Supplied territory description '<span class="VarName">&lt;value&gt;</span>' is invalid, expecting ln[_CO[_variant]]
					ln=lower-case two-letter ISO-639 language code, CO=upper-case two-letter ISO-3166 country codes, see java.util.Locale.</td>
                    </tr>
                    <tr>
                        <td><code>XBM03.D</code></td>
                        <td>Supplied value '<span class="VarName">&lt;value&gt;</span>' for collation attribute is invalid, expecting UCS_BASIC or TERRITORY_BASED.</td>
                    </tr>
                    <tr>
                        <td><code>XBM04.D</code></td>
                        <td>Collator support not available from the JVM for the database's locale '<span class="VarName">&lt;value&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0Y.D</code></td>
                        <td>Backup database directory <span class="VarName">&lt;directoryName&gt;</span> not found. Please make sure that the specified backup path is right.</td>
                    </tr>
                    <tr>
                        <td><code>XBM0Z.D</code></td>
                        <td>Unable to copy file '<span class="VarName">&lt;fileName&gt;</span>' to '<span class="VarName">&lt;fileName&gt;</span>'. Please make sure that there is enough space and permissions are correct. </td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

