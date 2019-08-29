---
title: SYSCS_UTIL.SYSCS_BACKUP_TABLE built-in system procedure
summary: Built-in system procedure that backs up a specific table to a specified backup directory.
keywords: backing up, backup_database, backup database
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_backuptable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_BACKUP_TABLE

The `SYSCS_UTIL.SYSCS_BACKUP_TABLE` system procedure performs an
immediate full backup of a table in your database to a specified
backup directory.

{% include splice_snippets/enterpriseonly_note.md %}

This procedure only works with internal, Splice Machine tables in your database. You can back up an external table using the Hadoop `DistCp` tool.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_BACKUP_TABLE( VARCHAR schemaName,
                                   VARCHAR tableName,
                                   VARCHAR directory,
                                   VARCHAR type );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">

schemaName
{: .paramName}

The name of the table's schema.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table that you are backing up.
{: .paramDefnFirst}

directory
{: .paramName}

Specifies the path to the directory in which you want the backup stored.
This can be a local directory if you're using the standalone version of
Splice Machine, or a directory in your cluster's file system (HDFS or
MapR-FS).
{: .paramDefnFirst}

You must have permissions set properly to use cloud storage as a backup
destination. See [Backing Up to Cloud
Storage](onprem_admin_backingup.html#Backing) for information about setting backup permissions properties.
{: .noteNote}

Relative paths are resolved based on the current user directory. To
avoid confusion, we strongly recommend that you use an absolute path
when specifying the backup destination.
{: .paramDefn}

type
{: .paramName}

Specifies the type of table backup that you want performed. Currently, the only valid value is `full`.
{: .paramDefnFirst}
</div>

## Results

This procedure does not return a result.

## Backup Resource Allocation

Splice Machine backups run as Spark jobs, submitting tasks to copy HFiles. In the past, Splice Machine backups used the Apache Hadoop `distcp` tool to copy the HFile; `distcp` uses MapReduce to copy, which can require significant resources. These requirements can limit file copying parallelism and reduce backup throughput. Splice Machine backups now can run (and do so by default) using a Spark executor to copy the HFiles, which significantly increases backup performance.

You can revert to using `distcp`, which uses a MapReduce job that can run into resource issues. For more information, see the [Understanding and Troubleshooting Backups](bestpractices_onprem_backups.html) topic.

## Backup and Restore Compatibility

{% include splice_snippets/backupcompatibility.md %}

### Backing Up and Restoring Statistics
{% include splice_snippets/backupstats1924.md %}

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

The following example performs an immediate full backup of the TPCH100 `LINEITEM` table to a
subdirectory of the `/backup` directory:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_BACKUP_TABLE(?,?,?,?)");
      cs.setString(1, 'TPCH100');
      cs.setString(2, 'LINEITEM');
      cs.setString(3, '/backup');
      cs.setString(4, 'full');
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
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
{: .Example}

### Examining the Backup  {#exexamine}

After the backup completes, you can examine the `sys.sysbackup` table to find the ID of your new backup:

```
splice> SELECT * FROM sys.sysbackup;
BACKUP_ID      |BEGIN_TIMESTAMP          |END_TIMESTAMP            |STATUS     |SCOPE     |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
-----------------------------------------------------------------------------------------------------------------------------------
587516417      |2018-09-25 00:12:33.896  |2018-09-25 00:42:53.546  |SUCCESS    |TABLE     |false|-1                  |3

```
{: .Example}

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
{: .Example}

{% include splice_snippets/tblaccess1.md %}

### Validating the Backup  {#exvalidate}
Before restoring the table, you can validate the backup:
```
splice> CALL SYSCS_UTIL.VALIDATE_TABLE_BACKUP( 'TPCH100', 'LINEITEM', '/backup', 587516417 );
Results
---------------------------------------------------------------------------------------------
No corruptions found for backup.

1 row selected
```
{: .Example}

See the reference page for the [`SYSCS_UTIL.VALIDATE_TABLE_BACKUP`](sqlref_sysprocs_validatetablebackup.html) system procedure for more information about backup validation.

### Restoring the Backup  {#exrestore}
You can restore the table to another table on the same cluster, or on a different cluster.

This command restores the backed-up table to table named `LINEITEM` in the `SPLICE` schema:
```
splice> CALL SYSCS_UTIL.SYSCS_RESTORE_TABLE('SPLICE', 'LINEITEM', 'TPCH100', 'LINEITEM', '/backup', 587516417, false);
Statement executed.
```
{: .Example}

See the reference page for the [`SYSCS_UTIL.SYSCS_RESTORE_TABLE`](sqlref_sysprocs_restoretable.html) system procedure for more information about restoring a backed-up table.

## See Also

* [`SYSCS_UTIL.SYSCS_BACKUP_SCHEMA`](#sqlref_sysprocs_backupschema.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_SCHEMA`](#sqlref_sysprocs_restoreschema.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_TABLE`](sqlref_sysprocs_restoretable.html)
* [`SYSCS_UTIL.VALIDATE_TABLE_BACKUP`](sqlref_sysprocs_validatetablebackup.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)

</div>
</section>
