---
title: Storing and Updating Splice Machine Functions and Procedures
summary: How to store and update your compiled jar files when developing stored procedures and functions for Splice Machine.
keywords: stored procedures, functions, updating stored procedures, updating functions, storing procedures, storing functions
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fcnsandprocs_storing.html
folder: Developers/FcnsAndProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Storing and Updating Splice Machine Functions and Stored Procedures

This topic describes how to store and update your compiled Java
Jar (`.jar`) files when developing stored procedures and functions for
Splice Machine.

Jar files are not versioned: the `GENERATIONID` is always zero. You can
view the metadata for the Jar files in the Splice data dictionary by
executing this query: `select * from sys.sysfiles;`
{: .noteNote}

## Adding a Jar File

To add a new Jar file to your Splice Machine database, use the <span
class="AppCommand">splice&gt;</span> command line interface to store the
Jar and then update your `CLASSPATH` property so that your code can be
found:

When Splice Machine is searching for a class to load, it first searches
the system `CLASSPATH`. If the class is not found in the traditional
system class path, Splice Machine then searches the class path set as
the value of the `derby.database.classpath` property.
{: .noteNote}

<div class="opsStepsList" markdown="1">
1.  Load your Jar file into the Splice Machine database
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        splice> CALL SQLJ.INSTALL_JAR('/Users/me/dev/workspace/examples/bin/example.jar', 'SPLICE.MY_EXAMPLE_APP', 0);
    {: .AppCommand xml:space="preserve"}
    
    </div>
    
    Please refer to the
    [`SQLJ.INSTALL_JAR`](sqlref_sysprocs_installjar.html) topic in the
    Splice Machine SQL Reference book for more information about
    using this system procedure. To summarize:
    {: .indentLevel1}
    
    * The first argument is the path on your computer to your Jar file.
    * The second argument is the name for the stored procedure Jar file
      in your database, in `schema.name` format.
    * The third argument is currently unused but required; use `0` as
      its value.
    {: .plainFont}

2.  Update your CLASSPATH
    {: .topLevel}
    
    You need to update your `CLASSPATH` so that Splice Machine can find
    your code. You can do this by using the
    [`SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY`](sqlref_sysprocs_setdbprop.html) system
    procedure to update the `derby.database.classpath` property:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        splice> CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY('derby.database.classpath', 'SPLICE.MY_EXAMPLE_APP');
    {: .AppCommand xml:space="preserve"}
    
    </div>
    
    Note that if you've developed more than one Jar file, you can update
    the `derby.database.classpath` property with multiple Jars by
    separating the Jar file names with colons when you call the
    [`SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY`](sqlref_sysprocs_setdbprop.html) system
    procedure . For example:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        splice> CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY('derby.database.classpath', 'SPLICE.MY_EXAMPLE_APP:SPLICE.YOUR_EXAMPLE');
    {: .AppCommand xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
## Updating a Jar File

You can use the <span class="AppCommand">splice&gt;</span> command line
interface to replace a Jar file:

<div class="opsStepsList" markdown="1">
1.  Replace the stored Jar file
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        splice> CALL SQLJ.REPLACE_JAR('/Users/me/dev/workspace/examples/bin/example.jar', 'SPLICE.MY_EXAMPLE_APP');
    {: .AppCommand xml:space="preserve"}
    
    </div>
    
    Please refer to the
    [`SQLJ.REPLACE_JAR`](sqlref_sysprocs_replacejar.html) topic in the
    Splice Machine SQL Reference book for more information about
    using this system procedure. To summarize:
    {: .indentLevel1}
    
    * The first argument is the path on your computer to your Jar file.
    * The second argument is the name for the stored procedure Jar file
      in your database, in `schema.name` format.
    {: .plainFont}
{: .boldFont}

</div>
## Deleting a Jar File 

You can use the <span class="AppCommand">splice&gt;</span> command line
interface to delete a Jar file:

<div class="opsStepsList" markdown="1">
1.  Delete a stored Jar file
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        splice> CALL SQLJ.REMOVE_JAR('SPLICE.MY_EXAMPLE_APP', 0);
    {: .AppCommand xml:space="preserve"}
    
    </div>
    
    Please refer to the
    [`SQLJ.REMOVE_JAR`](sqlref_sysprocs_removejar.html) topic in the
    Splice Machine SQL Reference book for more information about
    using this system procedure. To summarize:
    {: .indentLevel1}
    
    * The first argument is the name for the stored procedure Jar file
      in your database, in `schema.name` format.
    * The second argument is currently unused but required; use `0` as
      its value.
    {: .plainFont}
{: .boldFont}

</div>
The Jar file operations (the
[`SQLJ.REMOVE_JAR`](sqlref_sysprocs_removejar.html) system procedures)
are not executed within transactions, which means that committing or
rolling back a transaction will not have any impact on these operations.
{: .noteNote}

</div>
</section>

