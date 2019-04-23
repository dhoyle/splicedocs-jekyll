---
title: Exporting Tables from MySQL to Splice Machine with Attunity Replicate
summary: Exporting Tables from MySQL to Splice Machine with Attunity Replicate
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: attunity_export_mysql.html
folder: Attunity
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Attunity to Export MySQL Tables to Splice Machine

Follow these steps to use *Attunity Replicate* to export tables from a MySQL database and import them into your Splice Machine database:

1. [Create a Splice Machine Endpoint in Attunity](#createendpoint)
2. [Create an Attunity Task to Export Data](#createtask)
3. [Run the Replication Task](#runtask)
4. [Import the Data into Splice Machine](#import)

## 1. Create a Splice Machine Endpoint in Attunity  {#createendpoint}
Your first step is to open the <em>Attunity Replicate</em> user interface and click <span class="ConsoleLink">Manage Endpoint Connections</span>.

In the pop-up window that opens, select <span class="ConsoleLink">+ New Endpoint Connection</span>, and follow these steps:

<div class="opsStepsList" markdown="1">
<ol>
    <li class="topLevel">Enter data in these fields:
        <ol>
            <li> Enter the name for your endpoint in the <span class="ConsoleLink">Name:</span> field.</li>
            <li> Enter a description for the endpoint in the <span class="ConsoleLink">Description:</span> field.</li>
            <li> Select <em>Target</em> as the value of the <span class="ConsoleLink">Role:</span> field.</li>
            <li> Enter <em>Hadoop</em> as the value of the <span class="ConsoleLink">Type:</span> field. You'll now see three new fields displayed: <span class="ConsoleLink">Security, HDFS, </span>and <span class="ConsoleLink">Hive Access</span>.</li>
        </ol>
    </li>

    <li class="topLevel">Click the down-arrow to fill in <span class="ConsoleLink">Security</span> information:
        <ol>
            <li>Select <em>User name</em> in the <span class="ConsoleLink">Authentication type</span> field.</li>
            <li>Enter the Hadoop username in the <span class="ConsoleLink">Username:</span> field. For example: <em>hdfs</em>.</li>
        </ol>
    </li>

    <li class="topLevel">Click the down-arrow to fill in <span class="ConsoleLink">HDFS</span> information:
        <ol>
            <li>Select <em>WebHDFS</em> in the <span class="ConsoleLink">Use:</span> field.</li>
            <li><p>Enter the IP or host name of a Hadoop name node in the <span class="ConsoleLink">NameNode:</span> field.</p>
                <p>Make sure all of the data nodes are accessible from Attunity and configure all of the Hadoop nodes in <code>/etc/hosts</code> file in the machine that is running Attunity.</p>
            </li>
            <li><p>Enter the port to use for webHDFS in the <span class="ConsoleLink">Port:</span> field. The default port value is <code>50070</code>.</p>
                <p>Make sure the WebHDFS service is running.</p>
            </li>
            <li>Enter your preferred target location in the <span class="ConsoleLink">Target folder:</span> field. Make sure that the user you specified in the <span class="ConsoleLink">Username:</span> field has write access to this folder.</p>
            </li>
        </ol>
    </li>

    <li class="topLevel">Click the down-arrow to fill in the <span class="ConsoleLink">Hive Access</span> information:
        <ol>
            <li>Select <em>No Access</em> in the <span class="ConsoleLink">Access Hive using:</span> field.</li>
        </ol>
    </li>

    <li class="topLevel">Now select the <span class="ConsoleLink">Advanced</span> tab near the top of the window, and click the down-arrow to display the <em>File Format</em> settings:
        <ol>
            <li>Change the <span class="ConsoleLink">Field Delimiter:</span> character to <code>|</code>.</li>
            <li>Click the <span class="ConsoleLink">Save</span> button at the bottom of the window to save you endpoint settings.</li>
            <li>Click the <span class="ConsoleLink">Test Connection</span> button to test your settings.</li>
        </ol>
    </li>
</ol>
</div>

## 2. Create an Attunity Task to Export Data  {#createtask}
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

## 3. Run the Replication Task  {#runtask}

Now you can run your newly defined replication task by clicking <span class="ConsoleLink">Run</span>.

Once your task is running, you can:

* Click <span class="ConsoleLink">Monitor</span> to monitor the task.
* Click <span class="ConsoleLink">Stop</span> to stop the task.

## 4. Import the Data into Splice Machine  {#import}

Once the files have been transferred use one of the [ingest methods](bestpractices_ingest_overview.html) available in Splice Machine to import the data into your database.


</div>
</section>
