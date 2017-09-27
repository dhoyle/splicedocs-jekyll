---
title: Connecting to Splice Machine with Java and JDBC
summary: Walks you through compiling and running a Java program that connects to your Splice Machine database via our JDBC driver.&#xA;
keywords: Java, JDBC, connect tutorial, java jdbc, jdbc java
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_java.html
folder: Tutorials/Connect
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with Java and JDBC

This topic shows you how to compile and run a sample Java program that
connects to Splice Machine using our JDBC driver. The
`SampleJDBC` program does the following:

* connects to a standalone (`localhost`) version of Splice Machine
* creates a table named `MYTESTTABLE`
* inserts several sample records
* issues a query to retrieve those records

[Follow the written directions below](#Compile), which includes the raw
code for the `SampleJDBC` example program.

## Compile and Run the Sample Program   {#Compile}

This section walks you through compiling and running the
`SampleJDBC` example program, in the following steps:

<div class="opsStepsList" markdown="1">
1.  Locate the Splice Machine JDBC Driver:
    {: .topLevel}
    
    Our JDBC driver is automatically installed on your computer(s) when
    you install Splice Machine. You'll find it in the <span
    class="CodeFont">jdbc-driver</span> folder under the `splicemachine`
    directory; typically:
    {: .indentLevel1}
    
    <div class="PreWrapperWide" markdown="1">
        /splicemachine/jdbc-driver/{{splvar_location_JDBCDriverJar260}}
    {: .Example}
    
    </div>
    
    \- or -
    
    <div class="PreWrapperWide" markdown="1">
        /splicemachine/jdbc-driver/{{splvar_location_JDBCDriverJar250}}
    {: .Example}
    
    </div>
    
    The build number, e.g. `1729`, varies with each Splice Machine
    software update.
    {: .noteNote}

2.  Copy the example program code:
    {: .topLevel}
    
    You can copy and paste the code below:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        package com.splicemachine.cs.tools
        
        import java.sql.*;
        
        /**
        * Simple example that establishes a connection with splice and does a few basic JDBC operations
        */
        public class SampleJDBC {
        public static void main(String[] arg) {
        	//JDBC Connection String - sample connects to local database
        	String dbUrl = "jdbc:splice://localhost:1527/splicedb;user=splice;password=admin";
        	try{
        		//For the JDBC Driver - Use the Apache Derby Client Driver
        		Class.forName("com.splicemachine.db.jdbc.ClientDriver");
        	}catch(ClassNotFoundException cne){
        		cne.printStackTrace();
        		return; //exit early if we can't find the driver
        	}
        
        	try(Connection conn = DriverManager.getConnection(dbUrl)){
        		//Create a statement
        		try(Statement statement = conn.createStatement()){
        
        			//Create a table
        			statement.execute("CREATE TABLE MYTESTTABLE(a int, b varchar(30))");
        
        			//Insert data into the table
        			statement.execute("insert into MYTESTTABLE values (1,'a')");
        			statement.execute("insert into MYTESTTABLE values (2,'b')");
        			statement.execute("insert into MYTESTTABLE values (3,'c')");
        			statement.execute("insert into MYTESTTABLE values (4,'c')");
        			statement.execute("insert into MYTESTTABLE values (5,'c')");
        
        			int counter=0;
        			//Execute a Query
        			try(ResultSet rs=statement.executeQuery("select a, b from MYTESTTABLE")){
        				while(rs.next()){
        					counter++;
        					int val_a=rs.getInt(1);
        					String val_b=rs.getString(2);
        					System.out.println("record=["+counter+"] a=["+val_a+"] b=["+val_b+"]");
        				}
        			}
        		}
        
        	}catch (SQLException se) {
        		se.printStackTrace();
        	}
        }
    {: .Example}
    
    </div>
    
    Note that the code uses the default JDBC URL and driver class
    values:
    {: .spaceAbove}
    
    <table summary="Table of default Splice Machine connection parameters.">
                                <col />
                                <col />
                                <col />
                                <thead>
                                    <tr>
                                        <th>Connection Parameter</th>
                                        <th>Default Value</th>
                                        <th>Comments</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><em>JDBC URL</em></td>
                                        <td><code>jdbc:splice://<span class="Highlighted">&lt;hostname&gt;</span>:1527/splicedb</code></td>
                                        <td>
                                            <p class="noSpaceAbove">Use <code>localhost</code> as the <span class="HighlightedCode">&lt;hostname&gt;</span> value for the standalone version of Splice Machine.</p>
                                            <p>On a cluster, specify the IP address of an HBase RegionServer.</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><em>JDBC driver class</em></td>
                                        <td><code>com.splicemachine.db.jdbc.ClientDriver</code></td>
                                        <td> </td>
                                    </tr>
                                </tbody>
                            </table>

3.  Compile the code
    {: .topLevel}
    
    Compile and package the code into <span
    class="ShellCommand">splice-jdbc-test-0.1.0-SNAPSHOT.jar</span>.
    {: .indentLevel1}

4.  Run the program:
    {: .topLevel}
    
    When you run the program, your `CLASSPATH` must include the path to
    the Splice Machine JDBC driver. If you did compile and package your
    code into `splice-jdbc-test-0.1.0-SNAPSHOT.jar`, you can run the
    program with this command line:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        java -cp splice-installer-<platformVersion>/resources/jdbc-driver/{{splvar_platform_JDBCDriverJar}} com.splicemachine.cs.tools.SampleJDBC   
    {: .ShellCommand xml:space="preserve"}
    
    </div>
    
    The command should display a result like the following:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        
        record=[1] a=[1] b=[a]
        record=[2] a=[2] b=[b]
        record=[3] a=[3] b=[c]
        record=[4] a=[4] b=[c]
        record=[5] a=[5] b=[c]
    {: .ShellCommand xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
</div>
</section>

