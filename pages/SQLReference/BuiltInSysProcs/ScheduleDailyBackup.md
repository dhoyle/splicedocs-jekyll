---
title: SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP built-in system procedure
summary: Built-in system procedure that schedules a full or incremental database backup to run at a specified time daily.
keywords: schedule_daily_backup, schedule backup, backing up
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_scheduledailybackup.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP

You can use the `SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP` to schedule a
full or incremental backup job that runs at a specified time each day.

You specify the scheduled start hour of the backup in Greenwich Mean
Time (GMT).
{: .noteNote}

Note that you can subsequently cancel a scheduled backup job with the [Backing Up and Restoring](onprem_admin_backingup.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_DATABASE(
                   VARCHAR backupDir,
                   VARCHAR(30) backupType,
                   INT startHour
                   );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupDir
{: .paramName}

Specifies the path to the directory in which you want the backup stored.
This can be a local directory if you're using the standalone version of
Splice Machine, or a directory in your cluster's file system (HDFS or
MapR-FS).
{: .paramDefnFirst}

You must have permissions set properly to use cloud storage as a backup
destination. See [Backing Up to Cloud
Storage](onprem_admin_backingup.html#Backing) in the *Administrator's
Guide* for information about setting backup permissions properties.
{: .noteNote}

Relative paths are resolved based on the current user directory. To
avoid confusion, we strongly recommend that you use an absolute path
when specifying the backup destination.
{: .paramDefn}

backupType
{: .paramName}

Specifies the type of backup that you want performed. This must be one
of the following values: `'full'` or `'incremental'`; any other value
produces an error and the backup is not run.
{: .paramDefnFirst}

Note that if you specify `'incremental'`, Splice Machine checks the &nbsp;  [`SYS.SYSBACKUP`](sqlref_systables_sysbackup.html) table to determine if
there already is a backup for the system; if not, Splice Machine will
perform a full backup, and subsequent backups will be incremental.
{: .paramDefn}

startHour
{: .paramName}

Specifies the hour (`0-23`) **in GMT** at which you want the backup to
run each day. A value less than `0` or greater than `23` produces an
error and the backup is not scheduled.
{: .paramDefnFirst}

</div>
## SQL Examples

<div markdown="1">
The following example schedules a daily incremental backup that runs at
3 am (GMT) and gets stored in the `hdfs:///home/backup/` directory:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP('hdfs:///home/backup', 'incremental', 3);
    Statement executed;
{: .Example xml:space="preserve"}

</div>
The following example schedules the same backup and stores it on AWS:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP('s3://backup1234', 'incremental', 3);
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
And this example schedules a daily backup at 6pm (GMT) on a standalone
version of Splice Machine:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP('./dbBackups', 'full',18);
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html) in
  the *Administrator's Guide*
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP`](sqlref_sysprocs_canceldailybackup.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deletebackup.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)
  built-in system procedure
* [`SYSBACKUP`](sqlref_systables_sysbackup.html) system table
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html) system table
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html) system table

</div>
</section>
