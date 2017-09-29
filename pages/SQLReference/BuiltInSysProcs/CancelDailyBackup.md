---
title: SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP  built-in system procedure
summary: Built-in system procedure that cancels a specific backup.
keywords: cancel_daily_backup
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_canceldailybackup.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP

The `SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP` system procedure cancels a
scheduled backup job.

Once you cancel a daily backup, it will no longer be scheduled to run.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP( BIGINT jobId );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
jobId
{: .paramName}

A `BIGINT` value that specifies which scheduled backup job you want to
cancel.
{: .paramDefnFirst}

To find the *jobId* you want to cancel, see the [*Backing Up
and Restoring*](onprem_admin_backingup.html) topic.
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
[`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html) system table to
find the `jobId` of the job you want to cancel.

And then cancel that job; for example:


    splice> SELECT * FROM SYS.SYSBACKUPJOBS;
    JOB_ID      |FILESYSTEM                               |TYPE          |HOUR_OF_DAY|BEGIN_TIMESTAMP
    -------------------------------------------------------------------------------------------------
    41069       |/~/Documents/splicemachine/dbBackups/    |full          |18         |09:41:05.455

    1 row selected

    splice> CALL SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP(41069);
    Statement executed.
{: .Example xml:space="preserve"}

## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)
* [`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html)

</div>
</section>
