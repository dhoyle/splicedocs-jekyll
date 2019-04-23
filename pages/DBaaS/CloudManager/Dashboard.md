---
summary: Describes the functionality of the Splice Machine Cloud Manager Dashboard
title: Using the Cloud Manager Dashboard
keywords: dbaas, paas, cloud manager, dashboard
sidebar: home_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_dashboard.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Exploring Your Cloud Manager Dashboard

This topic describes the actions you can initiate from your
Splice Machine dashboard, which include:

* [Viewing and Managing Your Clusters](#viewing)
* [Creating a New Cluster](#creating)

## Viewing and Managing Your Clusters   {#viewing}
Your dashboard displays a list of the clusters that you've created, along with the status of each:

![](images/DashboardView1.png){: .indentedTightSpacing}
{: .spaceAbove}

CPU, Memory, and Disk usage statistics are displayed for the currently selected cluster (in this case *mlmanager*). Simply click or tap a cluster name to display its usage information.

## Creating a New Cluster   {#creating}
When you first log in to your Splice Machine Database Service, you'll see a large indication that you need to create a new cluster before you can do anything:

![](images/InitialDashboard.png){: .indentedTightSpacing}
{: .spaceAbove}

Click the large <span class="ConsoleLink">Create New Cluster</span>
button to start the process of creating a new cluster. This process,
which requires just a few minutes, is described in detail in our
[Creating a New Cluster](dbaas_cm_initialstartup.html) topic.
 
After you've created a new cluster, you land back on this Dashboard screen,
at which time the status of your new cluster will be *Initializing*.

![](images/JustCreatedDashboard.png){: .indentedTightSpacing}
{: .spaceAbove}

After a few minutes, your new cluster will be initialized, its status will change to *Active*,
and you'll receive an email message from Splice Machine notifying you that
your cluster is ready. At that point, you can click the cluster name
(e.g. *SpliceDocs1*) to use the *Cluster Management* screen for that
cluster, as described in the [Managing a Cluster](dbaas_cm_managecluster.html) topic.

</div>
</section>
