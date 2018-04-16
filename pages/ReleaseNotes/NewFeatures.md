---
title: New Features
summary: Notes about new features in this release of our database.
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
# New Features and Changes in Release {{site.build_version}} of the Splice Machine Database

The Splice Machine database is used in both our Database-Service and On-Premise Database products.

This page describes the major new features added to the Splice Machine database since the original 2.5 GA Release of Splice Machine, in March, 2017.

Splice Machine Release 2.6 was an interim release in September, 2017, which coincided with the initial Release of our Database-as-a-Service product. All changes in v2.6 have been incorporated into the 2.7 Release of the Splice Machine database.
{: .noteIcon}

## New Features Only Available in Splice Machine Release 2.7  {#Only27}

These features have been added to Release 2.7 of Splice Machine, and have not been backported to Release 2.5:

<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Add support for AVRO format for external tables.</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Query Logging</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td><p>Add MacOS version of our ODBC driver.</p>
                <p class="noteIcon">This is a provisional feature that has not yet been as thoroughly tested as it will be.</p>
            </td>
        </tr>
        <tr>
            <td>Internal</td>
            <td><p>JDBC Driver Improvements</p>
                <p class="noteIcon">This is a provisional feature that has not yet been as thoroughly tested as it will be.</p>
            </td>
        </tr>
    </tbody>
</table>

## New Features in Available in Splice Machine Releases 2.7 and 2.5

Each section in this topic includes a list of major new in each interim Splice Machine release since the 2.5 GA Release (2.5.0.1707) on March 1, 2017.

