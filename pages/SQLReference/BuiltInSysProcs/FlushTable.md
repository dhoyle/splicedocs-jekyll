---
title: SYSCS_UTIL.SYSCS_FLUSH_TABLE built-in system procedure
summary: Built-in system procedure that flushes a table.
keywords: flush table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_flushtable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_FLUSH_TABLE

The `SYSCS_UTIL.SYSCS_FLUSH_TABLE` system procedure performs a major flush on a table.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_FLUSH_TABLE( VARCHAR schemaName,
                                  VARCHAR tableName );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">

schemaName
{: .paramName}

The name of the table's schema.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table that you want to flush.
{: .paramDefnFirst}
</div>

## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Examples
```
splice> CALL SYSCS_UTIL.SYSCS_FLUSH_TABLE( 'mySchema', 'myTable' );
Statement executed
```
{: .Example}

</div>
</section>
