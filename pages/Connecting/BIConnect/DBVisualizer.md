---
title: Connecting DBVisualizer to Splice Machine
summary: How to configure a DBVisualizer connection to Splice Machine
keywords: dbvisualizer, dbvis, connect tutorial, db visualizer
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_connect_dbvisualizer.html
folder: Connecting/BIConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting DBVisualizer with Splice Machine Using JDBC

This topic shows you how to connect DBVisualizer to Splice Machine using
our JDBC driver. To complete this tutorial, you need to:

* Have Splice Machine installed and running on your computer.
* Have DBVisualizer installed on your computer. You can find directions
  on the DBVisualizer web site ([https://www.dbvis.com][1]{:
  target="_blank"}); you can also download a free trial version of
  DBVisualizer from there.

{% include splicevars.html %}

You can read more about [our JDBC Driver here](tutorials_connectjdbc_intro.html). And you can download the driver from here: <a href="{{splvar_jdbc_dllink}}" target="_blank">{{splvar_jdbc_dllink}}.</a>
{: .notePlain}

## Connect DBVisualizer with Splice Machine   {#Compile}

This section walks you through configuring DBVisualizer to connect
with Splice Machine

<div class="opsStepsList" markdown="1">
1.  Install DBVisualizer, if you've not already done so
    {: .topLevel}

    [Follow the instructions on the DBVis web site][1]{:
    target="_blank"}.
    {: .indentLevel1}

2.  Configure a Splice Machine connection in DBVisualizer
    {: .topLevel}

    Follow the instructions in the next section, [Configure a
    DBVisualizer Connection for Splice Machine](#ConfiguringDBVis), to
    create and test a new connection in DBVisualizer.
    {: .indentLevel1}

3.  Connect DBVisualizer to Splice Machine
    {: .topLevel}

    In DBVisualizer, open the connection alias you created and click the
    <span class="AppCommand">Connect</span> button. Your database will
    display in DBVisualizer, and you can inspect objects or enter SQL to
    interact with your data.
    {: .indentLevel1}

    ![](images/DBVisSplice.png){: .nestedTightSpacing}
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure a DBVisualizer Connection for Splice Machine   {#ConfiguringDBVis}

Follow these steps to configure and test a new driver entry and
connection in DBVisualizer.

<div class="opsStepsList" markdown="1">
1.  Start a Splice Machine session on the computer on which you have
    installed DBVisualizer.

2.  Open the DBVisualizer application.

3.  Use the Driver Manager to create a new DBVisualizer driver entry.
    {: .topLevel}

    Select <span class="AppCommand">Driver Manager</span> from the
    *Tools* menu; in the <span class="AppCommand">Driver Manager</span>
    screen:
    {: .indentLevel1}

    1.  Click the green plus sign <span class="AppFontCust">+</span>
        button to add a new driver entry.

    2.  Name the driver and enter
        `jdbc:splice://localhost:1527/splicedb` in the <span
        class="AppCommand">URL Format</span> field:

        ![](images/DBVis.Driver.png){: .nestedTightSpacing}

    3.  In the Driver File Paths section, click <span
        class="AppCommand">User Specified</span>, and then click the
        yellow folder icon.

    4.  Navigate to and select the Splice JDBC Driver jar file. which
        you'll find it in the `jdbc-driver` folder under the
        `splicemachine` directory on your computer.

    5.  Close the Driver Manager screen.
    {: .LowerAlphaPlainFont}

4.  Create a DBVisualizer connection alias that uses the new driver:
    {: .topLevel}

    1.  Select <span class="AppCommand">Create Database
        Connection</span> from the *Database* menu. If prompted about
        using the Wizard, click the <span class="AppCommand">No
        Wizard</span> button.

    2.  Name the connection (we use <span class="AppCommand">Splice
        Machine</span>), then click the empty field next to the <span
        class="AppCommand">Driver (JDBC)</span> caption and select the
        driver you just created:

        ![](images/DBVisSelectDriver.png){: .nestedTightSpacing}

    3.  Enter the following URL into the <span
        class="AppCommand">Database URL</span> field that appears once
        you've selected the driver:

        <div class="preWrapperWide" markdown="1">
            jdbc:splice://localhost:1527/splicedb
        {: .AppCommand}

        </div>

        Use <span class="CodeBoldFont">localhost:1527</span> with the
        standalone (local computer) version of splicemachine. If you're
        running Splice Machine on a cluster, substitute the address of
        your server for `localhost`; for example:
           <span
        class="CodeBoldFont">jdbc:splice://mySrv123cba:1527/splicedb</span>.
        {: .noteIcon}

    4.  Fill in the <span class="AppCommand">Userid</span>
        and <span class="AppCommand">Password</span>
        fields with your user Id and password. Then click the <span
        class="AppCommand">Connect</span> button. Your Splice Machine
        database will now display in DBVisualizer.
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
</div>
</section>



[1]: https://www.dbvis.com/
