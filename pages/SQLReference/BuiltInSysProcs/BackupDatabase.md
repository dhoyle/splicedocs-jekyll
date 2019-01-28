---
title: SYSCS_UTIL.SYSCS_BACKUP_DATABASE built-in system procedure
summary: Built-in system procedure that backs up the database to a specified backup directory.
keywords: backing up, backup_database, backup database
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_backupdb.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_BACKUP_DATABASE

The `SYSCS_UTIL.SYSCS_BACKUP_DATABASE` system procedure performs an
immediate full or incremental backup of your database to a specified
backup directory.

{% include splice_snippets/enterpriseonly_note.md %}

Splice Machine supports both full and incremental backups: 

* A *full backup* backs up all of the files/blocks that constitute your
  database.
* An *incremental backup* only stores database files/blocks that have
  changed since a previous backup.

The first time that you run an incremental backup, a full backup is
performed. Subsequent runs of the backup will only copy information that
has changed since the previous backup.
{: .noteNote}

For more information, see the [*Backing Up and
Restoring*](onprem_admin_backingup.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_BACKUP_DATABASE( VARCHAR backupDir,
                                      VARCHAR(30) backupType );
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
Storage](onprem_admin_backingup.html#Backing) for information about setting backup permissions properties.
{: .noteNote}

Relative paths are resolved based on the current user directory. To
avoid confusion, we strongly recommend that you use an absolute path
when specifying the backup destination.
{: .paramDefn}

backupType
{: .paramName}

Specifies the type of backup that you want performed. This must be one of
the following values: `full` or `incremental`; any other value
produces an error and the backup is not run.
{: .paramDefnFirst}

Note that if you specify `'incremental'`, Splice Machine checks the &nbsp;
[`SYS.SYSBACKUP`](sqlref_systables_sysbackup.html) table to determine if
there already is a backup for the system; if not, Splice Machine will
perform a full backup, and subsequent backups will be incremental.
{: .paramDefn}

</div>
## Results

This procedure does not return a result.

## Backup Resource Allocation

Splice Machine backups run as Spark jobs, submitting tasks to copy HFiles. In the past, Splice Machine backups used the Apache Hadoop `distcp` tool to copy the HFile; `distcp` uses MapReduce to copy, which can require significant resources. These requirements can limit file copying parallelism and reduce backup throughput. Splice Machine backups now can run (and do so by default) using a Spark executor to copy the HFiles, which significantly increases backup performance.

You can revert to using `distcp`, which uses a MapReduce job that can run into resource issues. For more information, see the [Understanding and Troubleshooting Backups](bestpractices_onprem_backups.html) topic.

## Usage Notes

Please review these important notes about usage of this system procedure:

* HBase Configuration Options for Incremental Backup
* Temporary Tables and Backups

### HBase Configuration Options for Incremental Backup {#UsageConfig}

If you're performing incremental backups, you _must_ add the following options to your `hbase-site.xml` configuration file:

<div class="preWrapperWide" markdown="1">
    hbase.master.hfilecleaner.plugins = com.splicemachine.hbase.SpliceHFileCleaner,
    org.apache.hadoop.hbase.master.cleaner.TimeToLiveHFileCleaner
{: .AppCommand}
</div>

### Temporary Tables and Backups {#UsageTemp}

There's a subtle issue with performing a backup when you're using a
temporary table in your session: although the temporary table is
(correctly) not backed up, the temporary table's entry in the system
tables will be backed up. When the backup is restored, the table entries
will be restored, but the temporary table will be missing.

There's a simple workaround:

1.  Exit your current session, which will automatically delete the
    temporary table and its system table entries.
2.  Start a new session (reconnect to your database).
3.  Start your backup job.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

The following example performs an immediate full backup to a
subdirectory of the `hdfs:///home/backup` directory:

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE(?,?)");
      cs.setString(1, 'hdfs:///home/backup');
      cs.setString(2, 'full');
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

Backing up a database may take several minutes, depending on the size of
your database and how much of it you're backing up.
{: .noteRelease}

<div markdown="1">
The following example runs an immediate incremental backup to the
`hdfs:///home/backup/` directory:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE( 'hdfs:///home/backup', 'incremental' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
The following example runs the same backup and stores it on AWS:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE( 's3://backup1234', 'incremental' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
And this example does a full backup to a relative directory (relative to
your `splicemachine` directory) on a standalone version of
Splice Machine:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE( './dbBackups', 'full' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [*Backing Up and Restoring Databases*](onprem_admin_backingup.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_SCHEMA`](#sqlref_sysprocs_backupschema.html)
* [`SYSCS_UTIL.SYSCS_BACKUP_TABLE`](#sqlref_sysprocs_backuptable.html)
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_SCHEMA`](#sqlref_sysprocs_restoreschema.html)
* [`SYSCS_UTIL.SYSCS_RESTORE_TABLE`](#sqlref_sysprocs_restoretable.html)
* [`SYSBACKUP`](sqlref_systables_sysbackup.html)
* [`SYSBACKUPITEMS`](sqlref_systables_sysbackupitems.html)
* [`SYSBACKUPJOBS`](sqlref_systables_sysbackupjobs.html)

</div>
</section>
