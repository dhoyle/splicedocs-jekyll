---
title: Connecting Tableau to Splice Machine
summary: How to configure a Tableau connection to Splice Machine
keywords: tableau, connect tutorial, odbc
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_connect_tableau.html
folder: Connecting/BIConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting Tableau with Splice Machine Using ODBC

This topic shows you how to connect Tableau to Splice Machine using our
ODBC driver. To complete this tutorial, you need to:

* Have Tableau installed on your Windows or MacOS computer. You can find
  directions on the Tableau web site ([www.tableau.com][1]{:
  target="_blank"}); you can also download a free trial version of
  Tableau from there.
* Have the Splice Machine ODBC driver installed on your computer. Follow
  the instructions in our Developer's Guide.

{% include splicevars.html %}

You can read more about [our JDBC Driver here](tutorials_connectjdbc_intro.html). And you can download the driver from here: <a href="{{splvar_jdbc_dllink}}" target="_blank">{{splvar_jdbc_dllink}}.</a>
{: .notePlain}


## Connect Tableau with Splice Machine   {#Compile}

This section walks you through configuring Tableau on a Windows PC to
connect with Splice Machine using our ODBC driver.

<div class="opsStepsList" markdown="1">
1.  Install Tableau, if you've not already done so
    {: .topLevel}

    [Follow the instructions on the Tableau web site][1]{:
    target="_blank"}.
    {: .indentLevel1}

2.  Install the Splice Machine ODBC driver
    {: .topLevel}

    [Follow our instructions](tutorials_connect_odbcinstall.html) for
    installing the driver on Unix or Windows. This includes instructions
    for setting up your data source (DSN), which we'll use with Tableau.
    {: .indentLevel1}

3.  Connect from Tableau:
    {: .topLevel}

    Follow these steps to connect to your data source in Tableau:
    {: .indentLevel1}

    1.  Open the list of connections:

        Click <span class="AppCommand">Connect to Data</span> on
        Tableau's opening screen to reveal the list of possible data
        connections.
        {: .indentLevel1}

    2.  Select ODBC:

        Scroll to the bottom of the <span class="AppCommand">To a
        server</span> list, click More Servers, then click <span
        class="AppCommand">Other Databases (ODBC)</span>.
        {: .indentLevel1}

    3.  Select your DSN and connect:

        Select the DSN you just created (typically named Splice Machine)
        when installing our ODBC driver) from the drop-down list, and
        then click the <span class="AppCommand">Connect</span> button.
        {: .indentLevel1}

    4.  Select the schema:

        Select the schema you want to work with (`splice`), and then
        select the <span class="AppCommand">Single Table</span> option.
        {: .indentLevel1}

    5.  Select the table to view:

        Click the search (magnifying glass) icon, and then select the
        table you want to view from the drop-down list.
        {: .indentLevel1}

        For example, we choose the <span
        class="AppCommand">CUSTOMERS</span> table and specify <span
        class="AppCommand">CUSTOMERS (SPLICE)</span> as the connection
        name for use in Tableau.
        {: .indentLevel1}
    {: .LowerAlphaPlainFont}

4.  After you click <span class="AppCommand">OK</span>, *Tableau* is
    ready to work with your data.
    {: .topLevel}
{: .boldFont}

</div>
</div>
</section>



[1]: https://www.tableau.com/
