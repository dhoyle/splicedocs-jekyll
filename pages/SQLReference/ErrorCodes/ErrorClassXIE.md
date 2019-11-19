---
title: Splice Machine Error Codes - Class XIE&#58; Import/Export Exceptions
summary: Summary of Splice Machine Class XIE Errors
keywords: XIE errors, error XIE
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxie.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XIE: Import/Export Exceptions

<table>
                <caption>Error Class XIE: Import/Export Exceptions</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XIE01.S</code></td>
                        <td>Connection was null.</td>
                    </tr>
                    <tr>
                        <td><code>XIE03.S</code></td>
                        <td>Data found on line <span class="VarName">&lt;lineNumber&gt;</span> for column <span class="VarName">&lt;columnName&gt;</span> after the stop delimiter.  </td>
                    </tr>
                    <tr>
                        <td><code>XIE04.S</code></td>
                        <td>Data file not found: <span class="VarName">&lt;fileName&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XIE05.S</code></td>
                        <td>Data file cannot be null. </td>
                    </tr>
                    <tr>
                        <td><code>XIE06.S</code></td>
                        <td>Entity name was null.</td>
                    </tr>
                    <tr>
                        <td><code>XIE07.S</code></td>
                        <td>Field and record separators cannot be substrings of each other. </td>
                    </tr>
                    <tr>
                        <td><code>XIE08.S</code></td>
                        <td>There is no column named: <span class="VarName">&lt;columnName&gt;</span>.  </td>
                    </tr>
                    <tr>
                        <td><code>XIE09.S</code></td>
                        <td>The total number of columns in the row is: <span class="VarName">&lt;number&gt;</span>.  </td>
                    </tr>
                    <tr>
                        <td><code>XIE0A.S</code></td>
                        <td>Number of columns in column definition, <span class="VarName">&lt;columnName&gt;</span>, differ from those found in import file <span class="VarName">&lt;type&gt;</span>. </td>
                    </tr>
                    <tr>
                        <td><code>XIE0B.S</code></td>
                        <td>Column '<span class="VarName">&lt;columnName&gt;</span>' in the table is of type <span class="VarName">&lt;type&gt;</span>, it is not supported by the import/export feature.   </td>
                    </tr>
                    <tr>
                        <td><code>XIE0C.S</code></td>
                        <td>Illegal <span class="VarName">&lt;delimiter&gt;</span> delimiter character '<span class="VarName">&lt;character&gt;</span>'.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0D.S</code></td>
                        <td>Cannot find the record separator on line <span class="VarName">&lt;lineNumber&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0E.S</code></td>
                        <td>Read endOfFile at unexpected place on line <span class="VarName">&lt;lineNumber&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0F.S</code></td>
                        <td>Character delimiter cannot be the same as the column delimiter.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0I.S</code></td>
                        <td>An IOException occurred while writing data to the file.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0J.S</code></td>
                        <td>A delimiter is not valid or is used more than once.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0K.S</code></td>
                        <td>The period was specified as a character string delimiter.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0M.S</code></td>
                        <td>Table '<span class="VarName">&lt;tableName&gt;</span>' does not exist.  </td>
                    </tr>
                    <tr>
                        <td><code>XIE0N.S</code></td>
                        <td>An invalid hexadecimal string '<span class="VarName">&lt;hexString&gt;</span>' detected in the import file.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0P.S</code></td>
                        <td>Lob data file <span class="VarName">&lt;fileName&gt;</span> referenced in the import file not found.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0Q.S</code></td>
                        <td>Lob data file name cannot be null. </td>
                    </tr>
                    <tr>
                        <td><code>XIE0R.S</code></td>
                        <td>Import error on line <span class="VarName">&lt;lineNumber&gt;</span> of file <span class="VarName">&lt;fileName&gt;</span>: <span class="VarName">&lt;details&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XIE10.S</code></td>
                        <td>Import error during reading source file <span class="VarName">&lt;fileName&gt;</span> : <span class="VarName">&lt;details&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XIE11.S</code></td>
                        <td>SuperCSVReader error during Import : <span class="VarName">&lt;details&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XIE12.S</code></td>
                        <td>There was <span class="VarName">&lt;details&gt;</span> RegionServer failures during a write with WAL disabled, the transaction has to rollback to avoid data loss.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0S.S</code></td>
                        <td>The export operation was not performed, because the specified output file (<span class="VarName">&lt;fileName&gt;</span>) already exists. Export processing will not overwrite an existing file, even if the process has permissions to write to that file, due to security concerns, and to avoid accidental file damage. Please either change the output file name in the export procedure arguments to specify a file which does not exist, or delete the existing file, then retry the export operation.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0T.S</code></td>
                        <td>The export operation was not performed, because the specified large object auxiliary file (<span class="VarName">&lt;fileName&gt;</span>) already exists. Export processing will not overwrite an existing file, even if the process has permissions to write to that file, due to security concerns, and to avoid accidental file damage. Please either change the large object auxiliary file name in the export procedure arguments to specify a file which does not exist, or delete the existing file, then retry the export operation.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0U.S</code></td>
                        <td>The export operation was not performed, because the specified parameter (replicationCount) is less than or equal to zero.</td>
                    </tr>
                    <tr>
                        <td><code>XIE0X.S</code></td>
                        <td>The export operation was not performed, because value of the specified parameter (<span class="VarName">&lt;paramName&gt;</span>) is wrong.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>
