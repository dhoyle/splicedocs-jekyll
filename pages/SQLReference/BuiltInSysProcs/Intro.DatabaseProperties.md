---
title: Database Property System Procedures and Functions in Splice Machine
summary: A table that summarizes the function of each available Splice Machine built-in system procedures for retrieving and setting database properties.
keywords: database property procedures
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_dbpropsintro.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Database Property System Procedures and Functions

These are the system procedures and functions for working with your
database properties:
{: .body}

<table summary="Summary of Splice Machine system procedures and functions for database properties">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Procedure / Function Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getallprops.html">SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES</a>
                        </td>
                        <td>Displays all of the Splice Machine Derby properties.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getglobaldbprop.html">SYSCS_UTIL.SYSCS_GET_GLOBAL_DATABASE_PROPERTY function</a>
                        </td>
                        <td>Fetches the value of the specified property of the database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getschemainfo.html">SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO</a>
                        </td>
                        <td>Displays table information for all user schemas, including the HBase regions occupied and their store file size.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_peekatseq.html">SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE function</a>
                        </td>
                        <td>
                            <p>Allows users to observe the instantaneous current value of a sequence generator without having to query the <a href="sqlref_systables_syssequences.html"><code>SYSSEQUENCES</code> system table</a>. </p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_setglobaldbprop.html">SYSCS_UTIL.SYSCS_SET_GLOBALDATABASE_PROPERTY</a>
                        </td>
                        <td>Sets or deletes the value of a property of the database.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>
