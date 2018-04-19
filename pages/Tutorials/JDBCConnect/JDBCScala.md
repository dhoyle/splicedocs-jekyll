---
title: Connecting to Splice Machine with Scala and JDBC
summary: Walks you through compiling and running a Scala program that connects to your Splice Machine database via our JDBC driver.
keywords: Scala, JDBC, connect tutorial
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_scala.html
folder: Tutorials/JDBCConnect
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with Scala and JDBC

This topic shows you how to compile and run a sample Scala program that
connects to Splice Machine using our JDBC driver. The
`SampleScalaJDBC` program does the following:

* connects to a standalone (`localhost`) version of Splice Machine
* creates a table named `MYTESTTABLE`
* inserts several sample records
* selects and displays records from one of the system tables

## Compile and Run the Sample Program   {#Compile}

This section walks you through compiling and running the
`SampleScalaJDBC` example program, in the following steps:

<div class="opsStepsList" markdown="1">
1.  Add the Splice client jar to your `CLASSPATH`; for example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">

        export CLASSPATH=/splicemachine/jdbc-driver/{{splvar_jdbc_jarloc}}
    {: .ShellCommand xml:space="preserve"}

    </div>

2.  Copy the example program code:
    {: .topLevel}

    You can copy and paste the code below; note that this example uses
    our default connectivity parameters (database, user, URL, and
    password values):
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        package com.splicemachine.tutorials.jdbc

        import java.sql.DriverManager
        import java.sql.Connection

        /**
         *  Simple example of Establishes a connection with splice and executes statements
         */
        object SampleScalaJDBC{

        	def main(args: Array[String]) {

        		// connect to the database named "splicedb" on the localhost
        		val driver = "com.splicemachine.db.jdbc.ClientDriver"
        		val dbUrl = "jdbc:splice://localhost:1527/splicedb;user=YourUserId;password=YourPassword"

        		var connection:Connection = null

        		try {

        			// make the connection
        			Class.forName(driver)
        			connection = DriverManager.getConnection(dbUrl)

        			// create the statement
        			var statement = connection.createStatement()

        			//Create a table
        			statement.execute("CREATE TABLE MYTESTTABLE(a int, b varchar(30))");
        			statement.close

        			//Insert data into the table
        			var pst = connection.prepareStatement("insert into MYTESTTABLE (a,b)  values (?,?)")

        			pst.setInt (1, 1)
        			pst.setString (2, "a")
        			pst.executeUpdate()

        			pst.clearParameters()
        			pst.setInt (1, 2)
        			pst.setString (2, "b")
        			pst.executeUpdate()

        			pst.clearParameters()
        			pst.setInt (1, 3)
        			pst.setString (2, "c")
        			pst.executeUpdate()

        			pst.clearParameters()
        			pst.setInt (1, 4)
        			pst.setString (2, "c")
        			pst.executeUpdate()

        			pst.clearParameters()
        			pst.setInt (1, 5)
        			pst.setString (2, "c")
        			pst.executeUpdate()

        			pst.close

        			//Read the data
        			statement = connection.createStatement()
        			val resultSet = statement.executeQuery("select a, b from MYTESTTABLE")
        			var counter =0

        			while ( resultSet.next() ) {
        				counter += 1
        				val val_a = resultSet.getInt(1)
        				val val_b = resultSet.getString(2)
        				println("record=[" + counter + "] a=[" + val_a + "] b=[" +val_b + "]")
        			}
        			resultSet.close()
        			statement.close()
        		} catch {
        			case ex : java.sql.SQLException => println("SQLException: "+ex)
        		} finally {
        			connection.close()
        		}
        	}

        }
    {: .Example}

    </div>

3.  Save the code to `SampleScalaJDBC.scala`.
    {: .topLevel}

4.  Compile the program:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        scalac SampleScalaJDBC.scala
    {: .ShellCommand xml:space="preserve"}

    </div>

5.  Run the program:
    {: .topLevel}

    Run the `SampleScalaJDBC` program as follows:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        scala SampleScalaJDBC
    {: .ShellCommand xml:space="preserve"}

    </div>

    The command should display a result like the following:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        record=[1] a=[5] b=[c]
        record=[2] a=[1] b=[a]
        record=[3] a=[2] b=[b]
        record=[4] a=[3] b=[c]
        record=[5] a=[4] b=[c]
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>
