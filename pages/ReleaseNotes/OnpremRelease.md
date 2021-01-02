---
title: On-Premise Product Release Notes
summary: Splice Machine On-Premise Product Release Notes
keywords: release notes, on-premise
toc: false
product: all
sidebar: home_sidebar
permalink: releasenotes_onprem.html
folder: ReleaseNotes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Release Notes for the Splice Machine On-Premise Product

This topic includes release notes that are specific to the Splice Machine *On-Premise Database* product, in these sections:

* [New Features and Enhancements](#new-features)
* [Supported Platforms](#supported-platforms)
* [Enterprise-only Features](#enterprise-only-features)
* [Running the Standalone Version](#running-the-standalone-version)

Most of the information about changes in Splice Machine relate to our database, which is part of both our on-premise and cloud-based products. Most of the release information of note is found in the [database release notes](releasenotes_intro.html).

## After Updating

After updating to a new release of Splice Machine, you may need to update your stored statement metadata by calling these system procedures:

<div class="preWrapperWide"><pre class="Example">
CALL <a href="sqlref_sysprocs_emptyglobalcache.html">SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE();</a>
CALL <a href="sqlref_sysprocs_invalidatestoredstmts.html">SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS();</a>
CALL <a href="sqlref_sysprocs_updatemetastmts.html">SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS();</a>
</pre></div>

## New Features and Enhancements  {#new-features}

This section lists the significant updates in release {{site.build_version}}, in these subsections:

* [Major New Features](#new-features)
* [New Built-in Functions](#new-functions)
* [Feature Enhancements](#feature-enhancements)
* [Notable Performance Enhancements](#performance-enhancements)

### Major New Features  {#new-features}

<table class="oddEven">
    <col width="25%" />
    <col width="75%" />
    <thead>
        <tr>
            <th>Update</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
    <tr>
        <td><em>Time Travel Query</em></td>
        <td>The Splice Machine <a href="sqlref_queries_time_travel_query.html">Time Travel Query</a> feature enables you to query data in your database as it existed at a past time. The past point in time can be specified by a Transaction ID or a timestamp expression. </td>
    </tr>
    <tr>
        <td><em>NSDS 2.0</em></td>
        <td>Version 2.0 of the <a href="bestpractices_ingest_streaming.html#streamsubmitnsds">Splice Machine Native Spark DataSource</a> (NSDS) streams DataFrames across the Kubernetes container/network boundary to Splice Machine, offering a high throughput solution. This is implemented with Kafka.</td>
    </tr>
    <tr>
        <td><em>SSDS</em></td>
        <td>The <a href="bestpractices_ingest_streaming.html#streamsubmitssds">Structured Streaming Data Sink</a> is the Splice Machine implementation of Spark Structured Streaming for high performance data streaming.</td>
    </tr>  
        <tr>
            <td><em>Splice Machine CLI Windows Support</em></td>
            <td>The <a href="cmdlineref_using_getstarted.html#StartingCLIWindows">Splice Machine CLI</a> is now supported on Windows.</td>
        </tr>
        <tr>
            <td><em>MVCC Purge</em></td>
            <td><a href="bestpractices_onprem_configperf.html#MVCCPurge">MVCC Purge</a> enables you to control the way data is purged during memstore flush, minor compaction, and major compaction.</td>
        </tr>
        <!--tr>
            <td><em></em></td>
            <td></td>
        </tr-->
        <tr>
            <td><em>Application Server Queues</em></td>
            <td><p>We have added support for <a href="bestpractices_appservers_intro.html">multiple OLAP (analytical query processing) servers</a>, each of which has its own YARN queue. These queues are role-based, which means that the role assigned to the user submitting a query defines which OLAP server will run that query.</p>
                <p>Application server queues are sometimes referred to as <em>multiple OLAP servers;</em> they allow you to specify how different queries are prioritized into different execution lanes.</p></td>
        </tr>
            <td><em>Schema Access Restrictions</em></td>
            <td><p>Access to the <code>SYS</code> schema is now, by default, restricted to only Database Administrators, who now have the ability to restrict access to the <code>SYS</code> schema on a user or role basis. For more information about this feature, see the [Schema Restriction](tutorials_security_schemarestrict.html) topic.</p>
                <p>Views have been added on many of the system tables; these <a href="sqlref_sysviews_intro.html">Splice Machine system views</a> provide access to all users; however, each user will only be able to access the values within each view to which s/he has been granted access.</p>
                <p class="noteNote">These restrictions are compatible with <em>Apache Ranger</em>. </p>
            </td>
        <tr>
            <td><em>Replication</em></td>
            <td>Asynchronous, Active/Passive Replication allows you to define a master cluster and follower cluster, which is automatically kept in synch with the master. Reads are allowed in either cluster, while only the master cluster supports writes.</td>
        </tr>
        <tr>
            <td><em>Log Filtering</em></td>
            <td>You can now filter sensitive information out of log entries by specifying matching patterns (with regular expressions).</td>
        </tr>
    </tbody>
</table>

### New Built-in Functions  {#new-functions}

<table class="oddEven">
    <col width="25%" />
    <col width="75%" />
    <thead>
        <tr>
            <th>Update</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>MONTH</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_month.html"><code>MONTH</code></a> has been added.</p>
            </td>
        </tr>
        <tr>
            <td><code>DECFLOAT</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_decfloat.html"><code>DECFLOAT</code></a> has been added.</p>
            </td>
        </tr>        
        <!--tr>
            <td><code></code></td>
            <td></td>
        </tr-->
        <tr>
            <td><code>CHR</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_chr.html"><code>CHR</code></a> has been added.</p>
                <p>This work originated with this open-source JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2341" target="_blank">SPLICE-2341</a>.</p>
            </td>
        </tr>
        <tr>
            <td><code>CONCAT</code></td>
            <td>You can now use either <code>||</code> or the term <code>CONCAT</code> to denote the concatenation operator.</td>
        </tr>
        <tr>
            <td><code>HEX</code></td>
            <td>The built-in function <a href="sqlref_builtinfcns_hex.html"><code>HEX</code></a> has been added.</td>
        </tr>
        <tr>
            <td><code>LEFT</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_left.html"><code>LEFT</code></a> has been added.</p>
                <p>This work originated with this open-source JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2343" target="_blank">SPLICE-2343</a>.</p>
            </td>
        </tr>
        <tr>
            <td><code>REPEAT</code></td>
            <td>The built-in function <a href="sqlref_builtinfcns_repeat.html"><code>REPEAT</code></a> has been added.</td>
        </tr>
        <tr>
            <td><code>RIGHT</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_right.html"><code>RIGHT</code></a> has been added.</p>
                <p>This work originated with this open-source JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2344" target="_blank">SPLICE-2344</a>.</p>
            </td>
        </tr>
        <tr>
            <td><code>STRIP</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_strip.html"><code>STRIP</code></a> has been added.</p>
                <p>This work originated with this open-source JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2345" target="_blank">SPLICE-2345</a>.</p>
            </td>
        </tr>
    </tbody>
</table>

### Feature Enhancements  {#feature-enhancements}

<table class="oddEven">
    <col width="25%" />
    <col width="75%" />
    <thead>
        <tr>
            <th>Update</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>WHERE Clause Tuple Support</em></td>
            <td>Statements with <code>WHERE (KEY1#,KEY2#)=(?,?)</code> are now supported.</td>
        </tr>
        <tr>
            <td><em>Support for Multiple Jar Files in User Defined Functions</em></td>
            <td><a href="developers_fcnsandprocs_intro.html">User Defined Functions and Stored Procedures</a> now support multiple Jar files per schema.</td>
        </tr>
        <tr>
            <td><em>External Table Support for CDH 6.3</em></td>
            <td>External tables are now fully supported for CDH 6.3.</td>
        </tr>
        <tr>
            <td><em>Support for Multiple Statements in Database Triggers</em></td>
            <td><a href="sqlref_statements_createtrigger.html"><code>CREATE TRIGGER</code></a> now supports multiple statements for <a href="developers_fundamentals_triggers.html">Database Triggers</a></td>
        </tr>
        <tr>
            <td><em>Disable Option for Transitive Closure</em></td>
            <td>A property has been added to the <a href="cmdlineref_setsessionproperty.html"><code>SET SESSION_PROPERTY</code></a> command that allows you to disable transitive closure for predicates pushed from outside of the view/DT. </td>
        </tr>
        <tr>
            <td><em>Mask Sensitive Information in Log Messages</em></td>
            <td>You can now <a href="developers_tuning_logging.html#Filtering">mask sensitive information in log messages</a> to prevent sensitive information such as passwords and credit card information from appearing in log messages.</td>
        </tr>
        <tr>
            <td><em>CREATE TABLE ... IF NOT EXISTS</em></td>
            <td>The  <a href="sqlref_statements_createtable.html#createTableIfNotExists"><code>IF NOT EXISTS</code></a> clause for <code>CREATE TABLE</code> blocks table creation if a table with the same name already exists.</td>
        </tr>
        <tr>
            <td><em>Show Local Time in Command Prompt</em></td>
            <td>You can use the <a href=cmdlineref_using_cli.html#ShowTime"><code>prompt clock on</code></a> command to display the current local time in the Splice Machine CLI command prompt.</td>
        </tr>
        <tr>
            <td><em>Updated Explain Plan Execution Engine Terminology</em></td>
            <td>In <a href=bestpractices_optimizer_explain.html">Explain Plans</a> <code>OLTP</code> is now used to reference the OLTP (HBase) execution engine, and <code>OLAP</code> is used to reference the OLAP (Spark) execution engine. These terms have also been updated for <a href=sqlref_sysprocs_getrunningops.html"><code>GET_RUNNING_OPERATIONS</code></a>.</td>
        </tr>
        <tr>
            <td><em>FROM Clause Qualifiers: OLD TABLE, NEW TABLE, FINAL TABLE</em></td>
            <td>You can use <a href="sqlref_clauses_from.html#from-clause-qualifiers">FROM Clause Qualifiers</a> to retrieve intermediate result sets from a SQL data change statement.</td>
        </tr>
        <tr>
            <td><em>Foreign Key: ON DELETE SET NULL</em></td>
            <td>A foreign key with <a href="sqlref_clauses_constraint.html#on-delete-set-null">ON DELETE SET NULL</a> specifies that if a record in the parent table is deleted, the corresponding records in the child table will have the foreign key fields set to NULL. </td>
        </tr>
        <tr>
            <td><em>Foreign Key: ON DELETE CASCADE</em></td>
            <td>A foreign key with <a href="sqlref_clauses_constraint.html#on-delete-cascade">ON DELETE CASCADE</a> specifies that if a record in the parent table is deleted, the corresponding records in the child table will be deleted.</td>
        </tr>
        <tr>
            <td><em>Enhanced Foreign Key Checker</em></td>
            <td>Foreign key error messages have been enhanced to provide more information.</td>
        </tr>
        <tr>
            <td><em>Spool Command</em></td>
            <td>The <a href="cmdlineref_spool.html"><code>spool</code></a> command logs Splice Machine command line session data to a specified file on the local file system.</td>
        </tr>
        <!--tr>
            <td><em></em></td>
            <td></td>
        </tr-->
        <tr>
            <td><em>Merge Data From Multiple Files</em></td>
            <td>The <a href="sqlref_sysprocs_mergedata.html"><code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code></a> system procedure now supports merging all files in a directory.</td>
        </tr>
        <tr>
            <td><em>Full Join Support</em></td>
            <td>Full joins, also referred to as <em>full outer joins</em>, allow you to combine the rows from two tables, including the rows in either table that don’t have match in the other table.</td>
        </tr>
        <tr>
            <td><em>Alter Table</em></td>
            <td>The <a href="sqlref_statements_altertable.html"><code>ALTER TABLE</code></a> statement now supports self-referencing foreign keys.</td>
        </tr>
        <tr>
            <td><em>Alias</em></td>
            <td>You can now use <code>ALIAS</code> interchangeably with <code>SYNONYM</code>.</td>
        </tr>
        <tr>
            <td><em>Statistics Backed Up and Restored</em></td>
            <td><p>The <a href="sqlref_sysprocs_backuptable.html"><code>SYSCS_UTIL.SYSCS_BACKUP_TABLE</code></a> and <a href="sqlref_sysprocs_backupschema.html"><code>SYSCS_UTIL.SYSCS_BACKUP_SCHEMA</code></a> system procedures now back up statistics, and the <a href="sqlref_sysprocs_restoretable.html"><code>SYSCS_UTIL.SYSCS_RESTORE_TABLE</code></a> and <a href="sqlref_sysprocs_restoreschema.html"><code>SYSCS_UTIL.SYSCS_RESTORE_SCHEMA</code></a> system procedures restore those statistics.</p>
            <p class="noteIcon">This means that, if the statistics were current when you backed up, you do not need to run an <code>ANALYZE</code> after restoring the table or schema.</p>
            </td>
        </tr>
        <tr>
            <td><em>Decimal Precision Increase</em></td>
            <td>Maximum precision for the <a href="sqlref_datatypes_decimal.html"><code>DECIMAL</code></a> data type has been increased from <code>31</code> to <code>38</code>.</td>
        </tr>
        <tr>
            <td><em>TimeStamp Precision Increase</em></td>
            <td>Timestamp precision has been increased to microseconds (6 decimals places).</td>
        </tr>
    </tbody>
</table>

### Performance Enhancements  {#performance-enhancements}

<table class="oddEven">
    <col width="25%" />
    <col width="75%" />
    <thead>
        <tr>
            <th>Update</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Native Spark Aggregation</em></td>
            <td><p>This update improves the performance of queries that perform aggregation after a join or series of joins that are CPU bound; for example: cross join cases or join queries with join keys that have high rows-per-value. This is achieved by using the latest Spark Dataset methods to perform the aggregation, which allows Spark to use WholeStageCodeGen to combine multiple physical operators into a single Java function.</p>
                <p>This work originated with this open-source JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2302" target="_blank">SPLICE-2302</a>.</p>
            </td>
        </tr>
        <tr>
            <td><em>Cross Join</em></td>
            <td>The implementation of <code>Nested Loop Inner Join</code> has been enhanced to use Spark's DataFrame Cross Join implementation, resulting in performance improvement for applicable queries.</td>
        </tr>
        <tr>
            <td><em>Property Caching</em></td>
            <td>Property cache added for Spark executor to reduce hits to splice:16 region.</td>
        </tr>
    </tbody>
</table>

### Database Service New Features and Enhancements

If you're using the Splice Machine Database-as-a-Service produce, you'll find additional enhancements in the [Database Service Release Notes](releasenotes_dbaas.html) topic page.

## Supported Platforms {#supported-platforms}
The supported platforms for release {{site.build_version}} are:

{% if site.build_version == "3.0" %}
{% include splice_snippets/Vers3.0Platforms.md %}
{% elsif site.build_version == "2.8" %}
{% include splice_snippets/Vers2.8Platforms.md %}
{% else %}
{% include splice_snippets/Vers2.7Platforms.md %}
{% endif %}

## Enterprise-only Features {#enterprise-only-features}
Some features only work on the *Enterprise Edition* of Splice Machine; they __do not__ work on the Community Edition of Splice Machine. To obtain a license for the Splice Machine *Enterprise Edition*, please [Contact Splice Machine Sales](https://www.splicemachine.com/company/contact-us/)
today.

These are the enterprise-only features in our *On-Premise Database*:

* Backup/Restore
* LDAP integration
* Column-level user privileges
* Kerberos enablement
* Encryption at rest


## Running the Standalone Version {#running-the-standalone-version}
The supported operating systems for the STANDALONE release of Splice Machine are:

* Mac OS X (10.8 or greater)
* Centos (6.4 or equivalent)

</div>
</section>
