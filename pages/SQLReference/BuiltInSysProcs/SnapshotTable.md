---
title: SYSCS_UTIL.SNAPSHOT_TABLE built-in system procedure
summary: Built-in system procedure that creates a snapshot of a table.
keywords: snapshots, snapshot_table, create table snapshot
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_snapshottable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SNAPSHOT_TABLE   {#BuiltInSysProcs.SnapshotTable}

The `SYSCS_UTIL.SYSCS_SNAPSHOT_TABLE` system procedure creates a Splice
Machine snapshot of the specified table. These snapshots can
subsequently be used to restore the table to its state at the time that
a snapshot was created.

Snapshots include both the data and indexes for tables.
{: .noteNote}

For more information, see the [*Using
Snapshots*](developers_tuning_snapshots.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SNAPSHOT_TABLE( VARCHAR(128) schemaName,
                                      VARCHAR(128) tableName,
                                      VARCHAR(128) snapshotName );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

The name of the table's schema.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table for which you are creating a snapshot.
{: .paramDefnFirst}

snapshotName
{: .paramName}

The name that you are assigning to this snapshot, which you can
subsequently use to restore or delete the snapshot.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

Creating a table snapshot can require several minutes of more to
complete, depending on the size of the table.
{: .noteIcon}

## Example

<div markdown="1">
The following example creates a snapshot of the table named `myTable`:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SNAPSHOT_SCHEMA('mySchema', 'myTable', 'snap_myschema_070417a');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
</div>
</section>
