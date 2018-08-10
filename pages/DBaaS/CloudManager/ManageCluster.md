---
summary: Describes the functionality of the Cluster Management screen
title: Managing a Cluster
keywords: cloud manager, dashboard, cluster manager
sidebar:  dbaas_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_managecluster.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Managing a Cluster

This topic describes the actions you can initiate from the <span
class="ConsoleLink">Cluster Management</span> screen, which include:

* [Viewing the cluster's CPU, Disk, and Memory Usage](#managing)
* [Reconfiguring cluster access](#reconfiguring)
* [Resizing your cluster](#resizing)
* [Deleting your cluster](#deleting)
* [Using Zeppelin and the Database Console with your cluster](working)

## The Cluster Management Screen

You can access the <span class="ConsoleLink">Cluster Management</span>
screen for any cluster in your Dashboard by simply clicking the name of
the cluster.

This screen displays information about the cluster, and includes three
panels that display a graph of resource usage over time. There are three
similar resource usage graphs displayed:

* CPU Percentage Used (shown in the following image)
* Disk Usage
* Memory Usage

![](images/ActiveDashboard1.png){: .indentedTightSpacing}
{: .spaceAbove}

## Modifying Your Cluster   {#modifying}

Your dashboard features three cluster modification choices; you can
[Reconfiguring](reconfiguring), [Resizing](Resizing), or
[Deleting](Deleting) your cluster by clicking one of the buttons near
the top-left of your Dashboard screen:

![](images/DashboardButtons.png){: .indentedTightSpacing}

### Reconfiguring Your Cluster   {#reconfiguring}

To reconfigure your cluster, click the <span
class="ConsoleLink">Reconfigure</span> button; the cluster
reconfiguration screen displays:

![](images/Reconfigure1.png){: .indentedTightSpacing}

You can modify your VPC and/or IAM configuration information in this
screen. Once you've entered your new information, click the <span
class="CalloutFont">Reconfigure</span> button to update your
configuration and return to your Cluster Management screen.

### Resizing Your Cluster   {#resizing}

To resize your cluster, click the <span
class="CalloutFont">Resize</span> button. The Resize Cluster screen,
which is pretty much identical to the Create New Cluster screen,
displays:

![](images/ResizeCluster.png){: .indentedTightSpacing}

You can adjust your cluster parameters, then click the <span
class="CalloutFont">Resize</span> button, which will return you to your
Cluster Management screen, where you'll see the status of your cluster
set to *Updating*.

### Deleting Your Cluster   {#deleting}

To delete your cluster, click the <span
class="CalloutFont">Delete</span> button. You'll be ask to confirm the
deletion:

![](images/ClusterDelete.png){: .indentedTightSpacing}

After confirming that you want to do so, your cluster will be deleted,
and its status in your dashboard will show as *Deleted*.

## Working With Your Database   {#working}

Your dashboard includes buttons with which you can access two different
means of working with your database; you can launch the <span
class="CalloutFont">DB Console</span> or the Apache Zeppelin <span
class="CalloutFont">Notebook</span> interface by clicking one of the
buttons near the upper-right corner of the Dashboard screen:

![](images/DashboardLinks.png){: .indentedTightSpacing}

Click the <span class="CalloutFont">DB Console</span> button to land on
our [Database Console](tutorials_dbconsole_intro.html) interface.

Click the <span class="CalloutFont">Notebook</span> button to land on
our [Zeppelin Notebook](dbaas_zep_intro.html) interface.

### Connecting to Your Database with JDBC

At the very bottom of the Cluster Management screen, below the three
graph panels, is the URL you can use for a JDBC connection with your
database service:

![](images/ActiveDashboard2.png){: .indentedTightSpacing}

The same JDBC link was emailed to you in the message from Splice Machine
letting you know that your cluster creation was successful.
{: .noteIcon}

</div>
</section>

