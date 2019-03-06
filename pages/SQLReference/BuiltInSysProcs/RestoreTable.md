---
title: SYSCS_UTIL.SYSCS_RESTORE_TABLE built-in system procedure
summary: Built-in system procedure that restores a table from a previous backup.
keywords: restoring, RESTORE_TABLE, restore from backup
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_restoretable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_RESTORE_TABLE

The `SYSCS_UTIL.SYSCS_RESTORE_TABLE` system procedure restores a table that was previously backed up with the &nbsp;&nbsp; [`SYSCS_UTIL.SYSCS_BACKUP_TABLE`](sqlref_sysprocs_backuptable.html) procedure. You can restore the table to another table on the same cluster, or on a different cluster. Note that:

* The table to which you are restoring must already exist in the database.
* The source and destination tables must have the same DDL, including the same primary keys and unique constraints.
* The source and destinatoin tables must have the same indexes.


{% include splice_snippets/enterpriseonly_note.md %}

{% comment %}
+++ REMOVE THIS COMMENT WHEN INCREMENTAL BECOMES AVAILABLE +++
You can restore your table from a previous full or incremental table
backup.

When you restore from a backup, Splice Machine automatically determines
and runs whatever sequence of restores may be required to accomplish the
restoration of your table; this means that when you select an
incremental backup from which to restore, Splice Machine will detect
that it needs to first restore from the previous full table backup and then
apply any incremental restorations.
{: .noteIcon}
{% endcomment %}
## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_RESTORE_TABLE( VARCHAR destSchema,
                                    VARCHAR destTable,
                                    VARCHAR sourceSchema,
                                    VARCHAR sourceTable,
                                    VARCHAR directory,
                                    BIGINT  backupId,
                                    BOOLEAN validate );
{: .FcnSyntax xml:space="preserve"}
</div>

<div class="paramList" markdown="1">

destSchema
{: .paramName}

The name of the schema to which you want the table restored.
{: .paramDefnFirst}
This schema must already exist in your database.
{: .noteNote}

destTable
{: .paramName}

The name of the restored table.
{: .paramDefnFirst}
This table must already exist in your database, and must have the same DDL as the `sourceTable`.
{: .noteNote}

sourceSchema
{: .paramName}

The name of the schema from which the table was backed up.
{: .paramDefnFirst}

sourceTable
{: .paramName}

The name of the table that was backed up.
{: .paramDefnFirst}

directory
{: .paramName}

Specifies the path to the directory containing the backup from which you
want to restore your table. This can be a local directory if you're
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

The ID of the backup job from which you want to restore the table.
{: .paramDefnFirst}
{: .paramDefn}

validate
{: .paramName}

A Boolean value that specifies whether to validate the table backup before restoring from it:
{: .paramDefnFirst}

* If *validate* is `false`, the restore proceeds without any pre-validation.
* If *validate* is `true`, the backup is validated before the restoration is started. (See [`SYSCS_UTIL.VALIDATE_TABLE_BACKUP`](sqlref_sysprocs_validatetablebackup.html)). If the validation check finds inconsistencies, the errors are reported to the user, and the table is _not_ restored. If the inconsistencies are minor, you can choose to re-run this procedure with `validate` set to `false`.
{: .nested}
</div>
## Results

This procedure does not return a result.

## Backup and Restore Compatibility

{% include splice_snippets/backupcompatibility.md %}


## Usage
The source and destination tables must have the same DDL, including the same primary keys and unique constraints. They must also have the same indexes.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Example: Backup, Validate, and Restore a Table

This example shows you how to back up a table, then validate and restore it, in these steps:

* [Backing Up the Table](#exbackup)
* [Examining the Backup](#exexamine)
* [Validating the Backup](#exvalidate)
* [Restoring the Backup](#exrestore)

### Backing Up the Table  {#exbackup}
This command line performs a full backup of the TPCH100 `LINEITEM` table to the `/backup` directory on HDFS:

```
splice> CALL SYSCS_UTIL.SYSCS_BACKUP_TABLE('TPCH100', 'LINEITEM', '/backup', 'full');
Success
----------------------
FULL backup to /backup

1 row selected
```

See the reference page for the [`SYSCS_UTIL.SYSCSBACKUP_TABLE`](sqlref_sysprocs_backuptable.html) system procedure for more information about backing up a table.

### Examining the Backup  {#exexamine}

After the backup completes, you can examine the `sys.sysbackup` table to find the ID of our new backup:

```
splice> SELECT * FROM sys.sysbackup;
BACKUP_ID      |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS     |SCOPE     |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
-----------------------------------------------------------------------------------------------------------------------------------
587516417      |2018-09-25 00:12:33.896  |2018-09-25 00:42:53.546  |SUCCESS    |TABLE     |false|-1                  |3

```

You can use the ID of your backup job to examine the `sys.sysbackupitems` and verify that the base table and two indexes have been backed up:

```
splice> SELECT * FROM sys.sysbackupitems WHERE backup_Id=587516417 ;
BACKUP_ID   |ITEM             |BEGIN_TIMESTAMP           |END_TIMESTAMP
-----------------------------------------------------------------------------------------
587516417   |splice:292000    |2018-09-25 00:12:40.512   |2018-09-25 00:32:14.856
587516417   |splice:292033    |2018-09-25 00:12:40.513   |2018-09-25 00:42:48.573
587516417   |splice:292017    |2018-09-25 00:12:40.512   |2018-09-25 00:41:25.683

3 rows selected
```

### Validating the Backup  {#exvalidate}
Before restoring the table, you can validate the backup:
```
splice> CALL SYSCS_UTIL.VALIDATE_TABLE_BACKUP( 'TPCH100', 'LINEITEM', '/backup', 587516417 );
Results
---------------------------------------------------------------------------------------------
No corruptions found for backup.

1 row selected
```

See the reference page for the [`SYSCS_UTIL.VALIDATE_TABLE_BACKUP`](sqlref_sysprocs_validatetablebackup.html) system procedure for more information about backup validation.

### Restoring the Backup  {#exrestore}
You can restore the table to another table on the same cluster, or on a different cluster.

This command restores the backed-up table to table named `LINEITEM` in the `SPLICE` schema:
```
splice> CALL SYSCS_UTIL.SYSCS_RESTORE_TABLE('SPLICE', 'LINEITEM', 'TPCH100', 'LINEITEM', '/backup', 587516417, false);
Statement executed.
```

## See Also

* [`SYSCS_UTIL.SYSCS_BACKUP_SCHEMA`](sqlref_sysprocs_backupschema.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_TABLE`](sqlref_sysprocs_backuptable.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_SCHEMA`](sqlref_sysprocs_restoreschema.html)
* [`SYSCS_UTIL.SYSCS_VALIDATE_TABLE_BACKUP`](sqlref_sysprocs_validatetablebackup.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)


</div>
</section>
