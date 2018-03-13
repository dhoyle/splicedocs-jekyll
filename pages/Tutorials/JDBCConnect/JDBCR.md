---
title: Connecting to Splice Machine with R via JDBC
summary: Walks you through compiling and running a Scala program that connects to your Splice Machine database via our JDBC driver.
keywords: Scala, JDBC, connect tutorial
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connectjdbc_r.html
folder: Tutorials/JDBCConnect
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with R via JDBC

This topic shows you how to connect to a Splice Machine database using our JDBC driver with R, using the following steps.

The steps in this topi use *R Studio*, which is _not_ required.
{: .noteNote}

<div class="opsStepsList" markdown="1">
1.  Install R Studio (this is optional).
    {: .topLevel}

2.  Install these R packages:
    {: .topLevel}

    * RJDBC
    * rJava

3.  Install any dependencies required as a result of installing the packages.
    {: .topLevel}

4.  Access the Splice Machine JDBC Jar file:
    {: .topLevel}

    * If you're using our Database-as-Service product, you can download the JAR file by clicking the <span class="ConsoleLink">Download JDBC Driver</span> link at the bottom of your *Cluster Details* screen; you'll find the same link in the email message that welcomed you to the Service.
    * If you're using our On-Premise-Database product, you'll find the driver in your `splicemachine` directory.

    You'll need to specify the JAR file location in a subsequent step, so make sure you note where the JAR file is located. We'll refer to that location as `MyJDBCJarLoc`.
    {: .noteIcon}

5.  Find the JDBC URL you need to use to connect to Splice Machine
    {: .topLevel}

    * If you're using our Database-as-Service product, you can copy the `JDBC-URL` at the bottom of your *Cluster Details* screen, or from the email message that welcomed you to the Service.
    * If you're working with the standalone version of Splice Machine, the link you use is typically: `jdbc:splice://localhost:1527/splicedb`

6.  Run this snippet of R code to verify connectivity:

    <div class="preWrapperWide" markdown="1">
        library(RJDBC)

        vDriver <- JDBC(driverClass="com.splicemachine.db.jdbc.ClientDriver",
        classPath="MyJDBCJarLoc/splice.jdbc.jar")
        db  <- dbConnect(vDriver, "jdbc:splice://localhost:1527/splicedb", "splice", "admin")
        sql <- "select * from SCHEMA.TABLE"
        df1 <- dbGetQuery(db, sql)

        print (df1)
    {: .AppCommand xml:space="preserve"}
    </div>

7.  If you can't connect, follow the [troubleshooting](#Troubleshoot) steps below.

</div>
{: .boldFont}

## Troubleshooting {#Troubleshoot}

If you're unable to connect, we suggest that you try the following:

<div class="opsStepsList" markdown="1">

1.  Follow our quick instructions for [installing DB Visualizer](tutorials_connect_dbvisualizer.html) and creating a JDBC connection from DB Visualizer to Splice Machine.
    {: .topLevel}

2.  Verify that DB Visualizer can connect to your database.
    {: .topLevel}

3.  Re-run the snippet of R code using the JDBC URL, Username, and Password that worked with DB Visualizer.
    {: .topLevel}

</div>
{: .boldFont}

</div>
</section>
