---
title: Known Limitations and Workarounds
summary: Limitations and workarounds in our database.
keywords: on-premise limitations, work arounds, limits,
toc: false
product: all
sidebar: home_sidebar
permalink: releasenotes_workarounds.html
folder: ReleaseNotes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Limitations and Workarounds in This Release of Splice Machine

This topic describes workarounds for known limitations in this release of the Splice Machine Database. These can include previously unstated limitations or workarounds for problems that will be fixed in a future Release.

These are the notes and workarounds for known issues in this release:

* [With Clauses and Temporary Tables](#with-clauses-and-temporary-tables)
* [Temporary Tables and Backups](#temporary-tables-and-backups)
* [Natural Self Joins Not Supported](#natural-self-joins-not-supported)
* [Columnar Screen Output Gets Truncated](#columnar-screen-output-gets-truncated)
* [ToDate Function Problem With DD Designator](#todate-function-problem-with-dd-designator)
* [Compaction Queue Issue](#compaction-queue-issue)
* [Alter Table Issues](#alter-table-issues)
* [Default Value for Lead and Lag Functions](#default-value-for-lead-and-lag-functions)
* [CREATE TABLE AS with RIGHT OUTER JOIN](#create-table-as-with-right-outer-join)
* [Import Performance Issues With Many Foreign Key References](#import-performance-issues-with-many-foreign-key-references)
{% if site.build_version == "2.7" %}
* [Importing Data with SYSCS_IMPORT_DATA from Amazon S3](#ImportFromS3)
* [HDP 2.6.4 and 2.6.3 OLAP Memory Setting](#HDPOLAPMem)
{% elsif site.build_version == "2.5" %}
* [LDAP Authentication Property Issue](#LDAPPropIssue)
{% endif %}

## With Clauses and Temporary Tables

You cannot currently use temporary tables in ``WITH`` clauses.


## Natural Self Joins Not Supported

Splice Machine does not currently support ``NATURAL SELF JOIN`` operations.


## Temporary Tables and Backups

There's a subtle issue with performing a backup when you're using a temporary table in your session: although the temporary table is (correctly) not backed up, the temporary table's entry in the system tables will be backed up. When the backup is restored, the table entries will be restored, but the temporary table will be missing.

There's a simple workaround:
1. Exit your current session, which will automatically delete the temporary table and its system table entries.
2. Start a new session (reconnect to your database).
3. Start your backup job.


## Columnar Screen Output Gets Truncated

When using ``Explain Plan`` and other commands that generate lengthy output lines, you may see some output columns truncated on the screen.

**WORKAROUND:** Use the `maximumdisplaywidth=0` command to force all column contents to be displayed.


## ToDate Function Problem With DD Designator

The [TO_DATE](sqlref_builtinfcns_date.html) function currently returns the wrong date if you specify ``DD`` for the day field; however, specifying ``dd`` instead works properly.

**WORKAROUND:** Use `dd` instead of `DD`.

## Compaction Queue Issue

We have seen a problem in which the compaction queue grows quite large after importing large amounts of data, and are investigating a solution; for now, please use the following workaround.

Run a full compaction on tables into which you have imported a large amount of data, using the [SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE](sqlref_sysprocs_compacttable.html) system procedure.

## Alter Table Limitations

You can only use `ALTER TABLE` to add or remove `PRIMARY KEY` columns if the table being altered is empty.


## Default Value for Lead and Lag Functions

This release of Splice Machine features several new window functions, including [LAG](sqlref_builtinfcns_lag.html) do not support the default value parameter that you can specify in some other implementations. We expect to add this parameter in future releases.


## CREATE TABLE AS with RIGHT OUTER JOIN

There is a known problem using the ``CREATE TABLE AS`` form of the [RIGHT OUTER JOIN](sqlref_joinops_rightouterjoin.html) operation. For example, the following statement currently produces a table with all ``NULL`` values:
~~~ sql
CREATE TABLE t3 AS
   SELECT t1.a,t1.b,t2.c,t2.d
   FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c
   WITH DATA;
~~~

There's a simple workaround for now: create the table without inserting the data, and then insert the data; for example:
~~~ sql
CREATE TABLE t3 AS
   SELECT t1.a,t1.b,t2.c,t2.d
   FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c
   WITH NO DATA;

INSERT INTO t3
   SELECT t1.a,t1.b,t2.c,t2.d
   FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c;
~~~

## Import Performance Issues With Many Foreign Key References

The presence of many foreign key references on a table will slow down imports of data into that table.

{% if site.build_version == "2.7" %}
## Importing Data with SYSCS_IMPORT_DATA from Amazon S3 {#ImportFromS3}

There are currently two platform-dependent issue for importing data using the <a href="sqlref_sysprocs_importdata.html">SYSCS_UTIL.IMPORT_DATA</a> system procedure from Amazon S3 in this release. You only need to pay attention to this note if you're using HDP 2.5.5 or MapR 5.2.0:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Platform</th>
            <th>Settings</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HDP 2.5.5</td>
            <td><p class ="indentLevel1">Add a custom setting to your    <code>hdfs-site.xml</code> file. Using Ambari, click:</p>
                <pre>
        HDFS->Configs->Advanced->Customer hdfs-site</pre>
                <p class="indentLevel1"><br />and add this setting:</p>
                <div class="preWrapperWide"><pre>
        fs.s3a.impl=com.splicemachine.fs.s3.PrestoS3FileSystem</pre></div>
            </td>
        </tr>
        <tr>
            <td>MapR 5.2.0</td>
            <td><ol>
                <li><p>Add the following property setting in <code>/opt/mapr/hadoop/hadoop-2.7.0/etc/hadoop/hdfs-site.xml</code> <bold>on each node:</bold></p>
                    <div class="preWrapperWide"><pre>
    &lt;property&gt;
        &lt;name>fs.s3a.impl&lt;/name&gt;
        &lt;value>com.splicemachine.fs.s3.PrestoS3FileSystem&lt;/value&gt;
    &lt;/property&gt;</pre></div>
                </li>
                <li><p>Add the following option in <code>/opt/mapr/hbase/hbase-1.1.1/conf/hbase-env.sh</code> <bold> on each node:</bold></p>
                <div class="preWrapperWide"><pre>
    SPLICE_HBASE_REGIONSERVER_OPTS="$SPLICE_HBASE_REGIONSERVER_OPTS -Dorg.xerial.snappy.tempdir=/tmp"</pre></div>
                </li>
                </ol>
            </td>
        </tr>
    </tbody>
</table>

  These changes may impact non-SpliceMachine services or applications that rely on an implementation other than the Presto implementation; for example, `org.apache.hadoop.fs.s3a.S3AFileSystem`.
  {: .noteNote}

## HDP 2.6.4 and 2.6.3 OLAP Memory Setting {#HDPOLAPMem}

If you're using Splice Machine on HDP 2.6.4 or HDP 2.6.3, you need to correct a property setting in the `HBase Service Advanced Configuration Snippet (Safety Valve)` settings for `hbase-site.xml`.

Replace the `.` between `olap` and `server` in this property name:
````
    splice.olap.server.memory=8192
````

with the `_` character to produce the correct property name:
{: .spaceAbove}
````
    splice.olap_server.memory=8192
````

Note that the `.` character needs to be changed to the `_` character in `splice.olap`
{: .spaceAbove}

{% endif %}

{% if site.build_version == "2.5" %}
## LDAP Authentication Property Issue {#LDAPPropIssue}

For customers who use LDAP authentication and are updating from an earlier version of release 2.5, you need to modify a property name in your HBase configuration file. Replace this property name:
````
    splice.authentication.ldap.searchAuthPW
````

with this property name:
````
    splice.authentication.ldap.searchAuth.password
````

{% endif %}


</div>
</section>
