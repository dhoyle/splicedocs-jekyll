---
title: Using Splice Machine Active-Passive Replication
summary: Describes how replication works.
keywords: select, time travel
toc: false
product: all
sidebar: home_sidebar
permalink: developers_fundamentals_replication.html
folder: DeveloperTopics/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Active-Passive Replication

This topic describes the Splice Machine *replication* mechanism, which you can use to replicate all or part of your database on a second cluster.

## Overview

Although working with replication is straightforward, there are a number of basic terms and concepts you need to understand:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Term or Concept</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">Replication Configuration</td>
            <td>There are a few configuration options that you need to set before using replication.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Active (Master) Cluster</td>
            <td>The master or active cluster houses the active version of your database. You can perform all database operations (reads and writes) on this cluster.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Passive (Slave) Cluster</td>
            <td>The database on your slave or passive cluster is kept in sync with the active database; however, you cannot write to the database on this cluster.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Peer</td>
            <td>The term peer is used to refer to the passive peer of the active cluster. When you set up a cluster to be the peer of your active cluster, you assign a <em>peerId</em> to the passive cluster.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Peer Management</td>
            <td>You can enable or disable replication to a passive cluster using the passive cluster's *peerId*.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Database Replication</td>
            <td><p>You can replicate your entire database to a passive cluster and keep it synchronized with the active version. Enabling replication of your database initially means that all schemas and tables are replicated, unless you specifically disable them individually.</p>
                <p class="noteNote">You can  enable or disable replication at the schema or table level, regardless of whether replication is enabled at the database level.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Schema Replication</td>
            <td><p>You can replicate an entire schema to a passive cluster and keep it synchronized with the active version. Enabling replication of a schema initially means that all tables (and their indexes) are replicated, unless you specifically disable them individually.</p>
                <p class="noteNote">You can  enable or disable replication at the table level, regardless of whether replication is enabled at the schema level.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Table Replication</td>
            <td>You can replicate a specific table (and its indexes) to a passive cluster and keep it synchronized with the active version.</td>
        </tr>
    </tbody>
</table>

Note that the enabling and disabling of peers, database-level replication, schema-level replication, and table-level replication are all independent of each other. This means, for example, that you can enable or disable replication of a table whether or not its schema or the entire database is being replicated.


## Setting Up Asynchronous Active-Passive Replication

To set up asynchronous active-passive replication, first determine which cluster will be your *active* cluster, and which will be your *slave* cluster. Then, follow these steps:

1.  Configure Splice Machine replication.
2.  Run syscs_util.enable_database_replication() on active cluster
3.  Full backup database on active cluster
4.  Restore database on a slave cluster
5.  From active cluster, run syscs_util.add_peer() to setup active-passive replication

In this topic, we'll use *activerServer* as the name of the active cluster, and *passiveServer* as the name of the passive cluster.

### Step 1: Configure Replication for Both Clusters

Modify the configuration on both *activerServer* and *passiveServer*:

<table class="noBorder">
    <thead>
        <tr>
            <th>Configuration Option</th>
            <th>Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">splice.replication.enabled</td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont">hbase.replication.sink.service</td>
            <td class="CodeFont">com.splicemachine.replication.SpliceReplication</td>
        </tr>
        <tr>
            <td class="CodeFont">hbase.replication.source.service</td>
            <td class="CodeFont">com.splicemachine.replication.SpliceReplication</td>
        </tr>
        <tr>
            <td class="CodeFont">hbase.regionserver.replication.handler.count</td>
            <td class="CodeFont">40</td>
        </tr>
    </tbody>
</table>

### Step 2: Enable Database Replication and Do a Full Database Backup on *activeServer*

Follow these steps to enable replication on *activeServer*:

1.  Enable replication on *activeServer*:

    ```
    CALL SYSCS_UTIL.ENABLE_DATABASE_REPLICATION();
    ```
    {: .Example}

2.  Perform a full back-up of *activeServer*:

    ```
    CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE('/backup', ‘full’);
    ```
    {: .Example}

3.  Find the ID of the backup (`backup_id`) you just performed  in the `SYS.SYSBACKUP` table.

    ```
    select backup_id from sys.sysbackup;
    ```
    {: .Example}

### Step 3: Restore From the Backup to *passiveServer*

Use the `backup_id` from the previous step to perform a restore on your *passiveServer*. The following call uses `10752` as the `backup_id`:

```
CALL SYSCS_UTIL.SYSCS_RESTORE_DATABASE('hdfs://*activeServer*/backup', 10752 , false);
```
{: .Example}

### Step 4: Set Up Replication from *activeServer* to *passiveServer*

Finally, make the folllowing call on *activeServer* to set up replication to *passiveServer*:

```
CALL SYSCS_UTIL.ADD_PEER(1, ‘*passiveServer*:2181:/hbase-unsecure, true, false);
```
{: .Example}

### Enabling Replication for Bulk Loads

To enable replication for bulk load workload, please follow <a href="https://issues.apache.org/jira/browse/HBASE-13153" target="_blank"> this HBase topic</a>.

### Removing a Peer

If you want to remove a peer in the future, make this call:

```
CALL SYSCS_UTIL.REMOVE_PEER(1);
```
{: .Example}


## See Also

* [`SYS.SYSREPLICATION TABLE`](sqlref_systables_sysreplication.html)
* [`SYSCS_UTIL.ADD_PEER`](sqlref_sysprocs_addpeer.html)
* [`SYSCS_UTIL.REMOVE_PEER`](sqlref_sysprocs_removepeer.html)
* [`SYSCS_UTIL.ENABLE_PEER`](sqlref_sysprocs_enablepeer.html)
* [`SYSCS_UTIL.DISABLE_PEER`](sqlref_sysprocs_disablepeer.html)
* [`SYSCS_UTIL.ENABLE_TABLE_REPLICATION`](sqlref_sysprocs_enabletablereplication.html)
* [`SYSCS_UTIL.DISABLE_TABLE_REPLICATION`](sqlref_sysprocs_disabletablereplication.html)
* [`SYSCS_UTIL.ENABLE_SCHEMA_REPLICATION`](sqlref_sysprocs_enableschemareplication.html)
* [`SYSCS_UTIL.DISABLE_SCHEMA_REPLICATION`](sqlref_sysprocs_disableschemareplication.html)
* [`SYSCS_UTIL.ENABLE_DATABASE_REPLICATION`](sqlref_sysprocs_enabledbreplication.html)
* [`SYSCS_UTIL.DISABLE_DATABASE_REPLICATION`](sqlref_sysprocs_disabledbreplication.html)


</div>
</section>
