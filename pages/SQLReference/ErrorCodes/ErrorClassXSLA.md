---
title: Splice Machine Error Codes - Class XSLA&#58; RawStore - Log.Generic database exceptions
summary: Summary of Splice Machine Class XSLA Errors
keywords: XSLA errors, error XSLA
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxsla.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSLA: RawStore - Log.Generic database exceptions

<table>
                <caption>Error Class XSLA: RawStore - Log.Generic database exceptions</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSLA0.D</code></td>
                        <td>Cannot flush the log file to disk <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA1.D</code></td>
                        <td>Log Record has been sent to the stream, but it cannot be applied to the store (Object <span class="VarName">&lt;object&gt;</span>).  This may cause recovery problems also.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA2.D</code></td>
                        <td>System will shutdown, got I/O Exception while accessing log file.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA3.D</code></td>
                        <td>Log Corrupted, has invalid data in the log stream.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA4.D</code></td>
                        <td>Cannot write to the log, most likely the log is full.  Please delete unnecessary files.  It is also possible that the file system is read only, or the disk has failed, or some other problems with the media.  </td>
                    </tr>
                    <tr>
                        <td><code>XSLA5.D</code></td>
                        <td>Cannot read log stream for some reason to rollback transaction <span class="VarName">&lt;transactionID&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA6.D</code></td>
                        <td>Cannot recover the database.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA7.D</code></td>
                        <td>Cannot redo operation <span class="VarName">&lt;operation&gt;</span> in the log.</td>
                    </tr>
                    <tr>
                        <td><code>XSLA8.D</code></td>
                        <td>Cannot rollback transaction <span class="VarName">&lt;value&gt;</span>, trying to compensate <span class="VarName">&lt;value&gt;</span> operation with <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSLAA.D</code></td>
                        <td>The store has been marked for shutdown by an earlier exception.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAB.D</code></td>
                        <td>Cannot find log file <span class="VarName">&lt;logfileName&gt;</span>, please make sure your logDevice property is properly set with the correct path separator for your platform.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAC.D</code></td>
                        <td>Database at <span class="VarName">&lt;value&gt;</span> have incompatible format with the current version of software, it may have been created by or upgraded by a later version.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAD.D</code></td>
                        <td>log Record at instant <span class="VarName">&lt;value&gt;</span> in log file <span class="VarName">&lt;logfileName&gt;</span> corrupted. Expected log record length <span class="VarName">&lt;value&gt;</span>, real length <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAE.D</code></td>
                        <td>Control file at <span class="VarName">&lt;value&gt;</span> cannot be written or updated.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAF.D</code></td>
                        <td>A Read Only database was created with dirty data buffers.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAH.D</code></td>
                        <td>A Read Only database is being updated.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAI.D</code></td>
                        <td>Cannot log the checkpoint log record</td>
                    </tr>
                    <tr>
                        <td><code>XSLAJ.D</code></td>
                        <td>The logging system has been marked to shut down due to an earlier problem and will not allow any more operations until the system shuts down and restarts.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAK.D</code></td>
                        <td>Database has exceeded largest log file number <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAL.D</code></td>
                        <td>log record size <span class="VarName">&lt;value&gt;</span> exceeded the maximum allowable log file size <span class="VarName">&lt;number&gt;</span>. Error encountered in log file <span class="VarName">&lt;logfileName&gt;</span>, position <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAM.D</code></td>
                        <td>Cannot verify database format at <span class="VarName">&lt;value&gt;</span> due to IOException.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAN.D</code></td>
                        <td>Database at <span class="VarName">&lt;value&gt;</span> has an incompatible format with the current version of the software.  The database was created by or upgraded by version <span class="VarName">&lt;versionNumber&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAO.D</code></td>
                        <td>Recovery failed unexpected problem <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAP.D</code></td>
                        <td>Database at <span class="VarName">&lt;value&gt;</span> is at version <span class="VarName">&lt;versionNumber&gt;</span>. Beta databases cannot be upgraded,</td>
                    </tr>
                    <tr>
                        <td><code>XSLAQ.D</code></td>
                        <td>cannot create log file at directory <span class="VarName">&lt;directoryName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAR.D</code></td>
                        <td>Unable to copy log file '<span class="VarName">&lt;logfileName&gt;</span>' to '<span class="VarName">&lt;value&gt;</span>' during restore. Please make sure that there is enough space and permissions are correct. </td>
                    </tr>
                    <tr>
                        <td><code>XSLAS.D</code></td>
                        <td>Log directory <span class="VarName">&lt;directoryName&gt;</span> not found in backup during restore. Please make sure that backup copy is the correct one and it is not corrupted.</td>
                    </tr>
                    <tr>
                        <td><code>XSLAT.D</code></td>
                        <td>The log directory '<span class="VarName">&lt;directoryName&gt;</span>' exists. The directory might belong to another database. Check that the location specified for the logDevice attribute is correct.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

