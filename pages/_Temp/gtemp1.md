---
title: TEMP
summary: Release Notes for Patch Release 2.5.0.1729
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: gtemp1.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Highlighted New Features in GA Release 2.7 (2.7.0.1815 on April 15, 2018)
<table>
<thead>
<tr>
    <td>JIRA</td>
    <td>Description</td>
    <td>Docs Link</td>
</tr>
</thead>
<tbody>
<tr>
    <td><a href="https://splice.atlassian.net/browse/DB-5875">DB-5875</a></td>
    <td>Kerberos-capable JDBC Client</td>
    <td><a href="https://doc.splicemachine.com/onprem_install_configureauth.html">Configuring Splice Machine Authentication</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/DB-6140">DB-6140</a></td>
    <td>Support Major Compaction by Region</td>
    <td><a href="https://doc.splicemachine.com/sqlref_sysprocs_majorcompactregion.html">SYSCS_UTIL.MAJOR_COMPACT_REGION</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/DB-6146">DB-6146</a></td>
    <td>Delete data by region without scanning</td>
    <td><a href="https://doc.splicemachine.com/sqlref_sysprocs_deleteregion.html">SYSCS_UTIL.DELETE_REGION</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/DB-6639">DB-6639</a></td>
    <td>Spark Adapter, Import, and Hive Security Model</td>
    <td><a href="https://doc.splicemachine.com/developers_fundamentals_sparkadapter.html">Using the Splice Machine Spark Adapter</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-137">SPLICE-137</a></td>
    <td>Allow Default Role specification to Users, and automatically set on connecting</td>
    <td><a href="https://doc.splicemachine.com/developers_fundamentals_auth.html">Splice Machine Authorization and Roles</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-175">SPLICE-175</a></td>
    <td>Run Olap server in separate YARN instance</td>
    <td><a href="https://doc.splicemachine.com/onprem_info_troubleshoot.html">Troubleshooting and Best Practices</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1320">SPLICE-1320</a></td>
    <td>Add support for array data type (Beta)</td>
    <td>Not Yet Documented</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1372">SPLICE-1372</a></td>
    <td>Control-side query management</td>
    <td><p><a href="https://doc.splicemachine.com/sqlref_sysprocs_killoperation.html">SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS</a></p>
    <p><a href="https://doc.splicemachine.com/sqlref_sysprocs_getrunningops.html">SYSCS_UTIL.SYSCS_KILL_OPERATION</a></p></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1373">SPLICE-1373</a></td>
    <td>Mechanism to log/view all queries run</td>
    <td><a href="https://doc.splicemachine.com/developers_tuning_logging.html">Using Splice Machine Logging</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1482">SPLICE-1482</a></td>
    <td>HBase Bulk Import</td>
    <td><p>Lots of pages; start with <a href="tutorials_ingest_importoverview.html">Import Overview</a>;</p>
        <p><a href="https://doc.splicemachine.com/sqlref_sysprocs_importhfile.html">SYSCS_UTIL.BULK_IMPORT_HFILE</a></p>
    </td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1568">SPLICE-1568</a></td>
    <td>Core Spark Adapter Functionality with Maven Build</td>
    <td>This looks like an internal fix to me; customer implications covered by DB-6639 (Using the Splice Machine Spark Adapter)
</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1591">SPLICE-1591</a></td>
    <td>Allow Physical Deletes in a Table</td>
    <td><a href="https://doc.splicemachine.com/sqlref_sysprocs_purgedeletedrows.html">SYSCS_UTIL.SET_PURGE_DELETED_ROWS</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1603">SPLICE-1603</a></td>
    <td>Support sample statistics collection (via Analyze)</td>
    <td><p><a href="https://doc.splicemachine.com/cmdlineref_analyze.html">Analyze Command</a></p>
        <p><a href="https://doc.splicemachine.com/sqlref_systables_systablestats.html">SYSTABLESTATISTICS</a></p></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1669">SPLICE-1669</a></td>
    <td>Bulk delete by loading HFiles</td>
    <td><p><a href="https://doc.splicemachine.com/sqlref_statements_delete.html">DELETE Statement</a></p>
        <p><a href="https://doc.splicemachine.com/developers_tuning_queryoptimization.html">Optimizing Queries</a></p></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1671">SPLICE-1671</a></td>
    <td>Enable snapshot with bulk load procedure</td>
    <td><a href="https://doc.splicemachine.com/developers_tuning_snapshots.html">Using Snapshots</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1802">SPLICE-1802</a></td>
    <td>Create Index on Existing Table Using HFile Bulk Loading</td>
    <td><a href="https://doc.splicemachine.com/sqlref_statements_createindex.html">CREATE INDEX Statement</a></td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1681">SPLICE-1681</a></td>
    <td>Introduce hint to bypass statistics for costing</td>
    <td>Not Yet Documented; will be: <a href="https://doc.splicemachine.com/developers_tuning_queryoptimization.html">Optimizing Queries</a></td>
</tr>
</tbody>
</table>


# Notable Performance and Operational Enhancements in GA Release 2.7 (2.7.0.1815 on April 15, 2018)
<table>
<thead>
<tr>
    <td>JIRA</td>
    <td>Description</td>
    <td>Docs Link</td>
</tr>
</thead>
<tbody>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1701">SPLICE-1701</a></td>
    <td>Enable monitoring and reporting capability of memory usage for HBase's JVM via JMX</td>
    <td>Not documented; looks like a performance/operations enhancement w/o documentation implications</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1512">SPLICE-1512</a></td>
    <td>Multiple Distinct Operations in Aggregates Support</td>
    <td>Not documented; looks like a performance/operations enhancement w/o documentation implications</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1617">SPLICE-1617</a></td>
    <td>Index on skewed column - not to load DEFAULT values when creating index (a.k.a., null suppression)</td>
    <td>Not documented; looks like a performance/operations enhancement w/o documentation implications</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1700">SPLICE-1700</a></td>
    <td>Add new columns with DEFAULT values without materialization of existing rows</td>
    <td>Not documented; looks like a performance/operations enhancement w/o documentation implications</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1936">SPLICE-1936</a></td>
    <td>Improve Sqlshell.sh to accept kerberos properties as argument</td>
    <td>Not Documented</td>
</tr>
<tr>
    <td><a href="https://splice.atlassian.net/browse/SPLICE-1984">SPLICE-1984</a></td>
    <td>Parallelize MultiProbeScan and Union operations</td>
    <td>Not documented; looks like a performance/operations enhancement w/o documentation implications</td>
</tr>
</tbody>
</table>

</div>
</section>
