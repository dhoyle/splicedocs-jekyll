---
title: Connecting to Splice Machine with Python and JDBC
summary: Shows how to connect to your Splice Machine database with Python via our JDBC driver.
keywords: JDBC, Python, connect tutorial
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_connectjdbc_python.html
folder: Connecting/JDBCConnect
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with Python via JDBC

This topic shows you how to connect to a Splice Machine database using our JDBC driver with Python, using these steps:

You can read more about [our JDBC Driver here](tutorials_connectjdbc_intro.html). And you can download the driver from here: <a href="{{splvar_jdbc_dllink}}" target="_blank">{{splvar_jdbc_dllink}}.</a>
{: .notePlain}

<div class="opsStepsList" markdown="1">
1. Install the JayDeBeApi python library
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        $ pip install JayDeBeApi
    {: .ShellCommand xml:space="preserve"}
    </div>

2.  Start the Python interpreter
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        $ python
    {: .ShellCommand xml:space="preserve"}
    </div>

3.  Connect to a running instance of Splice Machine
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        >>> import jaydebeapi
        >>> conn = jaydebeapi.connect("com.splicemachine.db.jdbc.ClientDriver",
        "jdbc:splice://asdsaccount-qatest4.splicemachine-qa.io:1527/splicedb",
        {'user': "yourUserId", 'password': "yourPassword", 'ssl': "basic"},
        "/Users/admin/Downloads/db-client-2.6.1.1736.jar")
        >>> curs = conn.cursor()
        >>> curs.execute('select count(1) from sysvw.systablesview')
        >>> n = curs.fetchall()
        >>> n
        [(<jpype._jclass.java.lang.Long object at 0x11fd61ad0>,)]
        >>> int(n[0][0].value)
        43
    {: .AppCommand xml:space="preserve"}
    </div>
</div>
{: .boldFont}

</div>
</section>
