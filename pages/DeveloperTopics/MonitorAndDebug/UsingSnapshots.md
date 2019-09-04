---
title: Using Snapshots
summary: Describes Splice Machine snapshots, which you can use to store and subsequently restore the current state of a table or schema.
keywords: snapshots, restore, importing, table snapshot, schema snapshot, restore snapshot, delete snapshot, backup table, backup schema, restore table, restore schema, backup restore
toc: false
product: all
sidebar: home_sidebar
permalink: developers_tuning_snapshots.html
folder: DeveloperTopics/MonitorAndDebug
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Splice Machine Snapshots

This topic describes how to use the Splice Machine snapshot feature to
create a restorable snapshot of a table or schema; this is commonly used
when importing or deleting a significant amount of data from a database.

## Overview

Snapshots allow you to create point-in-time backups of tables (or an
entire schema) without actually cloning the data.

Snapshots include both the data and indexes for tables.
{: .noteNote}

You use these system procedures and tables to work with snapshots:

* Use the
 &nbsp;[`SYSCS_UTIL.SNAPSHOT_TABLE`](sqlref_sysprocs_snapshottable.html)
  system procedure to create a named snapshot for a table.
* Use the
 &nbsp;[`SYSCS_UTIL.SNAPSHOT_SCHEMA`](sqlref_sysprocs_snapshotschema.html)
  system procedure to create a named snapshot for a schema.
* Use the
 &nbsp;[`SYSCS_UTIL.RESTORE_SNAPSHOT`](sqlref_sysprocs_restoresnapshot.html)
  system procedure to restore a table or schema from a named snapshot.
* Use the
 &nbsp;[`SYSCS_UTIL.DELETE_SNAPSHOT`](sqlref_sysprocs_deletesnapshot.html)
  system procedure to delete a named snapshot.
* Information about stored snapshots, including their names, is found in
  the &nbsp;[`SYS.SYSSNAPSHOTS`](sqlref_systables_syssnapshots.html) system
  table.

  The `SYS.SYSSNAPSHOTS` table is part of the `SYS` schema, to which access is restricted for security purposes. You can only access tables in the `SYS` schema if you are a Database Administrator or if your Database Administrator has explicitly granted access to you.
  {: .noteIcon}

</div>
</section>
