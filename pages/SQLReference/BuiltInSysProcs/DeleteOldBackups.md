---
title: SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS built-in system procedure
summary: Built-in system procedure that deletes all backups that were created more than a certain number of days ago.
keywords: Delete old backups, delete_old_backups
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_deleteoldbackups.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS

The `SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS` system procedure deletes any
backups that are older than a specified number of days (the *backup
window*), retaining only those backups that fit into that window.

Backups can consume a lot of disk space, and thus, we recommend
regularly scheduling both the creation of new backups and deletion of
outdated backups.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS( INT backupWindow );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupWindow
{: .paramName}

Specifies the number of days of backups that you want retained. Any
backups created more than `backupWindow` days ago are deleted.
{: .paramDefnFirst}

See the [*Backing Up and Restoring*](onprem_admin_backingup.html) topic
in our *Administrator's Guide* for more information.
{: .paramDefn}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Example

The following example deletes all database backups that were created
more than 30 days ago.

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS(30);
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)

</div>
</section>
