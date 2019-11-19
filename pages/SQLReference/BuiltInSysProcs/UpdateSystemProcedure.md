---
title: SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE built-in system procedure
summary: Built-in system procedure that updates the stored declaration of a specific system procedure in the data dictionary.
keywords: update_system_procedure, update system procedure
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_updatesysproc.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE

The `SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE` system procedure updates
the stored declaration of a specific system procedure in the data
dictionary. Call this procedure after adding a new system procedure or
modifying an existing system procedure.

## About System Procedures

Splice Machine uses prepared statements known as *system procedures* to
access data in the system tables. Each system procedure has two parts:

* An *implementation*, which is compiled Java byte code that is stored
  in the Splice jar and is included in the CLASSPATH of the Splice
  server.
* A *declaration* (or *signature*), which is a `CREATE PROCEDURE`
  statement that is stored in the Splice jar file and is synchronized
  with the data dictionary (in the `SYSALIASES` table).

The `SYSALIASES` table is synchronized with a database when the database
is first created. Thereafter, when you make changes to the system
procedures, you need to call a function to keep the `SYSALIASES` table
synchronized with the procedures in the Splice jar file.

If you've modified, deleted, or added a system procedure, call this
function, `SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE`, which drops the
procedure from the data dictionary, and updates the dictionary with the
new version in the Splice jar file.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE(schemaName, procName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

A string specifying the name of the schema that needs to be updated in
the data dictionary.
{: .paramDefnFirst}

procName
{: .paramName}

A string specifying the name of the system procedure whose declaration
needs to be updated in the data dictionary.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_UPDATE_SYSTEM_PROCEDURE('SYSCS_UTIL', 'IMPORT_DATA');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL_SYSCS_UPDATE_ALL_SYSTEM_PROCEDURES`](sqlref_sysprocs_updateallsysprocs.html)

</div>
</section>

