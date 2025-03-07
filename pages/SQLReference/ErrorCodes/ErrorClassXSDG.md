---
title: Splice Machine Error Codes - Class XSDG&#58; RawStore - Data.Filesystem database
summary: Summary of Splice Machine Class XSDG Errors
keywords: XSDG errors, error XSDG
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxsdg.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSDG: RawStore - Data.Filesystem database

<table>
                <caption>Error Class XSDG: RawStore - Data.Filesystem database</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSDG0.D</code></td>
                        <td>Page <span class="VarName">&lt;page&gt;</span> could not be read from disk.</td>
                    </tr>
                    <tr>
                        <td><code>XSDG1.D</code></td>
                        <td>Page <span class="VarName">&lt;page&gt;</span> could not be written to disk, please check if the disk is full, or if a file system limit, such as a quota or a maximum file size, has been reached.</td>
                    </tr>
                    <tr>
                        <td><code>XSDG2.D</code></td>
                        <td>Invalid checksum on Page <span class="VarName">&lt;page&gt;</span>, expected=<span class="VarName">&lt;value&gt;</span>, on-disk version=<span class="VarName">&lt;value&gt;</span>, page dump follows: <span class="VarName">&lt;value&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDG3.D</code></td>
                        <td>Meta-data for <span class="VarName">&lt;containerName&gt;</span> could not be accessed to <span class="VarName">&lt;type&gt;</span> <span class="VarName">&lt;file&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDG5.D</code></td>
                        <td>Database is not in create mode when createFinished is called.</td>
                    </tr>
                    <tr>
                        <td><code>XSDG6.D</code></td>
                        <td>Data segment directory not found in <span class="VarName">&lt;value&gt;</span> backup during restore. Please make sure that backup copy is the right one and it is not corrupted.</td>
                    </tr>
                    <tr>
                        <td><code>XSDG7.D</code></td>
                        <td>Directory <span class="VarName">&lt;directoryName&gt;</span> could not be removed during restore. Please make sure that permissions are correct.</td>
                    </tr>
                    <tr>
                        <td><code>XSDG8.D</code></td>
                        <td>Unable to copy directory '<span class="VarName">&lt;directoryName&gt;</span>' to '<span class="VarName">&lt;value&gt;</span>' during restore. Please make sure that there is enough space and permissions are correct. </td>
                    </tr>
                    <tr>
                        <td><code>XSDG9.D</code></td>
                        <td>Splice thread received an interrupt during a disk I/O operation, please check your application for the source of the interrupt.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

