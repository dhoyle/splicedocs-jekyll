---
title: SYSCS_UTIL.SYSCS_DELETE_BACKUP built-in system procedure
summary: Built-in system procedure that delete a specific backup.
keywords: Delete a backup, delete_backup
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_deletebackup.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_DELETE_BACKUP   {#BuiltInSysProcs.DeleteBackup}

The `SYSCS_UTIL.SYSCS_DELETE_BACKUP` system procedure deletes a backup
that you previously created using either the
[`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html) system
procedures.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DELETE_BACKUP( BIGINT backupId ); 
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupId
{: .paramName}

Specifies the ID of the backup job you want to delete.
{: .paramDefnFirst}

You can find the ID of a specific backup by querying the `Backing Up and
Restoring` topic in our *Administrator's Guide* for more information.
{: .paramDefn}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Example

If necessary, you can first query the
[`SYS.SYSBACKUP`](sqlref_systables_sysbackup.html) system table to find
the `BACKUP_ID` of the job you want to delete; entries in that table
include timestamp information.

And then delete that job:

    splice> SELECT * FROM SYS.SYSBACKUP;
    BACKUP_ID  |BEGIN_TIMESTAMP           |END_TIMESTAMP            |STATUS  |FILESYSTEM                                     |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------
    40975      |2015-11-25 09:32:53.04    |2015-11-25 09:33:09.081  |S       |/Users/me/Documents/splicemachine/dbBackups    |D     |false|-1                  |93
    
    1 row selected
    
    splice> CALL SYSCS_UTIL.SYSCS_DELETE_BACKUP(40975);
    Statement executed.
{: .Example xml:space="preserve"}

## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html) in
  the *Administrator's Guide*
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP`](sqlref_sysprocs_canceldailybackup.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html)
  built-in system procedure
* [`SYSBACKUP`](sqlref_systables_sysbackup.html) system table
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html) system table
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html) system table

</div>
</section>

