---
title: Integrating Apache Storm with Splice Machine
summary: A tutorial showing you how to use Apache Storm to insert data from a MySQL database into a Splice Machine database.
keywords: storm
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_storm.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Integrating Apache Storm with Splice Machine

This topic walks you through building and running two different examples
of integrating Storm with Splice Machine:

* [Inserting Random Values in Splice Machine with Storm](#Insertin)
* [Inserting Data into Splice Machine from MySQL](#Insertin2)

## Inserting Random Values in Splice Machine with Storm   {#Insertin}

This example iterates through a list of random words and numbers,
inserting the values into a Splice Machine database; follow along in
these steps:

<div class="opsStepsList" markdown="1">
1.  Download the Sample Code:
    {: .topLevel}
    
    Pull the code from our git repository:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        https://github.com/splicemachine/splice-community-sample-code/tree/master/tutorial-storm
    {: .Plain}
    
    </div>

2.  Check the prerequisites:
    {: .topLevel}
    
    You must be running Splice Machine 2.0 or later on the same machine
    on which you will run this example code. If Splice Machine is
    running on a different machine, you'll need to modify the `server`
    variable in the `SpliceDumperTopology.java` file; change it to the
    name of the server that is running Splice Machine.
    {: .indentLevel1}
    
    You also must have <span class="AppCommand">maven v.3.3.9</span> or
    later installed.
    {: .indentLevel1}

3.  Create the test table in Splice Machine:
    {: .topLevel}
    
    This example inserts data into a Splice Machine table named
    `testTable`. You need to create that table by entering this command
    at the <span class="AppCommand">splice&gt;</span> prompt:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        splice> CREATE TABLE testTable( word VARCHAR(100), number INT );
    {: .Example}
    
    </div>

4.  Compile the sample code:
    {: .topLevel}
    
    Compile the sample code with this command
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        % mvn clean compile dependency:copy-dependencies
    {: .ShellCommand}
    
    </div>

5.  Run the sample code:
    {: .topLevel}
    
    Follow these steps:
    {: .indentLevel1}
    
    1.  Make sure that Splice Machine is running and that you have
        created the `testTable` table.
    2.  Execute this script to run the program:
        
        <div class="preWrapperWide" markdown="1">
            % run-storm.sh
        {: .ShellCommand}
        
        </div>
    
    3.  Query `testTable` in Splice Machine to verify that it has been
        populated with random words and numbers:
        
        <div class="preWrapperWide" markdown="1">
            splice> select * from testTable;
        {: .AppCommand}
        
        </div>
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
### About the Sample Code Classes

The random insertion example contains the following java classes, each
of which is described below:

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Class</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>SpliceCommunicator.java</code></td>
                        <td>Contains methods for communicating with Splice Machine.</td>
                    </tr>
                    <tr>
                        <td><code>SpliceConnector.java</code></td>
                        <td>Establishes a JDBC connection with Splice Machine.</td>
                    </tr>
                    <tr>
                        <td><code>SpliceDumperBolt.java</code></td>
                        <td>Dumps data into Splice Machine.</td>
                    </tr>
                    <tr>
                        <td><code>SpliceDumperTopology.java</code></td>
                        <td>Defines the Storm topology for this example.</td>
                    </tr>
                    <tr>
                        <td><code>SpliceIntegerSpout.java</code></td>
                        <td>Emits tuples that are inserted into the Splice Machine table.</td>
                    </tr>
                </tbody>
            </table>
## Inserting Data into Splice Machine from MySQL   {#Insertin2}

This example uses Storm to read data from a MySQL database, and insert
that data into a table in Splice Machine.

<div class="opsStepsList" markdown="1">
1.  Download the Sample Code:
    {: .topLevel}
    
    Pull the code from our git repository:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        https://github.com/splicemachine/splice-community-sample-code/tree/master/tutorial-storm
    {: .Plain}
    
    </div>

2.  Check the prerequisites:
    {: .topLevel}
    
    You must be running Splice Machine 2.0 or later on the same machine
    on which you will run this example code. If Splice Machine is
    running on a different machine, you'll need to modify the `server`
    variable in the `MySqlToSpliceTopology`.java file; change it to the
    name of the server that is running Splice Machine.
    {: .indentLevel1}
    
    You also must have <span class="AppCommand">maven v.3.3.9</span> or
    later installed.
    {: .indentLevel1}
    
    This example assumes that your MySQL database instance is running on
    the same machine on which you're running Splice Machine, and that
    the root user does not have a password. If either of these is not
    true, then you need to modify the call to the `seedBufferQueue`
    method in the `MySqlSpout.java` file. This method takes four
    parameters that you may need to change:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        seedBufferQueue( MySqlServer, MySqlDatabase, mySqlUserName, mySqlPassword );
    {: .Plain}
    
    </div>
    
    The default settings used in this example are:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        seedBufferQueue( "localhost", "test", "root", "" );
    {: .Plain}
    
    </div>

3.  Create the students table in Splice Machine:
    {: .topLevel}
    
    This example inserts data into a Splice Machine table named
    `students`. You need to create that table by entering this command
    at the <span class="AppCommand">splice&gt;</span> prompt:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        splice> CREATE TABLE students( name VARCHAR(100) );
    {: .Example}
    
    </div>

4.  Create the students table in your MySQL database:
    {: .topLevel}
    
    This example read data from a MySQL table named `students`. You need
    to create that table in MySQL:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        $$ CREATE TABLE students( id INTEGER, name VARCHAR(100) );
    {: .Example}
    
    </div>
    
    If your MySQL instance is on a different machine
    {: .indentLevel1}

5.  Compile the sample code:
    {: .topLevel}
    
    Compile the sample code with this command
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        % mvn clean compile dependency:copy-dependencies
    {: .ShellCommand}
    
    </div>

6.  Run the sample code:
    {: .topLevel}
    
    Follow these steps:
    {: .indentLevel1}
    
    1.  Make sure that Splice Machine is running and that you have
        created the `testTable` table.
    2.  Execute this script to run the program:
        
        <div class="preWrapperWide" markdown="1">
            % run-mysql-storm.sh
        {: .ShellCommand}
        
        </div>
    
    3.  Query the `students` table in Splice Machine to verify that it
        has been populated with data from the MySQL table:
        
        <div class="preWrapperWide" markdown="1">
            splice> select * from students;
        {: .AppCommand}
        
        </div>
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
### About the Sample Code Classes

This example contains the following java classes:

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Class</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>MySqlCommunicator.java</code></td>
                        <td>Contains methods for communicating with MySQL.</td>
                    </tr>
                    <tr>
                        <td><code>MySqlConnector.java</code></td>
                        <td>Establishes a JDBC connection with MySQL.</td>
                    </tr>
                    <tr>
                        <td><code>MySqlSpliceBolt.java</code></td>
                        <td>Dumps data from MySQL into Splice Machine.</td>
                    </tr>
                    <tr>
                        <td><code>MySqlSpout.java</code></td>
                        <td>Emits tuples from MySQL that are inserted into the Splice Machine table.</td>
                    </tr>
                    <tr>
                        <td><code>MySqlToSpliceTopology.java</code></td>
                        <td>Defines the Storm topology for this example.</td>
                    </tr>
                    <tr>
                        <td><code>SpliceCommunicator.java</code></td>
                        <td>Contains methods for communicating with Splice Machine.</td>
                    </tr>
                    <tr>
                        <td><code>SpliceConnector.java</code></td>
                        <td>Establishes a JDBC connection with Splice Machine.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

