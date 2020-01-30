---
title: SYSCS_UTIL.REMOVE_PEER built-in system procedure
summary: Built-in system procedure that removes a replication slave cluster.
keywords: replication
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_removepeer.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.REMOVE_PEER

The `SYSCS_UTIL.REMOVE_PEER` system procedure removes a slave cluster from replication. Run this procedure from your master (*active*) cluster.


## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.REMOVE_PEER( SMALLINT peerId );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="paramList" markdown="1">

peerId
{: .paramName}

A number that identifies the slave cluster.
{: .paramDefnFirst}

</div>

## Usage

You must call this procedure from your master cluster to remove the slave cluster from replication of the master cluster.

The slave cluster must have previously been set up with the specified `peerId` using the &nbsp;&nbsp;[`SYSCS_UTIL.ADD_PEER`](sqlref_sysprocs_addpeer.html) system procedure.

## Example

```
splice> CALL SYSCS_UTIL.REMOVE_PEER( 1 );

Success
-------------------------------------------
Removed peer 1
```
{: .Example}

## See Also

* [Using Replication](developers_fundamentals_replication.html)
* [`SYS.SYSREPLICATION TABLE`](sqlref_systables_sysreplication.html)
* [`SYSCS_UTIL.ADD_PEER`](sqlref_sysprocs_addpeer.html)
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
