---
title: New and Deprecated Features
summary: Update notes for the current release of our on-premise database product.
keywords: update notes, on-premise, new features, features, HAProxy, estimated statistics, incremental restore, bulk import, hfile import, bulk delete, hfile delete, snapshots, external tables, physical delete, backup, restore, physical delete, pinned tables, rdd caching, schema-level, statistics, avro
toc: false
product: all
sidebar:  onprem_sidebar
permalink: onprem_info_newfeatures.html
folder: OnPrem/Info
---
\{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# New Features in This Release

{% include splice_snippets/onpremonlytopic.html %}
This topic describes significant new and deprecated features in the
Splice Machine On-Premise Database product, in these sections:

* [New Features Summary](#NewFeatures)
* [Deprecated Features Summary](#DeprecatedFeatures)
* [Documentation Updates Summary](#DocsFeatures)

If a new feature has been back-ported into a patch release of a previous
version, it will be noted in the Version column. For example, several
features that were introduced in release 2.6 (2.6.0.1729) were
back-ported into the v2.5 patch release (2.5.0.1729) in August, 2017.

## New Features Summary   {#NewFeatures}

<table summary="Summary of new and updated features in this release">
            <col />
            <col />
            <col />
            <tbody>
                <tr>
                    <th>Version Updated</th>
                    <th>Change</th>
                    <th>Description</th>
                </tr>
            <tr>
                <td><strong>2.6.1</strong></td>
                <td><em>DBaaS</em></td>
                <td>Our new <span class="CalloutFont">Database-as-a-Service</span> offering is now available. Please see our <a href="dbaas_intro.html">Welcome to our Database Service page</a> for more information.</td>
            </tr>
            <tr>
                <td><strong>2.6.1</strong></td>
                <td><em>SSL/TLS</em></td>
                <td>You can now configure and use SSL/TLS secured JDBC connections to your Splice Machine database. We support both basic encrypted connections and peer-authenticated connections. Please see our <a href="onprem_install_configureTLS.html">Configuring SSL/TLS topic</a> for more information.</td>
            </tr>
            <tr>
                <td><strong>2.6.1</strong></td>
                <td><em>Region Functions</em></td>
                <td><p>We've added a number of built-in system procedures that allow you to work directly with table and index regions; some customers use these to optimize processing of recent data while optimizing storage of older data:</p>
					<ul>
						<li><a href="sqlref_sysprocs_compactregion.html"><code>SYSCS_UTIL.COMPACT_REGION</code></a></li>
						<li><a href="sqlref_sysprocs_getencodedregion.html"><code>SYSCS_UTIL.GET_ENCODED_REGION_NAME</code></a></li>
						<li><a href="sqlref_sysprocs_getregions.html"><code>SYSCS_UTIL.GET_REGIONS</code></a></li>
						<li><a href="sqlref_sysprocs_getstartkey.html"><code>SYSCS_UTIL.GET_START_KEY</code></a></li>
						<li><a href="sqlref_sysprocs_majorcompactregion.html"><code>SYSCS_UTIL.MAJOR_COMPACT_REGION</code></a></li>
						<li><a href="sqlref_sysprocs_mergeregions.html"><code>SYSCS_UTIL.MERGE_REGIONS</code></a></li>
                    </ul>
				</td>
            </tr>
            <tr>
                <td><strong>2.6.1</strong></td>
                <td><em>Session Information</em></td>
                <td>The new <a href="sqlref_sysprocs_getsessioninfo.html"><code>SYSCS_UTIL.GET_SESSION_INFO"</code></a> system procedure reports information about your current session, including  the hostname and session ID for your current session. You can use this information to correlate your Splice Machine query with a Spark job: the same information is displayed in the <code>Job Id (Job Group)</code> in the Spark console.</td>
            </tr>
            <tr>
                <td><strong>2.6.1</strong></td>
                <td><em>Working with Running Operations</em></td>
				<td><p>We've added two new system procedures for working with database operations that are currently running on a server:</p>
				<ul>
					<li>The <a href="sqlref_sysprocs_getrunningops.html"><code>SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS</code></a> system procedure displays a list of the operations running on the server to which you are currently connected.</li>
					<li>You can use this procedure to find the UUID for an operation, which you can then use for purposes such as terminating an operation with the <a href="sqlref_sysprocs_killoperation.html"><code>SYSCS_UTIL.SYSCS_KILL_OPERATION</code></a> system procedure.</li>
				</ul>
				</td>
            </tr>
			<tr>
				<td><strong>2.6.1</strong></td>
				<td><em>Logging Changes</em></td>
				<td><p>We've made two significant changes in logging:</p>
					<ul>
						<li>Statement logging is now enabled by default. To modify this, see the <a href="developers_tuning_logging">Using Logging</a> topic in our <em>Developer's Guide</em>.</li>
						<li>Logs are stored, by default, in your region server's log directory. You can modify the location of the logs with a code snippet that is described in the <a href="onprem_install_intro.html">Installation Guide</a> page for your platform (Cloudera, Hortonworks, or MapR).</li>
					</ul>
				</td>
			</tr>
            <tr>
                <td><strong>2.6</strong></td>
                <td><em>HAProxy</em></td>
                <td>
                    <p>HAProxy is an open source utility that is available on most Linux distributions and cloud platforms for load-balancing TCP and HTTP requests. Users can leverage this tool to distribute incoming client requests among the region server nodes on which Splice Machine instances are running.</p>
                    <p>Our <a href="tutorials_connect_haproxy.html">Configuring HAProxy</a> topic walks you through configuring HAProxy on a non-Splice Machine cluster node, and how to use HAProxy with Splice Machine on a Kerberos-enabled cluster.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.6</strong></td>
                <td><em>Incremental Restore Enhanced</em></td>
                <td>
                    <p>When you decide to restore from an incremental backup, you no longer have to restore from a sequence of backups; Splice Machine now automatically determines what's required to perform the restore operation and takes care of it for you.</p>
                    <p class="noteIcon">Backup and Restore functionality is only available to <span class="CalloutFont">Splice Machine Enterprise Edition</span> users.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.6</strong></td>
                <td><em>External AVRO files</em></td>
                <td>
                    <p>We've added support for AVRO files files as external tables. See <a href="developers_fundamentals_externaltables.html">Using External Tables</a> in our <em>Developer's Guide</em> for more information.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.6</strong></td>
                <td><em>Bulk HFile Delete</em></td>
                <td>
                    <p>Our new <span class="CalloutFont">Bulk HFile Delete</span> features generates HFiles for deleting large amounts of data, which significantly speeds up bulk deletion by bypassing the Splice Machine write pipeline and HBase write path.</p>
                    <p>You can use this feature by specifying a <a href="developers_tuning_queryoptimization.html#Delete"> optimization hint</a> with the <a href="sqlref_statements_delete.html"><code>DELETE</code></a> statement</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.6, 2.5.0.1729</strong></td>
                <td><em>Estimated Statistics</em></td>
                <td>You can now optionally reduce the time required to generate statistics for a table by specifying a sampling percentage in the <a href="cmdlineref_analyze.html">analyze</a> command; Splice Machine will then generate statistics by sampling that percentage of the table, instead of analyzing the entire table. </td>
            </tr>
            <tr>
                <td><strong>2.6, 2.5.0.1729</strong></td>
                <td><em>BULK_IMPORT_HFILE</em></td>
                <td>
                    <p>We have added a new system procedure for rapidly importing data:</p>
                    <ul class="bullet">
                        <li><a href="sqlref_sysprocs_importhfile.html"><code>SYSCS_UTIL.BULK_IMPORT_HFILE</code></a>
                        </li>
                    </ul>
                    <p>This procedure creates HFiles directly, rather than using HBase APIs; it is faster than our <a href="sqlref_sysprocs_importhfile.html"><code>IMPORT_DATA</code></a> procedure, but has some limitations:</p>
                    <ul class="bullet">
                        <li>To use it, you must already know how you want your data split across regions (your data's <em>split points</em>).</li>
                        <li>
                            <p>HFile import does not enforce any constraints, including unique, foreign key, or primary key constraints.</p>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td><strong>2.6, 2.5.0.1729</strong></td>
                <td><em>Snapshots</em></td>
                <td>
                    <p>The Splice Machine <a href="developers_tuning_snapshots.html">snapshot feature</a> to create a restorable snapshot of a table or schema; this is commonly used when importing or deleting a significant amount of data from a database.</p>
                    <p>We've introduced these new system procedures for working with snapshots:</p>
                    <ul class="bullet">
                        <li><a href="sqlref_sysprocs_snapshottable.html"><code>SYSCS_UTIL.SNAPSHOT_TABLE</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_snapshotschema.html"><code>SYSCS_UTIL.SNAPSHOT_SCHEMA</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_restoresnapshot.html"><code>SYSCS_UTIL.RESTORE_SNAPSHOT</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_deletesnapshot.html"><code>SYSCS_UTIL.DELETE_SNAPSHOT</code></a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td><strong>2.6, 2.5.0.1729</strong></td>
                <td><em>Physical Delete</em></td>
                <td>
                    <p>You can now tell Splice Machine that, when a major compaction next runs, you want logically deleted table rows to be physically deleted from your database. Use the <a href="sqlref_sysprocs_purgedeletedrows.html"><code>SYSCS_UTIL.SET_PURGE_DELETED_ROWS</code></a> system procedure to enable or disable this setting.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.5</strong></td>
                <td><em>Backup and Restore</em></td>
                <td>
                    <p>The ability to incrementally back up and restore your database is now available to <span class="CalloutFont">Splice Machine Enterprise Edition</span> users.</p>
                    <p>For more information, see <a href="onprem_admin_backingup.html">Backing Up and Restoring Your Database</a> in our <em>Administrator's Guide</em>, and the following built-in system procedures and system tables in our <em>SQL Reference Manual</em>:</p>
                    <ul class="bullet">
                        <li><a href="sqlref_sysprocs_backupdb.html"><code>SYSCS_UTIL.SYSCS_BACKUP_DATABASE</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_cancelbackup.html"><code>SYSCS_UTIL.SYSCS_CANCEL_BACKUP</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_canceldailybackup.html"><code>SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_deletebackup.html"><code>SYSCS_UTIL.SYSCS_DELETE_BACKUP</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_deleteoldbackups.html"><code>SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_restoredb.html"><code>SYSCS_UTIL.SYSCS_RESTORE_DATABASE</code></a>
                        </li>
                        <li><a href="sqlref_sysprocs_scheduledailybackup.html"><code>SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP</code></a>
                        </li>
                        <li><a href="sqlref_systables_sysbackup.html"><code>SYSBACKUP System Table</code></a>
                        </li>
                        <li><a href="sqlref_systables_sysbackupitems.html"><code>SYSBACKUPITEMS System Table</code></a>
                        </li>
                        <li><a href="sqlref_systables_sysbackupjobs.html"><code>SYSBACKUPJOBS System Table</code></a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td><strong>2.5</strong></td>
                <td><em>External Tables</em></td>
                <td>
                    <p>You can now access ORC and PARQUET files as external tables. See <a href="developers_fundamentals_externaltables.html">Using External Tables</a> in our <em>Developer's Guide</em> for more information.</p>
                    <p>The <a href="sqlref_sysprocs_refreshexttable.html"><code>SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE</code></a> built-in system procedure are now available for working with external tables.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.5</strong></td>
                <td><em>Pinned Tables<br />(RDD Caching)</em></td>
                <td>
                    <p>You can now use the <a href="sqlref_statements_unpintable.html"><code>UNPIN TABLE</code></a> statement to delete the cached version of the table.</p>
                    <p>You also need to use the new <code>pin</code> query optimization hint, which is described in our <a href="developers_tuning_queryoptimization.html">Query Optimization</a> topic.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.5</strong></td>
                <td><em>Schema-level Privileges</em></td>
                <td>Updates to the <a href="sqlref_statements_revoke.html">Revoke</a> statements allow you to define privileges at the schema level.</td>
            </tr>
            <tr>
                <td><strong>2.5</strong></td>
                <td><em>Updated Connectors</em></td>
                <td>
                    <p>Splice Machine has added enhancements to our JDBC and ODBC drivers for improved performance and added features. </p>
                    <p class="noteIcon">Due to these changes, you <strong>must use</strong> the Splice Machine JDBC and ODBC drivers; other drivers will not work properly.</p>
                </td>
            </tr>
            <tr>
                <td><strong>2.5</strong></td>
                <td><em>Updated Statistics</em></td>
                <td>
                    <p>Splice Machine has enhanced our statistics collection methods, taking advantage of advanced features provided by the Yahoo DataSketches library. As a result, these procedures and tables have been deprecated:</p>
                    <ul class="bullet">
                        <li><code>SYSCS_UTIL.SYSCS_COLLECT_TABLE_STATISTICS</code>
                        </li>
                        <li><code>SYSCS_UTIL.SYSCS_DROP_TABLE_STATISTICS</code>
                        </li>
                        <li><code>SYSSTATISTICS</code> table</li>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
## Deprecated Features Summary   {#DeprecatedFeatures}

<table summary="Summary of functions deprecated in recent releases.">
            <col />
            <col />
            <col />
            <tbody>
                <tr>
                    <th>Version when deprecated</th>
                    <th>Change</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><strong>2.5</strong></td>
                    <td>Statistics Built-in Procedures</td>
                    <td>
                        <p>The following built-in system procedures are no longer available:</p>
                        <ul class="bullet">
                            <li><code>SYSCS_UTIL.SYSCS_COLLECT_TABLE_STATISTICS</code>
                            </li>
                            <li><code>SYSCS_UTIL.SYSCS_DROP_TABLE_STATISTICS</code>
                            </li>
                        </ul>
                        <p>Note that:</p>
                        <ul class="bullet">
                            <li>You can continue to use the <a href="cmdlineref_analyze.html"><code>ANALYZE</code></a> command line command to collect statistics for a specific table.</li>
                            <li>You can call the <a href="sqlref_sysprocs_collectschemastats.html"><code>SYSCS_UTIL.SYSCS_COLLECT_SCHEMA_STATISTICS</code></a> built-in system procedure to collect statistics on a schema, including statistics for every table in the schema.</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td><strong>2.5</strong></td>
                    <td>Statistics Tables</td>
                    <td>
                        <p>The following system tables are no longer available:</p>
                        <ul class="codeList">
                            <li>SYSSTATISTICS</li>
                            <li>SYSOPERATIONHISTORY</li>
                            <li>SYSSTATEMENTHISTORY</li>
                            <li>SYSSTATISTICS</li>
                            <li>SYSTASKHISTORY</li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
## Documentation Updates Summary   {#DocsFeatures}

This section summarizes important documentation updates in this version:

<table summary="Summary of documentation updates in this release.">
            <col />
            <col />
            <col />
            <tbody>
                <tr>
                    <th>Version</th>
                    <th>Change</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><strong>2.6</strong></td>
                    <td><em>Documentation Revamped</em></td>
                    <td><p>We have switched to a new documentation system, with a simplified navigation structure that accomodates both our Database Service and On-Premise Database products. The documentation system is built on the open-source site generator Jekyll, with continuous deployment technology, so the docs will be kept up to date with much less effort.</p>
                        <p>We've updated our <a href="notes_usingdocs.html">Using the Documentation</a> topic for this new system. We've also added a <a href="notes_urlmap.html"> page that maps URLs</a> from our previous documentation system into the equivalent permalinks in our new documentation system.</p></td>
                </tr>
                <tr>
                    <td><strong>2.6</strong></td>
                    <td><em>Error Codes Documented</em></td>
                    <td>Our SQL Reference Manual now has a <a href="sqlref_errcodes_intro.html">section that contains descriptions of all error codes</a>.</td>
                </tr>
                <tr>
                    <td><strong>2.5</strong></td>
                    <td><em>Appearance</em></td>
                    <td>The appearance of the documentation has been altered: we are now using a left-sided navigation pane, and some of our appearance styles have been altered to more closely match the appearance of the <a href="https://www.splicemachine.com/" target="_blank">splicemachine.com</a> web.</td>
                </tr>
                <tr>
                    <td><strong>2.5</strong></td>
                    <td><em>Content Organization</em></td>
                    <td>
                        <p>The organization of the docs has been altered:</p>
                        <ul class="bullet">
                            <li>The top-level contents has changed:<ul class="bullet"><li>The <a href="cmdlineref_intro.html">splice&gt; Command Line Reference</a> manual is now a top-level section, rather than being part of the <em>Developer's Guide</em>.</li><li>The <em>Developer's Guide</em> has been reorganized.</li><li>The user interface for our Database-as-a-Service is documented in the top-level <em>Database-as-a-Service Only</em> section.</li><li>The <em>Administrator's Guide</em> and <em>Installation Guide</em> are now part of the top-level <em>On-Premise Only</em> section.</li></ul></li>
                            <li>Content previously included in our <em>Getting Started Guide</em> has been moved to the <em>Notes</em> section.</li>
                        </ul>
                        <p> </p>
                    </td>
                </tr>
                <tr>
                    <td><strong>2.5</strong></td>
                    <td><em>Tutorials</em></td>
                    <td>
                        <p>We've added a number of tutorials to the documentation, a number of which have been migrated from our Community site.</p>
                        <p>You can find a <a href="tutorials_intro.html">list of available tutorials</a> here. </p>
                        <p class="noteTip">Our navigation menu prefaces the title of each tutorial with an asterisk (<code>*</code>).</p>
                    </td>
                </tr>
                <tr>
                    <td><strong>2.5</strong></td>
                    <td><em>Updates</em></td>
                    <td>
                        <p>All enhancements and bug fixes have been documented, as have all new features.</p>
                    </td>
                </tr>
            </tbody>
        </table>
</div>
</section>

