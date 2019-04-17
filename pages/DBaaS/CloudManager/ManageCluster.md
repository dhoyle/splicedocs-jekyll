---
summary: Describes the functionality of the Cluster Management screen
title: Managing a Cluster
keywords: cloud manager, dashboard, cluster manager
sidebar:  getstarted_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_managecluster.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Managing a Cluster

This topic describes the actions you can initiate from the <span
class="ConsoleLink">Cluster Management</span> screen. You can access the <span class="ConsoleLink">Cluster Management</span> screen for any cluster in your Dashboard by simply clicking the name of
the cluster. You can use the controls in this screen to:

* [Launch Tools for Monitoring and Notebook Development](#launch)
* [Modify Your Cluster](#modify)
* [View Your Cluster's Resource Usage](#managing)
* [View Cluster Events](#events)
* [View Log Details for Your Cluster](#logdetails)
* [Download Drivers and Related Software](#downloads)


## Launch Tools for Monitoring and Notebook Development  {#launch}
The  <span class="ConsoleLink">Cluster Management</span> screen includes three buttons that launch monitoring and development tools:

![](images/clusterlinks.png){: .indentedSmall}
{: .spaceAbove}

* Click the <span class="CalloutFont">DB Console</span> button to open a new browser tab for the Database Console, which you can use to monitor the Splice Machine queries running on your cluster in real-time. The DB Console uses port 4040.

* Click the <span class="CalloutFont">Notebooks</span> button to open a new browser tab for your Zeppelin notebooks. you can use the notebooks that are pre-installed on your cluster to learn about and experiment with using various features of Splice Machine; you can also quickly develop your own notebooks that use your database, Spark, and Machine Learning.

* Click the <span class="CalloutFont">Spark Console</span> button to open a new browser tab for the Spark Console, which you can use to monitor the Spark jobs running on your cluster in real-time. The Spark Console uses port 4041.

## Modify Your Cluster  {#modify}

The <span class="ConsoleLink">Cluster Management</span> has four buttons you can click to update your cluster:

![](images/clusterupdates.png){: .indentedSmall}
{: .spaceAbove}

* Click the <span class="CalloutFont">Reconfigure</span> button to reconfigure this cluster. This displays the cluster
reconfiguration screen:

  ![](images/Reconfigure1.png){: .indentedMedium}
  {: .spaceAbove}

  You can modify your VPC and/or IAM configuration information or change the Zeppelin instances settings. Click the   <span   class="CalloutFont">Reconfigure</span> button to update your
  configuration and return to your Cluster Management screen.

* Click the <span class="CalloutFont">Resize</span> button to modify the size of this cluster. This displays the cluster resize screen, which is almost identical to the <span class="ConsoleLink">Create New Cluster</span> screen:

  ![](images/ResizeCluster.png){: .indentedTightSpacing}
  {: .spaceAbove}

  After you make any modifications to the cluster configuration, click the <span class="CalloutFont">Resize</span> button to update the cluster settings and return to your Cluster Management screen. Note that resizing a cluster can take a bit of time.

* Click the <span class="CalloutFont">Delete</span> button to delete this cluster. This displays a confirmation screen:

  ![](images/ClusterDelete.png){: .indentedSmall}
  {: .spaceAbove}

  After confirming that you want to do so, your cluster will be deleted, and its status in your dashboard will show as *Deleted*.

* Click the <span class="CalloutFont">Retrieve DB Password</span> button to display the user ID and password for the Splice Machine database running on this cluster.

## View Your Cluster's Resource Usage  {#managing}
The *Activity* tab displays timeline graphs of cluster CPU, Memory, and Storage usage. For example:

![](images/activitytab.png){: .indentedTightSpacing}
{: .spaceAbove}

## View Cluster Events  {#events}
The *Events* tab displays information about cluster events that have occurred over a specified period of time:

![](images/eventstab.png){: .indentedTightSpacing}
{: .spaceAbove}

As you can see, you're able to search for specific words in an event in addition to filtering on a range of dates.

## View Log Details for Your Cluster  {#logdetails}
The *Events* tab displays information about cluster events that have occurred over a specified period of time:

![](images/logdetailstab.png){: .indentedTightSpacing}
{: .spaceAbove}

As you can see, you're able to search for specific words in a log entry in addition to restricting the display to a range of date/time values. You can also filter on any combination of log entry types (Info, Debug, Warning, and Error).

## Download Drivers and Related Software  {#downloads}

The bottom of the <span class="ConsoleLink">Cluster Management</span> screen includes a number of useful links:

![](images/clustermgmtdls.png){: .indentedTightSpacing}
{: .spaceAbove}

You can:

* Launch the  <span class="CalloutFont">Spark Console</span> in a separate browser tab.
* Download the Splice Machine <span class="CalloutFont">ODBC Driver</span>.
* Download the Splice Machine <span class="CalloutFont">JDBC Driver</span>.
* Download the Splice Machine <span class="CalloutFont">SqlShell</span> command line client.
* Copy a basic JDBC connection URL to your cluster's database.

  The same JDBC URL was emailed to you in the message from Splice Machine
  letting you know that your cluster creation was successful.
  {: .noteIcon}

</div>
</section>
