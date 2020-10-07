---
summary: Walks you through creating your cluster and getting started.
title: Getting Started with Splice Machine Cloud Manager
keywords: dbaas, create cluster, cloud manager, dashboard, splice units
sidebar: home_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_initialstartup.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Creating a New Splice Machine Cluster

When you first visit your new Splice Machine Cloud Manager dashboard,
you'll see the initial dashboard view, which prompts you to create a new
cluster:

![](images/InitialDashboard.png "Splice Machine Dashboard upon initial
startup"){: .indentedTightSpacing}

Click <span class="CalloutFont">Create New Cluster</span> to start the
process of provisioning your Splice Machine cluster. You'll then need
to:
{: .spaceAbove}

1.  [Configure Cluster Parameters](#Configure) for data sizing, cluster
    power, ML Manager, and backup frequency.
2.  [Configure Cluster Access and Options](#Configur) for your users.
3.  Start Using Splice Machine!

## Configure Cluster Parameters   {#Configure}

You use the <span class="ConsoleLink">Create New Cluster</span> screen
to provision your cluster. Note that cluster creation is the same on both AWS and Azure:

![](images/CloudCreateCluster.png "Initial settings for new Splice
Machine cluster"){: .indentedTightSpacing}

### Screen Help

Many of the components of the <span class="ConsoleLink">Create
Cluster</span> screen, like most of our Cloud Manager screens, include
small information buttons ![](images/infobutton.png){: .icon36} that you
can click to display a small pop-up that describes the components.

For example, here you can see several of the information pop-ups from the <span class="ConsoleLink">Create New Cluster</span> screen:

![](images/CloudCreateClusterInfo.png "Create Cluster screen Pop-ups"){: .indentedTightSpacing}

Click the information button again to dismiss a pop-up.

### About the Cluster Parameters

You'll notice several sliders that you can adjust to modify the
configuration of your cluster. As you move these sliders, you'll see how
the estimated monthly costs for your cluster change. Here are
explanations of the adjustments you can make to your cluster
provisioning:

Note that you can come back and modify your cluster configuration in the
future, so you're not stuck forever with your initial settings.
{: .noteNote}

<table>
   <col />
   <col />
   <col />
   <tbody>
       <tr>
           <td> </td>
           <td><code>Cluster Name</code></td>
           <td>Supply whatever name you want for your Splice Machine cluster.</td>
       </tr>
       <tr>
           <td> </td>
           <td><code>Cloud Provider</code></td>
           <td><p>You can select which cloud provider is hosting your cluster by clicking the current provider name, which drops down a list of choices.</p>
               <p class="noteNote">If you have subscribed to Splice Machine via the AWS Marketplace, your costs will be estimated on an hourly basis instead of on a monthly basis.</p>
           </td>
       </tr>
       <tr>
           <td> </td>
           <td><code>Region</code></td>
           <td>You can select in which region your cluster will reside by clicking the current region name, which drops down a list of choices.</td>
       </tr>
       <tr>
           <td rowspan="2" class="ConsoleLink">Data Sizing</td>
           <td><code>Internal Dataset (TB)</code></td>
           <td>
               <p>Move the slider to modify your estimate of how large your database will be.</p>
               <p><code>Internal Dataset</code> is the amount of data that you will be storing within your Splice Machine database.</p>
           </td>
       </tr>
       <tr>
           <td><code>External Dataset (TB)</code></td>
           <td>
               <p>Move the slider to modify your estimate of how large your external dataset will be.</p>
               <p><code>External Dataset</code> is the amount of data the you will be accessing from external data sources, using features such as external tables and our virtual table interface.</p>
           </td>
       </tr>
       <tr>
           <td rowspan="2" class="ConsoleLink">Cluster Power</td>
           <td><code>OLTP Splice Units</code></td>
           <td>
               <p>Move the slider to modify your estimate of how much processing power you need for transactional activity, involving quick inserts, lookups, updates, and deletes. More OLTP units means more region servers in your cluster.</p>
           </td>
       </tr>
       <tr>
           <td><code>OLAP Splice Units</code></td>
           <td>
               <p>Move the slider to modify your estimate of how much processing power you need for running longer queries, typically analytical queries. More OLAP units means more Spark executors.</p>
           </td>
       </tr>
       <tr>
           <td rowspan="6" class="ConsoleLink">Notebook</td>
           <td><code>Total Users</code></td>
           <td>
               <p>The total number of users who can use notebooks on your cluster.</p>
           </td>
       </tr>
       <tr>
            <td><code>Active Users</code></td>
            <td>
                <p>The number of users who can concurrently be working in Jupyter notebooks.</p>
            </td>
       </tr>
       <tr>
            <td><code>Notebooks per User</code></td>
            <td>
                <p>The number of notebooks that a single user can be working on at any point in time.</p>
            </td>
       </tr>
       <tr>
            <td><code>Splice Units per Notebook</code></td>
            <td>
                <p>The number of Spark units allocated per notebook.</p>
            </td>
       </tr>
       <tr>
            <td><code>Storage Total</code></td>
            <td>
                <p>The total amount of storage for notebooks; Splice Machine allocates 10GB per user.</p>
            </td>
       </tr>
       <tr>
            <td><code>Total Splice Units</code></td>
            <td>
                <p>This is computed by:</p>
                <pre class="PlainCell"><code>Active-Users * Notebooks-per-User * Splice-Units-per-Notebook</code></pre>
            </td>
       </tr>
       <tr>
           <td class="ConsoleLink">ML Manager</td>
           <td><code>Enable</code></td>
           <td>Select this checkbox to enable the beta version of the Splice Machine ML Manager, which provides access to our Model Workflow and Deployment integration and additional Machine Learning libraries.</td>
       </tr>
       <tr>
           <td class="ConsoleLink">Backup Frequency</td>
           <td><code>Frequency</code></td>
           <td>
               <p>Select how frequently you want Splice Machine to back up your database. You can select <code>None</code>, or you can select automatic <code>Daily</code> or <code>Weekly</code> backups, each of which displays additional backup timing and retention options:</p>
               <p>Daily:</p>
               <p>
                   <img src="images/DailyBackupOptions_450x68.png" class="indentedTightSpacing" title="Hourly backup options"  />
               </p>
               <p>Weekly:</p>
               <p>
                   <img src="images/WeeklyBackupOptions_450x67.png" class="indentedTightSpacing" title="Hourly backup options" />
               </p>
           </td>
       </tr>
   </tbody>
</table>
A *Splice Unit* is a measure of processing work; one unit currently
translates (approximately) to 2 virtual CPUs and 16 GB of memory.
{: .noteIcon}

### Modifying Cluster Parameters

We recommend that you spend a few minutes experimenting with modifying
the cluster parameters; you'll notice that as you increase various
values, the estimated monthly cost of your cluster changes.

When you're satisfied with your cluster configuration parameters, click
the <span class="CalloutFont">Next</span> button to set up access to
your cluster.

You'll notice that when you increase some values, Splice Machine may
indicate that the current setting for a parameter clashes with a change
that you've made. For example, in the following image, we have increased
the <span class="ConsoleLink">Internal Dataset</span> size to 20 TB, and
as a result the <span class="ConsoleLink">Cluster Power</span> values
are no longer adequate to support that large a dataset, as indicated by
the striping:

![](images/CloudCreateClash.png "Modified cluster parameters"){:
.indentedTightSpacing}

Splice Machine will not allow you to create your cluster if any of your
values clash. You can click the vertical bar at the end of the striping
to instantly set the parameter to the required value.

If you don't correct the required setting and attempt to advance to the
<span class="CalloutFont">Next</span> screen, you'll see an error
message and will be unable to advance until you do correct it.
{: .noteNote}

## Configure Database Credentials   {#Configur}

Once you've configured your cluster, click the <span
class="CalloutFont">Next</span> button to display the <span
class="ConsoleLink">Database Credentials</span> screen.

![](images/CloudAWSCredentials.png "Setting up credentials for a new
cluster"){: .indentedTightSpacing}

You need to enter the Password for the <code>splice</code> user on your new cluster.

If you're creating your cluster on AWS, you will see the <span class="ConsoleLink">IAM S3 Access</span> panel;
use this to configure AWS Identity and Access Management (IAM) for your cluster to allow Splice Machine to access selected S3 folders, as described in our [Configuring an S3 bucket for Splice Machine Access](developers_cloudconnect_configures3.html) topic.

You will not see this panel if you're on Azure.
{: .noteNote}

After configuring your credentials, please confirm that you `accept our terms and conditions`, then click the <span
class="CalloutFont">Launch</span> button. Splice Machine will immediately begin creating your cluster, and you'll receive an email notfication when it's done.

## Start Using Your Database!   {#loadData}

After your cluster spins up, which typically requires about 10 minutes,
you can load your data into your Splice Machine database and start
running queries.

The easiest way to get going with your new database is to use our
[Jupyter Notebook interface](dbaas_jup_intro.html), with which you can
quickly run queries and generate different visualizations of your
results, all without writing any code. We've provided a number of useful
Jupyter tutorials, including one that walks you through setting up a
schema, creating tables, loading data, and then running queries.

Note that your data must be in Azure storage or an AWS S3 bucket before you can import it
into your Splice Machine database:

* For information about uploading data to S3, please check our [Uploading Data to an S3
  Bucket](developers_cloudconnect_uploadtos3.html) tutorial. You may need to configure your Amazon IAM permissions to allow Splice Machine to access your bucket; see our [Configuring an S3 Bucket for Splice Machine Access](developers_cloudconnect_configures3.html) tutorial.
* To configure Azure Storage for use with Splice Machine, see our [Using Azure Storage](developers_cloudconnect_configureazure.html) tutorial.
* Once you've got your data uploaded, you can follow our [Ingestion Best Practices](bestpractices_ingest_overview.html) topic to load that data into
  Splice Machine.

</div>
</section>
