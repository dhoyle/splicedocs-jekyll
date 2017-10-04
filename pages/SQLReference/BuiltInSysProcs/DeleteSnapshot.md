---
title: SYSCS_UTIL.DELETE_SNAPSHOT built-in system procedure
summary: Built-in system procedure that deletes a stored Splice Machine snapshot.
keywords: delete snapshot, delete_snapshot
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_deletesnapshot.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_DELETE_SNAPSHOT

The `SYSCS_UTIL.SYSCS_DELETE_SNAPSHOT` system procedure deletes a
previously created Splice Machine snapshot.

Snapshots include both the data and indexes for tables.
{: .noteNote}

For more information, see the [*Using
Snapshots*](developers_tuning_snapshots.html) topic.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DELETE_SNAPSHOT( VARCHAR(128) snapshotName );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
snapshotName
{: .paramName}

The name of the snapshot that you are deleting.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Example

The following example deletes a snapshot:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.DELETE_SNAPSHOT( 'snap_myschema_070417a' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
</section>
