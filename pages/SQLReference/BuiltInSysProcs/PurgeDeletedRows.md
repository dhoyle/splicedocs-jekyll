---
title: SYSCS_UTIL.SET_PURGE_DELETED_ROWS built-in system procedure
summary: Built-in system procedure that tells Splice Machine to physically purge deleted rows when a major compaction is next run.
keywords: purge_deleted_rows, purging rows, physical delete, delete physical
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_purgedeletedrows.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SET_PURGE_DELETED_ROWS

The `SYSCS_UTIL.SET_PURGE_DELETED_ROWS` system procedure enables (or
disables) physical deletion of logically deleted rows from a specific
table.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SET_PURGE_DELETED_ROWS( VARCHAR schema,
                                      VARCHAR table,
                                      VARCHAR enable );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schema
{: .paramName}

The name of the schema.
{: .paramDefnFirst}

table
{: .paramName}

The name of the table
{: .paramDefnFirst}

enable
{: .paramName}

A Boolean specifying whether or not to physically delete rows that have
been logically deleted during major compaction.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Example

This specifies that deleted rows from `my_table` will be physically
deleted when the next major compaction is run:

<div class="preWrapperWide" markdown="1">
    CALL SYSCS_UTIL.SET_PURGE_DELETED_ROWS('SPLICE', 'my_table', true); 
{: .Example xml:space="preserve"}

</div>
</div>
</section>

