---
title: Connecting to Splice Machine with Python and ODBC
summary: Walks you through compiling and running a Python program that connects to your Splice Machine database via our ODBC driver.
keywords: ODBC, Python, connect tutorial
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_connect_python.html
folder: Connecting/ODBCConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with Python and ODBC

This topic shows you how to compile and run a sample Python program that
connects to Splice Machine using our ODBC driver. The
`SpliceODBCConnect.py` program does the following:

* connects to a standalone (`localhost`) version of Splice Machine
* retrieves and displays records from several system tables
* creates a tables inserts several sample records into it
* selects and aggregates records from the new table

## Compile and Run the Sample Program   {#Compile}

This section walks you through compiling and running the
`SpliceODBCConnect.py` example program, in the following steps:

<div class="opsStepsList" markdown="1">
1.  Install the Splice Machine ODBC driver
    {: .topLevel}

    [Follow our instructions](tutorials_connect_odbcinstall.html) for
    installing the driver on Unix or Windows.
    {: .indentLevel1}

2.  Install the pyodbc module
    {: .topLevel}

    You need to install the `pyodbc` open source Python module, which
    implements the DB API 2.0 specification and can be used with Python
    2.4 or higher. See [https://github.com/mkleehammer/pyodbc][1]{:
    target="_blank"} for more information about this module.
    {: .indentLevel1}

    To install pyodbc on the server on which you'll be running your job:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        yum install gcc-c++pip install pyodbc
    {: .ShellCommand xml:space="preserve"}

    </div>

3.  Confirm that you can connect
    {: .topLevel}

    To confirm that you're ready to use the ODBC driver, launch the
    python shell and enter the following commands, replacing <span
    class="HighlightedCode">SpliceODBC64</span> with the name of your
    data source (which is found in the `odbc.ini` file that you edited
    when installing our ODBC driver):
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        import pyodbc
        cnxn = pyodbc.connect("DSN=SpliceODBC64")
        cursor = cnxn.cursor()
        cursor.execute("select * from SYS.SYSTABLES")
        row = cursor.fetchone()
        print('row:',row)
    {: .Example}

    </div>

4.  Copy the example program code:
    {: .topLevel}

    You can copy and paste the code below:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        #!/usr/bin/python

        # This program is used to demonstrate connecting to Splice Machine using ODBC

        import pyodbc

        #Connect to Splice Machine using an Datasource
        cnxn = pyodbc.connect("DSN=SpliceODBC64")

        #Open a cursor
        cursor = cnxn.cursor()

        #Build a select statement
        cursor.execute("select * from SYS.SYSTABLES")

        #Fetch one record from the select
        row = cursor.fetchone()

        #If there is a record, print it
        if row:
                print(row)

        #The following will continue to retrieve one record at a time from the resultset
        while 1:
                row = cursor.fetchone()
                if not row:
                        break
                print('table name:', row.TABLENAME)

        #The following is an example of using the fetchall option, instead of retrieving one record at time
        cursor.execute("select * from SYS.SYSSCHEMAS")
        rows = cursor.fetchall()
        for row in rows:
                print(row.SCHEMAID, row.SCHEMANAME)


        #Create a table
        cursor.execute("CREATE TABLE MYPYTHONTABLE(a int, b varchar(30))")

        #Insert data into the table
        cursor.execute("insert into MYPYTHONTABLE values (1,'a')");
        cursor.execute("insert into MYPYTHONTABLE values (2,'b')");
        cursor.execute("insert into MYPYTHONTABLE values (3,'c')");
        cursor.execute("insert into MYPYTHONTABLE values (4,'c')");
        cursor.execute("insert into MYPYTHONTABLE values (5,'c')");

        #Commit the creation of the table
        cnxn.commit();

        #Confirm the records are in the table
        row = cursor.execute("select count(1) as TOTAL from SPLICE.MYPYTHONTABLE").fetchone()
        print(row.TOTAL)
    {: .Example}

    </div>

5.  Save the code to `SpliceODBCConnect.py`.
    {: .topLevel}

6.  Run the program:
    {: .topLevel}

    Run the `SpliceODBCConnect.py` program as follows:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        python ./SpliceODBCConnect.py
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>



[1]: https://github.com/mkleehammer/pyodbc
