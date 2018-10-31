---
title: SYSCS_UTIL.SYSCS_BACKUP_SCHEMA built-in system procedure
summary: Built-in system procedure that backs up tables and indexes belonging to a specific schema to a specified backup directory.
keywords: backing up, backup_database, backup database
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_backupschema.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_BACKUP_SCHEMA

The `SYSCS_UTIL.SYSCS_BACKUP_SCHEMA` system procedure performs an
immediate full or incremental backup of the tables and indexes belonging to a schema in your database to a specified
backup directory.

{% include splice_snippets/enterpriseonly_note.md %}

Splice Machine supports both full and incremental backups: 

* A *full backup* backs up all of the files/blocks that constitute your
  schema.
* An *incremental backup* only stores database files/blocks that have
  changed since a previous backup.

The first time that you run an incremental backup, a full backup is
performed. Subsequent runs of the backup will only copy information that
has changed since the previous backup.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_BACKUP_SCHEMA( VARCHAR schemaName,
                                    VARCHAR directory,
                                    VARCHAR type );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">

schemaName
{: .paramName}

The name of the schema you want to back up.
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

Specifies the type of schema backup that you want performed. This must be one of
the following values: `full` or `incremental`; any other value
produces an error and the backup is not run.
{: .paramDefnFirst}

Note that if you specify `incremental`, Splice Machine checks the &nbsp;
[`SYS.SYSBACKUP`](sqlref_systables_sysbackup.html) table to determine if
there already is a backup for the schema; if not, Splice Machine will
perform a full backup, and subsequent backups will be incremental.
{: .paramDefn}

</div>
## Results

This procedure does not return a result.

## Backup Resource Allocation

Splice Machine backups run as Spark jobs, submitting tasks to copy HFiles. In the past, Splice Machine backups used the Apache Hadoop `distcp` tool to copy the HFile; `distcp` uses MapReduce to copy, which can require significant resources. These requirements can limit file copying parallelism and reduce backup throughput. Splice Machine backups now can run (and do so by default) using a Spark executor to copy the HFiles, which significantly increases backup performance.

You can revert to using `distcp`, which uses a MapReduce job that can run into resource issues. For more information, see the [Understanding and Troubleshooting Backups](bestpractices_onprem_backups.html) topic.

## HBase Configuration Options for Incremental Backup {#UsageConfig}

If you're performing incremental backups, you _must_ add the following options to your `hbase-site.xml` configuration file:

<div class="preWrapperWide" markdown="1">
    hbase.master.hfilecleaner.plugins = com.splicemachine.hbase.SpliceHFileCleaner,
    org.apache.hadoop.hbase.master.cleaner.TimeToLiveHFileCleaner
{: .AppCommand}
</div>

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

The following example performs an immediate full backup of the TPCH1 schema to a
subdirectory of the `/backup` directory:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_BACKUP_SCHEMA(?,?,?)");
      cs.setString(1, 'TPCH1');
      cs.setString(2, '/backup');
      cs.setString(3, 'full');
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
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
You can restore the table to another table on the same cluster, or on a different cluster. You can optionally specify that you want the backup validated before it is restored; the validation process checks for inconsistencies and missing files.

This command first validates the backed-up schema, and then restores it to a different (pre-existing) schema named `NEWTPCH1`:
```
splice> CALL SYSCS_UTIL.SYSCS_RESTORE_SCHEMA('NEWTPCH1', 'TPCH1', '/backup', 125953, true);
Statement executed.
```

See the reference page for the [`SYSCS_UTIL.SYSCS_RESTORE_SCHEMA`](sqlref_sysprocs_restoreschema.html) system procedure for more information about restoring a backed-up schema.

## See Also

* [`SYSCS_UTIL.SYSCS_RESTORE_TABLE`](sqlref_sysprocs_restoretable.html)
* [`SYSCS_UTIL.VALIDATE_TABLE_BACKUP`](sqlref_sysprocs_validatetablebackup.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)

</div>
</section>
