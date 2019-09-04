---
title: Release Notes for This Release of Splice Machine
summary: Release notes for this release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar: home_sidebar
permalink: releasenotes_intro.html
folder: ReleaseNotes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}

# Release Notes for Splice Machine

Welcome to the {{site.build_version}} Release of Splice Machine, originally released  {{site.release_date}}.

Our release notes are presented in these topics:

* This topic summarizes the [major new features and improvements](#major) in version {{site.build_version}}.
* The [Database Release Notes](#releasenotes) section below links to the notes for each update (patch release) of the Splice Machine database, which is part of all Splice Machine products.
* The [Known Issues and Workarounds](releasenotes_workarounds.html) topic describes each known issue in the current release and its workaround.
* The [Database-as-Service Product Release Notes](releasenotes_dbaas.html) topic contains release information specific to our Database-as-Service product.
* The [On-Premise Product Release Notes](releasenotes_onprem.html) topic contains release information specific to our On-Premise product.
* If you're looking for older release notes, you'll find them in the [Archived Release Notes](releasenotes_archived_intro.html) section, under the *Previous Release Docs* heading.

## Major Updates in Release {{site.build_version}}  {#major}

<table>
    <col width="15%" />
    <col width="25%" />
    <col width="60%" />
    <thead>
        <tr>
            <th>Category</th>
            <th>Update</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="BoldFont" rowspan="3">New Feature</td>
            <td>Multiple OLAP Servers</td>
            <td><p>We have added support for <a href="bestpractices_appservers_intro.html">multiple OLAP (analytical query processing) servers</a>, each of which has its own YARN queue. These queues are role-based, which means that the role assigned to the user submitting a query defines which OLAP server will run that query.</p>
                <p>Multiple OLAP servers are sometimes referred to as *multiple swim lanes;* they allow you to specify how different queries are prioritized into different execution lanes.</p>
            </td>
        </tr>
        <tr>
            <td>Schema Access Restrictions</td>
            <td><p>Database Administrators now have the ability to restrict access to the <code>SYS</code> schema on a user or role basis. This means that access to the <a href="sqlref_systables_intro.html">Splice Machine system tables</a> is limited, by default, to administrative users.</p>
                <p>Views have been added on many of the system tables; these <a href="sqlref_sysviews_intro.html">Splice Machine system views</a> provide access to all users; however, each user will only be able to access the values within each view to which s/he has been granted access.</p>
                <p class="noteNote">These restrictions are compatible with <em>Apache Ranger</em>.</p>
            </td>
        </tr>
        <tr>
            <td>Log Filtering</td>
            <td>You can now filter sensitive information out of log entries by specifying matching patterns (with regular expressions).</td>
        </tr>
        <tr>
            <td class="BoldFont" rowspan="4">New Built-in Function</td>
            <td><code>STRIP</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_strip.html"><code>STRIP</code></a> has been added.</p>
                <p>This work originated with this JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2345" target="_blank">SPLICE-2345</a>.</p>
            </td>
        </tr>
        <tr>
            <td><code>RIGHT</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_right.html"><code>RIGHT</code></a> has been added.</p>
                <p>This work originated with this JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2344" target="_blank">SPLICE-2344</a>.</p>
            </td>
        </tr>
        <tr>
            <td><code>LEFT</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_left.html"><code>LEFT</code></a> has been added.</p>
                <p>This work originated with this JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2343" target="_blank">SPLICE-2343</a>.</p>
            </td>
        </tr>
        <tr>
            <td><code>CHR</code></td>
            <td><p>The built-in function <a href="sqlref_builtinfcns_chr.html"><code>CHR</code></a> has been added.</p>
                <p>For more information, see this JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2341" target="_blank">SPLICE-2341</a>.</p>
            </td>
        </tr>
        <tr>
            <td class="BoldFont" rowspan="3">Feature Enhancement</td>
            <td>Merge Data From Multiple Files</td>
            <td>The <a href="sqlref_sysprocs_mergedata.html"><code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code></a> system procedure now supports merging all files in a directory.</td>
        </tr>
        <tr>
            <td>Statistics Backed Up and Restored</td>
            <td><p>The <a href="sqlref_sysprocs_backuptable.html"><code>SYSCS_UTIL.SYSCS_BACKUP_TABLE</code></a> and <a href="sqlref_sysprocs_backupschema.html"><code>SYSCS_UTIL.SYSCS_BACKUP_SCHEMA</code></a> system procedures now back up statistics, and the <a href="sqlref_sysprocs_restoretable.html"><code>SYSCS_UTIL.SYSCS_RESTORE_TABLE</code></a> and <a href="sqlref_sysprocs_restoreschema.html"><code>SYSCS_UTIL.SYSCS_RESTORE_SCHEMA</code></a> system procedures restore those statistics.</p>
            <p class="noteIcon">This means that, if the statistics were current when you backed up, you do not need to run an <code>ANALYZE</code> after restoring the table or schema.</p>
            </td>
        </tr>
        <tr>
            <td>Decimal Precision Increase</td>
            <td>Maximum precision for the <a href="sqlref_datatypes_decimal.html"><code>DECIMAL</code> data type has been increased from <code>31</code> to <code>38</code>.</td>
        </tr>
        <tr>
            <td class="BoldFont" rowspan="3">Performance Enhancement</td>
            <td>Native Spark Aggregation</td>
            <td><p>This update improves the performance of queries that perform aggregation after a join or series of joins that are CPU bound; for example: cross join cases or join queries with join keys that have high rows-per-value. This is achieved by using the latest Spark Dataset methods to perform the aggregation, which allows Spark to use WholeStageCodeGen to combine multiple physical operators into a single Java function.</p>
                <p>This work originated with this JIRA issue: <a href="https://splice.atlassian.net/browse/SPLICE-2302" target="_blank">SPLICE-2302</a>.</p>
            </td>
        </tr>
        <tr>
            <td>Cross Join</td>
            <td>The implementation of <em>Cross Join</em> has been enhanced to improve performance.</td>
        </tr>
        <tr>
            <td>Property Caching</td>
            <td>Property cache added for Spark executor to reduce hits to splice:16 region.</td>
        </tr>
    </tbody>
</table>

## Database Patch Release Notes  {#releasenotes}

<ul>
    <li><a href="releasenotes_2.8.1928.html">Patch Release 2.8.0.1928</a></li>
    <li><a href="releasenotes_2.8.1927.html">Patch Release 2.8.0.1927</a></li>
    <li><a href="releasenotes_2.8.1926.html">Patch Release 2.8.0.1926</a></li>
    <li><a href="releasenotes_2.8.1925.html">Patch Release 2.8.0.1925</a></li>
    <li><a href="releasenotes_2.8.1924.html">Patch Release 2.8.0.1924</a></li>
</ul>

The product is available to build from open source (see <https://github.com/splicemachine/spliceengine>), as well as prebuilt packages for use on a cluster or cloud.

</div>
</section>
