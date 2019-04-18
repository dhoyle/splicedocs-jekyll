---
title: Splice Machine Error Codes - Class XSDA&#58; RawStore - Data.Generic statement
summary: Summary of Splice Machine Class XSDA Errors
keywords: XSDA errors, error XSDA
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxsda.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSDA: RawStore - Data.Generic statement

<table>
                <caption>Error Class XSDA: RawStore - Data.Generic statement</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSDA1.S</code></td>
                        <td>An attempt was made to access an out of range slot on a page</td>
                    </tr>
                    <tr>
                        <td><code>XSDA2.S</code></td>
                        <td>An attempt was made to update a deleted record</td>
                    </tr>
                    <tr>
                        <td><code>XSDA3.S</code></td>
                        <td>Limitation: Record cannot be updated or inserted due to lack of space on the page. Use the parameters derby.storage.pageSize and/or derby.storage.pageReservedSpace to work around this limitation.</td>
                    </tr>
                    <tr>
                        <td><code>XSDA4.S</code></td>
                        <td>An unexpected exception was thrown</td>
                    </tr>
                    <tr>
                        <td><code>XSDA5.S</code></td>
                        <td>An attempt was made to undelete a record that is not deleted</td>
                    </tr>
                    <tr>
                        <td><code>XSDA6.S</code></td>
                        <td>Column <span class="VarName">&lt;columnName&gt;</span> of row is null, it needs to be set to point to an object.</td>
                    </tr>
                    <tr>
                        <td><code>XSDA7.S</code></td>
                        <td>Restore of a serializable or SQLData object of class <span class="VarName">&lt;className&gt;</span>, attempted to read more data than was originally stored</td>
                    </tr>
                    <tr>
                        <td><code>XSDA8.S</code></td>
                        <td>Exception during restore of a serializable or SQLData object of class <span class="VarName">&lt;className&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDA9.S</code></td>
                        <td>Class not found during restore of a serializable or SQLData object of class <span class="VarName">&lt;className&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XSDAA.S</code></td>
                        <td>Illegal time stamp <span class="VarName">&lt;value&gt;</span>, either time stamp is from a different page or of incompatible implementation</td>
                    </tr>
                    <tr>
                        <td><code>XSDAB.S</code></td>
                        <td>cannot set a null time stamp</td>
                    </tr>
                    <tr>
                        <td><code>XSDAC.S</code></td>
                        <td>Attempt to move either rows or pages from one container to another.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAD.S</code></td>
                        <td>Attempt to move zero rows from one page to another.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAE.S</code></td>
                        <td>Can only make a record handle for special record handle id.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAF.S</code></td>
                        <td>Using special record handle as if it were a normal record handle.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAG.S</code></td>
                        <td>The allocation nested top transaction cannot open the container.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAI.S</code></td>
                        <td>Page <span class="VarName">&lt;page&gt;</span> being removed is already locked for deallocation.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAJ.S</code></td>
                        <td>Exception during write of a serializable or SQLData object</td>
                    </tr>
                    <tr>
                        <td><code>XSDAK.S</code></td>
                        <td>Wrong page is gotten for record handle <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAL.S</code></td>
                        <td>Record handle <span class="VarName">&lt;value&gt;</span> unexpectedly points to overflow page.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAM.S</code></td>
                        <td>Exception during restore of a SQLData object of class <span class="VarName">&lt;className&gt;</span>. The specified class cannot be instantiated.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAN.S</code></td>
                        <td>Exception during restore of a SQLData object of class <span class="VarName">&lt;className&gt;</span>. The specified class encountered an illegal access exception.</td>
                    </tr>
                    <tr>
                        <td><code>XSDAO.S</code></td>
                        <td>Internal error: page <span class="VarName">&lt;pageNumber&gt;</span> attempted latched twice.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

