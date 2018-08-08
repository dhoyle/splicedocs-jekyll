---
title: SYSCS_UTIL.VALIDATE_BACKUP built-in system procedure
summary: Built-in system procedure that validates a previous database backup.
keywords: backing up, backup_database, backup database
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_validatebackup.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.VALIDATE_BACKUP

The `SYSCS_UTIL.VALIDATE_BACKUP` system procedure validates a database backup by checking for inconsistencies; it reports on missing files and bad checksum values.

For more information, see the [*Backing Up and
Restoring*](onprem_admin_backingup.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.VALIDATE_BACKUP( VARCHAR backupDir,
                                BIGINT  backupId );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupDir
{: .paramName}

Specifies the path to the directory containing the backup you
want to validate. This can be a local directory if you're
using the standalone version of Splice Machine, or a directory in your
cluster's file system (HDFS or MapR-FS).
{: .paramDefnFirst}

Relative paths are resolved based on the current user directory. To
avoid confusion, we strongly recommend that you use an absolute path
when specifying the backup location.
{: .paramDefn}

backupId
{: .paramName}

The ID of the backup job from which you want to restore your database.
{: .paramDefnFirst}

The system [*Backing Up and Restoring*](onprem_admin_backingup.html)
topic for more information.
{: .paramDefn}
</div>

## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Examples
This section contains an example showing a successful validation and a validation that reports errors.

### Example 1: Successful Validation

    splice> SELECT * FROM SYS.SYSBACKUP;
    BACKUP_ID |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS    |FILESYSTEM      |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    ----------------------------------------------------------------------------------------------------------------------------------------
    74101     |2015-11-30 17:46:41.431  |2015-11-30 17:46:56.664  |S         |./dbBackups/    |D     |true |40975               |30
    40975     |2015-11-25 09:32:53.04   |2015-11-25 09:33:09.081  |S         |~/splicemachine |D     |false|-1                  |93

    2 rows selected

    splice> CALL SYSCS_UTIL.SYSCS_VALIDATE_BACKUP('./dbBackups/', 74101);
    Statement executed.
{: .Example xml:space="preserve"}

### Example 2: Validation Failure

    splice> SELECT * FROM SYS.SYSBACKUP;
    BACKUP_ID |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS    |FILESYSTEM      |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    ----------------------------------------------------------------------------------------------------------------------------------------
    63541     |2017-10-30 13:46:41.431  |2017-10-30 13:46:56.664  |S         |./dbBackups/    |D     |true |60836               |30
    60836     |2017-10-25 08:32:53.04   |2017-10-25 08:33:09.081  |S         |~/splicemachine |D     |false|-1                  |93

    2 rows selected

    splice> CALL SYSCS_UTIL.SYSCS_VALIDATE_DATABASE('./dbBackups/', 63541);
    Results                                 |Warnings
    ----------------------------------------------------------------------------------------------------------------------------------------
    BR010                                   |A data file ./dbBackups/BACKUP_63541/tables/SPLICE_TXN/f4460c47f6c96fe8d76c0def11c22dc8/V/c7350de1acaf4a11a561472675eda1dd is missing. The restored table may be corrupted.

    1 row selected
{: .Example xml:space="preserve"}


## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [`SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP`](sqlref_sysprocs_canceldailybackup.html)
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
* [`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html)
* [`SYSCS_UTIL.VALIDATE_BACKUP`](sqlref_sysprocs_validatebackup.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html)

</div>
</section>
