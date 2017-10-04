---
title: Upgrading from Splice Machine V2.0 to Splice Machine V2.5
summary: Walks you through upgrading your Splice Machine V2.0 Database
keywords: upgrading, 2.0, 2.5,
sidebar:  onprem_sidebar
toc: false
product: all
permalink: onprem_install_upgradev2.0.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Upgrading Splice Machine Version 2.0 to Version 2.5

This topic walks you through upgrading your Splice Machine Database from
version 2.0 to version 2.5, in these steps:

* [Run a Full Backup](#backup)
* [If Necessary, Upgrade to a Later Version of 2.0](#latervers)
* [Start the Upgrade](#tartupgrade)
* [Install Version 2.5](#install)
* [Make Configuration Changes](#configure)

## Step 1: Run a Full Backup   {#backup}

[Back up your database](onprem_admin_backingup.html), so that you can
recover if anything goes amiss.

We also recommend that you create a JSON backup dump of your current 2.0
configuration, which you'll find here:

<div class="preWrapperWide" markdown="1">
    http://<your cloudera manager host>:7180/api/v12/cm/deployment
{: .Plain}

</div>
## Step 2: If Necessary, Upgrade to a Later Version of 2.0   {#latervers}

This upgrade requires you to start with a Version 2.0 release that
includes the needed upgrade code, which is any version numbered
2.0.1.1725 or greater. If you're running an earlier version of Splice
Machine v2.0, please follow these steps before starting the upgrade to
2.5:

1.  Deploy version 2.0.1.1725 or later.
2.  Activate and restart hbase.
3.  Verify that the upgrade was successful: You should see this message
    in the HBase master log:
    *Conglomerates upgrade complete*
    {: .indentLevel1}

4.  Wait for hbase to complete startup and make sure you can connect and
    run some queries.

### Recovering from Upgrade Issues

If your upgrade to a more recent 2.0 version fails, you can recover by
following these steps:

1.  Deactivate the newly installed Splice Machine 2.0 parcel.
2.  Deploy and activate your previous Splice Machine 2.0 parcel.
3.  Restart HBase.
4.  [Flatten (clean) your database](onprem_admin_cleaningdb.html).
5.  [Restore your database](onprem_admin_backingup.html) from the backup
    you created at the beginning of this process.
6.  [Restart all cluster services"](onprem_admin_startingdb.html).

## Step 3: Start the Upgrade   {#startupgrade}

The first upgrade step is to prepare your cluster for the new version,
following these steps:

1.  [Shut down your cluster](onprem_admin_shuttingdowndb.html).
2.  Upgrade the version of JDK running on all cluster nodes to 1.8:
    
    * Install to `/usr/java`
    * Delete any other versions of JDK from `/usr/java`

3.  Delete the Spark service in CM.
4.  Delete all Spark jars from `/opt/cloudera/parcels/CDH/jars/`

## Step 4: Now install and activate Splice Machine, version 2.5.   {#install}

Activate Splice Machine, but **DO NOT restart your cluster yet!**
{: .noteIcon}

Run the following script on each node in your cluster:

<div class="PreWrapperWide" markdown="1">
    sudo /opt/cloudera/parcels/SPLICEMACHINE/scripts/install-splice-symlinks.sh
{: .ShellCommand}

</div>
## Step 5: Make Configuration Changes for Version 2.5   {#configure}

You need to make several updates in your Hadoop configuration so that
2.5 works properly, including:

* [YARN Updates](#yarnupd)
* [HBase Updates](#hbaseupd)

Please refer to our [Cloudera Installation
topic](onprem_install_cloudera.html#Configur8){: target="_blank"}
(onprem_install_cloudera.html) when making these modifications.
{: .noteNote}

### Yarn Updates   {#yarnupd}

You need to add the same two property values to each of four [YARN
advanced configuration
settings](onprem_install_cloudera.html#Configur2).

Add these properties:

<table>
            <col />
            <col />
            <thead>
                <tr>
                    <th>Property Name</th>
                    <th>Property Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>yarn.nodemanager.aux-services.spark_shuffle.class</code></td>
                    <td><code>org.apache.spark.network.yarn.YarnShuffleService</code></td>
                </tr>
                <tr>
                    <td><code>yarn.nodemanager.aux-services</code></td>
                    <td><code>mapreduce_shuffle,spark_shuffle</code></td>
                </tr>
            </tbody>
        </table>
to each of these YARN settings:

* Yarn Service Advanced Configuration Snippet (Safety Valve) for
  yarn-site.xml
* Yarn Client Advanced Configuration Snippet (Safety Valve) for
  yarn-site.xml
* NodeManager Advanced Configuration Snippet (Safety Valve) for
  yarn-site.xml
* ResourceManager Advanced Configuration Snippet (Safety Valve) for
  yarn-site.xml

### HBase Updates   {#hbaseupd}

Make these changes to the [HBase
Configuration](onprem_install_cloudera.html#Configur3):

* Apply the 2.5 [Java Configuration Options for HBASE
  Master](onprem_install_cloudera.html#Configur3) to your configuration.
* Set `Maximum Number of HStoreFiles Compaction = 7`.

Make these **temporary** changes to your Hbase Configuration:

* Set `Maximum HBase Client Retries` to `400`.
* Set `RPC Timeout` to `40`.

Undo these temporary changes after the upgrade has completed.
{: .noteIcon}

### Recovering from Upgrade Issues

If your upgrade from version 2.0 to version 2.5 fails, you can recover
by following these steps:

1.  Stop all services in CM.
2.  Deactivate the Splice Machine CDH parcel.
3.  Remove the Splice Machine CDH parcel.
4.  Delete the Splice Machine CDH parcel.
5.  Download the Splice Machine 2.0 CDH parcel
6.  Distribute the Splice Machine 2.0 CDH parcel to all nodes.
7.  Activate the Splice Machine 2.0 CDH parcel.

</div>
</section>

