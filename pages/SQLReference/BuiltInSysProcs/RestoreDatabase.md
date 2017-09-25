---
title: SYSCS_UTIL.SYSCS_RESTORE_DATABASE built-in system procedure
summary: Built-in system procedure that restores a database from a previous backup.
keywords: restoring, restore_database, restore from backup
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_restoredb.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_RESTORE_DATABASE   {#BuiltInSysProcs.DeleteBackup}

The `SYSCS_UTIL.SYSCS_RESTORE_DATABASE` system procedure restores your
database to the state it was in when a specific backup was performed,
using a backup that you previously created using either the
[`SYSCS_UTIL_SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html) system
procedure.

You can restore your database from any previous full or incremental
backup.

There are several important things to know about restoring your database
from a previous backup:

* Restoring a database **wipes out your database** and replaces it with
  what had been previously backed up.
* You **cannot use your cluster** while restoring your database.
* You **must reboot your database** after the restore is complete. See
  the [Starting Your Database](onprem_admin_startingdb.html) topics in
  this book for instructions on restarting your database.

When you restore from a backup, Splice Machine automatically determines
and runs whatever sequence of restores may be required to accomplish the
restoration of your database; this means that when you select an
incremental backup from which to restore, Splice Machine will detect
that it needs to first restore from the previous full backup and then
apply any incremental restorations.
{: .noteIcon}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_RESTORE_DATABASE( VARCHAR backupDir,
                                       BIGINT backupId ); 
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupDir
{: .paramName}

Specifies the path to the directory containing the backup from which you
want to restore your database. This can be a local directory if you're
using the standalone version of Splice Machine, or a directory in your
cluster's file system (HDFS or MapR-FS).
{: .paramDefnFirst}

Relative paths are resolved based on the current user directory. To
avoid confusion, we strongly recommend that you use an absolute path
when specifying the backup location.
{: .paramDefn}

You must specify the backup's directory when you call this procedure
because, if your database has become corrupted and needs to be restored,
the data in the `BACKUP.BACKUP` table (which includes the location of
each backup) may also be corrupted.
{: .noteNote}

backupId
{: .paramName}

The ID of the backup job from which you want to restore your database.
{: .paramDefnFirst}

The system [*Backing Up and Restoring*](onprem_admin_backingup.html)
topic in our *Administrator's Guide* for more information.
{: .paramDefn}

</div>
## Usage

Restoring you database can take a while, and has several major
implications:
{: .body}

<div class="notePlain" markdown="1">
There are several important things to know about restoring your database
from a previous backup:

* Restoring a database **wipes out your database** and replaces it with
  what had been previously backed up.
* You **cannot use your cluster** while restoring your database.
* You **must reboot your database** after the restore is complete by
  first [Starting Your Database](onprem_admin_startingdb.html).

</div>
As noted at the top of this topic: if you are restoring from an
incremental backup, you must first restore from the most recent full
backup, and then incrementally restore from each subsequent incremental
backup. See [Example 2 below.](#Example)

## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Examples

The following example first queries the system backup table to find the
ID of the backup from which we want to restore, and then initiates the
restoration.

Stop using your database before backing up, and keep in mind that
restoring a database may take several minutes, depending on the size of
your database.
{: .noteIcon}

    
    splice> SELECT * FROM SYS.SYSBACKUP;
    BACKUP_ID |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS    |FILESYSTEM      |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    ----------------------------------------------------------------------------------------------------------------------------------------
    74101     |2015-11-30 17:46:41.431  |2015-11-30 17:46:56.664  |S         |./dbBackups/    |D     |true |40975               |30
    40975     |2015-11-25 09:32:53.04   |2015-11-25 09:33:09.081  |S         |~/splicemachine |D     |false|-1                  |93
    
    2 rows selected
    
    splice> CALL SYSCS_UTIL.SYSCS_RESTORE_DATABASE('./dbBackups/', 74101);
    Statement executed.
{: .Example xml:space="preserve"}

Once the restoration is complete, reboot your database by the [Starting
Your Database.](onprem_admin_startingdb.html)

## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html) in
  the *Administrator's Guide*
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP`](sqlref_sysprocs_canceldailybackup.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)built-in
  system procedure
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
  built-in system procedure
* [`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html)
  built-in system procedure
* [`SYSBACKUP`](sqlref_systables_sysbackup.html) system table
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html) system table
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html) system table

</div>
</section>

