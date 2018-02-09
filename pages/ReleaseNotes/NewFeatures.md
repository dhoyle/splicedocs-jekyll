---
title: New Features
summary: Notes about new features in the current release of our database.
keywords: update notes
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_newfeatures.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# New Features in Release {{splvar_basic_SpliceReleaseVersion}} of the Splice Machine Database

{% include splice_snippets/onpremonlytopic.md %}
This topic describes significant new features in the Splice Machine Database, which is used in both our Database-as-Service and On-Premise Database products.

Here's a summary of the new features in the 2.7.0 release:

<table summary="Summary of new features in this release">
    <col />
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>Feature</th>
            <th>JIRA ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Implement Kerberos JDBC support</em></td>
            <td>SPLICE-31</td>
            <td>Our JDBC driver now supports Kerberos authentication.</td>
        </tr>
        <tr>
            <td><em>HAProxy and connection load balancing solution</em></td>
            <td>SPLICE-662</td>
            <td>Our JDBC client now distributes query requests across multiple nodes without losing transactions, which provides a more even distribution of work across the cluster, resulting in better performance. </td>
        </tr>
        <tr>
            <td><em>Support for Array Data Type</em></td>
            <td>SPLICE-1320</td>
            <td>Adds <code>ARRAY</code> data type</td>
        </tr>
        <tr>
            <td><em>Working with Running Operations</em></td>
            <td>SPLICE-1372</td>
            <td><p>We've added two new system procedures for working with database operations that are currently running on a server:</p>
            <ul>
                <li>The <a href="sqlref_sysprocs_getrunningops.html"><code>SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS</code></a> system procedure displays a list of the operations running on the server to which you are currently connected.</li>
                <li>You can use this procedure to find the UUID for an operation, which you can then use for purposes such as terminating an operation with the <a href="sqlref_sysprocs_killoperation.html"><code>SYSCS_UTIL.SYSCS_KILL_OPERATION</code></a> system procedure.</li>
            </ul>
            </td>
        </tr>
        <tr>
            <td><em>Logging Changes</em></td>
            <td>SPLICE-1373</td>
            <td><p>We've made two significant changes in logging:</p>
                <ul>
                    <li>Statement logging is now enabled by default. To modify this, see the <a href="developers_tuning_logging">Using Logging</a> topic.</li>
                    <li>Logs are stored, by default, in your region server's log directory. You can modify the location of the logs with a code snippet that is described in the <a href="onprem_install_intro.html">Installation Guide</a> page for your platform (Cloudera, Hortonworks, or MapR).</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><em>HBase Bulk Import</em></td>
            <td>SPLICE-1482</td>
            <td>Improves import performance by using Hfiles.</td>
        </tr>
        <tr>
            <td><em>Multiple Distinct Operations in Aggregates</em></td>
            <td>SPLICE-1512</td>
            <td>Allows use of multiple <code>DISTINCT</code> operations in aggregates.</td>
        </tr>
        <tr>
            <td><em>Allow Physical Deletes in a Table</em></td>
            <td>SPLICE-1591</td>
            <td>Adds an option to purge deleted rows when performing a major compaction.</td>
        </tr>
        <tr>
            <td><em>Support sample statistics collection (via Analyze)</em></td>
            <td>SPLICE-1603</td>
            <td>Adds a clause to the <code>ANALYZE TABLE</code> command to allow analyzing via sampled statistics, rather than analyzing the entire table.</td>
        </tr>
        <tr>
            <td><em>SSL/TLS</em></td>
            <td>SPLICE-1607</td>
            <td>You can now configure and use SSL/TLS secured JDBC connections to your Splice Machine database. We support both basic encrypted connections and peer-authenticated connections. Please see our <a href="onprem_install_configureTLS.html">Configuring SSL/TLS topic</a> for more information.</td>
        </tr>
        <tr>
            <td><em>Sparse index support</em></td>
            <td>SPLICE-1617</td>
            <td>Adds support for suppressing <code>NULLs</code> when creating an index to address a situation where most rows in a table contain the default (<code>NULL</code>) value, which wastes storage and causes bad distribution of rows across regions.</td>
        </tr>
        <tr>
            <td><em>Bulk delete by loading HFiles</em></td>
            <td>SPLICE-1669</td>
            <td>Supports bulk delete via HFiles, bypassing the HBase write path.</td>
        </tr>
        <tr>
            <td><em>Enable snapshot with bulk load procedure.</em></td>
            <td>SPLICE-1671</td>
            <td>Added the ability to take snapshots of tables (and their indexes).</td>
        </tr>
        <tr>
            <td><em>Enable monitoring and reporting capability of memory usage for HBase's JVM via JMX</em></td>
            <td>SPLICE-1701</td>
            <td>Adds ability to monitor memory usage by HBase JVM through JMX.</td>
        </tr>
        <tr>
            <td><em>Session Information</em></td>
            <td>SPLICE-1760</td>
            <td>The new <a href="sqlref_sysprocs_getsessioninfo.html"><code>SYSCS_UTIL.GET_SESSION_INFO"</code></a> system procedure reports information about your current session, including  the hostname and session ID for your current session. You can use this information to correlate your Splice Machine query with a Spark job: the same information is displayed in the <code>Job Id (Job Group)</code> in the Spark console.</td>
        </tr>
        <tr>
            <td><em>Region Functions</em></td>
            <td>N/A</td>
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
            <td><em>Add a system procedure <code>MERGE_DATA_FROM_FILE</code> to achieve a limited fashion of merge-into</em></td>
            <td>N/A</td>
            <td>Imports data without overwriting generated or default values contained in non-imported columns.</td>
        </tr>
        <tr>
            <td><em>Support <code>BLOB/CLOB</code> in ODBC</em></td>
            <td>N/A</td>
            <td>Our ODBC Driver now supports BLOB and CLOB objects.</td>
        </tr>
    </tbody>
</table>

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>

</div>
</section>
