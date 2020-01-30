---
title: SYSCS_UTIL.ENABLE_DATABASE_REPLICATION built-in system procedure
summary: Built-in system procedure that enables replication of a database.
keywords: replication
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_enabledbreplication.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.ENABLE_DATABASE_REPLICATION

The `SYSCS_UTIL.ENABLE_DATABASE_REPLICATION` system procedure enables replication for an entire database.


## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.ENABLE_DATABASE_REPLICATION( );
{: .FcnSyntax xml:space="preserve"}

</div>

## Usage

You must call this procedure from your master cluster to enable replication of your database.

Database-level replication is recorded in the &nbsp;&nbsp;[`SYS.SYSREPLICATION`](sqlref_systables_sysreplication.html) system table.

## Example

```
splice> CALL SYSCS_UTIL.ENABLE_DATABASE_REPLICATION( );

Success
-------------------------------------------
Enabled replication for database
```
{: .Example}

## See Also

* [Using Replication](developers_fundamentals_replication.html)
* [`SYS.SYSREPLICATION TABLE`](sqlref_systables_sysreplication.html)
* [`SYSCS_UTIL.ADD_PEER`](sqlref_sysprocs_addpeer.html)
* [`SYSCS_UTIL.REMOVE_PEER`](sqlref_sysprocs_removepeer.html)
* [`SYSCS_UTIL.ENABLE_PEER`](sqlref_sysprocs_enablepeer.html)
* [`SYSCS_UTIL.DISABLE_PEER`](sqlref_sysprocs_disablepeer.html)
* [`SYSCS_UTIL.ENABLE_TABLE_REPLICATION`](sqlref_sysprocs_enabletablereplication.html)
* [`SYSCS_UTIL.DISABLE_TABLE_REPLICATION`](sqlref_sysprocs_disabletablereplication.html)
* [`SYSCS_UTIL.ENABLE_SCHEMA_REPLICATION`](sqlref_sysprocs_enableschemareplication.html)
* [`SYSCS_UTIL.DISABLE_SCHEMA_REPLICATION`](sqlref_sysprocs_disableschemareplication.html)
* [`SYSCS_UTIL.DISABLE_DATABASE_REPLICATION`](sqlref_sysprocs_disabledbreplication.html)

</div>
</section>
