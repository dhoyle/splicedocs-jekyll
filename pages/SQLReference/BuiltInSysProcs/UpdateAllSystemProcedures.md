---
title: SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES built-in system procedure
summary: Built-in system procedure that updates the signatures of all of the system procedures in a database.
keywords: update_all_system_procedures, update system procedure signatures
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_updateallsysprocs.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES

The `SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES` system procedure
updates the signatures of all of the system procedures in a database.

You need to call this procedure when you update to a new version of
Splice Machine that includes new or updates system procedure signatures.
{: .noteImportant}

## About System Procedures

Splice Machine uses prepared statements known as *system procedures* to
access data in the system tables. Each system procedure has two parts:

* An *implementation*, which is compiled Java byte code that is stored
  in the Splice jar and is included in the CLASSPATH of the Splice
  server.
* A *declaration* (or *signature*), which is a CREATE PROCEDURE
  statement that is stored in the Splice jar file and is synchronized
  with the data dictionary (in the SYSALIASES table).

The `SYSALIASES` table is synchronized with a database when the database
is first created. Thereafter, when you make changes to the system
procedures, you need to call a function to keep the `SYSALIASES` table
synchronized with the procedures in the Splice jar file.

If you've modified, deleted, or added a system procedure, call the
[`SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE`](sqlref_sysprocs_updatesysproc.html)
function, which drops the procedure from the data dictionary, and
updates the dictionary with the new version in the Splice jar file.

If you've made multiple modifications to the system procedures, you can
call this function, `SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES`, to
update all of the stored declarations for a database in the data
dictionary. This function drops all of the system procedures from the
data dictionary and then recreates the system procedures stored in the
dictionary from the definitions in the Splice jar file.

## Results

This procedure does not return a result.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES
{: .FcnSyntax xml:space="preserve"}

</div>

## Example

<div class="preWrapperWide" markdown="1">
    splice> call SYSCS_UTIL.SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES;
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL_SYSCS_UPDATE_SYSTEM_PROCEDURE`](#)

</div>
</section>
