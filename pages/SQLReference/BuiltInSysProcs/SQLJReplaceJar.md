---
title: SQLJ.REPLACE_JAR built-in system procedure
summary: Built-in system procedure that replaces a jar file in a database.
keywords: jar files, replace_jar
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_replacejar.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SQLJ.REPLACE_JAR   {#BuiltInSysProcs.SQLJReplaceJar}

The `SQLJ.REPLACE_JAR` system procedure replaces a jar file in a
database.

For more information about using JAR files, see the [Using Functions and
Stored Procedures](developers_fcnsandprocs_intro.html) section in our
*Developer's Guide*.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SQLJ.REPLACE_JAR(
                    IN jar_file_path_or-url VARCHAR(32672),
                    IN qualified_jar_name VARCHAR(32672)
    )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
jar_file_path_or-url
{: .paramName}

The path or URL of the jar file to use as a replacement. A path includes
both the directory and the file name (unless the file is in the current
directory, in which case the directory is optional). For example:
{: .paramDefnFirst}

<div class="preWrapper" markdown="1">
    d:/todays_build/tours.jar
{: .Example}

</div>
qualified_jar_name
{: .paramName}

The Splice Machine name of the jar file, qualified by the schema name.
Two examples:
{: .paramDefnFirst}

<div class="preWrapper" markdown="1">
    MYSCHEMA.Sample1
      -- a delimited identifier.
    MYSCHEMA."Sample2"
{: .Example xml:space="preserve"}

</div>
</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Example

<div class="preWrapperWide" markdown="1">
       -- SQL statement
    CALL sqlj.replace_jar('c:\myjarfiles\newtours.jar', 'SPLICE.Sample1');
    
       -- SQL statement
       -- replace jar from remote location
    CALL SQLJ.REPLACE_JAR('http://www.example.com/tours.jar', 'SPLICE.Sample2');
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SQLJ_INSTALL_JAR`](sqlref_sysprocs_installjar.html)
* [`SQLJ_REMOVE_JAR`](sqlref_sysprocs_modifypassword.html)

</div>
</section>

