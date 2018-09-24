---
title: Writing Functions and Stored Procedures
summary: A mini-tutorial on writing database functions and stored procedures for your Splice Machine database.
keywords: stored procedures, writing procedures, writing functions, creating procedures, creating stored procedures, creating functions
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fcnsandprocs_writing.html
folder: DeveloperTopics/FcnsAndProcs
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Writing Functions and Stored Procedures

This topic shows you the steps required to write functions and stored
procedures for use in your Splice Machine database.

* Refer to the [Introduction to Functions and Stored
  Procedures](developers_fcnsandprocs_intro.html) topic in this section
  for an overview and comparison of functions and stored procedures.
* Refer to the [Storing and Updating Functions and Stored
  Procedures](developers_fcnsandprocs_storing.html) topic in this
  section for information about storing your compiled code and updating
  the `CLASSPATH` to ensure that Splice Machine can find your code.
* Refer to the [Functions and Stored Procedure
  Examples](developers_fcnsandprocs_examples.html) topic in this section
  for complete sample code for both a function and a stored procedure.

Note that the processes for adding functions and stored procedures to
your Splice Machine database are quite similar; however, there are some
important differences, so we've separated them into their own sections
below.

## Writing a Function in Splice Machine

This section includes these subsections:

* [Writing a Function in JAVA](#JavaFcn)
* [Writing a Function in Python](#PythonFcn)

### Writing a Function in Java {#JavaFcn}
Follow the steps below to write a Splice Machine database function in Java.

<div class="opsStepsList" markdown="1">
1.  Create a Java method
    {: .topLevel}

    Each function maps to a Java method. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        package com.splicemachine.cs.function;

        public class Functions {
           public static int addNumbers(int val1, int val2) {
              return val1 + val2;
           }
        }
    {: .Example xml:space="preserve"}

    </div>

2.  Create the function in the database
    {: .topLevel}

    You can find the complete syntax for [`CREATE FUNCTION`](sqlref_statements_createfunction.html) in the
    *Splice Machine SQL Reference* manual.
    {: .indentLevel1}

    Here's a quick example of creating a function. In this example,
    `com.splicemachine.cs.function` is the package, `Functions` is the
    class name, and `addNumbers` is the method name:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        CREATE FUNCTION add(val1 int, val2 int)
            RETURNS integer
            LANGUAGE JAVA
            PARAMETER STYLE JAVA
            NO SQL
            EXTERNAL NAME 'com.splicemachine.cs.function.Functions.addNumbers';
    {: .Example xml:space="preserve"}

    </div>

3.  Store your compiled Jar file and update your CLASSPATH
    {: .topLevel}

    Follow the instructions in the [Storing and Updating Functions and
    Stored Procedures](developers_fcnsandprocs_storing.html) topic in
    this section to:
    {: .indentLevel1}

    * <span class="PlainFont">store your Jar file</span>
    * <span class="PlainFont">update the class path so that Splice Machine can find your code
      when the function is called.</span>

    Invoke your function
    {: .topLevel}

    You can invoke functions just like you would call any built-in
    database function. For example, if you're using the Splice Machine
    command line interface (*CLI*), and have created a function named
    `add`, you could use a statement like the following:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        SELECT add(1,2) FROM SYS.SYSTABLES;
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
### Writing a Function in Python {#PythonFcn}
Follow the steps below to write a Splice Machine database function in Python.

Creating functions in Python is currently a __Beta Release__ feature; it will become generally available in a future release.
{: .noteIcon}

<div class="opsStepsList" markdown="1">
1.  Define a Python script as a function in your database:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        CREATE FUNCTION SPLICE.PYSAMPLE_FUNC( a VARCHAR(50) )
          RETURNS VARCHAR(50)
          PARAMETER STYLE JAVA
          READS SQL DATA
          SQL LANGUAGE PYTHON
          AS ' def run(inputStr):
                import re
                result = inputStr.strip().split(",")[0]
                return result ';
    {: .Example xml:space="preserve"}

    </div>

    You can find the complete syntax for [`CREATE FUNCTION`](sqlref_statements_createfunction.html) in the
    *Splice Machine SQL Reference* manual.
    {: .indentLevel1}

2.  Invoke your function
    {: .topLevel}

    You can invoke functions just like you would call any built-in
    database function. For example, you could use the above sample function as follows:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        splice> VALUES SPLICE.PYSAMPLE_FUNC('Splice,Machine');

        1
        -----------------------------------------------------
        Splice
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>

## Writing a Stored Procedure in Splice Machine   {#CreatingStoredProc}
This section includes these subsections:

* [Writing a Stored Procedure in JAVA](#JavaProc)
* [Writing a Stored Procedure in Python](#PythonProc)

### Writing a Stored Procedure in JAVA {#JavaProc}
Follow the steps below to write a stored procedure in Java.

<div class="opsStepsList" markdown="1">
1.  Write your custom stored procedure:
    {: .topLevel}

    Here is a very simple stored procedure that uses JDBC:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        package org.splicetest.customprocs;
        import java.sql.Connection;
        import java.sql.DriverManager;
        import java.sql.PreparedStatement;
        import java.sql.ResultSet;
        import java.sql.SQLException;


        /**
         * This class contains custom stored procedures that will be dynamically loaded into the Splice Machine
         * database with the SQLJ jar file loading system procedures.
         *
         * @author Splice Machine
         */


        public class CustomSpliceProcs {
         /**
          * Return the names for all tables in the database.
          *
          * @param rs    result set containing names of all the tables in the database
          */

           public static void GET_TABLE_NAMES(ResultSet[] rs)
        	 throws SQLException
           {
        	Connection conn = DriverManager.getConnection("jdbc:default:connection");
        	PreparedStatement pstmt = conn.prepareStatement("select * from sys.systables");
        	rs[0] = pstmt.executeQuery();
        	conn.close();
           }
        }
    {: .Example}

    </div>

    You can use any Java IDE or text edit to write your code.
    {: .indentLevel1}

    You can find additional examples in the [Functions and Stored
    Procedure Examples](developers_fcnsandprocs_examples.html) topic in
    this section.
    {: .indentLevel1}

    See the information about [working with ResultSets](#ResultSet) in
    the next section.
    {: .noteNote}

2.  Compile your code and build a Jar file
    {: .topLevel}

    You now need to compile your stored procedure and build a jar file
    for it.
    {: .indentLevel1}

    You can use any Java IDE or build tool, such as *Maven* or *Ant*, to
    accomplish this. Alternatively, you can use the *javac* Java
    compiler and the *Java Archive* tool packaged with the JDK.
    {: .indentLevel1}

3.  Copy the Jar file to a cluster node
    {: .topLevel}

    Next, copy your custom Jar file to a region server (any node running
    an HBase region server) in your Splice Machine cluster. You can copy
    the file anywhere that allows the splice&gt; interface to access it.
    {: .indentLevel1}

    You can use any remote copying tool, such as scp or ftp. For
    example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        scp custom-splice-procs-1.0.2-SNAPSHOT.jar splice@myServer:myDir
    {: .AppCommand xml:space="preserve"}

    </div>

    See the [Storing and Updating Functions and Stored
    Procedures](developers_fcnsandprocs_storing.html) topic in this
    section for more information.
    {: .indentLevel1}

4.  Deploy the Jar file to your cluster
    {: .topLevel}

    Deploying the Jar file requires you to install the file in your
    database, and to add it to your database's `CLASSPATH`. You can
    accomplish both of these steps by calling built-in system procedures
    from the <span class="AppCommand">splice&gt;</span> command line
    interpreter. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        CALL SQLJ.INSTALL_JAR(
          '/Users/splice/my-directory-for-jar-files/custom-splice-procs-{% if site.build_type  == "doc" %}{{site.build_version}}{% else %}{{splvar_basic_InternalReleaseVersion}}{% endif %}-SNAPSHOT.jar',
          'SPLICE.CUSTOM_SPLICE_PROCS_JAR', 0);

        CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY(
        'derby.database.classpath', 'SPLICE.CUSTOM_SPLICE_PROCS_JAR');
    {: .AppCommand xml:space="preserve"}

    </div>

    The &nbsp;[`SQLJ.INSTALL_JAR`](sqlref_sysprocs_installjar.html) system
    procedure uploads the jar file from the local file system where
    <span class="AppCommand">splice&gt;</span> is executing into the
    HDFS:
    {: .indentLevel1}

    * <span class="PlainFont">If you are running a cluster, the Jar files are stored under the
      `/hbase/splicedb/jar` directory in HDFS (or MapR-FS).</span>
    * <span class="PlainFont">If you are running in standalone mode, the Jar files are stored on
      the local file system under the `splicedb/jar` directory in the
      Splice install directory.</span>

5.  Register your stored procedure with Splice Machine
    {: .topLevel}

    Register your stored procedure with the database by calling the
   &nbsp;[`CREATE PROCEDURE`](sqlref_statements_createprocedure.html)
    statement. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        CREATE PROCEDURE SPLICE.GET_TABLE_NAMES()
           PARAMETER STYLE JAVA
           READS SQL DATA
           LANGUAGE JAVA
           DYNAMIC RESULT SETS 1
           EXTERNAL NAME 'org.splicetest.customprocs.CustomSpliceProcs.GET_TABLE_NAMES';
    {: .AppCommand xml:space="preserve"}

    </div>

    Note that after running the above `CREATE PROCEDURE` statement, your
    procedure will show up in the list of available procedures when you
    run the Splice Machine <span class="AppCommand">show
    procedures</span> command.
    {: .indentLevel1}

    You can find the complete syntax for
   &nbsp;[`CREATE PROCEDURE`](sqlref_statements_createprocedure.html) in the
    *Splice Machine SQL Reference* manual.
    {: .indentLevel1}

6. See [Running Your Stored Procedure](#runningProc) for information about running your stored procedure, and [Updating Your Stored Procedure](#updatingProc) for information about updating your stored procedure.
{: .boldFont}

</div>

### Writing a Stored Procedure in Python {#PythonProc}
Follow the steps below to write a stored procedure in Python. Please note the following Python-related version information:

* Creating functions in Python is currently a __Beta Release__ feature; it will become generally available in a future release.
* Our Python stored procedure implementation uses {{splvar_storedprocs_JythonVersion}}.
* Python scripts should be compatible with {{splvar_storedprocs_PythonVersion}}.
* The JDBC connection uses {{splvar_storedprocs_PythonDbApiVersion}}; it is implemented by [{{splvar_storedprocs_PythonJDBC}}]({{splvar_storedprocs_Python}}).

<div class="opsStepsList" markdown="1">
#### Specifying Your Script
When creating a Python stored procedure, include your Python script directly in the `CREATE PROCEDURE` statement. Here's a simple example:
{: .topLevel}

<div class="preWrapper" markdown="1">
    splice> CREATE PROCEDURE SPLICE.PYTHON_TEST (
        IN limit INT )
        PARAMETER STYLE JAVA
        LANGUAGE PYTHON
        DYNAMIC RESULT SETS 1
        READS SQL DATA
        AS ' def run(lim, res):
                c = conn.cursor()
                    # select alias and javaclassname columns from sys.sysaliases tables
                    # return them as a ResultSet
                stmt = "select alias, javaclassname from sys.sysaliases {limit ?}"
                c.executemany(stmt,[lim])
                d = c.description
                result = c.fetchall()
                    # construct the ResultSet and fill it into the ResultSet list res
                res[0] = factory.create([d,result])
                conn.commit()
                c.close()
                conn.close() ';
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

#### General Rules
Here are some important notes about your script:
{: .indentLevel1}
* The entire script must be enclosed in single quotes.
* Use double quotes (`"`) around strings within the script; if you must use single quote within the script, specify each as two single quotes (`''`).
* Use spaces instead of tabs within your scripts; the command line processor will convert tabs to a single space in your script, *even within a string.*
* Write the script under the `run` function.
* The arguments you specify for your script in the `CREATE PROCEDURE` statement should match the order specified in your method definition. Note that their names do not need to match.

#### Connecting to Your Database
The `conn` global variable provides a default connection to your database.

#### Restrictions
Transactional `auto-commit` cannot be enabled within SQL statements in your stored procedure; this is due to the fact that the SQL statements are executed via a nested connection.

#### Constructing and Returning ResultSets
If your procedure returns a `ResultSet`, you must specify the `ResultSet` as a final argument to your method; for example, `res` in this snippet:

<div class="preWrapper" markdown="1">
    def run(lim, res)
    ...
    d = c.description
    result = c.fetchall()
    res[0] = factory.create([d,result])
{: .Example}
</div>

You can use the pre-defined `create` function to construct the `ResultSet`. Access this function from the global variable `factory`, which is defined here:
    <div class="preWrapper" markdown="1">
        com.splicemachine.derby.impl.sql.pyprocedure.PyStoredProcedureResultSetFactory
    </div>

The `factory.create` function has the following syntax:
<div class="fcnWrapperWide" markdown="1">
    factory.create( description, resultRows)
{: .FcnSyntax xml:space="preserve"}
</div>

<div class="paramList" markdown="1">
description
{: .paramName}

A tuple containing these 7 values:
   * name
   * type code
   * display size
   * internal size
   * precision
   * scale
   * nullability
{: .paramDefnFirst}

resultRows
{: .paramName}

A list of all of the rows retrieved from the cursor of the result set. You can retrieve this list by calling the cursor's `fetchall` method.
</div>

#### Running and Updating Your Procedure
See [Running Your Stored Procedure](#runningProc) for information about running your stored procedure, and [Updating Your Stored Procedure](#updatingProc) for information about updating your stored procedure.
</div>

## Running Your Stored Procedure {#runningProc}
You can run your stored procedure by calling it from the <span
class="AppCommand">splice&gt;</span> prompt. For example:

<div class="preWrapper" markdown="1">
    splice> call SPLICE.GET_TABLE_NAMES();
{: .AppCommand xml:space="preserve"}
</div>

<div class="preWrapper" markdown="1">
    splice> call SPLICE.PYTHON_TEST(5);
{: .AppCommand xml:space="preserve"}
</div>

## Updating Your Stored Procedure {#updatingProc}
If you make changes to your procedure's code, you need to create a
new Jar file and reload that into your database by calling the
`SQLJ.REPLACE_JAR` system procedure:

<div class="preWrapper" markdown="1">
    CALL SQLJ.REPLACE_JAR(
      '/Users/splice/my-directory-for-jar-files/custom-splice-procs-{% if site.build_type == "doc" %}{{site.build_version}}{% else %}{{splvar_basic_InternalReleaseVersion}}{% endif %}-SNAPSHOT.jar',
      'SPLICE.CUSTOM_SPLICE_PROCS_JAR');
{: .AppCommand xml:space="preserve"}

</div>

## Working with ResultSets   {#ResultSet}

Splice Machine follows the SQL-J part 1 standard for returning
`ResultSets` through Java procedures. Each `ResultSet` is returned
through one of the parameters passed to the java method. For example,
the `resultSet` parameter in the `MY_TEST_PROC` method in our
`ExampleStoredProcedure` class:

<div class="preWrapperWide" markdown="1">

    public class ExampleStoredProcedure {
       public static void MY_TEST_PROC(String myInput, ResultSet[] resultSet) throws SQLException {
         ...
       }
    }
{: .Example xml:space="preserve"}

</div>
Here are a set of things you should know about `ResultSets[]` in stored
procedures:

Although the &nbsp;[`CREATE PROCEDURE`](sqlref_statements_createprocedure.html) call allows you to specify the number of `DYNAMIC RESULT SETs`, we currently only support returning a single `ResultSet`.
{: .noteIcon}

* The `ResultSets` are returned in the order in which they were created.
* The `ResultSets` must be open and generated from the
  `jdbc:default:connection` default connection. Any other `ResultSets`
  are ignored.
* If you close the statement that created the `ResultSet` within the
  procedure's method, that closes the `ResultSet` you want. Instead, you
  can close the connection.
* The Splice Machine database engine itself creates the one element
  `ResultSet` arrays that hold the returned `ResultSets`.

</div>
</section>
