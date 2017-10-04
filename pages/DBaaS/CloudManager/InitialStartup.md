---
summary: Walks you through creating your cluster and getting started.
title: Getting Started with Splice Machine Cloud Manager
keywords: dbaas, create cluster, cloud manager, dashboard, splice units
sidebar:  dbaas_sidebar
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
    power, and backup frequency.
2.  [Configure Cluster Access](#Configur) for your users.
3.  [Set Up Payment](#Payment) for your Splice Machine cluster.
4.  Start Using Splice Machine!

## Configure Cluster Parameters   {#Configure}

You use the <span class="ConsoleLink">Create New Cluster</span> screen
to provision your cluster:

![](images/CreateNewCluster1.png "Initial settings for new Splice
Machine cluster"){: .indentedTightSpacing}

If you have subscribed to Splice Machine via the AWS Marketplace, your
costs will be estimated on an hourly basis instead of a monthly basis:

![](images/hourlycosts.png){: .indentedTightSpacing style="max-width:
300px"}

### Screen Help

Many of the components of the <span class="ConsoleLink">Create
Cluster</span> screen, like most of our Cloud Manager screens, include
small information buttons ![](images/infobutton.png){: .icon36} that you
can click to display a small pop-up that describes the components.

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
                       <td><code>Region</code></td>
                       <td>You can select in which AWS region your cluster will reside by clicking the previously selected region name, which drops down a list of choices.</td>
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
                           <p>Move the slider to modify your estimate of how much processing power you need for transactional query processing. More OLTP units means more region servers in your cluster.</p>
                       </td>
                   </tr>
                   <tr>
                       <td><code>OLAP Splice Units</code></td>
                       <td>
                           <p>Move the slider to modify your estimate of how much processing power you need for analytical query processing. More OLAP units means more Spark executors.</p>
                       </td>
                   </tr>
                   <tr>
                       <td class="ConsoleLink">Backup Frequency</td>
                       <td><code>Frequency</code></td>
                       <td>
                           <p>Select how frequently you want Splice Machine to back up your database. You can select <code>Hourly</code>, <code>Daily</code>, or <code>Weekly</code>; each selection displays additional backup timing and retention options:</p>
                           <p>Hourly:</p>
                           <p>
                               <img src="images/HourlyBackupOptions_450x78.png" class="tableCell450" title="Hourly backup options" style="width: 450;height: 78;" />
                           </p>
                           <p>Daily:</p>
                           <p>
                               <img src="images/DailyBackupOptions_450x68.png" class="tableCell450" title="Hourly backup options" style="width: 450;height: 68;" />
                           </p>
                           <p>Weekly:</p>
                           <p>
                               <img src="images/WeeklyBackupOptions_450x67.png" class="tableCell450" title="Hourly backup options" style="width: 450;height: 67;" />
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

![](images/CreateNewCluster2.png "Modified cluster parameters"){:
.indentedTightSpacing}

Splice Machine will not allow you to create your cluster if any of your
values clash. You can click the vertical bar at the end of the striping
to instantly set the parameter to the required value.

If you don't correct the required setting and attempt to advance to the
<span class="CalloutFont">Next</span> screen, you'll see an error
message and will be unable to advance until you do correct it.
{: .noteNote}

## Configure Cluster Access   {#Configur}

Once you've configured your cluster, click the <span
class="CalloutFont">Next</span> button to display the <span
class="ConsoleLink">Cluster Access</span> screen. The following image
includes displays of the pop-up help information displays for the
different access methods:

![](images/CreateNewCluster4.png "Setting up VPC and/or IAM for a new
cluster"){: .indentedTightSpacing}

You can set your cluster up for access to your Amazon Virtual Private
Cloud (VPC) access by selecting the `Client VPC connectivity required`
option and providing your VPC account ID.

You need to configure AWS Identity and Access Management (IAM) for your
cluster to allow Splice Machine to access selected S3 folders; this is
described in our [Configuring an S3 bucket for Splice Machine
Acces](tutorials_ingest_configures3.html) tutorial.

<div class="notePlain" markdown="1">
For more information about Amazon VPC, see
[https://aws.amazon.com/vpc/][1]{: target="_blank"}.

For more information about Amazon IAM, see
[https://aws.amazon.com/iam/][2]{: target="_blank"}.

</div>
After setting up any access methods, please confirm that you `accept our
terms and conditions`, then click the <span
class="CalloutFont">Launch</span> button, which will take you to the
<span class="ConsoleLink">Payment</span> screen, unless you've
subscribed to Splice Machine from the Amazon Marketplace or have already
set up a payment method for your account.

## Set Up Payment   {#Payment}

When you click the <span class="CalloutFont">Launch button</span>, then
one of these actions happens:

* If you subscribed to Splice Machine via the AWS Marketplace, or you
  already have a payment method set up on your account, you'll land on
  your dashboard and will be notified when your cluster has been
  initialized.
* If you don't yet have a payment method set up, you'll land on the
  <span class="ConsoleLink">Payment</span> screen, in which you can
  elect to use on of three payment methods:

![](images/PaymentScreen_436x219.png "Splice Machine Provisioning
Payment Screen"){: .nestedTightSpacing style="width: 436;height: 219;"}

<table>
               <col />
               <col style="width: 52px;" />
               <tbody>
                   <tr>
                       <td>Credit Card</td>
                       <td>
                           <p>
                               <img src="images/PaymentCC_450x236.png" class="tableCell450" title="Paying with a credit card" style="width: 450;height: 236;" />
                           </p>
                       </td>
                   </tr>
                   <tr>
                       <td>ACH Electronic Transfer</td>
                       <td>
                           <p>
                               <img src="images/PaymentACH_450x130.png" class="tableCell450" title="Paying with ACH transfer" style="width: 450;height: 130;" />
                           </p>
                       </td>
                   </tr>
                   <tr>
                       <td>Authorization Code</td>
                       <td>
                           <p>
                               <img src="images/PaymentAuthCode_450x164.png" class="tableCell450" title="Paying with an authorization code" style="width: 450;height: 164;" />
                           </p>
                       </td>
                   </tr>
               </tbody>
           </table>
#### Modifying Payment Information

If you ever need to change your Splice Machine payment information, you
can update it in the <span class="ConsoleLink">Billing Activity</span>
tab of the <span class="ConsoleLink">Account</span> screen; just click
the <span class="CalloutFont">Update</span> button to revisit the <span
class="ConsoleLink">Payment</span> screen:

![](images/BillingActivity_729x348.png "Billing Activity tab of the
Account screen"){: .indentedTightSpacing style="width: 729;height:
348;"}

If you've purchased Splice Machine through Amazon Marketplace, change
your billing credentials in the Marketplace instead.
{: .noteNote}

## Start Using Your Database!   {#loadData}

After your cluster spins up, which typically requires about 10 minutes,
you can load your data into your Splice Machine database and start
running queries.

The easiest way to get going with your new database is to use our
[Zeppelin Notebook interface](dbaas_zep_intro.html), with which you can
quickly run queries and generate different visualizations of your
results, all without writing any code. We've provided a number of useful
Zeppelin tutorials, including one that walks you through setting up a
schema, creating tables, loading data, and then running queries.

Note that your data must be in an AWS S3 bucket before you can import it
into your Splice Machine database:

* If you don't yet know how to create an S3 bucket or upload data to a
  bucket, please check our [Uploading Data to an S3
  Bucket](tutorials_ingest_uploadtos3.html) tutorial.
* You may need to configure IAM permissions to allow Splice Machine to
  access your bucket; see our [Configuring an S3 Bucket for Splice
  Machine Access](tutorials_ingest_configures3.html) tutorial.
* Once you've got your data in a bucket, you can follow our [Importing
  Data](tutorials_ingest_importing.html) tutorial to load that data into
  Splice Machine.

</div>
</section>



[1]: https://aws.amazon.com/vpc/
[2]: https://aws.amazon.com/iam/