* [Patch Release 2.7.0.1814](#Patch1814)
* [Patch Release 2.5.0.1813](#Patch1813)
* [Patch Release 2.5.0.1812](#Patch1812)
* [Patch Release 2.5.0.1811](#Patch1811)
* [Patch Release 2.5.0.1810](#Patch1810)
* [Patch Release 2.5.0.1809](#Patch1809)
* [Patch Release 2.5.0.1808](#Patch1808)
* [Patch Release 2.5.0.1807](#Patch1807)
* [Patch Release 2.5.0.1806](#Patch1806)
* [Patch Release 2.5.0.1805](#Patch1805)
* [Patch Release 2.5.0.1804](#Patch1804)
* [Patch Release 2.5.0.1803](#Patch1803)
* [Patch Release 2.5.0.1802](#Patch1802)
* [Patch Release 2.5.0.1749](#Patch1749)
* [Patch Release 2.5.0.1748](#Patch1748)
* [Patch Release 2.5.0.1747](#Patch1747)
* [Patch Release 2.5.0.1745](#Patch1745)
* [Patch Release 2.5.0.1735](#Patch1735)
* [Patch Release 2.5.0.1729](#Patch1729)

## 2.7.0.1815 Patch Release  14-Apr-18  {#Patch1815}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

## 2.7.0.1814 Patch Release  06-Apr-18  {#Patch1814}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1813 Patch Release  31-Mar-18  {#Patch1813}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1812 Patch Release  24-Mar-18  {#Patch1812}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Support ldap group as authenticated user, get the group user when it exists.</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add configurable setting to map ldap group to splice user, add missing null check.</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Proxy HDFS access for Spark Adapter apps.</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Cache role grant permissions.</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1811 Patch Release  17-Mar-18  {#Patch1811}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-137</td>
            <td>Allow default roles to be set automatically in a session.</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1810 Patch Release  10-Mar-18  {#Patch1810}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-1883</td>
            <td>Add rowcount threshold parameter to determine Spark or Control</td>
        </tr>
        <tr>
            <td>SPLICE-2102</td>
            <td>Stats and truncate functions, a bit of scaladoc writing</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1809 Patch Release  03-Mar-18  {#Patch1809}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1808 Patch Release  24-Feb-18  {#Patch1808}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1807 Patch Release  18-Feb-18  {#Patch1807}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

## 2.5.0.1806 Patch Release  12-Feb-18  {#Patch1806}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>N/A</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>


###  2.5.0.1805 Patch Release  5-Feb-18  {#Patch1805}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Improve export performance</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix illegal merge join</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Prevent incremental backup from losing changes</td>
        </tr>
    </tbody>
</table>

###  2.5.0.1804 Patch Release  28-Jan-18  {#Patch1804}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Add hint <code>useDefaultRowCount</code> and <code>defaultSelectivityFactor</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix upsert index</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Vacuum disabled tables</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Cache more database properties</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix database restore from s3</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Retry write workload on host unreachable exceptions</td>
        </tr>
    </tbody>
</table>

###  2.5.0.1803 Patch Release  21-Jan-18  {#Patch1803}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Add system procedure to enable/disable all column statistics</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Close <code>FutureIterator</code> to avoid race condition</td>
        </tr>
    </tbody>
</table>

###  2.5.0.1802 Patch Release  14-Jan-18  {#Patch1802}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Clean up incremental changes from offline regions that were offline before full backup</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add ignore txn cache</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Handle CannotCommit exception correctly</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Reduce lengthy lineage of transformation for <code>MultiProbeTableScan</code> operation</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add JDBC timeout support</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Get keytab file name correctly</td>
        </tr>
    </tbody>
</table>

###  2.5.0.1749 Patch Release  26-Dec-17  {#Patch1749}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Exclude metrics jar for cdh platforms</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add missing <code>getEncodedName()</code> method</td>
        </tr>
    </tbody>
</table>

###  2.5.0.1748 Patch Release  18-Dec-17  {#Patch1748}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Fix inconsistent selectivity with predicate order change</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Delete data by region without scanning</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Adjust selectivity estimation by excluding skewed default values</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Propagate SORT elimination to outer joins</td>
        </tr>
        <tr>
            <td>SPLICE-1920</td>
            <td>Tooling to fix data dictionary corruption</td>
        </tr>
    </tbody>
</table>

###  2.5.0.1747 Patch Release  08-Dec-17  {#Patch1747}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Terminate backup timely if it has been cancelled</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Prepend schemaname to columns in PK conditions in update statement generated by <code>MERGE_DATA_FROM_FILE</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix column misalignment for join update through mergesort join</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Bound the outer join row count by the left outer table's row count</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Parameter sanity check for region operations</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Populate default value for column of DATE type in defaultRow with the right type (regression fix for SPLICE-1700)</td>
        </tr>
    </tbody>
</table>

###  2.6.1.1745 Patch Release  08-Dec-17  {#Patch1745}

2.6 was an interim release that has been folded in to 2.5
{: .noteIcon}

<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>Add region name and id to compaction job description</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add more logging</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Enhance <code>MultiProbeIndexScan</code> to apply for cases where inlist is not the leading index/PK column</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add logs around task failure in Spark</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Make table level select privileges to column level</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add back synchronous backup/restore</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add check for <code>actionAllowed</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Exclude flatten and restart scripts</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Move the bulkimport/bulkdelete test in DefaultIndexIT to a separate file under hbase_sql so it won't run for mem platform</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Add parameter to ignore missing transactions from <code>SPLICE_TXN</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Keep alive backup</td>
        </tr>
        <tr>
            <td>SPLICE-1802</td>
            <td>Create index by HFile loading</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Synchronize access to shared <code>ArrayList</code></td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Fix automatic DROP of temp tables</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Enhance subquery processing logic to convert eligible where subqueries</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allow first connection on Kerberized cluster</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Large variance in simple select query execution time</td>
        </tr>
        <tr>
            <td>SPLICE-1700</td>
            <td>Avoid updating existing physical rows when adding not-null column with default value</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Allow distributed execution for splice client</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Avoid index creation timeout</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Flatten correlated Scalar Subquery in <code>Select</code> clause</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Null checking for region operations</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Avoid sort if some of the index columns are bound with constant</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Set rowlocation for index lookup</td>
        </tr>
    </tbody>
</table>

## Splice Patch Release 2.5.0.1735  06-Sep-17  {#Patch1735}
<table summary="Summary of new features and changes in this release">
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SPLICE-31</td>
            <td>Our JDBC driver now supports Kerberos authentication.</td>
        </tr>
        <tr>
            <td>SPLICE-662</td>
            <td>Our JDBC client now distributes query requests across multiple nodes without losing transactions, which provides a more even distribution of work across the cluster, resulting in better performance. </td>
        </tr>
        <tr>
            <td>SPLICE-1320</td>
            <td>Adds <code>ARRAY</code> data type</td>
        </tr>
        <tr>
            <td>SPLICE-1372</td>
            <td><p>We've added two new system procedures for working with database operations that are currently running on a server:</p>
            <ul>
                <li>The <a href="sqlref_sysprocs_getrunningops.html"><code>SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS</code></a> system procedure displays a list of the operations running on the server to which you are currently connected.</li>
                <li>You can use this procedure to find the UUID for an operation, which you can then use for purposes such as terminating an operation with the <a href="sqlref_sysprocs_killoperation.html"><code>SYSCS_UTIL.SYSCS_KILL_OPERATION</code></a> system procedure.</li>
            </ul>
            </td>
        </tr>
        <tr>
            <td>SPLICE-1373</td>
            <td><p>We've made two significant changes in logging:</p>
                <ul>
                    <li>Statement logging is now enabled by default. To modify this, see the <a href="developers_tuning_logging">Using Logging</a> topic.</li>
                    <li>Logs are stored, by default, in your region server's log directory. You can modify the location of the logs with a code snippet that is described in the <a href="onprem_install_intro.html">Installation Guide</a> page for your platform (Cloudera, Hortonworks, or MapR).</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>SPLICE-1482</td>
            <td>Improves import performance by using Hfiles.</td>
        </tr>
        <tr>
            <td>SPLICE-1512</td>
            <td>Allows use of multiple <code>DISTINCT</code> operations in aggregates.</td>
        </tr>
        <tr>
            <td>SPLICE-1607</td>
            <td>You can now configure and use SSL/TLS secured JDBC connections to your Splice Machine database. We support both basic encrypted connections and peer-authenticated connections. Please see our <a href="onprem_install_configureTLS.html">Configuring SSL/TLS topic</a> for more information.</td>
        </tr>
        <tr>
            <td>SPLICE-1617</td>
            <td>Adds support for suppressing <code>NULLs</code> when creating an index to address a situation where most rows in a table contain the default (<code>NULL</code>) value, which wastes storage and causes bad distribution of rows across regions.</td>
        </tr>
        <tr>
            <td>SPLICE-1669</td>
            <td>Supports bulk delete via HFiles, bypassing the HBase write path.</td>
        </tr>
        <tr>
            <td>SPLICE-1701</td>
            <td>Adds ability to monitor memory usage by HBase JVM through JMX.</td>
        </tr>
        <tr>
            <td>SPLICE-1760</td>
            <td>The new <a href="sqlref_sysprocs_getsessioninfo.html"><code>SYSCS_UTIL.GET_SESSION_INFO"</code></a> system procedure reports information about your current session, including  the hostname and session ID for your current session. You can use this information to correlate your Splice Machine query with a Spark job: the same information is displayed in the <code>Job Id (Job Group)</code> in the Spark console.</td>
        </tr>
        <tr>
            <td>Internal</td>
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
            <td>Internal</td>
            <td>Imports data without overwriting generated or default values contained in non-imported columns.</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Our ODBC Driver now supports BLOB and CLOB objects.</td>
        </tr>
    </tbody>
</table>

###  Splice Patch Release 2.5.0.1729  01-Aug-17 {#Patch1729}

<table summary="Summary of new features and changes in this release">
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Internal</td>
            <td>add a system procedure MERGE_DATA_FROM_FILE to achieve a limited fashion of merge-into</td>
        </tr>
        <tr>
            <td>Internal</td>
            <td>Implement Kerberos JDBC support (2.5)</td>
        </tr>
        <tr>
            <td>SPLICE-1591</td>
            <td>Allow Physical Deletes in a Table</td>
        </tr>
        <tr>
            <td>SPLICE-1603</td>
            <td>Support sample statistics collection (via Analyze)</td>
        </tr>
        <tr>
            <td>SPLICE-1671</td>
            <td>Enable snapshot with bulk load procedure</td>
        </tr>
    </tbody>
</table>

For a full list of JIRA's for the Community/Open Source software, see <https://splice.atlassian.net>

</div>
</section>
