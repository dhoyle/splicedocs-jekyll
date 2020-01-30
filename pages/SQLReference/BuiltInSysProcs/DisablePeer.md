---
title: SYSCS_UTIL.DISABLE_PEER built-in system procedure
summary: Built-in system procedure that disables replication on a slave cluster.
keywords: replication
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_disablepeer.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.DISABLE_PEER

The `SYSCS_UTIL.DISABLE_PEER` system procedure temporarily disables replication on the specified slave cluster. Run this procedure from your master (*active*) cluster.


## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.DISABLE_PEER( SMALLINT peerId );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="paramList" markdown="1">

peerId
{: .paramName}

A number that identifies the slave cluster, as specified when you added the cluster as a peer.
{: .paramDefnFirst}

</div>

## Usage

You must call this procedure from your master cluster to temporarily disable replication to the slave cluster.

After running this procedure, changes to WALs will be queued on the master cluster. These changes will not be sent to the slave cluster until replication is re-enabled by running the &nbsp;[`SYSCS_UTIL.ENABLE_REPLICATION`](sqlref_sysprocs_enabledbreplication.html) procedure.

The slave cluster must have previously been set up with the specified `peerId` using the &nbsp;&nbsp;[`SYSCS_UTIL.ADD_PEER`](sqlref_sysprocs_addpeer.html) system procedure.

## Example

```
splice> CALL SYSCS_UTIL.DISABLE_PEER( 1 );

Success
-------------------------------------------
Disabled peer 1
```
{: .Example}

## See Also

* [Using Replication](developers_fundamentals_replication.html)
* [`SYS.SYSREPLICATION TABLE`](sqlref_systables_sysreplication.html)
* [`SYSCS_UTIL.ADD_PEER`](sqlref_sysprocs_addpeer.html)
* [`SYSCS_UTIL.REMOVE_PEER`](sqlref_sysprocs_removepeer.html)
* [`SYSCS_UTIL.ENABLE_PEER`](sqlref_sysprocs_enablepeer.html)
* [`SYSCS_UTIL.ENABLE_TABLE_REPLICATION`](sqlref_sysprocs_enabletablereplication.html)
* [`SYSCS_UTIL.DISABLE_TABLE_REPLICATION`](sqlref_sysprocs_disabletablereplication.html)
* [`SYSCS_UTIL.ENABLE_SCHEMA_REPLICATION`](sqlref_sysprocs_enableschemareplication.html)
* [`SYSCS_UTIL.DISABLE_SCHEMA_REPLICATION`](sqlref_sysprocs_disableschemareplication.html)
* [`SYSCS_UTIL.ENABLE_DATABASE_REPLICATION`](sqlref_sysprocs_enabledbreplication.html)
* [`SYSCS_UTIL.DISABLE_DATABASE_REPLICATION`](sqlref_sysprocs_disabledbreplication.html)

</div>
</section>
