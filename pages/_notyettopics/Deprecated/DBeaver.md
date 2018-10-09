---
title: Connecting DBeaver to Splice Machine
summary: How to configure a DBeaver connection to Splice Machine
keywords: dbeaver, connect tutorial
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_dbeaver.html
folder: DeveloperTutorials/BIConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting DBeaver with Splice Machine Using JDBC

This topic shows you how to connect DBeaver to Splice Machine using our
JDBC driver. To complete this tutorial, you need to:

* Have Splice Machine installed and running on your computer.
* Have DBeaver installed on your computer. You can download an installer
  and find directions on the DBeaver web site ([dbeaver.jkiss.org][1]{:
  target="_blank"}).

## Connect DBeaver with Splice Machine   {#Compile}

This section walks you through configuring DBeaver to connect
with Splice Machine

<div class="opsStepsList" markdown="1">
1.  Install DBeaver , if you've not already done so
    {: .topLevel}

    [Follow the instructions on the DBeaver web site][1]{:
    target="_blank"}.
    {: .indentLevel1}

2.  Start a Splice Machine session on the computer on which you have
    installed DBeaver
    {: .topLevel}

    Splice Machine must be running to create and use it with DBeaver .
    {: .indentLevel1}

3.  Configure a Splice Machine connection in DBeaver
    {: .topLevel}

    Follow the instructions in the next section, [Configure a DBeaver
    Connection for Splice Machine](#ConfiguringSquirrel), to create and
    test a new connection in DBeaver .
    {: .indentLevel1}

4.  Connect DBeaver to Splice Machine
    {: .topLevel}

    In DBeaver's *Database Navigator*, select the Splice Machine
    connection you configured. Your database will display, and you can
    inspect objects or enter SQL to interact with your data.
    {: .indentLevel1}

    ![](images/DBeaverSplice.png){: .nestedTightSpacing}
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure a DBeaver Connection for Splice Machine   {#ConfiguringSquirrel}

Follow these steps to configure and test a new driver and connection
alias in DBeaver .

<div class="opsStepsList" markdown="1">
1.  Start a Splice Machine session on the computer on which you have
    installed DBeaver

2.  Open the DBeaver application.

3.  Select <span class="AppCommand">Driver Manager</span> in the DBeaver
    *Database* menu, then click the <span class="AppCommand">New</span>
    button to create a new driver:
    {: .topLevel}

    1.  Specify values in the <span class="AppCommand">Create New
        Driver</span> form; these are the default values:

        <table>
                                            <col />
                                            <col />
                                            <thead>
                                                <tr>
                                                    <th>Field</th>
                                                    <th>Value</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class="AppFont">Driver Name:</td>
                                                    <td>Any name you choose</td>
                                                </tr>
                                                <tr>
                                                    <td class="AppFont">Class Name:</td>
                                                    <td><code>com.splicemachine.db.jdbc.ClientDriver</code></td>
                                                </tr>
                                                <tr>
                                                    <td class="AppFont">URL Template:</td>
                                                    <td><code>jdbc:splice://{host}:{port}/splicedb;create=false</code></td>
                                                </tr>
                                                <tr>
                                                    <td class="AppFont">Default Port:</td>
                                                    <td><code>1527</code></td>
                                                </tr>
                                                <tr>
                                                    <td class="AppFont">Description:</td>
                                                    <td>Any description you want to specify</td>
                                                </tr>
                                            </tbody>
                                        </table>

    2.  Click the <span class="AppCommand">Add File</span> button, then
        navigate to and select the Splice JDBC Driver jar file. which
        you'll find it in the `jdbc-driver` folder under the
        `splicemachine` directory on your computer.

        ![](images/DBeaverDriver.png){: .nestedTightSpacing}

        Instead of manually entering the <span class="AppCommand">Class
        Name</span> for your driver, you can click the <span
        class="AppCommand">Find Class</span> button to discover the
        driver class name associated with the file you've located.</span>
        {: .noteNote}

    {: .LowerAlphaPlainFont}

4.  Click <span class="AppCommand">OK</span> to save the driver entry
    and close the form.

5.  Select <span class="AppCommand">New Connection</span> in the DBeaver
    *Database* menu, then follow these steps to create a new connection
    that uses our driver:
    {: .topLevel}

    1.  Scroll through the connection type list and select the
        Splice Machine JDBC driver that you just created, then click the
        <span class="AppCommand">Next</span> button:

        ![](images/DBeaverConnection1.png){: .nestedTightSpacing}

    2.  Several of the fields in the *Generic JDBC Connection Settings*
        screen were pre-populated for you when you selected the driver.
        You need to fill in the <span class="AppCommand">User
        name:</span> and <span
        class="AppCommand">Password:</span> fields with your user ID and password:

        ![](images/DBeaverConnection2.png){: .nestedTightSpacing}

    3.  Click the <span class="AppCommand">Test Connection</span> button
        to verify your connection.

        Splice Machine must be running on your computer for the
        connection test to succeed.
        {: .noteNote}

    4.  Click the <span class="AppCommand">Next</span> button to reveal
        the network configuration screen. If you have VPN requirements,
        enter the appropriate information in this screen; if not, simply
        click the <span class="AppCommand">Next</span> button again.

        ![](images/DBeaverConnection3.png){: .nestedTightSpacing}

    5.  You can optionally modify any settings in the *Finish connection
        creation* screen; then click the <span
        class="AppCommand">Finish</span> button to save your new
        connection.

        ![](images/DBeaverFinishConnection.png){: .nestedTightSpacing}
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
</div>
</section>



[1]: http://dbeaver.jkiss.org/
