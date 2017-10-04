---
title: SYSCS_GET_DATABASE_PROPERTY built-in system function
summary: Built-in system function that fetches the value of the specified property of the database on the current connection.
keywords: properties, get_database_property, get property, property value
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getdbprop.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_DATABASE_PROPERTY Function

The `SYSCS_UTIL.SYSCS_GET_DATABASE_PROPERTY` function fetches the value
of the specified property of the database on the current connection.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    VARCHAR(32672) SYSCS_UTIL.SYSCS_GET_DATABASE_PROPERTY(
      IN Key VARCHAR(128)
      )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
Key
{: .paramName}

The key for the property whose value you want.
{: .paramDefnFirst}

An error occurs if *Key* is null.
{: .noteNote}

</div>
## Results

Returns the value of the property. If the value that was set for the
property is invalid, the `SYSCS_UTIL.SYSCS_GET_DATABASE_PROPERTY`
function returns the invalid value, but Splice Machine uses the default
value.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Example

Retrieve the value of the `splicemachine.locks.deadlockTimeout`
property:

<div class="preWrapper" markdown="1">
    splice> VALUES SYSCS_UTIL.SYSCS_GET_DATABASE_PROPERTY( 'splicemachine.locks.deadlockTimeout' );
    1
    -------------------------------------------------------------
    10

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY`](sqlref_sysprocs_setdbprop.html)

</div>
</section>
