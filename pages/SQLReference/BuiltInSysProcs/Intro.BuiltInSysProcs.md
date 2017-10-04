---
title: Summary of Splice Machine built-in system procedures
summary: A table that summarizes the function of each available Splice Machine system system procedure.
keywords: system procedures
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_intro.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Built-in System Procedures and Functions

This section contains the reference documentation for the Splice Machine
Built-in SQL System Procedures and Functions, in the following
subsections:

* [Database Admin Procedures and Functions](#DatabaseAdmin)
* [Database Property Procedures and Functions](#DatabaseProps)
* [Importing Data Procedures and Functions](#Importing)
* [Jar File Procedures and Functions](#Jar)
* [Logging Procedures and Functions](#Logging)
* [Statements and Stored Procedures System Procedures](#Statement)
* [Statistics Procedures and Functions](#Statistics)
* [System Status Procedures and Functions](#SystemStatus)
* [Transaction Procedures and Functions](#Transaction)

## Database Admin Procedures and Functions   {#DatabaseAdmin}

These are the system procedures and functions for administering your
database:
{: .body}

<table summary="Summary of Splice Machine system database administration procedures and functions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_backupdb.html">SYSCS_UTIL.SYSCS_BACKUP_DATABASE</a>
                        </td>
                        <td>
                            <p>Backs up the database to a specified backup directory.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_cancelbackup.html">SYSCS_UTIL.SYSCS_CANCEL_BACKUP</a>
                        </td>
                        <td>
                            <p>Cancels a backup.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_canceldailybackup.html">SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP</a>
                        </td>
                        <td>
                            <p>Cancels a scheduled daily backup.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_compactregion.html"><code>SYSCS_UTIL.COMPACT_REGION</code></a></td>
                        <td>Performs a minor compaction on a table or index region.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_builtinfcns_user.html">SYSCS_UTIL.SYSCS_CREATE_USER</a>
                        </td>
                        <td>Adds a new user account to a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_deletebackup.html">SYSCS_UTIL.SYSCS_DELETE_BACKUP</a>
                        </td>
                        <td>
                            <p>Delete a specific backup.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_deleteoldbackups.html">SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS</a>
                        </td>
                        <td>
                            <p>Deletes all backups that were created more than a certain number of days ago.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_builtinfcns_user.html">SYSCS_UTIL.SYSCS_DROP_USER</a>
                        </td>
                        <td>Removes a user account from a database.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_getencodedregion.html"><code>SYSCS_UTIL.GET_ENCODED_REGION_NAME</code></a></td>
                        <td>Returns the encoded name of the HBase region that contains the specified, unencoded Splice Machine table primary key or index values.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_getregions.html"><code>SYSCS_UTIL.GET_REGIONS</code></a></td>
                        <td>Retrieves the list of regions containing a range of key values.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_getrunningops.html"><code>SYSCS_UTIL.GET_RUNNING_OPERATIONS</code></a></td>
                        <td>Displays information about each Splice Machine operations running on a server.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_getstartkey.html"><code>SYSCS_UTIL.GET_START_KEY</code></a></td>
                        <td>Retrieves the unencoded start key for a specified HBase table or index region.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getloggers.html">SYSCS_UTIL.KILL_OPERATION</a>
                        </td>
                        <td>Terminates a Splice Machine operation running on the server to which you are connected.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_majorcompactregion.html"><code>SYSCS_UTIL.MAJOR_COMPACT_REGION</code></a></td>
                        <td>Performs a major compaction on a table or index region.</td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_sysprocs_mergeregions.html"><code>SYSCS_UTIL.MERGE_REGIONS</code></a></td>
                        <td>Merges two adjacent table or index regions.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_modifypassword.html">SYSCS_UTIL.SYSCS_MODIFY_PASSWORD</a>
                        </td>
                        <td>Called by a user to change that user's own password.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_compactschema.html">SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA</a>
                        </td>
                        <td>Performs a major compaction on a schema</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_compacttable.html">SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE</a>
                        </td>
                        <td>Performs a major compaction on a table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_refreshexttable.html">SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE</a>
                        </td>
                        <td>Refreshes the schema of an external table in Splice Machine; use this when the schema of the table's source file has been modified outside of Splice Machine.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_resetpassword.html">SYSCS_UTIL.SYSCS_RESET_PASSWORD</a>
                        </td>
                        <td>Resets a password that has expired or has been forgotten.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_restoredb.html">SYSCS_UTIL.SYSCS_RESTORE_DATABASE</a>
                        </td>
                        <td>
                            <p>Restores a database from a previous backup.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_deletebackup.html">SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP</a>
                        </td>
                        <td>
                            <p>Schedules a full or incremental database backup to run at a specified time daily.</p>
                            <p>This procedure is only available in our <em>On-Premise Database</em> product.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_updateschemaowner.html">SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER</a>
                        </td>
                        <td>Changes the owner of a schema.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_vacuum.html">SYSCS_UTIL.VACUUM</a>
                        </td>
                        <td>Performs clean-up operations on the system.</td>
                    </tr>
                </tbody>
            </table>
## Database Properties Procedures and Functions   {#DatabaseProps}

These are the system procedures and functions for working with your
database properties:
{: .body}

<table summary="Summary of Splice Machine system database properties procedures and functions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_getdbprop.html">SYSCS_UTIL.SYSCS_GET_DATABASE_PROPERTY function</a>
                        </td>
                        <td>Fetches the value of the specified property of the database on the current connection.</td>
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_setdbprop.html">SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY</a>
                        </td>
                        <td>Sets or deletes the value of a property of the database on the current connection.</td>
                    </tr>
                </tbody>
            </table>
## Importing Data Procedures and Functions   {#Importing}

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
                        <td class="CodeFont"><a href="sqlref_sysprocs_computesplitkey.html">SYSCS_UTIL.COMPUTE_SPLIT_KEY</a>
                        </td>
                        <td>Computes split keys for a table or index.</td>
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_mergedata.html">SYSCS_UTIL.SYSCS_MERGE_DATA_FROM_FILE</a>
                        </td>
                        <td>Imports data from external files, inserting new records and updating existing records.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_purgedeletedrows.html">SYSCS_UTIL.SET_PURGE_DELETED_ROWS</a>
                        </td>
                        <td>Enables (or disables) physical deletion of logically deleted rows from a specific table.</td>
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_splittableatpoints.html">SYSCS_UTIL.SPLIT_TABLE_OR_INDEX_AT_POINTS</a>
                        </td>
                        <td>Sets up a table or index in your database with split keys computed by the <code>COMPUTE_SPLIT_KEY</code> procedure.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_splittable.html">SYSCS_UTIL.SPLIT_TABLE_OR_INDEX</a>
                        </td>
                        <td>
                            <p>Computes split keys for a table or index and then sets up the table or index.</p>
                            <p>This combines the functionality of <code>SYSCS_UTIL.COMPUTE_SPLIT_KEY</code> and <code>SYSCS_UTIL.SPLIT_TABLE_OR_INDEX_AT_POINTS</code>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_upsertdata.html">SYSCS_UTIL.SYSCS_UPSERT_DATA_FROM_FILE</a>
                        </td>
                        <td>Imports data from external files, inserting new records and updating existing records.</td>
                    </tr>
                </tbody>
            </table>
## Jar File Procedures and Functions   {#Jar}

These are the system procedures and functions for working with
JAR files:
{: .body}

<table summary="Summary of Splice Machine system JAR file procedures and functions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_installjar.html">SQLJ.INSTALL_JAR</a>
                        </td>
                        <td>Stores a jar file in a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_removejar.html">SQLJ.REMOVE_JAR</a>
                        </td>
                        <td>Removes a jar file from a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_replacejar.html">SQLJ.REPLACE_JAR</a>
                        </td>
                        <td>Replaces a jar file in a database.</td>
                    </tr>
                </tbody>
            </table>
## Logging Procedures and Functions   {#Logging}

These are the system procedures and functions for working with system
logs:
{: .body}

<table summary="Summary of Splice Machine system logging and tracing procedures and functions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_getloggerlevel.html">SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL</a>
                        </td>
                        <td>Displays the log level of the specified logger.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getloggers.html">SYSCS_UTIL.SYSCS_GET_LOGGERS</a>
                        </td>
                        <td>Displays the names of all Splice Machine loggers in the system.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_setloggerlevel.html">SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL</a>
                        </td>
                        <td>Changes the log level of the specified logger.</td>
                    </tr>
                </tbody>
            </table>
## Statement and Stored Procedures System Procedures   {#Statement}

These are the system procedures and functions for working with executing
statements and stored procedures:
{: .body}

<table summary="Summary of Splice Machine system procedures and functions for working with statements and stored procedures">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_emptyglobalcache.html">SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE</a>
                        </td>
                        <td>Removes as many compiled statements (plans) as possible from the database-wide statement cache (across all region servers).</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_emptycache.html">SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE</a>
                        </td>
                        <td>Removes as many compiled statements (plans) as possible from the database statement cache on your current region server.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_invalidatestoredstmts.html">SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS</a>
                        </td>
                        <td>Invalidates all system prepared statements and forces the query optimizer to create new execution plans.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_updateallsysprocs.html">SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES</a>
                        </td>
                        <td>Updates the signatures of all of the system procedures in a database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_updatesysproc.html">SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE</a>
                        </td>
                        <td>Updates the stored declaration of a specific system procedure in the data dictionary.</td>
                    </tr>
                </tbody>
            </table>
## Statistics Procedures and Functions   {#Statistics}

These are the system procedures and functions for managing database
statistics:
{: .body}

<table summary="Summary of Splice Machine built-in statistics procedures and functions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_collectschemastats.html">SYSCS_UTIL.COLLECT_SCHEMA_STATISTICS</a>
                        </td>
                        <td>Collects statistics on a specific schema in your database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_disablecolumnstats.html">SYSCS_UTIL.DISABLE_COLUMN_STATISTICS</a>
                        </td>
                        <td>Disables collection of statistics on a specific column in a table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_dropschemastats.html">SYSCS_UTIL.DROP_SCHEMA_STATISTICS</a>
                        </td>
                        <td>Drops statistics for a specific schema in your database.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_enablecolumnstats.html">SYSCS_UTIL.ENABLE_COLUMN_STATISTICS</a>
                        </td>
                        <td>Enables collection of statistics on a specific column in a table.</td>
                    </tr>
                </tbody>
            </table>
## System Status Procedures and Functions   {#SystemStatus}

These are the system procedures and functions for monitoring and
adjusting system status:
{: .body}

<table summary="Summary of Splice Machine built-in system status procedures and functions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_getactiveservers.html">SYSCS_UTIL.SYSCS_GET_ACTIVE_SERVERS</a>
                        </td>
                        <td>Displays the number of active servers in the Splice cluster.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getregionserverstats.html">SYSCS_UTIL.SYSCS_GET_REGION_SERVER_STATS_INFO</a>
                        </td>
                        <td>Displays input and output statistics about the cluster.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getrequests.html">SYSCS_UTIL.SYSCS_GET_REQUESTS</a>
                        </td>
                        <td>Displays information about the number of RPC requests that are coming into Splice Machine.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getrunningops.html">SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS</a>
                        </td>
                        <td>Displays information about all Splice Machine operations running on the server to which you are connected.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getsessioninfo.html">SYSCS_UTIL.SYSCS_GET_SESSION_INFO</a>
                        </td>
                        <td>Displays session information, including the hostname and session IDs.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getversioninfo.html">SYSCS_UTIL.SYSCS_GET_VERSION_INFO</a>
                        </td>
                        <td>Displays the version of Splice Machine installed on each node in your cluster.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_getwriteintakeinfo.html">SYSCS_UTIL.SYSCS_GET_WRITE_INTAKE_INFO</a>
                        </td>
                        <td>Displays information about the number of writes coming into Splice Machine.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont"><a href="sqlref_sysprocs_killoperation.html">SYSCS_UTIL.KILL_OPERATION</a>
                        </td>
                        <td>Terminates a Splice Machine operation running on the server to which you are connected.</td>
                    </tr>
                </tbody>
            </table>
## Transaction Procedures and Functions   {#Transaction}

These are the system procedures and functions for working with
transactions in your database
{: .body}

<table summary="Summary of Splice Machine built-in procedures and functions for working with transactions">
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
                        <td class="CodeFont"><a href="sqlref_sysprocs_getcurrenttransaction.html">SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION</a>
                        </td>
                        <td>Displays summary information about the current transaction.</td>
                    </tr>
                </tbody>
            </table>
{% include splice_snippets/githublink.html %}
</div>
</section>
