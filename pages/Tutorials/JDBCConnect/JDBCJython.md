---
title: Connecting to Splice Machine with Jython and JDBC
summary: Walks you through compiling and running a Jython program that connects to your Splice Machine database via our JDBC driver.
keywords: JDBC, Jython, connect tutorial
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_jython.html
folder: Tutorials/Import
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with Jython and JDBC

This topic shows you how to compile and run a sample Jython program that
connects to Splice Machine using our JDBC driver. The
`print_tables` program does the following:

* connects to a standalone (`localhost`) version of Splice Machine
* selects and displays records from one of the system tables

## Compile and Run the Sample Program   {#Compile}

This section walks you through compiling and running the
`print_tables` example program, in the following steps:

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
        from java.sql import DriverManager
        from java.lang import Class
        from java.util import Properties

        url    = 'jdbc:splice://localhost:1527/splicedb'
        driver = 'com.splicemachine.db.jdbc.ClientDriver'
        props  = Properties()
        props.setProperty('user', 'splice')
        props.setProperty('password', 'admin')
        jcc    = Class.forName(driver).newInstance()
        conn   = DriverManager.getConnection(url, props)
        stmt   = conn.createStatement()
        rs     = stmt.executeQuery("select * from sys.systables")

        rowCount = 0
        while (rs.next() and rowCount < 10) :
            rowCount += 1
            print "Record=[" + str(rowCount) + \"]
                id   = [" + rs.getString('TABLEID') + \"]
                name = [" + rs.getString('TABLENAME') + \"]
                type = [" + rs.getString('TABLETYPE') + "]"

        rs.close()
        stmt.close()
        conn.close()
    {: .Example}

    </div>

3.  Save the code to `print_files.jy`.
    {: .topLevel}

4.  Run the program:
    {: .topLevel}

    Run the `print_tables.jy` program as follows:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        jython print_tables.jy
    {: .ShellCommand xml:space="preserve"}

    </div>

    The command should display a result like the following:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        Record=[1] id=[f9f140e7-0144-fcd8-d703-00003cbfba48] name=[ASDAS] type=[T]
        Record=[2] id=[c934c123-0144-fcd8-d703-00003cbfba48] name=[DDC_NOTMAILABLE] type=[T]
        Record=[3] id=[dd5cc163-0144-fcd8-d703-00003cbfba48] name=[FRANK_EMCONT_20130430] type=[T]
        Record=[4] id=[f584c1a3-0144-fcd8-d703-00003cbfba48] name=[INACTIVE_QA] type=[T]
        Record=[5] id=[cfcc41df-0144-fcd8-d703-00003cbfba48] name=[NUM_GROOM4] type=[T]
        Record=[6] id=[6b7f4217-0144-fcd8-d703-00003cbfba48] name=[PP_LL_QA] type=[T]
        Record=[7] id=[ac154287-0144-fcd8-d703-00003cbfba48] name=[QUAL_BRANDS] type=[T]
        Record=[8] id=[d67d42c7-0144-fcd8-d703-00003cbfba48] name=[SCIENCE_CAT_QA] type=[T]
        Record=[9] id=[c1e0c303-0144-fcd8-d703-00003cbfba48] name=[TESTOUTPUT2] type=[T]
        Record=[10] id=[f408c343-0144-fcd8-d703-00003cbfba48] name=[UAC_1267_AVJ] type=[T]
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>
