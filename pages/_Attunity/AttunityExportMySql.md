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

1. __Create a Splice Machine endpoint in Attunity:__
   * Open the Attunity Replicate user interface and click <span class="ConsoleLink">Manage Endpoint Connections</span>.
   * In the pop-up window that opens, select <span class="ConsoleLink">+ New Endpoint Connection</span>.
<br /><br />

2. __In the *New Endpoint Connection*, enter data in these fields:__
   * Enter the name for your endpoint in the <span class="ConsoleLink">Name:</span> field.
   * Enter a description for the endpoint in the <span class="ConsoleLink">Description:</span> field.
   * Select *Target* as the value of the <span class="ConsoleLink">Role:</span> field.
   * Enter *Hadoop* as the value of the <span class="ConsoleLink">Type:</span> field. You'll now see three new fields displayed: <span class="ConsoleLink">Security, HDFS, </span>and <span class="ConsoleLink">Hive Access</span>.
   * Click the down-arrow to fill in <span class="ConsoleLink">Security</span> information:
     1. Select *User name* in the <span class="ConsoleLink">Authentication type</span> field.
     2. Enter the Hadoop username in the <span class="ConsoleLink">Username:</span> field. For example: *hdfs*.
   * Click the down-arrow to fill in <span class="ConsoleLink">HDFS</span> information:
     1. Select *WebHDFS* in the <span class="ConsoleLink">Use:</span> field.
     2. Enter the IP or host name of a Hadoop name node in the <span class="ConsoleLink">NameNode:</span> field.
         Make sure all of the data nodes are accessible from Attunity and configure all of the Hadoop nodes in `/etc/hosts` file in the machine that is running Attunity.
     3. Enter the port webHDFS in the <span class="ConsoleLink">Port:</span> field. The default port value is `50070`.
         Make sure the WebHDFS service is running.
     4. Enter your preferred target location in the <span class="ConsoleLink">Target folder:</span> field. Make sure that the user you specified in the <span class="ConsoleLink">Username:</span> field has write access to this folder.
   * Click the down-arrow to fill in the <span class="ConsoleLink">Hive Access</span> information:
      1. Select *No Access* in the <span class="ConsoleLink">Access Hive using:</span> field.
   * Now select the <span class="ConsoleLink">Advanced</span> tab near the top of the window, and click the down-arrow to display the *File Format* settings:
      1. Change the <span class="ConsoleLink">Field Delimiter:</span> character to <code>|</code>.
   * Click the <span class="ConsoleLink">Save</span> button at the bottom of the window to save you endpoint settings.
   * Click the <span class="ConsoleLink">Test Connection</span> button to test your settings.
<br /><br />

2. __Create an Attunity replicate task to export data to Splice Machine:__
   * In the Atunity Replicate UI, click <span class="ConsoleLink">+ New Task</span>.
   * In the pop-up window that displays:
     1. Enter the name for your task in the <span class="ConsoleLink">Name:</span> field.
     2. Enter a description for the task in the <span class="ConsoleLink">Description:</span> field.
     3. Select *Unidirectional* in the <span class="ConsoleLink">Replication Profile</span> field.
     4. In the <span class="ConsoleLink">Task Options</span> section:
        * Select *Full Load*.
        * Select *Apply Changes*.
        * If you want to store the change logs on the target, select *Store Changes*.
     5. Click <span class="ConsoleLink">OK</span> to save the task.
   * Drag and drop the source and target endpoints into the center panel. Select the *Splice Machine* endpoint you just created as the target endpoint.
   * Click <span class="ConsoleLink">Table Selection</span> to open the pop-up window for selecting tables:
     * Select the tables from your source endpoint
     * Click <span class="ConsoleLink">OK</span>.
   * Click <span class="ConsoleLink">Save</span> in the top-left portion of the window to save your task settings.
<br /><br />

3. __Click <span class="ConsoleLink">Run</span> to start the replicate task:__
   * Once your task is running, you can click <span class="ConsoleLink">Monitor</span> to monitor the task.
   * You can click <span class="ConsoleLink">Stop</span> to stop the task.
<br /><br />
4. __Once the files have been transferred use one of the [ingest methods](bestpractices_ingest_overview.html) available in Splice Machine to import the data into your database.__

</div>
</section>
