---
title: SYSCS_UTIL.ADD_PEER built-in system procedure
summary: Built-in system procedure that adds a replication slave cluster.
keywords: replication
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_addpeer.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.ADD_PEER

The `SYSCS_UTIL.ADD_PEER` system procedure sets up replication from a master cluster to a slave cluster. Run this procedure from your master (*active*) cluster.


## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.ADD_PEER( SMALLINT peerId,
                         VARCHAR  clusterKey,
                         BOOLEAN  enabled,
                         BOOLEAN  isSerial );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="paramList" markdown="1">

peerId
{: .paramName}

A number that identifies the slave cluster.
{: .paramDefnFirst}

clusterKey
{: .paramName}

A string that specifies the ZooKeeper quorum and HBase root node.
{: .paramDefnFirst}

enabled
{: .paramName}

A Boolean that specifies whether or not replication is currently enabled for the slave cluster.
{: .paramDefnFirst}

isSerial
{: .paramName}

A Boolean that specifies whether replication to the peer is serial.
{: .paramDefnFirst}

</div>

## Usage

You must call this procedure from your master cluster to set up replication to the specified slave cluster.

To enable replication to a slave for which you have specfied `enabled=false`, call the &nbsp;&nbsp;[`SYSCS_UTIL.ENABLE_REPLICATION()`](sqlref_sysprocs_enabledbreplication.html) procedure.

## Example

```
splice> CALL SYSCS_UTIL.ADD_PEER(1, '*passiveServer*:2181:/hbase-unsecure', true, false);

Success
-------------------------------------------
Added *passiveServer*:2181:/hbase-unsecure as peer 1
```
{: .Example}

## See Also

* [Using Replication](developers_fundamentals_replication.html)
* [`SYS.SYSREPLICATION TABLE`](sqlref_systables_sysreplication.html)
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
