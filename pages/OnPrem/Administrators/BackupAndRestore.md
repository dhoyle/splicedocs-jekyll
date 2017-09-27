---
summary: How to back up your database, and how to restore your database from a backup.
title: Backing Up and Restoring Your Database
keywords: back up, restore, backup, backup restore, backing up, restoring, incremental backup, full backup
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_admin_backingup.html
folder: OnPrem/Administrators
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Backing Up and Restoring Your Database

{% include splice_snippets/enterpriseonly_note.md %}
Splice Machine provides built-in system procedures that make it easy to
back up and restore your entire database. You can:

* create full and incremental backups to run immediately
* schedule daily full or incremental backups
* restore your database from a backup
* manage your backups
* access logs of your backups

The rest of this topic will help you with working with your backups, in
these sections:

* [About Splice Machine Backups](#About)
* [Using the Backup Operations](#Using)
* [Backing Up to Cloud Storage](#Backing)

## About Splice Machine Backups   {#About}

Splice Machine supports: both full and incremental backups: 

* A *full backup* backs up all of the files/blocks that constitute your
  database.
* An *incremental backup* only stores database files/blocks that have
  changed since a previous backup.

Because backups can consume a lot of disk space, most customers define a
backup strategy that blends their needs for security, recover-ability,
and space restrictions. Since incremental backups require a lot less
space than do full backups, and allow for faster recovery of data, many
customers schedule daily, incremental backups.

Splice Machine automatically detects when it is the first run of an
incremental backup and performs a one-time full backup; subsequent runs
will only back up changed files/blocks.
{: .noteNote}

### Backup IDs, Backup Jobs, and Backup Tables

Splice Machine uses *backup IDs* to identify a specific full or
incremental *backup* that is stored on a file system, and *backup job
IDs* to identify each scheduled *backup job*. Information about backups
and backup jobs is stored in these system tables:

<table summary="Table of Splice Machine system backup tables.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>System Table</th>
                        <th>Contains Information About</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>SYS.SYSBACKUP</code>
                        </td>
                        <td>Each database backup; you can query this table to find the ID of and details about a backup that was run at a specific time.</td>
                    </tr>
                    <tr>
                        <td><code>SYS.SYSBACKUPITEMS</code>
                        </td>
                        <td>Each item (table) in a backup.</td>
                    </tr>
                    <tr>
                        <td><code>SYS.SYSBACKUPJOBS</code>
                        </td>
                        <td>Each backup job that has been run for the database.</td>
                    </tr>
                </tbody>
            </table>
### Temporary Tables and Backups

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

## Using the Backup Operations   {#Using}

This section summarizes and provides examples of using the Splice
Machine backup operations:

* [Scheduling a Daily Backup Job](#Scheduling)
* [Running an Immediate Backup](#Running)
* [Restoring Your Database From a Previous Backup](#Restorin)
* [Reviewing Backup Information](#Reviewing)
* [Canceling a Scheduled Backup Job](#Cancelin)
* [Canceling a Backup That's In Progress](#CancelB){: .WithinBook}
* [Deleting a Backup](#Deleting)
* [Deleting Outdated Backups](#DeleteOld)

You must make sure that the directory to which you are backing up or
from which data is being restored is accessible to the HBase user who is
initiating the restore. Make sure the directory permissions are set
correctly on the backup directory.

Note that you can store your backups in a cloud-based storage service
such as AWS; for more information, see the [Backing Up to Cloud
Storage](#Backing) section below.
{: .noteNote}

### Scheduling a Daily Backup Job   {#Scheduling}

Use the
[`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html) system
procedure to schedule a job that performs a daily incremental or full
backup of your database:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP( backupDir, backupType, startHour );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupDir
{: .paramName}

A `VARCHAR` value that specifies the path to the directory in which you
want the backup stored.
{: .paramDefnFirst}

Note that this directory can be cloud-based, as described in the
[Backing Up to Cloud Services](#Backing) section below.
{: .paramDefn}

backupType
{: .paramName}

A `VARCHAR(30)` value that specifies the type of backup that you want
performed; one of the following values: `full` or `incremental`. The
first run of an incremental backup is always a full backup.
{: .paramDefnFirst}

startHour
{: .paramName}

Specifies the hour (`0-23`) in GMT at which you want the backup to run
each day. A value less than `0` or greater than `23` produces an error
and the backup is not scheduled.
{: .paramDefnFirst}

#### Example 1: Set up a full backup to run every day at 3am:

To run a full backup every night at 3am:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP('/home/backup', 'full', 3);
{: .AppCommand xml:space="preserve"}

</div>
<div markdown="1">
#### Example 2: Set up an incremental backup to run every day at noon:

To run an incremental backup every day at noon.

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('/home/backup', 'incremental', 12);
{: .AppCommand xml:space="preserve"}

</div>
</div>
</div>
### Running an Immediate Backup   {#Running}

Use the
[`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html)
system procedure to immediately run a full or incremental backup.

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_BACKUP_DATABASE( backupDir, backupType );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupDir
{: .paramName}

A `VARCHAR` value that specifies the path to the directory in which you
want the backup stored.
{: .paramDefnFirst}

Note that this directory can be cloud-based, as described in the
[Backing Up to Cloud Services](#Backing) section below.
{: .paramDefn}

backupType
{: .paramName}

A `VARCHAR(30)` value that specifies the type of backup that you want
performed; use.one of the following values: `full` or `incremental`.
{: .paramDefnFirst}

#### Example 1: Execute a full backup now

To execute a backup right now:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('/home/backup', 'full');
{: .AppCommand xml:space="preserve"}

</div>
<div markdown="1">
#### Example 2: Execute an incremental backup now:

This call will run an incremental backup right now. Splice Machine
checks the [`SYSBACKUP System Table`](sqlref_systables_sysbackup.html)
to determine if there already is a backup for the system; if not, Splice
Machine will perform a full backup, and subsequent backups will be
incremental. The backup data is stored in the specified directory.

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('/home/backup', 'incremental');
{: .AppCommand xml:space="preserve"}

</div>
</div>
</div>
### Restoring Your Database From a Previous Backup   {#Restorin}

You can restore your database from a previous backup, use the
[`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html) system
procedure.

To restore your database from a previous backup, use the
[`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html) system
procedure:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_RESTORE_DATABASE(backupDir, backupId);
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupDir
{: .paramName}

A `VARCHAR` value that specifies the path to the directory in which the
backup isstored.
{: .paramDefnFirst}

You can find the *backupId* you want to use by querying the [`SYSBACKUP
System Table`](sqlref_systables_sysbackup.html). See the [Reviewing
Backup Information](#Reviewing) section below for more information.
{: .paramDefn}

backupId
{: .paramName}

A `BIGINT` value that specifies which backup you want to use to restore
your database.
{: .paramDefnFirst}

</div>
<div class="notePlain" markdown="1">
There are several important things to know about restoring your database
from a previous backup:

* Restoring a database **wipes out your database** and replaces it with
  what had been previously backed up.
* You **cannot use your cluster** while restoring your database.
* You **must reboot your database** after the restore is complete by
  first [Starting Your Database](onprem_admin_startingdb.html).

</div>
> #### Example: Restore the database from a local, full backup
>
> This example restores your database from the backup stored in the
> `/home/backup` directory that has `backupId=1273`:
>
> <div class="preWrapperWide" markdown="1">
>     call SYSCS_UTIL.SYSCS_RESTORE_DATABASE('/home/backup', 1273);
> {: .AppCommand xml:space="preserve"}
>
> </div>

### Reviewing Backups   {#Reviewing}

Splice Machine stores information about your backups and scheduled
backup jobs in system tables that you can query, and stores a backup log
file in the directory to which a backup is written when it runs.

#### Backup Job Information

Information about your scheduled backup jobs is stored in the
[`SYSBACKUPJOBS System Table`](sqlref_systables_sysbackupjobs.html):

<div class="preWrapperWide" markdown="1">
    splice> select * from SYS.SYSBACKUPJOBS;
    JOB_ID         |FILESYSTEM        |TYPE           |HOUR_OF_DAY|BEGIN_TIMESTAMP
    --------------------------------------------------------------------------------------
    22275          |/data/backup/0101 |FULL           |22         |2015-04-03 18:43:42.631
{: .Example xml:space="preserve"}

</div>
You can query this table to find a job ID, if you need to cancel a
scheduled backup.

#### Backup Information

Information about each backup of your database is stored in the
[`SYSBACKUP System Table`](sqlref_systables_sysbackup.html), including
the ID assigned to the backup and its location. You can query this table
to find the ID of a specific backup, which you need if you want to
restore your database from it, or to delete it:

<div class="preWrapperWide" markdown="1">
    splice> select * from SYS.SYSBACKUP;
    BACKUP_ID |BEGIN_TIMESTAMP         |END_TIMESTAMP           |STATUS |FILESYSTEM        |SCOPE |INCR&|INCREMENTAL_PARENT_&|BACKUP_ITEM
    ------------------------------------------------------------------------------------------------------------------------------------------
    22275     |2015-04-03 18:40:56.877 |2015-04-03 18:43:42.631 |S      |/data/backup/0101 |D     |false|-1       |15
    21428     |2015-04-03 18:30:55.964 |2015-04-03 18:33:49.494 |S      |/data/backup/0101 |D     |false|-1       |15
    20793     |2015-04-03 18:23:53.574 |2015-04-03 18:27:07.07  |S      |/data/backup/0101 |D     |false|-1       |87
{: .Example xml:space="preserve"}

</div>
#### Backup Log Files

When you run a backup, a log file is created or updated in the directory
in which the backup is stored. This log file is named
`backupStatus.log`, and is stored in plain text, human-readable format.
Here's a sample snippet from a log file:

<div class="preWrapperWide" markdown="1">

    Expected time for backup ~12 hours, expected finish at 15:30 on April 8, 2015
    5 objects of 833 objects backed up..
    6 objects of 833 objects backed up

    Finished with Success. Total time taken for backup was 11 hours 32 minutes.
{: .Example xml:space="preserve"}

</div>
### Canceling a Scheduled Backup   {#Cancelin}

You can cancel a daily backup with the
[`SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP`](sqlref_sysprocs_canceldailybackup.html) system
procedure:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP( jobId );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
jobId
{: .paramName}

A `BIGINT` value that specifies which scheduled backup job you want to
cancel.
{: .paramDefnFirst}

You can find the *jobId* you want to cancel by querying the
[`SYSBACKUPJOBS System Table`](sqlref_systables_sysbackupjobs.html).
{: .paramDefn}

Once you cancel a daily backup, it will no longer be scheduled to run.
{: .noteNote}

#### Example: Cancel a daily backup

This example cancels the backup that has `jobId=1273`:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP(1273);
{: .AppCommand xml:space="preserve"}

</div>
</div>
### Canceling a Backup That's In Progress   {#CancelB}

You can call the
[`SYSCS_UTIL.SYSCS_CANCEL_BACKUP`](sqlref_sysprocs_cancelbackup.html) system
procedure to cancel a backup that is currently running:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_CANCEL_BACKUP(  );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
#### Example: Cancel a running backup

This example cancels the Splice Machine backup job that is currently
running.

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_CANCEL_BACKUP();
{: .AppCommand xml:space="preserve"}

</div>
</div>
### Deleting a Backup   {#Deleting}

Use the
[`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html) system
procedure to delete a single backup:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DELETE_BACKUP( backupId );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupId
{: .paramName}

A `BIGINT` value that specifies which backup you want to delete.
{: .paramDefnFirst}

You can find the *backupId* you want to delete by querying the
[`SYSBACKUP System Table`](sqlref_systables_sysbackup.html),
{: .paramDefn}

#### Example: Delete a backup

This example deletes the backup that has `backupId=1273`:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_DELETE_BACKUP(1273);
{: .AppCommand xml:space="preserve"}

</div>
</div>
### Deleting Outdated Backups   {#DeleteOld}

Use the
[`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html) system
procedure to delete all backups that are older than a certain number of
days.

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS( backupWindow );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
backupWindow
{: .paramName}

An `INT` value that specifies the number of days of backups that you
want retained. Any backups created more than `backupWindow` days ago are
deleted.
{: .paramDefnFirst}

#### Example: Delete all backups more than a week old

This example deletes all backups that are more than a week old:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS(7);
{: .AppCommand xml:space="preserve"}

</div>
</div>
## Backing Up to Cloud Storage - AWS   {#Backing}

You can specify cloud-based directories as destinations for your
backups. This section describes how to set up credentials to allow
Splice Machine to create and manage backups on AWS.

You need to enable backups by storing your AWS Access Key ID and Secret
Access Key values in your cluster's HDFS core-site.xml file: how you set
up your credentials depends on the Hadoop platform you are using; see
the section below for your platform:

<div class="notePlain" markdown="1">
**IMPORTANT:** You must have access to the S3 bucket to which you are
backing up your database. The instructions below give general
guidelines; however, S3 access differs in every deployment. For more
information, see these sites:

* [http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html][1]{:
  target="_blank"}
* [https://wiki.apache.org/hadoop/AmazonS3][1]{: target="_blank"}

</div>
* [Enabling backups on CDH](#Enabling)
* [Enabling backups on HDP](#Enabling2)
* [Enabling backups on MapR](#Enabling3)

### Enabling Splice Machine Backups on CDH   {#Enabling}

You can use Cloudera Manager to configure properties to enable
Splice Machine backups; follow these steps:

<div class="opsStepsList" markdown="1">
1.  Navigate to the Cloudera Manager home screen.
2.  Stop both HBase and HDFS: 
    {: .topLevel}

    * Click the <span class="AppCommand">HBase Actions</span> drop-down
      arrow associated with (to the right of) `HBase` in the cluster
      summary section of the home screen, and then click <span
      class="AppCommand">Stop</span> to stop HBase.
    * Click the <span class="AppCommand">HDFS Actions</span> drop-down
      arrow associated with (to the right of) and then click <span
      class="AppCommand">Stop</span> to stop HDFS.
    {: .plainFont}

3.  Click <span class="AppCommand">HDFS</span> in the Cloudera Manager
    home screen, then click the <span
    class="AppCommand">Configuration</span> tab, and in category, click
    <span class="AppCommand">Advanced</span>. Then set these property
    values in the `Cluster-wide Advanced Configuration Snippet (Safety
    Valve) for core-site.xml` field:
    <div class="preWrapperWide" markdown="1">

        fs.s3.awsAccessKeyId       = <Your AWS Access Key>
        fs.s3.awsSecretAccessKey   = <Your AWS Access Secret Key>
    {: .AppCommand xml:space="preserve"}

    </div>

4.  Restart both services:
    {: .topLevel}

    * Click the <span class="AppCommand">HDFS Actions</span> drop-down
      arrow associated with (to the right of) HDFS in the cluster
      summary section of the Cloudera Manager home screen, and then
      click <span class="AppCommand">Start</span> to restart HDFS.
    * Navigate to the *HBase Status* tab in Cloudera Manager. Then,
      using the <span class="AppCommand">Actions</span> drop-down in the
      upper-right corner, click <span class="AppCommand">Start</span> to
      create a start HBase.
    {: .plainFont}
{: .boldFont}

</div>
### Enabling Splice Machine Backups on HDP   {#Enabling2}

You can use the Ambari dashboard to configure these properties. Follow
these steps:

<div class="opsStepsList" markdown="1">
1.  Navigate to the HDFS <span class="AppCommand">Configs</span> screen.
2.  Select the <span class="AppCommand">Services</span> tab at the top
    of the Ambari dashboard screen, then stop both HBase and HDFS: 
    {: .topLevel}

    * Click <span class="AppCommand">HBase</span> in the left pane of
      the screen, then click <span class="AppCommand">Service
      Actions-&gt;Stop</span> in the upper-right portion of the Ambari
      screen.
    * Click <span class="AppCommand">HDFS</span> in the left pane of the
      screen, the click <span class="AppCommand">Service
      Actions-&gt;Stop</span>.
    {: .plainFont}

3.  Select <span class="AppCommand">Custom core-site</span> and add
    these properties:
    <div class="preWrapperWide" markdown="1">

        fs.s3.awsAccessKeyId       = <Your AWS Access Key>
        fs.s3.awsSecretAccessKey   = <Your AWS Secret Access Key>
    {: .AppCommand xml:space="preserve"}

    </div>

4.  Restart both services:
    {: .topLevel}

    * Click <span class="AppCommand">HDFS</span> in the left pane of the
      screen, the click <span class="AppCommand">Service
      Actions-&gt;Restart All</span>.
    * Click <span class="AppCommand">HBase</span> in the left pane of
      the screen, the click <span class="AppCommand">Service
      Actions-&gt;Restart All</span>.
    {: .plainFont}
{: .boldFont}

</div>
### Enabling Splice Machine Backups on MapR   {#Enabling3}

To enable Amazon S3 access on a MapR cluster, you must stop services,
change the configuration files on each node, and then restart services.
Follow these steps:

<div class="opsStepsList" markdown="1">
1.  Stop all MapR services by stopping the warden service on each host:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        sudo service mapr-warden stop
    {: .ShellCommand}

    </div>

2.  You need to edit two files on each MapR-FS fileserver and HBase
    RegionServer in your cluster to allow hosts access to Amazon S3. You
    need to provide the fs.s3 access key ID and secret in each of these
    files:
    {: .topLevel}

    * `/opt/mapr/hadoop/hadoop-2.x.x/etc/hadoop/core-site.xml` for
      *Hadoop/MapReduce/YARN 2.x* site configuration
    * `/opt/mapr/hadoop/hadoop-0.x.x/conf/core-site.xml` for
      *Hadoop/MapReduce 0.x/1.x* site configuration
    {: .plainFont}

    If both *MapReduce v1* and *YARN/MapReduce 2* are installed on the
    MapR compute hosts, the newer *hadoop-2.x.x* version of the file
    will be canonical, and the older *hadoop-0.x.x* file symbolically
    linked to it. You can check this using the following `ls` and `file`
    commands:

    <div class="preWrapperWide" markdown="1">
        $ ls -al /opt/mapr/hadoop/hadoop-0*/conf/core-site.xml /opt/mapr/hadoop/hadoop-2*/etc/hadoop/core-site.xml
        lrwxrwxrwx 1 mapr root  54 Apr 24 11:01 /opt/mapr/hadoop/hadoop-0.20.2/conf/core-site.xml -> /opt/mapr/hadoop/hadoop-2.5.1/etc/hadoop/core-site.xml
        -rw-r--r-- 1 mapr root 775 Apr 24 12:50 /opt/mapr/hadoop/hadoop-2.5.1/etc/hadoop/core-site.xml
    {: .ShellCommand xml:space="preserve"}

    </div>

    <div class="preWrapperWide" markdown="1">
        $ file /opt/mapr/hadoop/hadoop-0*/conf/core-site.xml /opt/mapr/hadoop/hadoop-2*/etc/hadoop/core-site.xml
        /opt/mapr/hadoop/hadoop-0.20.2/conf/core-site.xml:      symbolic link to `/opt/mapr/hadoop/hadoop-2.5.1/etc/hadoop/core-site.xml'
        /opt/mapr/hadoop/hadoop-2.5.1/etc/hadoop/core-site.xml: XML  document text
    {: .ShellCommand xml:space="preserve"}

    </div>

3.  Add your access key ID and secret key in each file by adding the
    following properties between the `<configuration>` and
    `</configuration>` tags:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        <!-- AWS s3://bucket/... block-based access -->
        <property>
        <name>fs.s3.awsAccessKeyId</name>
        <value>_AWS_ACCESS_KEY_ID_</value>
        </property>
        <property>
        <name>fs.s3.awsSecretAccessKey</name>
        <value>_AWS_SECRET_ACCESS_KEY_</value>
        </property>
        <!-- AWS s3n://bucket/... filesystem-like access -->
        <property>
        <name>fs.s3n.awsAccessKeyId</name>
        <value>_AWS_ACCESS_KEY_ID_</value>
        </property>
        <property>
        <name>fs.s3n.awsSecretAccessKey</name>
        <value>_AWS_SECRET_ACCESS_KEY_</value>
        </property>
    {: .AppCommand xml:space="preserve"}

    </div>

4.  Use the `hadoop` command to view your configuration changes:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        $ hadoop conf | grep fs\\.s3 | grep -i access | sort -u
        <property><name>fs.s3.awsAccessKeyId</name><value>_AWS_ACCESS_KEY_ID_</value><source>core-site.xml</source></property>
        <property><name>fs.s3.awsSecretAccessKey</name><value>_AWS_SECRET_ACCESS_KEY_</value><source>core-site.xml</source></property>
        <property><name>fs.s3n.awsAccessKeyId</name><value>_AWS_ACCESS_KEY_ID_</value><source>core-site.xml</source></property>
        <property><name>fs.s3n.awsSecretAccessKey</name><value>_AWS_SECRET_ACCESS_KEY_</value><source>core-site.xml</source></property>
    {: .ShellCommand xml:space="preserve"}

    </div>

5.  You can also verify that access is correctly configured with the
    `hadoop` command to list the contents of an existing bucket. For
    example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo -iu mapr hadoop fs -ls s3n://yourbucketname/
    {: .ShellCommand xml:space="preserve"}

    </div>

6.  Finally, restart MapR services on each node via MapR's warden::
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo service mapr-warden start
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_BACKUP_DATABASE`](sqlref_sysprocs_backupdb.html) in
  the *SQL Reference Manual*
* [`SYSCS_UTIL.SYSCS_CANCEL_BACKUP`](sqlref_sysprocs_cancelbackup.html)
  in the *SQL Reference Manual*
* [`SYSCS_UTIL.SYSCS_CANCEL_DAILY_BACKUP`](sqlref_sysprocs_canceldailybackup.html)
  in the *SQL Reference Manual*
* [`SYSCS_UTIL.SYSCS_DELETE_BACKUP`](sqlref_sysprocs_deletebackup.html)
  in the *SQL Reference Manual*
* [`SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS`](sqlref_sysprocs_deleteoldbackups.html)
  in the *SQL Reference Manual*
* [`SYSCS_UTIL.SYSCS_RESTORE_DATABASE`](sqlref_sysprocs_restoredb.html)
  in the *SQL Reference Manual*
* [`SYSCS_UTIL.SYSCS_SCHEDULE_DAILY_BACKUP`](sqlref_sysprocs_scheduledailybackup.html)
  in the *SQL Reference Manual*
* [`SYSBACKUP System Table`](sqlref_systables_sysbackup.html) in the
  *SQL Reference Manual*
* [`SYSBACKUPITEMS System Table`](sqlref_systables_sysbackupitems.html)
  in the *SQL Reference Manual*
* [`SYSBACKUPJOBS System Table`](sqlref_systables_sysbackupjobs.html) in
  the *SQL Reference Manual*

</div>
</section>



[1]: http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html
