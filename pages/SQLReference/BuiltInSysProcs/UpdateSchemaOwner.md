---
title: SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER built-in system procedure
summary: Built-in system procedure that changes which user owns the schema.
keywords: update_schema_owner, change schema owner, modify schema owner
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_updateschemaowner.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER

The `SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER` system procedure changes the
owner of a schema.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER(
                             schemaName VARCHAR(128),
                             userName VARCHAR(128))
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the name of the schema..
{: .paramDefnFirst}

userName
{: .paramName}

Specifies the user ID in the Splice Machine database.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER( 'SPLICEBBALL', 'Walt');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
</div>
</section>

