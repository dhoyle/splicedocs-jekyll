---
title: Splice Machine Error Codes - Class XSDF&#58; RawStore - Data.Filesystem statement
summary: Summary of Splice Machine Class XSDF Errors
keywords: XSDF errors, error XSDF
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxsdf.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSDF: RawStore - Data.Filesystem statement

<table>
                <caption>Error Class XSDF: RawStore - Data.Filesystem statement</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSDF0.S</code></td>
                        <td>Could not create file <span class="VarName">&lt;fileName&gt;</span> as it already exists.</td>
                    </tr>
                    <tr>
                        <td><code>XSDF1.S</code></td>
                        <td>Exception during creation of file <span class="VarName">&lt;fileName&gt;</span> for container</td>
                    </tr>
                    <tr>
                        <td><code>XSDF2.S</code></td>
                        <td>Exception during creation of file <span class="VarName">&lt;fileName&gt;</span> for container, file could not be removed.  The exception was: <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDF3.S</code></td>
                        <td>Cannot create segment <span class="VarName">&lt;segmentName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDF4.S</code></td>
                        <td>Exception during remove of file <span class="VarName">&lt;fileName&gt;</span> for dropped container, file could not be removed <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDF6.S</code></td>
                        <td>Cannot find the allocation page <span class="VarName">&lt;page&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDF7.S</code></td>
                        <td>Newly created page failed to be latched <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDF8.S</code></td>
                        <td>Cannot find page <span class="VarName">&lt;page&gt;</span> to reuse.</td>
                    </tr>
                    <tr>
                        <td><code>XSDFB.S</code></td>
                        <td>Operation not supported by a read only database</td>
                    </tr>
                    <tr>
                        <td><code>XSDFD.S</code></td>
                        <td>Different page image read on 2 I/Os on Page <span class="VarName">&lt;page&gt;</span>, first image has incorrect checksum, second image has correct checksum. Page images follows: <span class="VarName">&lt;value&gt;</span> <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDFF.S</code></td>
                        <td>The requested operation failed due to an unexpected exception.</td>
                    </tr>
                    <tr>
                        <td><code>XSDFH.S</code></td>
                        <td>Cannot backup the database, got an I/O Exception while writing to the backup container file <span class="VarName">&lt;fileName&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDFI.S</code></td>
                        <td>Error encountered while trying to write data to disk during database recovery.  Check that the database disk is not full. If it is then delete unnecessary files, and retry connecting to the database.  It is also possible that the file system is read only, or the disk has failed, or some other problem with the media.  System encountered error while processing page <span class="VarName">&lt;page&gt;</span>.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

