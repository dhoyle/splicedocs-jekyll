---
title: SYSCS_UTIL.SYSCS_CANCEL_BACKUP built-in system procedure
summary: Built-in system procedure that cancels a specific backup.
keywords: cancel backup, cancel_backup
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_cancelbackup.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_CANCEL_BACKUP

The `SYSCS_UTIL.SYSCS_CANCEL_BACKUP` system procedure cancels an
in-progress backup.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_CANCEL_BACKUP( backupId );
{: .FcnSyntax xml:space="preserve"}

</div>

<div class="paramList" markdown="1">
backupId
{: .paramName}

A `BIGINT` value specifying the ID of the backup job you want to cancel. For more information about finding and using backup IDs, see [Backup IDs, Backup Jobs, and Backup Tables](onprem_admin_backingup.html#systables) and [Reviewing Backups](onprem_admin_backingup.html#Reviewing). You can find the *backupId* for an existing backup by querying the &nbsp;[`SYSBACKUP`
 System Table](sqlref_systables_sysbackup.html).
{: .paramDefnFirst}

</div>

## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Example

This cancels the currently running backup:

<div class="preWrapperWide" markdown="1">
    CALL SYSCS_UTIL.SYSCS_CANCEL_BACKUP( 12345 );
{: .Example xml:space="preserve"}

</div>
## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)


</div>
</section>
