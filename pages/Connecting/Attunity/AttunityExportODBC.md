---
title: Using Attunity via ODBC to Export to Splice Machine
summary: Using Attunity via ODBC to Export to Splice Machine
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: attunity_export_odbc.html
folder: Connecting/Attunity
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Attunity via ODBC to Export to Splice Machine

Follow these steps to use *Attunity Replicate* with the Splice Machine ODBC driver to export tables from a MySQL database and import them into your Splice Machine database:

1. [Install the Splice Machine ODBC Driver](#installdriver)
2. [Create a Splice Machine Endpoint in Attunity](#createendpoint)
3. [Create an Attunity Task to Export Data](#createtask)
4. [Run the Replication Task](#runtask)
5. [Verify the Tables in Splice Machine](#verify)

## 1. Install the Splice Machine ODBC Driver {#installdriver}
If you don't already have our ODBC driver installed, please follow the instructions in our [Installing the Splice Machine ODBC Driver on Linux](tutorials_connect_odbcinstall.html#Installi2) topic to install and test the driver on your system.

## 2. Create a Splice Machine Endpoint in Attunity  {#createendpoint}
Your first step is to open the <em>Attunity Replicate</em> user interface and click <span class="ConsoleLink">Manage Endpoint Connections</span>.

In the pop-up window that opens, select <span class="ConsoleLink">+ New Endpoint Connection</span>, and follow these steps:
<div class="opsStepsList" markdown="1">
<ol>
    <li class="topLevel">Enter data in these fields:
        <ol>
            <li> Enter the name for your endpoint in the <span class="ConsoleLink">Name:</span> field.</li>
            <li> Enter a description for the endpoint in the <span class="ConsoleLink">Description:</span> field.</li>
            <li> Select <em>Target</em> as the value of the <span class="ConsoleLink">Role:</span> field.</li>
            <li> Select <em>ODBC</em> as the value of the <span class="ConsoleLink">Type:</span> field.</li>
        </ol>
    </li>

    <li class="topLevel">
        <p>Click the <span class="ConsoleLink">Connection String</span> button, and enter ODBC connection information. Specify the Driver exactly as shown here, and replace the `Port` and `URL` values as required for your environment:</p>
        <div><pre class="Example">Driver={SpliceODBCDriver};Port=1527;URL=192.168.2.215</pre></div>
    </li>

    <li class="topLevel">Enter your Splice Machine user name and password in the <span class="ConsoleLink">Username</span> and <span class="ConsoleLink">Username</span> fields.</li>

    <li>Click the <span class="ConsoleLink">Save</span> button at the bottom of the window to save your endpoint settings.</li>

    <li>Click the <span class="ConsoleLink">Test Connection</span> button to test your settings.</li>
</ol>
</div>

## 3. Create an Attunity Task to Export Data  {#createtask}
Now that you've created the endpoint, you need to create an Attunity Replicate task that exports data from the MySQL source to files that Splice Machine can import.

Start by clicking <span class="ConsoleLink">+ New Task</span> in the Attunity Replicate UI, and then follow these steps:

<div class="opsStepsList" markdown="1">
<ol>
    <li class="topLevel">Enter the name for your task in the <span class="ConsoleLink">Name:</span> field.</li>
    <li class="topLevel">Enter a description for the task in the <span class="ConsoleLink">Description:</span> field.</li>
    <li class="topLevel">Select <em>Unidirectional</em> in the <span class="ConsoleLink">Replication Profile</span> field.</li>
    <li class="topLevel">In the <span class="ConsoleLink">Task Options</span> section:
        <ul>
            <li>Select <em>Full Load</em>.</li>
            <li>Select <em>Apply Changes</em>.</li>
            <li>If you want to store the change logs on the target you selected, select <em>Store Changes</em>.</li>
        </ul>
    </li>
    <li class="topLevel">Click <span class="ConsoleLink">OK</span> to save the task settings and proceed to the <em>Table Selection</em> settings.</li>
    <li class="topLevel">Drag and drop the source and target endpoints into the center panel. Select the <em>Splice Machine</em> endpoint you just created as the target endpoint.
        <ol>
            <li>Click <span class="ConsoleLink">Table Selection</span> to open the pop-up window for selecting tables.</li>
            <li>Select the tables from your source endpoint</li>
            <li>Click <span class="ConsoleLink">OK</span>.</li>
        </ol>
    </li>
    <li class="topLevel">Click <span class="ConsoleLink">Save</span> in the top-left portion of the window to save the task.</li>
</ol>
</div>

## 4. Run the Replication Task  {#runtask}

Now you can run your newly defined replication task by clicking <span class="ConsoleLink">Run</span>.

Once your task is running, you can:

* Click <span class="ConsoleLink">Monitor</span> to monitor the task.
* Click <span class="ConsoleLink">Stop</span> to stop the task.

## 5. Verify the Tables in Splice Machine  {#verify}

Once the replication task has completed, you can use the `splice>` command line interpreter (`sqlshell.sh`) to verify that the tables look good in your Splice Machine database:

<div class="opsStepsList" markdown="1">
<ul>
    <li class="topLevel">
        <p>To verify that the new schema you replicated from Attunity, display a list of available schemas:</p>
        <div><pre class="Example">splice> SHOW SCHEMAS;</pre></div>
    </li>
    <li class="topLevel">
        <p>To see a list of the tables in your schema, use the <code>SHOW TABLES</code> command. For example, if your schema name is <code>mySchema</code>, use this command:</p>
        <div><pre class="Example">splice> SHOW TABLES IN MYSCHEMA;</pre></div>
    </li>
    <li class="topLevel">
        <p>If you selected the <code>Store Changes</code> options in your replication task settings, you'll see <em>change tables</em> listed with a format like this:</p>
        <div><pre class="Example">&lt;MY_TABLE&gt;__ct</pre></div>
    </li>
    <li class="topLevel">
        <p>To verify the number of rows in a table, use a command like this:</p>
        <div><pre class="Example">splice> SELECT COUNT(*) FROM MYSCHEMA.MYTABLE;</pre></div>
    </li>
    <li class="topLevel">
        <p>To display the first 10 rows of a table, use a command like this:</p>
        <div><pre class="Example">splice> SELECT * FROM MYSCHEMA.MYTABLE {LIMIT 10};</pre></div>
    </li>
</ul>
</div>

Though `splice> ` command lines are shown in all caps in the examples above, the commands are not case sensitive.
{: .noteIcon}

</div>
</section>
