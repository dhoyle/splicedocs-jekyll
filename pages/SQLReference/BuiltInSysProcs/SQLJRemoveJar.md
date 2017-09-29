---
title: SQLJ.REMOVE_JAR built-in system procedure
summary: Built-in system procedure that removes a jar file from a database.
keywords: jar file, remove_jar
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_removejar.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SQLJ.REMOVE_JAR

The *SQLJ.REMOVE_JAR* system procedure removes a jar file from a
database.

For more information about using JAR files, see the [Using Functions and
Stored Procedures](developers_fcnsandprocs_intro.html) section in our
*Developer's Guide*.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SQLJ.REMOVE_JAR(
    		IN qualified_jar_name VARCHAR(32672),
     		IN undeploy INTEGER
    		)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
qualified_jar_name
{: .paramName}

The Splice Machine name of the jar file, qualified by the schema name.
Two examples:
{: .paramDefnFirst}

<div class="preWrapper" markdown="1">
    MYSCHEMA.Sample1
       -- a delimited identifier.
    MYSCHEMA."Sample2"
{: .Example}

</div>
undeploy
{: .paramName}

If set to `1`, this indicates the existence of an SQLJ deployment
descriptor file. Splice Machine ignores this argument, so it is normally
set to `0`.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Example

<div class="preWrapper" markdown="1">
    -- SQL statement
    CALL SQLJ.REMOVE_JAR('SPLICE.Sample1', 0);
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SQLJ_INSTALL_JAR`](sqlref_sysprocs_installjar.html)
* [`SQLJ_REPLACE_JAR`](sqlref_sysprocs_replacejar.html)

</div>
</section>

