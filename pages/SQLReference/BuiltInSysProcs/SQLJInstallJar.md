---
title: SQLJ.INSTALL_JAR built-in system procedure
summary: Built-in system procedure that stores a jar file in a database.
keywords: jar file, install_jar, install jar, jar file
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_installjar.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SQLJ.INSTALL_JAR

The `SQLJ.INSTALL_JAR` system procedure stores a jar file in a database.

For more information about using JAR files, see the [Using Functions and
Stored Procedures](developers_fcnsandprocs_intro.html) section in our
*Developer's Guide*.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SQLJ.INSTALL_JAR(IN jar_file_path_or-url VARCHAR(32672),
                     IN qualified_jar_name VARCHAR(32672),
                     IN deploy INTEGER)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
jar_file_path_or-url
{: .paramName}

The path or URL of the jar file to add. A path includes both the
directory and the file name (unless the file is in the current
directory, in which case the directory is optional).
{: .paramDefnFirst}

* If you're using Splice Machine on a cluster, the Jar file can be in the `HDFS` file system or in an `S3a` bucket on Amazon AWS.
* If you're using our standalone version, the Jar file can be in an `S3a` bucket on Amazon AWS or in your local file system.
{: .nested}

Here are a few examples:
{: .paramDefn}
<div class="preWrapper" markdown="1">
    https://s3a.amazonaws.com/splice/examples/jars/tours.jar
    hdfs:///home/jars/tours.jar
    d:/todays_build/tours.jar
{: .Example}
</div>

qualified_jar_name
{: .paramName}

Splice Machine name of the jar file, qualified by the schema name. Two
examples:
{: .paramDefnFirst}

<div class="preWrapper" markdown="1">
    MYSCHEMA.Sample1
       -- a delimited identifier
    MYSCHEMA."Sample2"
{: .Example}

</div>
deploy
{: .paramName}

If this set to `1`, it indicates the existence of an SQLJ deployment
descriptor file. Splice Machine ignores this argument, so it is normally
set to `0`.
{: .paramDefnFirst}

</div>
## Usage Notes

This procedure will not work properly unless you have first added your
procedure to the Derby CLASSPATH variable. For example:
{: .body}

    CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY('derby.database.classpath', 'SPLICE.MY_EXAMPLE_APP');
{: .Example}

For information about storing and updating stored procedures, and the
setting of the Derby classpath, see the [Storing and Updating Splice
Machine Functions and Stored
Procedures](developers_fcnsandprocs_storing.html) topic.
{: .body}

## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## SQL Examples

<div class="preWrapperWide" markdown="1">

       -- Make sure Derby classpath variable is correctly set for our examples
    CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY(
                        'derby.database.classpath',
                        'SPLICE.SAMPLE1_APP:SPLICE.SAMPLE2');

                           -- install jar from current directory
    splice> CALL SQLJ.INSTALL_JAR('tours.jar', 'SPLICE.SAMPLE1_APP', 0);

       -- install jar using full path
    splice> CALL SQLJ.INSTALL_JAR('c:\myjarfiles\tours.jar', 'SPLICE.SAMPLE1_APP', 0);

       -- install jar from remote location
    splice> CALL SQLJ.INSTALL_JAR('http://www.example.com/tours.jar', 'SPLICE.SAMPLE2_APP', 0);

       -- install jar using a quoted identifier for the
       -- Splice Machine jar name
    splice> CALL SQLJ.INSTALL_JAR('tours.jar', 'SPLICE."SAMPLE2"', 0);
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SQLJ_REMOVE_JAR`](sqlref_sysprocs_removejar.html)
* [`SQLJ_REPLACE_JAR`](sqlref_sysprocs_replacejar.html)

</div>
</section>
