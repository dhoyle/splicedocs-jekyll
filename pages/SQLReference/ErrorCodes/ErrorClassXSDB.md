---
title: Splice Machine Error Codes - Class XSDB&#58; RawStore - Data.Generic transaction
summary: Summary of Splice Machine Class XSDB Errors
keywords: XSDB errors, error XSDB
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxsdb.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSDB: RawStore - Data.Generic transaction

<table>
                <caption>Error Class XSDB: RawStore - Data.Generic transaction</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSDB0.D</code></td>
                        <td>Unexpected exception on in-memory page <span class="VarName">&lt;page&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDB1.D</code></td>
                        <td>Unknown page format at page <span class="VarName">&lt;page&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDB2.D</code></td>
                        <td>Unknown container format at container <span class="VarName">&lt;containerName&gt;</span> : <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDB3.D</code></td>
                        <td>Container information cannot change once written: was <span class="VarName">&lt;value&gt;</span>, now <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDB4.D</code></td>
                        <td>Page <span class="VarName">&lt;page&gt;</span> is at version <span class="VarName">&lt;versionNumber&gt;</span>, the log file contains change version <span class="VarName">&lt;versionNumber&gt;</span>, either there are log records of this page missing, or this page did not get written out to disk properly.</td>
                    </tr>
                    <tr>
                        <td><code>XSDB5.D</code></td>
                        <td>Log has change record on page <span class="VarName">&lt;page&gt;</span>, which is beyond the end of the container.</td>
                    </tr>
                    <tr>
                        <td><code>XSDB6.D</code></td>
                        <td>Another instance of Splice may have already booted the database <span class="VarName">&lt;databaseName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDB7.D</code></td>
                        <td>WARNING: Splice (instance <span class="VarName">&lt;value&gt;</span>) is attempting to boot the database <span class="VarName">&lt;databaseName&gt;</span> even though Splice (instance <span class="VarName">&lt;value&gt;</span>) may still be active.  Only one instance of Splice should boot a database at a time. Severe and non-recoverable corruption can result and may have already occurred.</td>
                    </tr>
                    <tr>
                        <td><code>XSDB8.D</code></td>
                        <td>WARNING: Splice (instance <span class="VarName">&lt;value&gt;</span>) is attempting to boot the database <span class="VarName">&lt;databaseName&gt;</span> even though Splice (instance <span class="VarName">&lt;value&gt;</span>) may still be active.  Only one instance of Splice should boot a database at a time. Severe and non-recoverable corruption can result if 2 instances of Splice boot on the same database at the same time.  The derby.database.forceDatabaseLock=true property has been set, so the database will not boot until the db.lck is no longer present.  Normally this file is removed when the first instance of Splice to boot on the database exits, but it may be left behind in some shutdowns.  It will be necessary to remove the file by hand in that case.  It is important to verify that no other VM is accessing the database before deleting the db.lck file by hand.</td>
                    </tr>
                    <tr>
                        <td><code>XSDB9.D</code></td>
                        <td>Stream container <span class="VarName">&lt;containerName&gt;</span> is corrupt.</td>
                    </tr>
                    <tr>
                        <td><code>XSDBA.D</code></td>
                        <td>Attempt to allocate object <span class="VarName">&lt;object&gt;</span> failed.</td>
                    </tr>
                    <tr>
                        <td><code>XSDBB.D</code></td>
                        <td>Unknown page format at page <span class="VarName">&lt;page&gt;</span>, page dump follows: <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDBC.D</code></td>
                        <td>Write of container information to page 0 of container <span class="VarName">&lt;container&gt;</span> failed.  See nested error for more information.  </td>
                    </tr>
                </tbody>
            </table>
</div>
</section>
