---
title: SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY built-in system procedure
summary: Built-in system procedure that sets or deletes the value of a property of the database.
keywords: properties, SET_GLOBAL_DATABASE_PROPERTY, set property value
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_setglobaldbprop.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY

Use the `SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY` system procedure to set
or delete the value of a property of the database.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY(
              IN key VARCHAR(128),
              IN value VARCHAR(32672)
            )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
key
{: .paramName}

The property name.
{: .paramDefnFirst}

value
{: .paramName}

The new property value. If this is `null`, then the property with key
value `key` is deleted from the database property set. If this is not
`null`, then this `value` becomes the new value of the property. If this
value is not a valid value for the property, Splice Machine uses the
default value of the property.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC example

Set the `splicemachine.locks.deadlockTimeout` property to a value of 10:

<div class="preWrapperWide" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY(?, ?)");
      cs.setString(1, "splicemachine.locks.deadlockTimeout");
      cs.setString(2, "10");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

Set the `splicemachine.locks.deadlockTimeout` property to a value of 10:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY( 'splicemachine.locks.deadlockTimeout', '10' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_GET_GLOBAL_DATABASE_PROPERTY`](sqlref_sysprocs_getglobaldbprop.html)

</div>
</section>
