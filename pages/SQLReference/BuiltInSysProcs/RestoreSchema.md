---
title: SYSCS_UTIL.SYSCS_RESTORE_SCHEMA built-in system procedure
summary: Built-in system procedure that restores a schema from a previous backup.
keywords: restoring, RESTORE_SCHEMA, restore from backup
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_restoreschema.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_RESTORE_SCHEMA

The `SYSCS_UTIL.SYSCS_RESTORE_SCHEMA` system procedure restores a schema that was previously backed up with the [`SYSCS_UTIL.SYSCS_BACKUP_SCHEMA`](sqlref_sysprocs_backupschema.html) procedure. You can restore the schema to another schema on the same cluster, or on a different cluster. Note that the schema to which you are restoring __must already exist__ in the database.

{% include splice_snippets/enterpriseonly_note.md %}

{% comment %}
+++ REMOVE THIS COMMENT WHEN INCREMENTAL BECOMES AVAILABLE +++
You can restore your schema from a previous full or incremental table
backup.

When you restore from a backup, Splice Machine automatically determines
and runs whatever sequence of restores may be required to accomplish the
restoration of your schema; this means that when you select an
incremental backup from which to restore, Splice Machine will detect
that it needs to first restore from the previous full schema backup and then
apply any incremental restorations.
{: .noteIcon}
{% endcomment %}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_RESTORE_SCHEMA( VARCHAR destSchema,
                                     VARCHAR sourceSchema,
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

sourceSchema
{: .paramName}

The name of the schema that was previously backed up.
{: .paramDefnFirst}

directory
{: .paramName}

Specifies the path to the directory containing the backup from which you
want to restore your schema. This can be a local directory if you're
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

The ID of the backup job from which you want to restore the schema.
{: .paramDefnFirst}

validate
{: .paramName}

A Boolean value that specifies whether to validate the schema backup before restoring from it:
{: .paramDefnFirst}

* If *validate* is `false`, the restore proceeds without any pre-validation.
* If *validate* is `true`, the backup is validated before the restoration is started. If the validation check finds inconsistencies, the errors are reported to the user, and the schema is _not_ restored. If the inconsistencies are minor, you can choose to re-run this procedure with `validate` set to `false`.
{: .nested}
</div>

## Backup and Restore Compatibility

{% include splice_snippets/backupcompatibility.md %}

## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Example: Backup, and Restore a Schema

This example shows you how to back up a schema, then restore it, in these steps:

* [Backing Up the Schema](#exbackup)
* [Examining the Backup](#exexamine)
* [Restoring the Backup](#exrestore)

### Backing Up the Schema  {#exbackup}
This command line performs a full backup of the TPCH1 schema to the `/backup` directory on HDFS:

```
splice> CALL SYSCS_UTIL.SYSCS_BACKUP_SCHEMA('TPCH1', '/backup', 'full');
Success
----------------------
FULL backup to /backup

1 row selected
```
See the reference page for the [`SYSCS_UTIL.SYSCS_BACKUP_SCHEMA`](sqlref_sysprocs_backupschema.html) system procedure for more information about backing up a schema.

### Examining the Backup  {#exexamine}

After the backup completes, you can examine the `sys.sysbackup` table to find the ID of your new backup:

```
splice> SELECT * FROM sys.sysbackup;
BACKUP_ID      |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS     |SCOPE     |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
-----------------------------------------------------------------------------------------------------------------------------------
125953         |2018-10-26 00:12:33.896  |2018-10-26 00:42:53.546  |SUCCESS    |SCHEMA    |false|-1                  |3

```

You can use the ID of your backup job to examine the `sys.sysbackupitems` and verify that the base table and two indexes have been backed up:

```
splice> SELECT * FROM sys.sysbackupitems WHERE backup_Id=125953 ;
BACKUP_ID   |ITEM             |BEGIN_TIMESTAMP           |END_TIMESTAMP
-----------------------------------------------------------------------------------------
125953      |splice:292000    |2018-10-26 00:12:40.512   |2018-10-26 00:32:14.856
125953      |splice:292033    |2018-10-26 00:12:40.513   |2018-10-26 00:42:48.573
125953      |splice:292017    |2018-10-26 00:12:40.512   |2018-10-26 00:41:25.683

3 rows selected
```

### Restoring the Backup  {#exrestore}
You can restore the schema to another schema on the same cluster, or on a different cluster. You can optionally specify that you want the backup validated before it is restored; the validation process checks for inconsistencies and missing files.

This command first validates the backed-up schema, and then restores it to a different (pre-existing) schema named `NEWTPCH1`:
```
splice> CALL SYSCS_UTIL.SYSCS_RESTORE_SCHEMA('NEWTPCH1', 'TPCH1', '/backup', 125953, true);
Statement executed.
```


## See Also

* [`SYSCS_UTIL.SYSCS_BACKUP_SCHEMA`](sqlref_sysprocs_backupschema.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_TABLE`](sqlref_sysprocs_backuptable.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_TABLE`](sqlref_sysprocs_restoretable.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)


</div>
</section>
