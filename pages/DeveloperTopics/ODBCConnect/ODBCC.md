---
title: Connecting to Splice Machine with C and ODBC
summary: Walks you through compiling and running a C program that connects to your Splice Machine database via our ODBC driver.&#xA;
keywords: ODBC, C, connect tutorial
toc: false
product: all
sidebar: developers_sidebar
permalink: tutorials_connect_odbcc.html
folder: DeveloperTopics/ODBCConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with C and ODBC

This topic shows you how to compile and run a sample C program that
exercises the Splice Machine ODBC driver. The `listODBCdriver` program
verifies that the driver is correctly installed and available.

## Compile and Run the Sample Program   {#Compile}

This section walks you through compiling and running the
`listODBCdriver` example program, which simply displays information
about the installed driver.

<div class="opsStepsList" markdown="1">
1.  Install the ODBC driver
    {: .topLevel}

    [Follow our instructions](tutorials_connect_odbcinstall.html) for
    installing the driver on Unix or Windows.
    {: .indentLevel1}

2.  Copy the example program code
    {: .topLevel}

    You can copy and paste the code below:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        #include <stdio.h>
        #include <sql.h>
        #include <sqlext.h>

        main() {
           SQLHENV env;
           char driver[256];
           char attr[256];
           SQLSMALLINT driver_ret;
           SQLSMALLINT attr_ret;
           SQLUSMALLINT direction;
           SQLRETURN ret;

           SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
           SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *) SQL_OV_ODBC3, 0);

           direction = SQL_FETCH_FIRST;
           while(SQL_SUCCEEDED(ret = SQLDrivers(env, direction,
                 driver, sizeof(driver), &driver_ret,
                 attr, sizeof(attr), &attr_ret))) {
                 direction = SQL_FETCH_NEXT;
              printf("%s - %s\n", driver, attr);
              if (ret == SQL_SUCCESS_WITH_INFO) printf("\tdata truncation\n");
              }
        }
    {: .Example}

    </div>

3.  Compile it
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">

        #!/bin/bash
        # gcc -I /usr/local/splice/unixODBC/include listODBCdriver.c -o listODBCdriver -L/usr/local/splice/lib -lodbc -lodbcinst -lodbccr
    {: .ShellCommand}

    </div>

4.  Run the program
    {: .topLevel}

    Run the compiled `listODBCdriver`:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        prompt:~$ ./listODBCdriver
    {: .ShellCommand xml:space="preserve"}

    </div>

    The command should display a result like the following:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        Splice Machine - Description=Splice Machine ODBC Driver
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
</div>
</section>
