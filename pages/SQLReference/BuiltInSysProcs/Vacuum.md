---
title: SYSCS_UTIL.VACUUM built-in system procedure
summary: Built-in system procedure that performs clean-up operations on the system.
keywords: vacuum, vacuuming, vacuum procedure
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_vacuum.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.VACUUM

When you drop a table from your database, Splice Machine marks the space occupied by the table as *deleted*, but does not actually free the physical space. That space is only reclaimed when you call the `SYSCS_UTIL.VACUUM` system procedure, which does the following:

1. Waits for all previous transactions to complete (and times out if this takes too long).
2. Gets a list of all of the HBase tables in use.
3. Compares that list with a list of objects currently in use in your database, and deletes any HBase tables that are no longer in use in your database.

This is a synchronous operations; when it completes, you'll see the following message:
```
Statement executed.
```
{: .AppCommand}

If you see an exception message instead of the completion message, please try calling `SYSCS_UTIL.VACUUM` once again.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.VACUUM()
{: .FcnSyntax xml:space="preserve"}

</div>

## Usage
To call `SYSCS_UTIL.VACUUM`, you must have execute permission on the (internal-only, undocumented) `SYSCS_UTIL.SYSCS_GET_OLDEST_ACTIVE_TRANSACTION` system procedure. You can use the following command to grant permission, replacing `myUserId` with your user ID:

```
grant EXECUTE on procedure SYSCS_UTIL.SYSCS_GET_OLDEST_ACTIVE_TRANSACTION to myUserId;
```
{: .Example}

## Example

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.VACUUM();
    Ready to accept connections.
{: .Example xml:space="preserve"}

</div>
</div>
</section>
