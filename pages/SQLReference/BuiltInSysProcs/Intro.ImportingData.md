---
title: Importing Data System Procedures and Functions in Splice Machine
summary: A table that summarizes the function of each available Splice Machine built-in system procedures for importing data into your database.
keywords: importing data, system import procedures
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_importingintro.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data System Procedures and Functions

These are the system procedures and functions for importing data into
your database:
{: .body}

<table summary="Summary of Splice Machine system procedures and functions for importing data">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_importhfile.html">SYSCS_UTIL.BULK_IMPORT_HFILE</a>
                        </td>
                        <td>Imports data from an HFile.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_deletesnapshot.html">SYSCS_UTIL.DELETE_SNAPSHOT</a>
                        </td>
                        <td>Deletes a stored snapshot.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_importdata.html">SYSCS_UTIL.IMPORT_DATA</a>
                        </td>
                        <td>Imports data to a subset of columns in a table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_restoresnapshot.html">SYSCS_UTIL.RESTORE_SNAPSHOT</a>
                        </td>
                        <td>Restores a table or schema from a stored snapshot.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_snapshotschema.html">SYSCS_UTIL.SNAPSHOT_SCHEMA</a>
                        </td>
                        <td>Creates a Splice Machine snapshot of a schema.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_snapshottable.html">SYSCS_UTIL.SNAPSHOT_TABLE</a>
                        </td>
                        <td>Creates a Splice Machine snapshot of a specific table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_splittable.html">SYSCS_UTIL.SPLIT_TABLE_OR_INDEX</a>
                        </td>
                        <td>Computes split keys for a table or index and then sets up the table or index.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_upsertdata.html">SYSCS_UTIL.SYSCS_UPSERT_DATA_FROM_FILE</a>
                        </td>
                        <td>Checks upsert data without actually performing the insertions or updates.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>
