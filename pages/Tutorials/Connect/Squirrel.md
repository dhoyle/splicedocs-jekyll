---
title: Connecting Squirrel to Splice Machine
summary: How to configure a Squirrel connection to Splice Machine
keywords: connect tutorial
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_squirrel.html
folder: Tutorials/Connect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting SQuirreL with Splice Machine Using JDBC

This topic shows you how to connect SQuirreL to Splice Machine using our
JDBC driver. To complete this tutorial, you need to:

* Have Splice Machine installed and running on your computer.
* Have SQuirreL installed on your computer. You can find directions on
  the SQuirreL web site ([http://squirrel-sql.sourceforge.net/][1]{:
  target="_blank"}); you can also download a free trial version of
  SQuirreL from there. You must also install the Derby plug-in for
  SQuirreL.

## Connect SQuirreL with Splice Machine   {#Compile}

This section walks you through configuring SQuirreL to connect
with Splice Machine

<div class="opsStepsList" markdown="1">
1.  Install SQuirreL, if you've not already done so:
    {: .topLevel}
    
    [Follow the instructions on the SQuirreL web site][1]{:
    target="_blank"}.
    {: .indentLevel1}

2.  Install the Derby plug-in for Squirrrel
    {: .topLevel}
    
    This plug-in is required to operate with Splice Machine. If you
    didn't select the Derby plug-in when you installed SQuirreL, you can
    download
    {: .indentLevel1}

3.  Start a Splice Machine session on the computer on which you have
    installed SQuirreL
    {: .topLevel}
    
    Splice Machine must be running to create and use it with SQuirreL.
    {: .indentLevel1}

4.  Configure a Splice Machine connection in SQuirreL
    {: .topLevel}
    
    Follow the instructions in the next section, [Configure a
    SQuirreL Connection for Splice Machine](#ConfiguringSquirrel){:
    .MCXref .xref .selected}, to create and test a new connection in
    SQuirreL.
    {: .indentLevel1}

5.  Connect SQuirreL to Splice Machine
    {: .topLevel}
    
    In SQuirreL, open the connection alias you created, enter your
    credentials, and click the <span class="AppCommand">Connect</span>
    button. Your database will display in SQuirreL, and you can inspect
    objects or enter SQL to interact with your data.
    {: .indentLevel1}
    
    ![](images/SquirrelWin.png){: .nestedTightSpacing}
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure a SQuirreL Connection for Splice Machine   {#ConfiguringSquirrel}

Follow these steps to configure and test a new driver and connection
alias in SQuirreL.

<div class="opsStepsList" markdown="1">
1.  Start a Splice Machine session on the computer on which you have
    installed SQuirreL
2.  Open the SQuirreL application.
3.  Click the SQuirreL <span class="AppCommand">Drivers</span> tab,
    which is near the upper left of the window:
    {: .topLevel}
    
    ![](images/SquirrelTabs_158x177.png){: .nestedTightSpacing
    style="width: 158;height: 177;"}

4.  In the *Drivers* tab, click the blue + sign <span
    class="AppCommand">Create a New Driver</span> icon to display the
    *Add Driver* window.
    {: .topLevel}
    
    1.  Name the driver and enter
        `jdbc:splice://localhost:1527/splicedb` in the <span
        class="AppCommand">Example URL</span> field:
        
        ![](images/SquirrelDriver3.png){: .nestedTightSpacing}
        
        Use <span class="CodeBoldFont">localhost:1527</span> with the
        standalone (local computer) version of splicemachine. If you're
        running Splice Machine on a cluster, substitute the address of
        your server for `localhost`; for example:  
           <span
        class="CodeBoldFont">jdbc:splice://mySrv123cba:1527/splicedb</span>.
        {: .noteIcon}
    
    2.  Click the <span class="AppFontCust">Extra Class Path</span>
        button, and click the <span class="AppCommand">Add</span>
        button.
    3.  Navigate to and select the Splice JDBC Driver jar file. which
        you'll find it in the `jdbc-driver` folder under the
        `splicemachine` directory on your computer.
        
        ![](images/SquirrelFindDriver.png)
    
    4.  Now, back in the <span class="AppCommand">Add Driver</span>
        screen, click the <span class="AppCommand">List Drivers</span>
        button verify that you see the Splice Machine driver:
        
        <div class="preWrapperWide" markdown="1">
            com.splicemachine.db.jdbc.ClientDriver
        {: .PlainCell}
        
        </div>
    
    5.  Click the <span class="AppFontCust">OK</span> button to add the
        driver entry in SQuirreL.
    {: .LowerAlphaPlainFont}

5.  Create a connection alias in SQuirreL
    {: .topLevel}
    
    1.  Click the *Aliases* tab in the SQuirreL window, and then click
        the <span class="AppCommand">Create new Alias</span> (blue
        + sign) button.
    2.  Enter a name for your alias and select the driver you just
        created from the drop-down list
        
        ![](images/SquirrelAlias2.png){: .nestedTightSpacing}
    
    3.  Click the <span class="AppCommand">Test</span> button to verify
        your connection.In the Connect screen, enter `splice` as the
        <span class="AppCommand">User:</span> value and `admin` for the
        <span class="AppCommand">Password:</span> value.
        
        ![](images/SquirrelConnect.png){: .nestedTightSpacing}
    
    4.  Click the <span class="AppCommand">Connect</span> button to
        verify your connection. You should see the success message:
        
        ![](images/SquirrelSuccess.png){: .nestedTightSpacing}
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
</div>
</section>



[1]: http://squirrel-sql.sourceforge.net/
