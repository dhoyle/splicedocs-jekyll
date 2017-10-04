---
title: SYSCS_UTIL.RESTORE_SNAPSHOT built-in system procedure
summary: Built-in system procedure that restores a table or schema from a previously stored snapshot.
keywords: snapshot, restore_snapshot, restore from snapshot, restore table, restore schema
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_restoresnapshot.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_RESTORE_SNAPSHOT

The `SYSCS_UTIL.SYSCS_RESTORE_SNAPSHOT` system procedure restores a
table or schema to the state it was in at the time the snapshot was
created.

Snapshots include both the data and indexes for tables.
{: .noteNote}

For more information, see the [*Using
Snapshots*](developers_tuning_snapshots.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_RESTORE_SNAPSHOT( VARCHAR(128) snapshotName );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
snapshotName
{: .paramName}

The name of the snapshot from which you are restoring.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Example

The following example restores the `mySchema` schema to its state when
the named snapshot was created:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.RESTORE_SNAPSHOT( 'snap_myschema_070417a' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
</section>
