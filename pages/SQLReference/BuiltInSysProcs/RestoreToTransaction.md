---
title: SYSCS_UTIL.SYSCS_RESTORE_DATABASE_TO_TRANSACTION built-in system procedure
summary: Built-in system procedure that restores a database to its state after a specified transaction ID completed.
keywords: restoring, restore_database, restore from backup
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_restoredbtransaction.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_RESTORE_DATABASE_TO_TRANSACTION

The `SYSCS_UTIL.SYSCS_RESTORE_DATABASE_TO_TRANSACTION` system procedure restores your
database to the state it was in when a backup was performed after a specified transaction ID completed.

{% include splice_snippets/enterpriseonly_note.md %}

You can restore your database from any previous full or incremental
backup.

There are several important things to know about restoring your database
from a previous backup:

* Restoring a database **wipes out your database** and replaces it with
  what had been previously backed up.
* You **cannot use your cluster** while restoring your database.
* You **must reboot your database** after the restore is complete. See&nbsp;&nbsp;
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
    SYSCS_UTIL.SYSCS_RESTORE_DATABASE_TO_TRANSACTION( VARCHAR backupDir,
                                                      BIGINT  backupId,
                                                      BOOLEAN validate,
                                                      BIGINT  transactionId );
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

The ID of the backup job from which you want to restore your database. To find the *backupId*, you can query the [`SYS.SYSBACKUP`](sqlref_systables_sysbackup.html) system table, as described in the [*Backing Up and Restoring*](onprem_admin_backingup.html) topic.
{: .paramDefnFirst}

The `SYS.SYSBACKUP` table is part of the `SYS` schema, to which access is restricted for security purposes. You can only access tables in the `SYS` schema if you are a Database Administrator or if your Database Administrator has explicitly granted access to you.
{: .noteIcon}

validate
{: .paramName}

A Boolean value that specifies whether to validate the backup before restoring from it:
{: .paramDefnFirst}

* If *validate* is `false`, the restore proceeds without any pre-validation.
* If *validate* is `true`, the backup is validated before the restoration is started. (See [`SYSCS_UTIL.VALIDATE_BACKUP`](sqlref_sysprocs_validatebackup.html)). If the validation check finds inconsistencies, the errors are reported to the user, and the database is _not_ restored. If the inconsistencies are minor, you can choose to re-run this procedure with `validate` set to `false`.
{: .nested}

transactionID
{: .paramName}

The ID of a completed transaction. You can find the transaction ID of a specific SQL statement in the `splice-derby.log` file.
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
This section includes two examples, both of which perform a pre-restore validation of the backup.

Stop using your database before restoring, and keep in mind that
restoring a database may take several minutes, depending on the size of
your database.
{: .noteIcon}

### Example 1: Successful Restoration
Assuming that you've already discovered the ID of the transaction to which you want to restore (`765123` in the example), this example first queries the system backup table to find the ID of the backup from which we want to restore, and then initiates the
restoration, specifying the transaction ID.


    splice> SELECT * FROM SYS.SYSBACKUP;
    BACKUP_ID |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS    |FILESYSTEM      |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    ----------------------------------------------------------------------------------------------------------------------------------------
    74101     |2015-11-30 17:46:41.431  |2015-11-30 17:46:56.664  |S         |./dbBackups/    |D     |true |40975               |30
    40975     |2015-11-25 09:32:53.04   |2015-11-25 09:33:09.081  |S         |~/splicemachine |D     |false|-1                  |93

    2 rows selected

    splice> CALL SYSCS_UTIL.SYSCS_RESTORE_DATABASE_TO_TRANSACTION('./dbBackups/', 74101, true, 765123 );
    Statement executed.
{: .Example xml:space="preserve"}

Once the restoration is complete, reboot your database by the [Starting
Your Database.](onprem_admin_startingdb.html)

### Example 2: Validation Failure
Here's a similar restore attempt that terminates after finding inconsistencies in the backup during validation:

    splice> SELECT * FROM SYS.SYSBACKUP;
    BACKUP_ID |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS    |FILESYSTEM      |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    ----------------------------------------------------------------------------------------------------------------------------------------
    63541     |2017-10-30 13:46:41.431  |2017-10-30 13:46:56.664  |S         |./dbBackups/    |D     |true |60836               |30
    60836     |2017-10-25 08:32:53.04   |2017-10-25 08:33:09.081  |S         |~/splicemachine |D     |false|-1                  |93

    2 rows selected

    splice> CALL SYSCS_UTIL.SYSCS_RESTORE_DATABASE('./dbBackups/', 63541, true, 443225 );
    result                                  |warnings
    ----------------------------------------------------------------------------------------------------------------------------------------
    BR010                                   |A data file ./dbBackups/BACKUP_63541/tables/SPLICE_TXN/f4460c47f6c96fe8d76c0def11c22dc8/V/c7350de1acaf4a11a561472675eda1dd is missing. The restored table may be corrupted.
    Found inconsistencies in backup         |To force a restore, set validate to false

    2 rows selected
{: .Example xml:space="preserve"}

## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
* [`SYSCS_UTIL.VALIDATE_BACKUP`](sqlref_sysprocs_validatebackup.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)

</div>
</section>
